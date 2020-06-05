package dev.codesquad.airbnb02.domain.room.vo;

import javax.persistence.Embeddable;

import org.locationtech.jts.geom.Point;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

import com.bedatadriven.jackson.datatype.jts.JtsModule;
import lombok.Getter;

@Component
@Embeddable
@Getter
public class Locale {
    private String location;
    private Double latitude;
    private Double longitude;
    private String address;

    private Point point;

    public boolean isEqualsLocation(String location) {
        return location.equals(this.location);
    }

    @Bean
    public JtsModule jtsModule() {
        return new JtsModule();
    }
}
