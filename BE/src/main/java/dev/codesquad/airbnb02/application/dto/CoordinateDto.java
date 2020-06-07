package dev.codesquad.airbnb02.application.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@NoArgsConstructor
public class CoordinateDto {

  private Double latitude;
  private Double longitude;

  private CoordinateDto(Double latitude, Double longitude) {
    this.latitude = latitude;
    this.longitude = longitude;
  }

  public static CoordinateDto ofLatitudeAndLongitude(Double latitude, Double longitude) {
    return new CoordinateDto(latitude, longitude);
  }
}
