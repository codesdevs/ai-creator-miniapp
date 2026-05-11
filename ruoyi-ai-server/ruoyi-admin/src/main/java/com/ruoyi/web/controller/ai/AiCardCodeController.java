package com.ruoyi.web.controller.ai;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.AiCardCode;
import com.ruoyi.system.domain.vo.AdminCardCodeGenerateBo;
import com.ruoyi.system.service.IAiCardCodeService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/ai/cardCode")
public class AiCardCodeController extends BaseController
{
    @Autowired
    private IAiCardCodeService aiCardCodeService;

    @PreAuthorize("@ss.hasPermi('ai:cardCode:list')")
    @GetMapping("/list")
    public TableDataInfo list(AiCardCode aiCardCode)
    {
        startPage();
        List<AiCardCode> list = aiCardCodeService.selectAiCardCodeList(aiCardCode);
        return getDataTable(list);
    }

    @Log(title = "卡密管理", businessType = BusinessType.EXPORT)
    @PreAuthorize("@ss.hasPermi('ai:cardCode:export')")
    @PostMapping("/export")
    public void export(HttpServletResponse response, AiCardCode aiCardCode)
    {
        List<AiCardCode> list = aiCardCodeService.selectAiCardCodeList(aiCardCode);
        ExcelUtil<AiCardCode> util = new ExcelUtil<AiCardCode>(AiCardCode.class);
        util.exportExcel(response, list, "卡密数据");
    }

    @PreAuthorize("@ss.hasPermi('ai:cardCode:query')")
    @GetMapping("/{cardCodeId}")
    public AjaxResult getInfo(@PathVariable Long cardCodeId)
    {
        return success(aiCardCodeService.selectAiCardCodeById(cardCodeId));
    }

    @PreAuthorize("@ss.hasPermi('ai:cardCode:add')")
    @Log(title = "卡密管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AiCardCode aiCardCode)
    {
        return toAjax(aiCardCodeService.insertAiCardCode(aiCardCode));
    }

    @PreAuthorize("@ss.hasPermi('ai:cardCode:edit')")
    @Log(title = "卡密管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AiCardCode aiCardCode)
    {
        return toAjax(aiCardCodeService.updateAiCardCode(aiCardCode));
    }

    @PreAuthorize("@ss.hasPermi('ai:cardCode:add')")
    @Log(title = "卡密批量生成", businessType = BusinessType.INSERT)
    @PostMapping("/batchGenerate")
    public AjaxResult batchGenerate(@Valid @RequestBody AdminCardCodeGenerateBo bo)
    {
        return toAjax(aiCardCodeService.batchGenerateAiCardCode(bo));
    }

    @PreAuthorize("@ss.hasPermi('ai:cardCode:remove')")
    @Log(title = "卡密管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{cardCodeIds}")
    public AjaxResult remove(@PathVariable Long[] cardCodeIds)
    {
        return toAjax(aiCardCodeService.deleteAiCardCodeByIds(cardCodeIds));
    }
}
