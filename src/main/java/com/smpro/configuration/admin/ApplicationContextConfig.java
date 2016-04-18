package com.smpro.configuration.admin;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import java.util.Properties;

@Slf4j
@Configuration
@ComponentScan(basePackages = {"com.smpro.service", "com.smpro.dao"})
public class ApplicationContextConfig {
	@Bean
	public JavaMailSender javaMailSender() {

		// 임의로 설정하였음.. 추후 메일 설정 세팅 바람
		JavaMailSenderImpl sender = new JavaMailSenderImpl();
		sender.setHost("127.0.0.1");
		sender.setUsername("master@kookje.gogosoft.kr");
		sender.setPassword("password");
		sender.setProtocol("smtp");
		sender.setPort(25);

		Properties prop = new Properties();
		prop.setProperty("mail.smtp.auth", "true");
		prop.setProperty("mail.smtp.socketFactory.port", "25");
		prop.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		prop.setProperty("mail.transport.protocol", "smtp");
		prop.setProperty("mail.debug", "true");
		sender.setJavaMailProperties(prop);

		return sender;
	}
}
