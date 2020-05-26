package dev.codesquad.airbnb02.domain.room.entity;

import lombok.Getter;

import javax.persistence.Embeddable;
import org.springframework.stereotype.Component;

@Component
@Embeddable
@Getter
public class Locale {
    private String location;
    private Double latitude;
    private Double longitude;
    private String address;
}
