package dev.codesquad.airbnb02.common.jwt;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
  private static final String[] EXCLUDE_PATHS = {
      "/search/**",
      "/all",
      "/detail/**",
      "/callback",
      "/user/**",
      "/booking/**"
  };

  @Bean
  public JwtInterceptor userInterceptor() {
    return new JwtInterceptor();
  }

  @Override
  public void addInterceptors(InterceptorRegistry registry) {
    registry.addInterceptor(userInterceptor())
        .addPathPatterns("/**")
        .excludePathPatterns(EXCLUDE_PATHS);
  }
}
