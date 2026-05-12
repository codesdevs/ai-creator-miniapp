package com.ruoyi.system.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * AI 任务结果对象 ai_c_task_result
 *
 * @author codex
 */
public class AiTaskResult extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long resultId;

    private Long taskId;

    private String resultType;

    private String fileUrl;

    private String coverUrl;

    private String resultText;

    private Integer width;

    private Integer height;

    private Integer duration;

    private Integer seqNo;

    public Long getResultId()
    {
        return resultId;
    }

    public void setResultId(Long resultId)
    {
        this.resultId = resultId;
    }

    public Long getTaskId()
    {
        return taskId;
    }

    public void setTaskId(Long taskId)
    {
        this.taskId = taskId;
    }

    public String getResultType()
    {
        return resultType;
    }

    public void setResultType(String resultType)
    {
        this.resultType = resultType;
    }

    public String getFileUrl()
    {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl)
    {
        this.fileUrl = fileUrl;
    }

    public String getCoverUrl()
    {
        return coverUrl;
    }

    public void setCoverUrl(String coverUrl)
    {
        this.coverUrl = coverUrl;
    }

    public String getResultText()
    {
        return resultText;
    }

    public void setResultText(String resultText)
    {
        this.resultText = resultText;
    }

    public Integer getWidth()
    {
        return width;
    }

    public void setWidth(Integer width)
    {
        this.width = width;
    }

    public Integer getHeight()
    {
        return height;
    }

    public void setHeight(Integer height)
    {
        this.height = height;
    }

    public Integer getDuration()
    {
        return duration;
    }

    public void setDuration(Integer duration)
    {
        this.duration = duration;
    }

    public Integer getSeqNo()
    {
        return seqNo;
    }

    public void setSeqNo(Integer seqNo)
    {
        this.seqNo = seqNo;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("resultId", getResultId())
            .append("taskId", getTaskId())
            .append("resultType", getResultType())
            .append("fileUrl", getFileUrl())
            .append("coverUrl", getCoverUrl())
            .append("resultText", getResultText())
            .append("width", getWidth())
            .append("height", getHeight())
            .append("duration", getDuration())
            .append("seqNo", getSeqNo())
            .toString();
    }
}
