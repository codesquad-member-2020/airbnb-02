package dev.codesquad.airbnb02.domain.favorite;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
@Embeddable
public class Favorite {

  @Column(name = "room_id", nullable = false)
  private Long roomId;

  @Column(nullable = false)
  private boolean favor;

  @Builder
  public Favorite(Long roomId, boolean favor) {
    this.roomId = roomId;
    this.favor = favor;
  }
}
