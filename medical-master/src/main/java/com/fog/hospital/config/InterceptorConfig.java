package com.fog.hospital.config;

import com.fog.hospital.interceptors.JwtInterceptor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Component
@Slf4j
/**
 * 作用：注册拦截器
 */
public class InterceptorConfig implements WebMvcConfigurer {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new JwtInterceptor())
                .excludePathPatterns("/patient/pdf")//这个是不需要拦截的路径
                .excludePathPatterns("/**/login")
                .excludePathPatterns("/announcements/**");;//这个是不需要拦截的路径
        log.info("注册拦截器成功");
    }
}
