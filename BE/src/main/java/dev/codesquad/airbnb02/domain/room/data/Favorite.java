package dev.codesquad.airbnb02.domain.room.data;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Getter
@Setter
@Embeddable
public class Favorite {

  @Column(name = "user_id", nullable = false)
  private Long userId;

  @Column(nullable = false)
  private boolean favor;

  @Builder
  public Favorite(Long userId, boolean favor) {
    this.userId = userId;
    this.favor = favor;
  }
}
