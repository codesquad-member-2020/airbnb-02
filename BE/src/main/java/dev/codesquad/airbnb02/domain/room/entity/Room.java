package dev.codesquad.airbnb02.domain.room.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.sun.istack.NotNull;
import dev.codesquad.airbnb02.domain.host.entity.Host;
import java.util.List;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.ForeignKey;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
@Getter
@Setter
@ToString(exclude = "images")
public class Room {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @NotNull
  private String name;

  @NotNull
  @Enumerated(EnumType.ORDINAL)
  private RoomType type;

  @NotNull
  private Integer price;

  @NotNull
  private Integer maximumGuest;

  @NotNull
  private Integer bedroom;

  @NotNull
  private Integer bed;

  @NotNull
  private Integer bath;

  @NotNull
  private Double reviewRating;

  @NotNull
  private Integer reviewCount;

  @NotNull
  private String location;

  @NotNull
  private Double latitude;

  @NotNull
  private Double longitude;

  @NotNull
  private String address;

  @OneToMany(mappedBy = "room")
  @JsonIgnore
  private List<Image> images;

  @ManyToOne
  @JoinColumn(foreignKey = @ForeignKey(name = "host_id"))
  @NotNull
  private Host host;

  public Room() {
  }
}
