package dev.codesquad.airbnb02.domain.room.entity;

import javax.persistence.ForeignKey;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.NotNull;

@Entity
@Getter
@Setter
@ToString
public class Image {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @NotNull
  private String imageUrl;

  @ManyToOne
  @JoinColumn(foreignKey = @ForeignKey(name = "room_id"))
  @NotNull
  private Room room;

  public Image() {
  }
}
