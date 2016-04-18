package com.smpro.configuration;

import com.smpro.configuration.admin.AdminWebAdapter;
import com.smpro.configuration.shop.ShopWebAdapter;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.DispatcherServlet;

import javax.servlet.*;

public class WebInitializer implements WebApplicationInitializer {
	public static final long MAX_FILE_SIZE = 1024*1024*25; // 25메가
	public static final long MAX_REQUEST_SIZE = 1024*1024*25; // 25메가
	public static final int FILE_THRESHOLD = 1024*1024*25;

	private void addUtf8CharacterEncodingFilter(ServletContext servletContext) {
		FilterRegistration.Dynamic filter = servletContext.addFilter("Character_Encoding_Filter", CharacterEncodingFilter.class);
		filter.setInitParameter("encoding", "UTF-8");
		filter.setInitParameter("forceEncoding", "true");
		filter.addMappingForUrlPatterns(null, false, "/*");
	}

	@Override
	public void onStartup(ServletContext context) throws ServletException {
		AnnotationConfigWebApplicationContext shopDispatcherContext = new AnnotationConfigWebApplicationContext();
		shopDispatcherContext.register(ShopWebAdapter.class);

		AnnotationConfigWebApplicationContext adminDispatcherContext = new AnnotationConfigWebApplicationContext();
		adminDispatcherContext.register(AdminWebAdapter.class);

		ServletRegistration.Dynamic shopDispatcher;
		shopDispatcher = context.addServlet("shop", new DispatcherServlet(shopDispatcherContext));
		shopDispatcher.addMapping("/shop/*");

		shopDispatcher.setMultipartConfig(
			new MultipartConfigElement("/tmp", MAX_FILE_SIZE, MAX_REQUEST_SIZE, FILE_THRESHOLD)
		);

		ServletRegistration.Dynamic adminDispatcher;
		adminDispatcher = context.addServlet("admin", new DispatcherServlet(adminDispatcherContext));
		adminDispatcher.addMapping("/admin/*");

		adminDispatcher.setMultipartConfig(
			new MultipartConfigElement("/tmp", MAX_FILE_SIZE, MAX_REQUEST_SIZE, FILE_THRESHOLD)
		);

		addUtf8CharacterEncodingFilter(context);
	}
}
