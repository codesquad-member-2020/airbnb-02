package dev.codesquad.airbnb02.common.oauth;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Github {

    @JsonProperty("access_token")
    private String accessToken;

    @JsonProperty("token_type")
    private String tokenType;

    @JsonProperty("scope")
    private String scope;

    public Github() {
    }

    public String getAccessToken() {
        return accessToken;
    }

    public String getAuthorization() {
        return tokenType + " " + accessToken;
    }
}
