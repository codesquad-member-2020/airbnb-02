package dev.codesquad.airbnb02.domain.room.entity;

import lombok.Getter;

import javax.persistence.Embeddable;

@Embeddable
@Getter
public class Location {
    private String location;
    private Double latitude;
    private Double longitude;
    private String address;
}
