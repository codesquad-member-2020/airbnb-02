package dev.codesquad.airbnb02.common.oauth.service;

import dev.codesquad.airbnb02.common.oauth.Github;
import dev.codesquad.airbnb02.common.oauth.GithubUser;
import dev.codesquad.airbnb02.common.oauth.RequestBody;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class LoginService {

    private static final Logger logger = LoggerFactory.getLogger(LoginService.class);

    private final String HEADER_ACCEPT = "Accept";
    private final String HEADER_MEDIA_TYPE = "application/json";
    private final String GITHUB_ACCESS_TOKEN_URL = "https://github.com/login/oauth/access_token";
    private final String GITHUB_USER_INFO_URL = "https://api.github.com/user";

    @Value("${GITHUB_CLIENT_ID}")
    private String GITHUB_CLIENT_ID;

    @Value("${GITHUB_CLIENT_SECRET}")
    private String GITHUB_CLIENT_SECRET;

    public Github requestAccessToken(String code) {
        RequestBody requestBody = RequestBody.builder()
                .clientId(GITHUB_CLIENT_ID)
                .clientSecret(GITHUB_CLIENT_SECRET)
                .code(code)
                .build();
        HttpHeaders headers = new HttpHeaders();
        headers.set(HEADER_ACCEPT, HEADER_MEDIA_TYPE);
        HttpEntity<?> httpEntity = new HttpEntity<>(requestBody, headers);
        ResponseEntity<Github> responseEntity = new RestTemplate().postForEntity(GITHUB_ACCESS_TOKEN_URL, httpEntity, Github.class);
        return responseEntity.getBody();
    }

    public GithubUser requestUserInfo(String accessToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(accessToken);
        HttpEntity<?> httpEntity = new HttpEntity<>(headers);
        ResponseEntity<GithubUser> responseEntity = new RestTemplate().exchange(GITHUB_USER_INFO_URL, HttpMethod.GET, httpEntity, GithubUser.class);
        return responseEntity.getBody();
    }
}
