package dev.codesquad.airbnb02.common.jwt;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import java.util.HashMap;
import java.util.Map;
import org.springframework.stereotype.Service;

@Service
public class JwtService {

  private String secretKey = "JinIsTheBest";

  public String createJwt(String userId) {
    final SignatureAlgorithm SIGNATUREALGORITHM = SignatureAlgorithm.HS256;
    final String USER_ID = "userId";
    final String TYP = "typ";
    final String ALG = "HS256";

    Map<String, Object> header = new HashMap<>();
    header.put(TYP, "JWT");
    header.put(ALG, "HS256");

    Map<String, Object> payload = new HashMap<>();
    payload.put(USER_ID, userId);

    return Jwts.builder()
        .setHeader(header)
        .setClaims(payload)
        .signWith(SIGNATUREALGORITHM, secretKey.getBytes())
        .compact();
  }
}
