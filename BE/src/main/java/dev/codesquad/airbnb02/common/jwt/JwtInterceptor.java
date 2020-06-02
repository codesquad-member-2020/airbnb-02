package dev.codesquad.airbnb02.common.jwt;

import dev.codesquad.airbnb02.common.exception.InvalidTokenException;
import java.util.Objects;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Slf4j
@NoArgsConstructor
public class JwtInterceptor extends HandlerInterceptorAdapter {

  private final String AUTHORIZATION = "Authorization";

  private JwtService jwtService;

  public JwtInterceptor(JwtService jwtService) {
    this.jwtService = jwtService;
  }

  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
    if (request.getMethod().equals("OPTIONS")) {
      return true;
    }
    final String token = request.getHeader(AUTHORIZATION);
    if (Objects.isNull(token)) {
      throw new InvalidTokenException("Token must not be null");
    }
    log.info("token >> {}", token);
    if (!jwtService.isValidToken(token)) {
      return false;
    }
    return true;
  }
}
