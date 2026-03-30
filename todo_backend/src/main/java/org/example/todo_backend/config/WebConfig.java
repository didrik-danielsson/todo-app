package org.example.todo_backend.config;

import org.springframework.context.annotation.Configuration;

@Configuration
public class WebConfig {


    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOrigins("*") // Tillåter alla källor under utveckling
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                .allowedHeaders("*");
    }
    
}

