package dev.codesquad.airbnb02.application.dto;

import dev.codesquad.airbnb02.domain.favorite.Favorite;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@NoArgsConstructor
public class UserFavoriteResponseDto {

  private Long roomId;
  private Long userId;
  private boolean favor;

  private UserFavoriteResponseDto(Favorite favorite, Long userId) {
    this.roomId = favorite.getRoomId();
    this.userId = userId;
    this.favor = favorite.isFavor();
  }

  public static UserFavoriteResponseDto create(Favorite favorite, Long userId) {
    return new UserFavoriteResponseDto(favorite, userId);
  }
}
