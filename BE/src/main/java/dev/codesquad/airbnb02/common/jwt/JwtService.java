package dev.codesquad.airbnb02.common.jwt;

import dev.codesquad.airbnb02.common.exception.InvalidTokenException;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Service
public class JwtService {

  private final String SECRET_KEY = "JinIsTheBest";
  private final String AUTHORIZATION = "Authorization";
  private final String NULL_TOKEN_USER = "null_token_user";

  public String createJwt(String userId) {
    final SignatureAlgorithm SIGNATUREALGORITHM = SignatureAlgorithm.HS256;
    final String USER_ID = "userId";
    final String TYP = "typ";
    final String ALG = "HS256";
    final int EXPIRATION_TIME = 1000 * 60 * 60 * 10;

    Map<String, Object> header = new HashMap<>();
    header.put(TYP, "JWT");
    header.put(ALG, "HS256");

    Map<String, Object> payload = new HashMap<>();
    payload.put(USER_ID, userId);

    return Jwts.builder()
        .setHeader(header)
        .setClaims(payload)
        .setIssuedAt(new Date(System.currentTimeMillis()))
        .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
        .signWith(SIGNATUREALGORITHM, SECRET_KEY.getBytes())
        .compact();
  }

  public boolean isValidToken(String token) {
    try {
      Jwts.parser().setSigningKey(SECRET_KEY).parseClaimsJws(token);
      return true;
    } catch (Exception e) {
      throw new InvalidTokenException(e.getMessage());
    }
  }

  public String getUserId() {
    HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
    String token = request.getHeader(AUTHORIZATION);
    if (token != null) {
      Jws<Claims> claims = Jwts.parser().setSigningKey(SECRET_KEY).parseClaimsJws(token);
      return claims.getBody().getSubject();
    }
    return NULL_TOKEN_USER;
  }
}
