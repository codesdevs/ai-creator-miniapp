package com.ruoyi.system.service.impl;

import cn.binarywang.wx.miniapp.api.WxMaService;
import cn.binarywang.wx.miniapp.api.impl.WxMaServiceImpl;
import cn.binarywang.wx.miniapp.bean.WxMaJscode2SessionResult;
import cn.binarywang.wx.miniapp.config.impl.WxMaDefaultConfigImpl;
import com.ruoyi.common.config.WxMaProperties;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.ServletUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.ip.IpUtils;
import com.ruoyi.common.utils.uuid.IdUtils;
import com.ruoyi.system.domain.AiAppUser;
import com.ruoyi.system.domain.AiAppUserAuth;
import com.ruoyi.system.domain.AiAppUserInvite;
import com.ruoyi.system.domain.vo.AppDevLoginBo;
import com.ruoyi.system.domain.vo.AppWxLoginBo;
import com.ruoyi.system.mapper.AiAppUserAuthMapper;
import com.ruoyi.system.mapper.AiAppUserInviteMapper;
import com.ruoyi.system.mapper.AiAppUserMapper;
import com.ruoyi.system.service.IAiWalletService;
import com.ruoyi.system.service.IAiAppUserService;
import me.chanjar.weixin.common.error.WxErrorException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

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
    private AiAppUserInviteMapper aiAppUserInviteMapper;

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
    public List<AiAppUser> selectAiAppUserList(AiAppUser aiAppUser)
    {
        return aiAppUserMapper.selectAiAppUserList(aiAppUser);
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

        AiAppUser user = createUser(StringUtils.defaultIfBlank(bo.getNickName(), "开发用户"), bo.getAvatar(), bo.getInviteCode());
        bindUserAuth(user.getUserId(), "DEV", bo.getDevKey(), null, null, bo.getNickName(), bo.getAvatar(), null, "DEV_LOGIN");
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
            auth.setAuthNickName(bo.getNickName());
            auth.setAuthAvatar(bo.getAvatar());
            auth.setUpdateTime(DateUtils.getNowDate());
            aiAppUserAuthMapper.updateAiAppUserAuth(auth);
            return refreshUserProfile(auth.getUserId(), bo.getNickName(), bo.getAvatar());
        }

        AiAppUser user = createUser(StringUtils.defaultIfBlank(bo.getNickName(), "微信用户"), bo.getAvatar(), bo.getInviteCode());
        bindUserAuth(user.getUserId(), "WECHAT_OPENID", sessionResult.getOpenid(), sessionResult.getUnionid(),
            sessionResult.getSessionKey(), bo.getNickName(), bo.getAvatar(), null, "WX_MINIAPP_LOGIN");
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
        fillLoginAuditFields(user);
        user.setUpdateTime(DateUtils.getNowDate());
        aiAppUserMapper.updateAiAppUser(user);
        aiWalletService.getOrCreateWallet(userId);
        return aiAppUserMapper.selectAiAppUserById(userId);
    }

    private AiAppUser createUser(String nickName, String avatar, String inviterCode)
    {
        AiAppUser inviter = resolveInviter(inviterCode);
        AiAppUser user = new AiAppUser();
        user.setUserNo("U" + DateUtils.dateTimeNow() + IdUtils.fastSimpleUUID().substring(0, 6).toUpperCase());
        user.setNickName(nickName);
        user.setAvatar(StringUtils.defaultString(avatar));
        user.setStatus("0");
        user.setInviteCode(IdUtils.fastSimpleUUID().substring(0, 8).toUpperCase());
        user.setInviterUserId(inviter == null ? null : inviter.getUserId());
        user.setActivateStatus("0");
        fillLoginAuditFields(user);
        user.setCreateTime(DateUtils.getNowDate());
        user.setUpdateTime(DateUtils.getNowDate());
        aiAppUserMapper.insertAiAppUser(user);
        saveInviteRelation(inviter, user);
        aiWalletService.getOrCreateWallet(user.getUserId());
        return user;
    }

    private void bindUserAuth(Long userId, String authType, String openid, String unionid, String sessionKey,
                              String authNickName, String authAvatar, String authMobile, String remark)
    {
        AiAppUserAuth userAuth = new AiAppUserAuth();
        userAuth.setUserId(userId);
        userAuth.setAuthType(authType);
        userAuth.setOpenid(openid);
        userAuth.setUnionid(unionid);
        userAuth.setSessionKey(sessionKey);
        userAuth.setAuthNickName(StringUtils.defaultString(authNickName));
        userAuth.setAuthAvatar(StringUtils.defaultString(authAvatar));
        userAuth.setAuthMobile(StringUtils.defaultString(authMobile));
        userAuth.setRemark(StringUtils.defaultString(remark));
        userAuth.setCreateTime(DateUtils.getNowDate());
        userAuth.setUpdateTime(DateUtils.getNowDate());
        aiAppUserAuthMapper.insertAiAppUserAuth(userAuth);
    }

    private void fillLoginAuditFields(AiAppUser user)
    {
        user.setLastLoginIp(StringUtils.substring(IpUtils.getIpAddr(), 0, 128));
        user.setLastLoginDevice(StringUtils.substring(ServletUtils.getRequest().getHeader("User-Agent"), 0, 255));
        user.setLastLoginTime(DateUtils.getNowDate());
    }

    private AiAppUser resolveInviter(String inviterCode)
    {
        if (StringUtils.isBlank(inviterCode))
        {
            return null;
        }
        AiAppUser inviter = aiAppUserMapper.selectAiAppUserByInviteCode(inviterCode.trim());
        if (inviter == null)
        {
            throw new ServiceException("邀请码不存在");
        }
        return inviter;
    }

    private void saveInviteRelation(AiAppUser inviter, AiAppUser invitee)
    {
        if (inviter == null || invitee == null)
        {
            return;
        }
        AiAppUserInvite invite = new AiAppUserInvite();
        invite.setInviterUserId(inviter.getUserId());
        invite.setInviteeUserId(invitee.getUserId());
        invite.setInviteCode(inviter.getInviteCode());
        invite.setCreateTime(DateUtils.getNowDate());
        aiAppUserInviteMapper.insertAiAppUserInvite(invite);
    }
}
