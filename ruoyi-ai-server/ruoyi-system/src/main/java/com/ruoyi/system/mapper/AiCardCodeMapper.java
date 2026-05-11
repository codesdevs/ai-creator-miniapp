package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.AiCardCode;
import java.util.List;

public interface AiCardCodeMapper
{
    public AiCardCode selectAiCardCodeById(Long cardCodeId);

    public List<AiCardCode> selectAiCardCodeList(AiCardCode aiCardCode);

    public int insertAiCardCode(AiCardCode aiCardCode);

    public int batchInsertAiCardCode(List<AiCardCode> list);

    public int deleteAiCardCodeByIds(Long[] cardCodeIds);
}
