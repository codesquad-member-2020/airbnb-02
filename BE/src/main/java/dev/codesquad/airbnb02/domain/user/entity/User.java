package dev.codesquad.airbnb02.domain.user.entity;

import dev.codesquad.airbnb02.domain.favorite.Favorite;
import java.util.List;
import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import lombok.Getter;

@Entity
@Getter
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
}
