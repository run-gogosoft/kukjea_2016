package com.smpro.configuration.shop;

import com.smpro.interceptor.shop.LoginCheckShopInterceptorImpl;
import com.smpro.interceptor.shop.MallCheckInterceptor;
import com.smpro.interceptor.shop.SessionCheckShopInterceptorImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.mobile.device.DeviceResolverHandlerInterceptor;
import org.springframework.mobile.device.site.SitePreferenceHandlerInterceptor;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration
@EnableWebMvc
@EnableAspectJAutoProxy
@ComponentScan(basePackages={"com.smpro.interceptor.shop", "com.smpro.controller.shop", "com.smpro.service", "com.smpro.dao", "com.smpro.configuration.shop"})
public class ShopWebAdapter extends WebMvcConfigurerAdapter {

	@Bean
	DeviceResolverHandlerInterceptor deviceResolverHandlerInterceptor() {
		return new DeviceResolverHandlerInterceptor();
	}

	@Bean
	SitePreferenceHandlerInterceptor sitePreferenceHandlerInterceptor() {
		return new SitePreferenceHandlerInterceptor();
	}

	@Autowired
	private MallCheckInterceptor mallCheckInterceptor;

	@Autowired
	private LoginCheckShopInterceptorImpl loginCheckShopInterceptor;

	@Autowired
	private SessionCheckShopInterceptorImpl sessionCheckShopInterceptor;

	@Bean
	public ViewResolver getViewResolver() {
		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/jsp/shop/");
		resolver.setExposeContextBeansAsAttributes(true);
		return resolver;
	}

	@Bean
	public StandardServletMultipartResolver multipartResolver(){
		return new StandardServletMultipartResolver();
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(mallCheckInterceptor)
				.addPathPatterns("/**")
		;

		registry.addInterceptor(deviceResolverHandlerInterceptor());
		registry.addInterceptor(sitePreferenceHandlerInterceptor());

		registry.addInterceptor(loginCheckShopInterceptor)
				.addPathPatterns("/mypage/main/**")
				.addPathPatterns("/mypage/NP_CARD2/**")
				.addPathPatterns("/mypage/estimate/**")
				.addPathPatterns("/mypage/confirm/**")
				.addPathPatterns("/mypage/delivery/**")
				.addPathPatterns("/mypage/direct/**")
				.addPathPatterns("/mypage/qna/**")
				.addPathPatterns("/mypage/review/**")
				.addPathPatterns("/mypage/point/**")
				.addPathPatterns("/wish/list/**")
				.addPathPatterns("/mypage/leave/**")
		;

		registry.addInterceptor(sessionCheckShopInterceptor)
				.addPathPatterns("/**/best/**")
				.addPathPatterns("/**/cscenter/**")
				.addPathPatterns("/**/event/**")
				.addPathPatterns("/**/mypage/**")
				.addPathPatterns("/**/order/**")
				.addPathPatterns("/**/search/**")
				.addPathPatterns("/**/cart/**")
				.addPathPatterns("/**/detail/**")
				.addPathPatterns("/**/main/**")
				.addPathPatterns("/**/wish/**")
				.addPathPatterns("/**/lv1/**")
				.addPathPatterns("/**/lv2/**")
				.addPathPatterns("/**/lv3/**")
				.addPathPatterns("/**/lv4/**")
				.addPathPatterns("/mypage/estimate/**")
				.addPathPatterns("/mypage/confirm/**")
				.addPathPatterns("/mypage/delivery/**")
				.addPathPatterns("/mypage/direct/**")
				.addPathPatterns("/mypage/qna/**")
				.addPathPatterns("/mypage/review/**")
				.addPathPatterns("/wish/list/**")
				.addPathPatterns("/mypage/leave/**")
		;

		super.addInterceptors(registry);
	}
}