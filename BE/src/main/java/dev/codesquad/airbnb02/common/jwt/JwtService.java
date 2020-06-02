package dev.codesquad.airbnb02.common.jwt;

import dev.codesquad.airbnb02.common.exception.InvalidTokenException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import org.springframework.stereotype.Service;

@Service
public class JwtService {

  private final String SECRET_KEY = "JinIsTheBest";

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
}
