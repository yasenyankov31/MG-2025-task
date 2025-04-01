package com.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;

@OpenAPIDefinition
@Configuration
public class OpenAPIConfig {
	@Bean
	public OpenAPI customConfigAPI() {
		return new OpenAPI().info(new Info().title("SpringBoot"));
	}

}
