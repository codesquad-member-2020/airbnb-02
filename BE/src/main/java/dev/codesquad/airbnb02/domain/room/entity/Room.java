package dev.codesquad.airbnb02.domain.room.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import dev.codesquad.airbnb02.domain.host.entity.Host;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import javax.persistence.*;
import javax.validation.constraints.NotNull;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Getter
@Setter
@ToString(exclude = {"images", "bookings"})
public class Room {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @NotNull
  private String name;

  @NotNull
  @Enumerated(EnumType.STRING)
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

  @Embedded
  private Locale locale;

  @OneToMany(mappedBy = "room")
  @JsonIgnore
  private List<Image> images;

  @ManyToOne
  @JoinColumn(foreignKey = @ForeignKey(name = "host_id"))
  @NotNull
  private Host host;

  @OneToMany(mappedBy = "room")
  @JsonIgnore
  private List<Booking> bookings;

  public Room() {}

  public boolean isValidPrice(Integer priceMin, Integer priceMax) {
    if (checkNull(priceMax)) {
      return true;
    }
    return priceMin <= this.price && this.price <= priceMax;
  }

  public boolean isValidDate(LocalDate checkin, LocalDate checkout) {
    if (checkNull(checkin) || checkNull(checkout)) {
      return true;
    }

    /**
     * checkin - checkout 내에, 숙소가 예약 가능 하다면 true, 아니면 false 반환
     */
    for(Booking booking : this.bookings) {
      if (!booking.isAvailable(checkin, checkout)) {
        return false;
      }
    }
    return true;
  }

  private boolean checkNull(Object input) {
    return Objects.isNull(input);
  }
}
