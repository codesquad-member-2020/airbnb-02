package dev.codesquad.airbnb02.domain.room.vo;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@NoArgsConstructor
@Embeddable
public class Image {

  @Column(name = "image_url")
  private String imageUrl;

  private Image(String imageUrl) {
    this.imageUrl = imageUrl;
  }

  public static Image create(String imageUrl) {
    return new Image(imageUrl);
  }
}
