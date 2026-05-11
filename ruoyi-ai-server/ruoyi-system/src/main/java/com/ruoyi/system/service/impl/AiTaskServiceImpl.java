package com.ruoyi.system.service.impl;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.uuid.IdUtils;
import com.ruoyi.system.domain.AiProvider;
import com.ruoyi.system.domain.AiProviderChannel;
import com.ruoyi.system.domain.AiModel;
import com.ruoyi.system.domain.AiModelVersion;
import com.ruoyi.system.domain.AiChannelModelRelation;
import com.ruoyi.system.domain.AiTask;
import com.ruoyi.system.domain.AiTaskResult;
import com.ruoyi.system.domain.vo.AdminTaskHandleBo;
import com.ruoyi.system.domain.vo.AppImageTaskSubmitBo;
import com.ruoyi.system.mapper.AiTaskMapper;
import com.ruoyi.system.mapper.AiTaskResultMapper;
import com.ruoyi.system.mapper.AiWalletFlowMapper;
import com.ruoyi.system.service.IAiProviderChannelService;
import com.ruoyi.system.service.IAiProviderService;
import com.ruoyi.system.service.IAiModelService;
import com.ruoyi.system.service.IAiModelVersionService;
import com.ruoyi.system.service.IAiChannelModelRelationService;
import com.ruoyi.system.service.IAiTaskService;
import com.ruoyi.system.service.IAiWalletService;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.support.TransactionSynchronization;
import org.springframework.transaction.support.TransactionSynchronizationManager;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;

/**
 * AI 任务 服务层实现
 *
 * @author codex
 */
@Service
public class AiTaskServiceImpl implements IAiTaskService
{
    private static final HttpClient HTTP_CLIENT = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(10)).build();

    private static final long MOCK_RUNNING_THRESHOLD_MS = 3_000L;

    private static final long MOCK_FINISH_THRESHOLD_MS = 8_000L;

    private static final String PROVIDER_CODE_ZHIPU = "ZHIPU";

    private static final String IMAGE_SUBMIT_IDEMPOTENT_KEY_PREFIX = "ai:task:image:submit:";

    private static final String IMAGE_SUBMIT_IDEMPOTENT_PENDING = "PENDING";

    private static final int IMAGE_SUBMIT_IDEMPOTENT_TTL_SECONDS = 120;

    @Autowired
    private AiTaskMapper aiTaskMapper;

    @Autowired
    private AiTaskResultMapper aiTaskResultMapper;

    @Autowired
    private IAiModelService aiModelService;

    @Autowired
    private IAiModelVersionService aiModelVersionService;

    @Autowired
    private IAiChannelModelRelationService aiChannelModelRelationService;

    @Autowired
    private IAiProviderChannelService aiProviderChannelService;

    @Autowired
    private IAiProviderService aiProviderService;

    @Autowired
    private IAiWalletService aiWalletService;

    @Autowired
    private AiWalletFlowMapper aiWalletFlowMapper;

    @Autowired
    private ThreadPoolTaskExecutor threadPoolTaskExecutor;

    @Autowired
    private RedisCache redisCache;

    @Override
    public AiTask selectAiTaskById(Long taskId)
    {
        return hydrateMockTask(aiTaskMapper.selectAiTaskById(taskId));
    }

    @Override
    public List<AiTask> selectAiTaskList(AiTask aiTask)
    {
        List<AiTask> list = aiTaskMapper.selectAiTaskList(aiTask);
        list.forEach(this::hydrateMockTask);
        return list;
    }

    @Override
    public List<AiTaskResult> selectAiTaskResultListByTaskId(Long taskId)
    {
        return aiTaskResultMapper.selectAiTaskResultListByTaskId(taskId);
    }

    @Override
    public AiTask selectUserTaskDetail(Long userId, Long taskId)
    {
        AiTask task = hydrateMockTask(aiTaskMapper.selectAiTaskById(taskId));
        if (task == null || !userId.equals(task.getUserId()))
        {
            throw new ServiceException("任务不存在");
        }
        return task;
    }

    @Override
    public List<AiTask> selectUserTaskList(Long userId)
    {
        AiTask query = new AiTask();
        query.setUserId(userId);
        query.setTaskType("IMAGE");
        return selectAiTaskList(query);
    }

    @Override
    public boolean hasTaskRefunded(Long taskId)
    {
        return hasRefunded(taskId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AiTask submitImageTask(AppImageTaskSubmitBo bo)
    {
        Long userId = bo.getUserId() == null ? 1L : bo.getUserId();
        String idempotentKey = buildImageSubmitIdempotentKey(userId, bo);
        AiTask existingTask = getExistingIdempotentTask(idempotentKey);
        if (existingTask != null)
        {
            return existingTask;
        }
        if (!redisCache.setCacheObjectIfAbsent(idempotentKey, IMAGE_SUBMIT_IDEMPOTENT_PENDING, IMAGE_SUBMIT_IDEMPOTENT_TTL_SECONDS, TimeUnit.SECONDS))
        {
            throw new ServiceException("任务提交中，请勿重复提交");
        }
        AiModel model = aiModelService.selectAiModelById(bo.getModelId());
        try
        {
            if (model == null || !"0".equals(model.getStatus()))
            {
                throw new ServiceException("模型不存在或已停用");
            }
            AiModelVersion version = aiModelVersionService.selectAiModelVersionById(bo.getVersionId());
            if (version == null || !"0".equals(version.getStatus()))
            {
                throw new ServiceException("模型版本不存在或已停用");
            }
            if (!bo.getModelId().equals(version.getModelId()))
            {
                throw new ServiceException("模型和版本不匹配");
            }
            AiChannelModelRelation route = resolveChannelModelRelation(version.getVersionId());

            AiTask task = new AiTask();
            task.setTaskNo("T" + DateUtils.dateTimeNow() + IdUtils.fastSimpleUUID().substring(0, 8).toUpperCase());
            task.setUserId(userId);
            task.setModelId(model.getModelId());
            task.setModelVersionId(version.getVersionId());
            task.setTaskType("IMAGE");
            task.setCreateMode(bo.getCreateMode());
            task.setPromptText(bo.getPromptText());
            task.setNegativePrompt(bo.getNegativePrompt());
            task.setStyleCode(bo.getStyleCode());
            task.setRatioCode(bo.getRatioCode());
            task.setSourceUrl(bo.getSourceUrl());
            task.setStatus(route == null ? "PENDING" : "WAITING");
            task.setPowerCost(version.getPowerCost());
            if (route != null)
            {
                task.setChannelId(route.getChannelId());
                task.setChannelModelRelationId(route.getRelationId());
                task.setRemoteModelName(route.getRemoteModelName());
                task.setRemark("任务已提交，等待渠道执行：" + StringUtils.defaultIfBlank(route.getChannelName(), "未命名渠道"));
            }
            else
            {
                task.setRemoteModelName(StringUtils.defaultIfBlank(version.getApiModelName(), version.getVersionCode()));
                task.setRemark("任务已创建，待接入实际模型执行器");
            }
            task.setSubmitTime(DateUtils.getNowDate());
            aiTaskMapper.insertAiTask(task);
            aiWalletService.consumePower(userId, version.getPowerCost(), "TASK_SUBMIT", task.getTaskId(), "提交图片生成任务扣减算力");
            redisCache.setCacheObject(idempotentKey, String.valueOf(task.getTaskId()), IMAGE_SUBMIT_IDEMPOTENT_TTL_SECONDS, TimeUnit.SECONDS);
            if (route != null)
            {
                dispatchRealImageTask(task.getTaskId(), model.getModelId(), version.getVersionId(), route.getRelationId());
            }
            return aiTaskMapper.selectAiTaskById(task.getTaskId());
        }
        catch (Exception ex)
        {
            redisCache.deleteObject(idempotentKey);
            throw ex;
        }
    }

    private String buildImageSubmitIdempotentKey(Long userId, AppImageTaskSubmitBo bo)
    {
        String requestId = StringUtils.trim(bo.getClientRequestId());
        if (StringUtils.isBlank(requestId))
        {
            requestId = buildImageSubmitFingerprint(bo);
        }
        return IMAGE_SUBMIT_IDEMPOTENT_KEY_PREFIX + userId + ":" + requestId;
    }

    private String buildImageSubmitFingerprint(AppImageTaskSubmitBo bo)
    {
        JSONObject payload = new JSONObject();
        payload.put("modelId", bo.getModelId());
        payload.put("versionId", bo.getVersionId());
        payload.put("createMode", StringUtils.trim(bo.getCreateMode()));
        payload.put("promptText", StringUtils.trim(bo.getPromptText()));
        payload.put("negativePrompt", StringUtils.trim(bo.getNegativePrompt()));
        payload.put("styleCode", StringUtils.trim(bo.getStyleCode()));
        payload.put("ratioCode", StringUtils.trim(bo.getRatioCode()));
        payload.put("sourceUrl", StringUtils.trim(bo.getSourceUrl()));
        return DigestUtils.md5DigestAsHex(JSON.toJSONString(payload).getBytes(StandardCharsets.UTF_8));
    }

    private AiTask getExistingIdempotentTask(String idempotentKey)
    {
        String cachedTaskId = redisCache.getCacheObject(idempotentKey);
        if (StringUtils.isBlank(cachedTaskId))
        {
            return null;
        }
        if (IMAGE_SUBMIT_IDEMPOTENT_PENDING.equals(cachedTaskId))
        {
            throw new ServiceException("任务提交中，请勿重复提交");
        }
        AiTask existingTask = aiTaskMapper.selectAiTaskById(Long.valueOf(cachedTaskId));
        if (existingTask == null)
        {
            redisCache.deleteObject(idempotentKey);
        }
        return existingTask;
    }

    private void dispatchRealImageTask(Long taskId, Long modelId, Long versionId, Long relationId)
    {
        Runnable taskRunner = () -> threadPoolTaskExecutor.execute(() -> executeRealImageTask(taskId, modelId, versionId, relationId));
        if (TransactionSynchronizationManager.isSynchronizationActive())
        {
            TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronization()
            {
                @Override
                public void afterCommit()
                {
                    taskRunner.run();
                }
            });
            return;
        }
        taskRunner.run();
    }

    private AiChannelModelRelation resolveChannelModelRelation(Long versionId)
    {
        AiChannelModelRelation query = new AiChannelModelRelation();
        query.setModelVersionId(versionId);
        query.setEnabled("0");
        List<AiChannelModelRelation> relationList = aiChannelModelRelationService.selectAiChannelModelRelationList(query);
        return relationList.isEmpty() ? null : relationList.get(0);
    }

    private void executeRealImageTask(Long taskId, Long modelId, Long versionId, Long relationId)
    {
        AiTask task = aiTaskMapper.selectAiTaskById(taskId);
        AiModel model = aiModelService.selectAiModelById(modelId);
        AiModelVersion version = aiModelVersionService.selectAiModelVersionById(versionId);
        AiChannelModelRelation route = aiChannelModelRelationService.selectAiChannelModelRelationById(relationId);
        if (task == null || model == null || version == null || route == null)
        {
            return;
        }
        if ("SUCCESS".equals(task.getStatus()) || "FAIL".equals(task.getStatus()))
        {
            return;
        }
        task.setStatus("RUNNING");
        task.setRemark("模型正在生成结果，请稍候查看");
        aiTaskMapper.updateAiTask(task);
        try
        {
            doExecuteRealImageTask(task, model, version, route);
        }
        catch (Exception ex)
        {
            handleAsyncTaskFailure(task, ex);
        }
    }

    private void doExecuteRealImageTask(AiTask task, AiModel model, AiModelVersion version, AiChannelModelRelation route)
    {
        if (route == null)
        {
            return;
        }
        AiProviderChannel channel = aiProviderChannelService.selectAiProviderChannelById(route.getChannelId());
        if (channel == null || !"0".equals(channel.getStatus()))
        {
            throw new ServiceException("渠道不存在或已停用");
        }
        AiProvider provider = aiProviderService.selectAiProviderById(channel.getProviderId());
        if (provider == null || !"0".equals(provider.getStatus()))
        {
            throw new ServiceException("提供商不存在或已停用");
        }
        if (PROVIDER_CODE_ZHIPU.equalsIgnoreCase(provider.getProviderCode()))
        {
            executeZhipuImageTask(task, version, route, channel);
            return;
        }
        throw new ServiceException("当前渠道尚未接入实际执行器");
    }

    private void handleAsyncTaskFailure(AiTask task, Exception ex)
    {
        String message = ex instanceof ServiceException ? ex.getMessage() : "任务执行异常：" + ex.getMessage();
        task.setStatus("FAIL");
        task.setFailReason(StringUtils.defaultIfBlank(message, "任务执行失败"));
        task.setResponsePayload(buildFailurePayload(task.getResponsePayload(), message));
        task.setFinishTime(new Date());
        task.setRemark("任务执行失败，已退回本次扣减算力");
        aiTaskMapper.updateAiTask(task);
        if (!hasRefunded(task.getTaskId()))
        {
            aiWalletService.grantPower(task.getUserId(), task.getPowerCost(), "TASK_REFUND", task.getTaskId(), "任务执行失败退回算力");
        }
    }

    private void executeZhipuImageTask(AiTask task, AiModelVersion version, AiChannelModelRelation route, AiProviderChannel channel)
    {
        if (!"TEXT_TO_IMAGE".equalsIgnoreCase(task.getCreateMode()))
        {
            throw new ServiceException("智谱图像生成当前仅支持文生图");
        }
        if (StringUtils.isBlank(channel.getApiKey()))
        {
            throw new ServiceException("智谱渠道未配置 API Key");
        }
        String baseUrl = StringUtils.defaultIfBlank(channel.getBaseUrl(), "https://open.bigmodel.cn");
        String requestUrl = buildZhipuRequestUrl(baseUrl);

        JSONObject body = new JSONObject();
        body.put("model", StringUtils.defaultIfBlank(route.getRemoteModelName(), StringUtils.defaultIfBlank(version.getApiModelName(), "glm-image")));
        body.put("prompt", buildZhipuPrompt(task));
        body.put("size", resolveZhipuSize(task.getRatioCode()));
        body.put("watermark_enabled", false);
        body.put("user_id", buildZhipuUserId(task.getUserId()));
        task.setRequestPayload(buildRequestPayload(requestUrl, body, task, route, channel));
        aiTaskMapper.updateAiTask(task);

        String responseText;
        try
        {
            HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(requestUrl))
                .timeout(Duration.ofMillis(resolveTimeoutMs(channel)))
                .header("Authorization", "Bearer " + channel.getApiKey())
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(body.toJSONString()))
                .build();
            HttpResponse<String> response = HTTP_CLIENT.send(request, HttpResponse.BodyHandlers.ofString());
            responseText = response.body();
            if (response.statusCode() < 200 || response.statusCode() >= 300)
            {
                throw new ServiceException("智谱接口调用失败：" + extractZhipuErrorMessage(responseText, response.statusCode()));
            }
        }
        catch (ServiceException ex)
        {
            throw ex;
        }
        catch (Exception ex)
        {
            throw new ServiceException("智谱接口调用异常：" + ex.getMessage());
        }

        JSONObject responseJson = JSON.parseObject(responseText);
        task.setResponsePayload(responseText);
        JSONArray dataArray = responseJson.getJSONArray("data");
        if (dataArray == null || dataArray.isEmpty())
        {
            aiTaskMapper.updateAiTask(task);
            throw new ServiceException("智谱接口未返回图片结果");
        }
        String imageUrl = dataArray.getJSONObject(0).getString("url");
        if (StringUtils.isBlank(imageUrl))
        {
            aiTaskMapper.updateAiTask(task);
            throw new ServiceException("智谱接口返回的图片地址为空");
        }

        int[] size = resolveImageSize(task.getRatioCode());
        AiTaskResult result = new AiTaskResult();
        result.setTaskId(task.getTaskId());
        result.setResultType("IMAGE");
        result.setFileUrl(imageUrl);
        result.setCoverUrl(imageUrl);
        result.setWidth(size[0]);
        result.setHeight(size[1]);
        result.setSeqNo(1);
        aiTaskResultMapper.insertAiTaskResult(result);

        task.setStatus("SUCCESS");
        task.setThirdTaskId(responseJson.getString("request_id"));
        task.setFailReason("");
        task.setFinishTime(new Date());
        task.setRemark("智谱图像生成完成");
        aiTaskMapper.updateAiTask(task);
    }

    private String buildRequestPayload(String requestUrl, JSONObject body, AiTask task, AiChannelModelRelation route, AiProviderChannel channel)
    {
        JSONObject payload = new JSONObject();
        payload.put("providerCode", PROVIDER_CODE_ZHIPU);
        payload.put("requestUrl", requestUrl);
        payload.put("taskId", task.getTaskId());
        payload.put("taskNo", task.getTaskNo());
        payload.put("channelId", channel.getChannelId());
        payload.put("channelCode", channel.getChannelCode());
        payload.put("channelName", channel.getChannelName());
        payload.put("relationId", route.getRelationId());
        payload.put("remoteModelName", route.getRemoteModelName());
        payload.put("headers", buildRequestHeaders(channel));
        payload.put("body", body);
        return JSON.toJSONString(payload);
    }

    private JSONObject buildRequestHeaders(AiProviderChannel channel)
    {
        JSONObject headers = new JSONObject();
        headers.put("Content-Type", "application/json");
        headers.put("Authorization", "Bearer " + maskApiKey(channel.getApiKey()));
        return headers;
    }

    private String maskApiKey(String apiKey)
    {
        if (StringUtils.isBlank(apiKey))
        {
            return "";
        }
        if (apiKey.length() <= 8)
        {
            return "****";
        }
        return apiKey.substring(0, 4) + "****" + apiKey.substring(apiKey.length() - 4);
    }

    private String buildFailurePayload(String responsePayload, String errorMessage)
    {
        JSONObject payload = new JSONObject();
        payload.put("errorMessage", errorMessage);
        if (StringUtils.isNotBlank(responsePayload))
        {
            payload.put("rawResponse", responsePayload);
        }
        return JSON.toJSONString(payload);
    }

    private String buildZhipuRequestUrl(String baseUrl)
    {
        String normalized = baseUrl.endsWith("/") ? baseUrl.substring(0, baseUrl.length() - 1) : baseUrl;
        if (normalized.endsWith("/api/paas/v4/images/generations"))
        {
            return normalized;
        }
        if (normalized.endsWith("/api/paas/v4"))
        {
            return normalized + "/images/generations";
        }
        return normalized + "/api/paas/v4/images/generations";
    }

    private int resolveTimeoutMs(AiProviderChannel channel)
    {
        return channel.getTimeoutMs() == null || channel.getTimeoutMs() <= 0 ? 60000 : channel.getTimeoutMs();
    }

    private String buildZhipuPrompt(AiTask task)
    {
        StringBuilder builder = new StringBuilder(StringUtils.defaultString(task.getPromptText()));
        if (StringUtils.isNotBlank(task.getStyleCode()))
        {
            builder.append("，风格：").append(task.getStyleCode());
        }
        if (StringUtils.isNotBlank(task.getNegativePrompt()))
        {
            builder.append("。避免：").append(task.getNegativePrompt());
        }
        return builder.toString();
    }

    private String resolveZhipuSize(String ratio)
    {
        return switch (StringUtils.defaultIfBlank(ratio, "1:1"))
        {
            case "9:16" -> "768x1344";
            case "16:9" -> "1344x768";
            case "3:4" -> "864x1152";
            case "4:3" -> "1152x864";
            default -> "1024x1024";
        };
    }

    private String buildZhipuUserId(Long userId)
    {
        String value = "app-user-" + StringUtils.defaultIfBlank(userId == null ? null : String.valueOf(userId), "guest");
        if (value.length() < 6)
        {
            return StringUtils.rightPad(value, 6, '0');
        }
        return value.length() > 128 ? value.substring(0, 128) : value;
    }

    private int[] resolveImageSize(String ratio)
    {
        return switch (StringUtils.defaultIfBlank(ratio, "1:1"))
        {
            case "9:16" -> new int[] { 768, 1344 };
            case "16:9" -> new int[] { 1344, 768 };
            case "3:4" -> new int[] { 864, 1152 };
            case "4:3" -> new int[] { 1152, 864 };
            default -> new int[] { 1024, 1024 };
        };
    }

    private String extractZhipuErrorMessage(String responseText, int statusCode)
    {
        try
        {
            JSONObject jsonObject = JSON.parseObject(responseText);
            String message = jsonObject.getString("message");
            if (StringUtils.isBlank(message))
            {
                JSONObject error = jsonObject.getJSONObject("error");
                if (error != null)
                {
                    message = error.getString("message");
                }
            }
            return StringUtils.defaultIfBlank(message, "HTTP " + statusCode);
        }
        catch (Exception ex)
        {
            return "HTTP " + statusCode;
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AiTask adminHandleTask(AdminTaskHandleBo bo)
    {
        AiTask task = aiTaskMapper.selectAiTaskById(bo.getTaskId());
        if (task == null)
        {
            throw new ServiceException("任务不存在");
        }

        task.setStatus(bo.getStatus());
        task.setRemark(bo.getRemark());
        if ("FAIL".equals(bo.getStatus()))
        {
            task.setFailReason(StringUtils.defaultIfBlank(bo.getFailReason(), "后台人工处理为失败"));
            task.setFinishTime(new Date());
            aiTaskMapper.updateAiTask(task);
            if (Boolean.TRUE.equals(bo.getRefund()) && !hasRefunded(task.getTaskId()))
            {
                aiWalletService.grantPower(task.getUserId(), task.getPowerCost(), "TASK_REFUND", task.getTaskId(), "后台处理失败任务退款");
            }
        }
        else if ("SUCCESS".equals(bo.getStatus()))
        {
            task.setFailReason("");
            task.setFinishTime(new Date());
            aiTaskMapper.updateAiTask(task);
            insertMockResultsIfAbsent(task);
        }
        else
        {
            task.setFailReason("");
            aiTaskMapper.updateAiTask(task);
        }
        return aiTaskMapper.selectAiTaskById(task.getTaskId());
    }

    private AiTask hydrateMockTask(AiTask task)
    {
        if (task == null || task.getSubmitTime() == null)
        {
            return task;
        }
        if (task.getChannelModelRelationId() != null || task.getChannelId() != null)
        {
            return task;
        }
        if ("SUCCESS".equals(task.getStatus()) || "FAIL".equals(task.getStatus()))
        {
            return task;
        }

        long elapsedMs = System.currentTimeMillis() - task.getSubmitTime().getTime();
        if (elapsedMs >= MOCK_FINISH_THRESHOLD_MS)
        {
            return finalizeMockTask(task);
        }
        if (elapsedMs >= MOCK_RUNNING_THRESHOLD_MS && !"RUNNING".equals(task.getStatus()))
        {
            task.setStatus("RUNNING");
            task.setRemark("模型正在生成结果，请稍候查看");
            aiTaskMapper.updateAiTask(task);
            return aiTaskMapper.selectAiTaskById(task.getTaskId());
        }
        return task;
    }

    private AiTask finalizeMockTask(AiTask task)
    {
        boolean success = Math.abs(task.getTaskNo().hashCode()) % 10 < 8;
        task.setFinishTime(new Date());
        if (success)
        {
            task.setStatus("SUCCESS");
            task.setFailReason("");
            task.setRemark("演示任务已生成完成");
            aiTaskMapper.updateAiTask(task);
            insertMockResultsIfAbsent(task);
        }
        else
        {
            task.setStatus("FAIL");
            task.setFailReason("演示环境模拟执行失败，请调整提示词后重试");
            task.setRemark("演示任务执行失败，已退回本次扣减算力");
            aiTaskMapper.updateAiTask(task);
            if (!hasRefunded(task.getTaskId()))
            {
                aiWalletService.grantPower(task.getUserId(), task.getPowerCost(), "TASK_REFUND", task.getTaskId(), "演示任务失败退回算力");
            }
        }
        return aiTaskMapper.selectAiTaskById(task.getTaskId());
    }

    private boolean hasRefunded(Long taskId)
    {
        return aiWalletFlowMapper.countAiWalletFlowByBiz("TASK_REFUND", taskId, "GRANT") > 0;
    }

    private void insertMockResultsIfAbsent(AiTask task)
    {
        List<AiTaskResult> resultList = aiTaskResultMapper.selectAiTaskResultListByTaskId(task.getTaskId());
        if (!resultList.isEmpty())
        {
            return;
        }
        String ratio = task.getRatioCode() == null || task.getRatioCode().isBlank() ? "1:1" : task.getRatioCode();
        int[] size = resolveMockSize(ratio);
        String seed = String.valueOf(task.getTaskId());

        AiTaskResult first = new AiTaskResult();
        first.setTaskId(task.getTaskId());
        first.setResultType("IMAGE");
        first.setWidth(size[0]);
        first.setHeight(size[1]);
        first.setSeqNo(1);
        first.setCoverUrl("https://picsum.photos/seed/ai-task-" + seed + "/" + size[0] + "/" + size[1]);
        first.setFileUrl(first.getCoverUrl());
        aiTaskResultMapper.insertAiTaskResult(first);

        AiTaskResult second = new AiTaskResult();
        second.setTaskId(task.getTaskId());
        second.setResultType("IMAGE");
        second.setWidth(size[0]);
        second.setHeight(size[1]);
        second.setSeqNo(2);
        second.setCoverUrl("https://picsum.photos/seed/ai-task-" + seed + "-b/" + size[0] + "/" + size[1]);
        second.setFileUrl(second.getCoverUrl());
        aiTaskResultMapper.insertAiTaskResult(second);
    }

    private int[] resolveMockSize(String ratio)
    {
        return switch (ratio)
        {
            case "9:16" -> new int[] { 900, 1600 };
            case "16:9" -> new int[] { 1600, 900 };
            case "3:4" -> new int[] { 900, 1200 };
            case "4:3" -> new int[] { 1200, 900 };
            default -> new int[] { 1024, 1024 };
        };
    }
}
