package com.ruoyi.web.controller.ai;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.AiChannelModelRelation;
import com.ruoyi.system.service.IAiChannelModelRelationService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/ai/channelModelRelation")
public class AiChannelModelRelationController extends BaseController
{
    @Autowired
    private IAiChannelModelRelationService aiChannelModelRelationService;

    @PreAuthorize("@ss.hasPermi('ai:channelModelRelation:list')")
    @GetMapping("/list")
    public TableDataInfo list(AiChannelModelRelation aiChannelModelRelation)
    {
        startPage();
        List<AiChannelModelRelation> list = aiChannelModelRelationService.selectAiChannelModelRelationList(aiChannelModelRelation);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('ai:channelModelRelation:query')")
    @GetMapping("/{relationId}")
    public AjaxResult getInfo(@PathVariable Long relationId)
    {
        return success(aiChannelModelRelationService.selectAiChannelModelRelationById(relationId));
    }

    @PreAuthorize("@ss.hasPermi('ai:channelModelRelation:add')")
    @Log(title = "AI渠道模型映射", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody AiChannelModelRelation aiChannelModelRelation)
    {
        aiChannelModelRelation.setCreateBy(getUsername());
        return toAjax(aiChannelModelRelationService.insertAiChannelModelRelation(aiChannelModelRelation));
    }

    @PreAuthorize("@ss.hasPermi('ai:channelModelRelation:edit')")
    @Log(title = "AI渠道模型映射", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody AiChannelModelRelation aiChannelModelRelation)
    {
        aiChannelModelRelation.setUpdateBy(getUsername());
        return toAjax(aiChannelModelRelationService.updateAiChannelModelRelation(aiChannelModelRelation));
    }

    @PreAuthorize("@ss.hasPermi('ai:channelModelRelation:remove')")
    @Log(title = "AI渠道模型映射", businessType = BusinessType.DELETE)
    @DeleteMapping("/{relationIds}")
    public AjaxResult remove(@PathVariable Long[] relationIds)
    {
        return toAjax(aiChannelModelRelationService.deleteAiChannelModelRelationByIds(relationIds));
    }
}
