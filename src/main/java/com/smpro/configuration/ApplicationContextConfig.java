package com.smpro.configuration;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

/**
 * Created by erobeat on 2014. 4. 10.
 */
@Slf4j
@Configuration
@ComponentScan(basePackages = {"smpro.configuration", "smpro.service", "smpro.repository", "smpro.util.crypt"})
public class ApplicationContextConfig {

}
