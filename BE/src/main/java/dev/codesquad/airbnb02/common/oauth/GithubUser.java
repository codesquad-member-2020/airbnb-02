package dev.codesquad.airbnb02.common.oauth;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class GithubUser {

    @JsonProperty("login")
    private String userId;

    public GithubUser() {
    }

    public String getUserId() {
        return userId;
    }
}
