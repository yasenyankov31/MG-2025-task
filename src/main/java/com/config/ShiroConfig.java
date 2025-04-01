package com.config;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.Filter;

import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.realm.Realm;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.security.CustomRealm;
import com.security.RestAuthenticationFilter;

@Configuration
public class ShiroConfig {
	@Bean
	public Realm realm() {
		return new CustomRealm();
	}

	@Bean
	public ShiroFilterFactoryBean shiroFilterFactoryBean(SecurityManager securityManager) {
		ShiroFilterFactoryBean filterFactory = new ShiroFilterFactoryBean();
		filterFactory.setSecurityManager(securityManager);

		Map<String, Filter> filters = new HashMap<>();
		filters.put("restAuthc", new RestAuthenticationFilter());
		filterFactory.setFilters(filters);

		Map<String, String> filterChain = new LinkedHashMap<>();
		// Public endpoints
		filterChain.put("/api/auth/login", "anon");
		filterChain.put("/api/auth/register", "anon");

		// Swagger UI resources
		filterChain.put("/swagger-ui/**", "anon");
		filterChain.put("/swagger-ui.html", "anon");
		filterChain.put("/swagger-resources/**", "anon");
		filterChain.put("/v2/api-docs/**", "anon");
		filterChain.put("/v3/api-docs/**", "anon");
		filterChain.put("/webjars/**", "anon");

		// Secure all other endpoints
		filterChain.put("/**", "restAuthc");

		filterFactory.setFilterChainDefinitionMap(filterChain);

		return filterFactory;
	}
}
