package com.ruoyi.common.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * AI Creator 业务开关配置
 *
 * @author codex
 */
@Component
@ConfigurationProperties(prefix = "ai-creator")
public class AiCreatorProperties
{
    private final Dev dev = new Dev();

    private final Payment payment = new Payment();

    private final Task task = new Task();

    public Dev getDev()
    {
        return dev;
    }

    public Payment getPayment()
    {
        return payment;
    }

    public Task getTask()
    {
        return task;
    }

    public static class Dev
    {
        private boolean loginEnabled;

        public boolean isLoginEnabled()
        {
            return loginEnabled;
        }

        public void setLoginEnabled(boolean loginEnabled)
        {
            this.loginEnabled = loginEnabled;
        }
    }

    public static class Payment
    {
        private boolean mockEnabled;

        public boolean isMockEnabled()
        {
            return mockEnabled;
        }

        public void setMockEnabled(boolean mockEnabled)
        {
            this.mockEnabled = mockEnabled;
        }
    }

    public static class Task
    {
        private boolean mockEnabled;

        public boolean isMockEnabled()
        {
            return mockEnabled;
        }

        public void setMockEnabled(boolean mockEnabled)
        {
            this.mockEnabled = mockEnabled;
        }
    }
}
