package dev.codesquad.airbnb02.application.controller;

import dev.codesquad.airbnb02.common.oauth.Github;
import dev.codesquad.airbnb02.common.oauth.GithubUser;
import dev.codesquad.airbnb02.common.oauth.service.LoginService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

@RestController
public class LoginController {

    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    private final String USER_ID = "userId";
    private final Integer EXPIRE_TIME = 60*60*6;
    private final String HEADER_LOCATION = "Location";
    private final String REDIRECT_URL = "http://localhost:8080";
    public static final String OAUTH_URL_SERVER = "https://github.com/login/oauth/authorize?client_id=8d92d01b11ba14d3d18f&scope=user:email";

    @Autowired
    private LoginService loginService;

    @GetMapping("/callback")
    public ResponseEntity oauthCallback(@Param("code") String code, HttpServletResponse response) {
        Github github = loginService.requestAccessToken(code);
        logger.info("Github AccessToken, TokenType, Scope Data : {}", github);
        GithubUser githubUser = loginService.requestUserInfo(github.getAccessToken());
        logger.info("Github UserId : {}", githubUser);

        Cookie cookie = new Cookie(USER_ID, githubUser.getUserId());
        cookie.setMaxAge(EXPIRE_TIME);
        response.addCookie(cookie);
        response.setHeader(HEADER_LOCATION, REDIRECT_URL);
        return new ResponseEntity(HttpStatus.FOUND);
    }
}
