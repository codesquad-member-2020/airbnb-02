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

  public boolean isValidDate(String checkinInput, String checkoutInput) {
    LocalDate checkin = LocalDate.parse(checkinInput);
    LocalDate checkout = LocalDate.parse(checkoutInput);
    if (checkNull(checkin) || checkNull(checkout)) {
      return true;
    }
    // checkin, checkin + 1, checkin + 2 ..... checkout까지 순회한다.
    // booking.getBookDate에 위의 날짜가 있는 지 확인한다.
    // 이 중에서 단 하나라도 true(날짜랑 겹치는 것이 있다) 가 반환되면, 전체를 false 리턴한다.

    for (LocalDate date = checkin; date.isBefore(checkout); date = date.plusDays(1)) {
      for (Booking booking : this.bookings) {
        if (booking.getBookDate().isEqual(date)) {
          return true;
        }
      }
      return false;
    }
    return false;
  }

  private boolean checkNull(Object input) {
    return Objects.isNull(input);
  }
}
