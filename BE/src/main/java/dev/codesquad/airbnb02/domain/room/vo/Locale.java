package dev.codesquad.airbnb02.domain.room.vo;

import javax.persistence.Embeddable;

import org.springframework.stereotype.Component;

import lombok.Getter;

@Component
@Embeddable
@Getter
public class Locale {
    private String location;
    private Double latitude;
    private Double longitude;
    private String address;

    public boolean isEqualsLocation(String location) {
        return location.equals(this.location);
    }
}
