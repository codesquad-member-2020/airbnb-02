package dev.codesquad.airbnb02.domain.user.entity;

import dev.codesquad.airbnb02.domain.favorite.Favorite;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor
public class User {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(name = "github_id")
  private String githubId;

  @ElementCollection
  @CollectionTable(name = "favorite",
      joinColumns = @JoinColumn(name = "user_id", insertable = false, updatable = false))
  private List<Favorite> favorites;

  public Favorite addFavorite(Long roomId) {
    if (Objects.nonNull(findFavoriteByRoomId(roomId))) {
      throw new RuntimeException("already exists.");
    }
    Favorite favorite = Favorite.builder()
        .roomId(roomId)
        .userId(this.id)
        .favor(true)
        .build();
    this.favorites.add(favorite);
    return favorite;
  }

  public Favorite deleteFavorite(Long roomId) {
    Favorite favorite = Optional.ofNullable(findFavoriteByRoomId(roomId))
        .orElseThrow(RuntimeException::new);
    this.favorites.remove(favorite);
    return favorite;
  }

  public Favorite findFavoriteByRoomId(Long roomId) {
    return this.favorites.stream()
        .filter(favorites -> favorites.getRoomId().equals(roomId))
        .findAny()
        .orElse(null);
  }
}
