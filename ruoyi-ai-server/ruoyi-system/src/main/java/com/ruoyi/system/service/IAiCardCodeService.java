package com.ruoyi.system.service;

import com.ruoyi.system.domain.AiCardCode;
import com.ruoyi.system.domain.vo.AdminCardCodeGenerateBo;
import java.util.List;

public interface IAiCardCodeService
{
    public AiCardCode selectAiCardCodeById(Long cardCodeId);

    public List<AiCardCode> selectAiCardCodeList(AiCardCode aiCardCode);

    public int insertAiCardCode(AiCardCode aiCardCode);

    public int batchGenerateAiCardCode(AdminCardCodeGenerateBo bo);

    public int deleteAiCardCodeByIds(Long[] cardCodeIds);
}
