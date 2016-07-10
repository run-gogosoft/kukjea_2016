package com.smpro.configuration.admin;

import com.smpro.component.admin.BatchComponent;
import com.smpro.interceptor.admin.LoginCheckAdminInterceptorImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration
@EnableWebMvc
@EnableAspectJAutoProxy
@ComponentScan(basePackages = {"com.smpro.interceptor.admin", "com.smpro.controller.admin", "com.smpro.service", "com.smpro.dao", "com.smpro.component.admin", "com.smpro.component.admin.annotation", "com.smpro.configuration.admin"})
public class AdminWebAdapter extends WebMvcConfigurerAdapter {

	@Bean
	public BatchComponent appTask() {
		return new BatchComponent();
	}

	@Bean
	public ViewResolver getViewResolver() {
		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/jsp/admin/");
		resolver.setExposeContextBeansAsAttributes(true);
		return resolver;
	}

	@Bean
	public StandardServletMultipartResolver multipartResolver(){
		return new StandardServletMultipartResolver();
	}

	@Autowired
	private LoginCheckAdminInterceptorImpl loginCheckAdminInterceptor;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(loginCheckAdminInterceptor)
				.addPathPatterns("/index")
				.addPathPatterns("/main/**")
				.addPathPatterns("/display/**")
				.addPathPatterns("/board/**")
				.addPathPatterns("/review/**")
				.addPathPatterns("/member/**")
				.addPathPatterns("/point/**")
				.addPathPatterns("/category/**")
				.addPathPatterns("/seller/**")
				.addPathPatterns("/event/**")
				.addPathPatterns("/item/**")
				.addPathPatterns("/order/**")
				.addPathPatterns("/adjust/**")
				.addPathPatterns("/system/**")
				.addPathPatterns("/mall/**")
				.addPathPatterns("/sms/**")
				.addPathPatterns("/estimate/**")
				.addPathPatterns("/about/**")
				.addPathPatterns("/stats/**")
				.addPathPatterns("/festival/**")
		;

		super.addInterceptors(registry);
	}
}