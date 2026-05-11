package com.ruoyi.system.service.impl;

import cn.binarywang.wx.miniapp.api.WxMaService;
import cn.binarywang.wx.miniapp.api.impl.WxMaServiceImpl;
import cn.binarywang.wx.miniapp.bean.WxMaJscode2SessionResult;
import cn.binarywang.wx.miniapp.config.impl.WxMaDefaultConfigImpl;
import com.ruoyi.common.config.WxMaProperties;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.uuid.IdUtils;
import com.ruoyi.system.domain.AiAppUser;
import com.ruoyi.system.domain.AiAppUserAuth;
import com.ruoyi.system.domain.vo.AppDevLoginBo;
import com.ruoyi.system.domain.vo.AppWxLoginBo;
import com.ruoyi.system.mapper.AiAppUserAuthMapper;
import com.ruoyi.system.mapper.AiAppUserMapper;
import com.ruoyi.system.service.IAiWalletService;
import com.ruoyi.system.service.IAiAppUserService;
import me.chanjar.weixin.common.error.WxErrorException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * C端用户 服务层实现
 *
 * @author codex
 */
@Service
public class AiAppUserServiceImpl implements IAiAppUserService
{
    @Autowired
    private AiAppUserMapper aiAppUserMapper;

    @Autowired
    private AiAppUserAuthMapper aiAppUserAuthMapper;

    @Autowired
    private IAiWalletService aiWalletService;

    @Autowired
    private WxMaProperties wxMaProperties;

    @Override
    public AiAppUser selectAiAppUserById(Long userId)
    {
        return aiAppUserMapper.selectAiAppUserById(userId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AiAppUser devLogin(AppDevLoginBo bo)
    {
        AiAppUserAuth auth = aiAppUserAuthMapper.selectAiAppUserAuthByAuthTypeAndOpenid("DEV", bo.getDevKey());
        if (auth != null)
        {
            return refreshUserProfile(auth.getUserId(), bo.getNickName(), bo.getAvatar());
        }

        AiAppUser user = createUser(StringUtils.defaultIfBlank(bo.getNickName(), "开发用户"), bo.getAvatar());
        bindUserAuth(user.getUserId(), "DEV", bo.getDevKey(), null, null);
        return aiAppUserMapper.selectAiAppUserById(user.getUserId());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AiAppUser wxLogin(AppWxLoginBo bo)
    {
        if (!wxMaProperties.isEnabled())
        {
            throw new ServiceException("微信小程序登录未启用，请先配置 wx.miniapp");
        }
        if (StringUtils.isAnyBlank(wxMaProperties.getAppId(), wxMaProperties.getSecret()))
        {
            throw new ServiceException("微信小程序配置不完整，请检查 appId 和 secret");
        }

        WxMaJscode2SessionResult sessionResult = getWxMaSession(bo.getCode());
        if (StringUtils.isBlank(sessionResult.getOpenid()))
        {
            throw new ServiceException("微信登录失败，未获取到openid");
        }

        AiAppUserAuth auth = aiAppUserAuthMapper.selectAiAppUserAuthByAuthTypeAndOpenid("WECHAT_OPENID", sessionResult.getOpenid());
        if (auth == null && StringUtils.isNotBlank(sessionResult.getUnionid()))
        {
            auth = aiAppUserAuthMapper.selectAiAppUserAuthByUnionid(sessionResult.getUnionid());
        }
        if (auth != null)
        {
            auth.setAuthType("WECHAT_OPENID");
            auth.setOpenid(sessionResult.getOpenid());
            auth.setUnionid(sessionResult.getUnionid());
            auth.setSessionKey(sessionResult.getSessionKey());
            aiAppUserAuthMapper.updateAiAppUserAuth(auth);
            return refreshUserProfile(auth.getUserId(), bo.getNickName(), bo.getAvatar());
        }

        AiAppUser user = createUser(StringUtils.defaultIfBlank(bo.getNickName(), "微信用户"), bo.getAvatar());
        bindUserAuth(user.getUserId(), "WECHAT_OPENID", sessionResult.getOpenid(), sessionResult.getUnionid(), sessionResult.getSessionKey());
        return aiAppUserMapper.selectAiAppUserById(user.getUserId());
    }

    private WxMaJscode2SessionResult getWxMaSession(String code)
    {
        WxMaDefaultConfigImpl config = new WxMaDefaultConfigImpl();
        config.setAppid(wxMaProperties.getAppId());
        config.setSecret(wxMaProperties.getSecret());
        WxMaService wxMaService = new WxMaServiceImpl();
        wxMaService.setWxMaConfig(config);
        try
        {
            return wxMaService.getUserService().getSessionInfo(code);
        }
        catch (WxErrorException e)
        {
            throw new ServiceException("微信登录失败：" + e.getError().getErrorMsg());
        }
    }

    private AiAppUser refreshUserProfile(Long userId, String nickName, String avatar)
    {
        AiAppUser user = aiAppUserMapper.selectAiAppUserById(userId);
        if (user == null)
        {
            throw new ServiceException("用户不存在");
        }
        if (StringUtils.isNotBlank(nickName))
        {
            user.setNickName(nickName);
        }
        if (StringUtils.isNotBlank(avatar))
        {
            user.setAvatar(avatar);
        }
        user.setUpdateTime(DateUtils.getNowDate());
        aiAppUserMapper.updateAiAppUser(user);
        aiWalletService.getOrCreateWallet(userId);
        return aiAppUserMapper.selectAiAppUserById(userId);
    }

    private AiAppUser createUser(String nickName, String avatar)
    {
        AiAppUser user = new AiAppUser();
        user.setUserNo("U" + DateUtils.dateTimeNow() + IdUtils.fastSimpleUUID().substring(0, 6).toUpperCase());
        user.setNickName(nickName);
        user.setAvatar(StringUtils.defaultString(avatar));
        user.setStatus("0");
        user.setInviteCode(IdUtils.fastSimpleUUID().substring(0, 8).toUpperCase());
        user.setActivateStatus("0");
        user.setCreateTime(DateUtils.getNowDate());
        user.setUpdateTime(DateUtils.getNowDate());
        aiAppUserMapper.insertAiAppUser(user);
        aiWalletService.getOrCreateWallet(user.getUserId());
        return user;
    }

    private void bindUserAuth(Long userId, String authType, String openid, String unionid, String sessionKey)
    {
        AiAppUserAuth userAuth = new AiAppUserAuth();
        userAuth.setUserId(userId);
        userAuth.setAuthType(authType);
        userAuth.setOpenid(openid);
        userAuth.setUnionid(unionid);
        userAuth.setSessionKey(sessionKey);
        userAuth.setCreateTime(DateUtils.getNowDate());
        aiAppUserAuthMapper.insertAiAppUserAuth(userAuth);
    }
}
