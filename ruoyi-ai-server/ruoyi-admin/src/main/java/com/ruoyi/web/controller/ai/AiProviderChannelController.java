package com.ruoyi.web.controller.ai;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.AiProviderChannel;
import com.ruoyi.system.service.IAiProviderChannelService;
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
@RequestMapping("/ai/providerChannel")
public class AiProviderChannelController extends BaseController
{
    @Autowired
    private IAiProviderChannelService aiProviderChannelService;

    @PreAuthorize("@ss.hasPermi('ai:providerChannel:list')")
    @GetMapping("/list")
    public TableDataInfo list(AiProviderChannel aiProviderChannel)
    {
        startPage();
        List<AiProviderChannel> list = aiProviderChannelService.selectAiProviderChannelList(aiProviderChannel);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('ai:providerChannel:query')")
    @GetMapping("/{channelId}")
    public AjaxResult getInfo(@PathVariable Long channelId)
    {
        return success(aiProviderChannelService.selectAiProviderChannelById(channelId));
    }

    @PreAuthorize("@ss.hasPermi('ai:providerChannel:add')")
    @Log(title = "AI渠道", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody AiProviderChannel aiProviderChannel)
    {
        aiProviderChannel.setCreateBy(getUsername());
        return toAjax(aiProviderChannelService.insertAiProviderChannel(aiProviderChannel));
    }

    @PreAuthorize("@ss.hasPermi('ai:providerChannel:edit')")
    @Log(title = "AI渠道", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody AiProviderChannel aiProviderChannel)
    {
        aiProviderChannel.setUpdateBy(getUsername());
        return toAjax(aiProviderChannelService.updateAiProviderChannel(aiProviderChannel));
    }

    @PreAuthorize("@ss.hasPermi('ai:providerChannel:remove')")
    @Log(title = "AI渠道", businessType = BusinessType.DELETE)
    @DeleteMapping("/{channelIds}")
    public AjaxResult remove(@PathVariable Long[] channelIds)
    {
        return toAjax(aiProviderChannelService.deleteAiProviderChannelByIds(channelIds));
    }
}
