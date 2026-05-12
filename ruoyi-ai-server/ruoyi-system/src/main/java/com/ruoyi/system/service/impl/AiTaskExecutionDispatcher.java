package com.ruoyi.system.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Component;
import org.springframework.transaction.support.TransactionSynchronization;
import org.springframework.transaction.support.TransactionSynchronizationManager;

/**
 * AI 任务异步调度入口
 *
 * @author codex
 */
@Component
public class AiTaskExecutionDispatcher
{
    private static final Logger log = LoggerFactory.getLogger(AiTaskExecutionDispatcher.class);

    private final ThreadPoolTaskExecutor aiTaskExecutor;

    public AiTaskExecutionDispatcher(@Qualifier("aiTaskExecutor") ThreadPoolTaskExecutor aiTaskExecutor)
    {
        this.aiTaskExecutor = aiTaskExecutor;
    }

    public void dispatch(Long taskId, Long modelId, Long versionId, Long relationId, Runnable executor, Runnable rejectHandler)
    {
        Runnable submit = () -> submit(taskId, modelId, versionId, relationId, executor, rejectHandler);
        if (TransactionSynchronizationManager.isSynchronizationActive())
        {
            TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronization()
            {
                @Override
                public void afterCommit()
                {
                    log.info("AI image task dispatch after commit, taskId={}, modelId={}, versionId={}, relationId={}",
                        taskId, modelId, versionId, relationId);
                    submit.run();
                }
            });
            return;
        }
        log.info("AI image task dispatch immediately, taskId={}, modelId={}, versionId={}, relationId={}",
            taskId, modelId, versionId, relationId);
        submit.run();
    }

    private void submit(Long taskId, Long modelId, Long versionId, Long relationId, Runnable executor, Runnable rejectHandler)
    {
        try
        {
            aiTaskExecutor.execute(executor);
        }
        catch (Exception ex)
        {
            log.error("AI image task dispatch rejected, taskId={}, modelId={}, versionId={}, relationId={}",
                taskId, modelId, versionId, relationId, ex);
            rejectHandler.run();
        }
    }
}
