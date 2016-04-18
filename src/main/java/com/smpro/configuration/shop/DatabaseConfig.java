package com.smpro.configuration.shop;

import com.jolbox.bonecp.BoneCPDataSource;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.core.io.ResourceLoader;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.TransactionManagementConfigurer;

import javax.sql.DataSource;

/**
 * property 소스로부터 읽어들여 데이터베이스 및 응용 어플리케이션의 설정을 하고 있는 클래스입니다
 */
@Slf4j
@Configuration
@PropertySource("classpath:application.properties")
@EnableTransactionManagement
public class DatabaseConfig implements TransactionManagementConfigurer {
	@Autowired
	private ResourceLoader resourceLoader;

	@Autowired
	private ResourcePatternResolver patternResolver;

	@Bean
	public static PropertySourcesPlaceholderConfigurer placeholderConfigurer() {
		return new PropertySourcesPlaceholderConfigurer();
	}

	@Value("${datasource.driver}")
	private String driverClassName;

	@Value("${datasource.url}")
	private String url;

	@Value("${datasource.username}")
	private String username;

	@Value("${datasource.password}")
	private String password;

	@Override
	@Bean(name="transactionManager")
	public PlatformTransactionManager annotationDrivenTransactionManager() {
		return new DataSourceTransactionManager(dataSource());
	}

	@Bean
	public DataSource dataSource() {
		BoneCPDataSource dataSource = new BoneCPDataSource();
		dataSource.setDriverClass(this.driverClassName);
		dataSource.setJdbcUrl(this.url);
		dataSource.setUsername(this.username);
		dataSource.setPassword(this.password);
		dataSource.setMaxConnectionsPerPartition(100);
		dataSource.setMinConnectionsPerPartition(3);
		return dataSource;
	}

	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
		factoryBean.setDataSource(dataSource());
		factoryBean.setConfigLocation(resourceLoader.getResource("classpath:sqlmap-config.xml"));
		factoryBean.setMapperLocations(patternResolver.getResources("classpath:mappers/*.xml"));
		return factoryBean.getObject();
	}

	@Bean
	public SqlSession sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) {
		return new SqlSessionTemplate(sqlSessionFactory);
	}
}
