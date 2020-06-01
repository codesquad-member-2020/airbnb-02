package dev.codesquad.airbnb02.domain.room.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import dev.codesquad.airbnb02.common.exception.NotFoundDataException;
import dev.codesquad.airbnb02.domain.host.entity.Host;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.CascadeType;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotNull;

import dev.codesquad.airbnb02.domain.user.entity.User;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Getter
@Setter
@ToString(exclude = {"images"})
@NoArgsConstructor
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
  private List<Image> images = new ArrayList<>();

  @NotNull
  @ManyToOne
  @JoinColumn(foreignKey = @ForeignKey(name = "host_id"))
  private Host host;

  @JsonIgnore
  @ManyToMany
  @JoinTable(
      name = "favorite",
      joinColumns = @JoinColumn(name = "room_id"),
      inverseJoinColumns = @JoinColumn(name = "user_id")
  )
  private List<User> users;

  @OneToMany(mappedBy = "room", cascade = CascadeType.ALL, orphanRemoval = true)
  private List<Booking> bookings = new ArrayList<>();

  public boolean isValidLocation(String location) {
    if (checkNull(location)) {
      return true;
    }
    return this.locale.isEqualsLocation(location);
  }

  public boolean isValidPrice(Integer priceMin, Integer priceMax) {
    if (checkNull(priceMax)) {
      return true;
    }
    return priceMin <= this.price && this.price <= priceMax;
  }

  /**
   * checkin - checkout 내에, 숙소가 예약 가능 하다면 true, 아니면 false 반환
   */
  public boolean isValidDate(LocalDate checkin, LocalDate checkout) {
    if (checkNull(checkin) || checkNull(checkout)) {
      return true;
    }

    for (Booking booking : this.bookings) {
      if (!booking.isAvailable(checkin, checkout)) {
        return false;
      }
    }
    return true;
  }

  public void addBooking(Booking booking) {
    bookings.add(booking);
    booking.setRoom(this);
  }

  public void addBookings(LocalDate checkin, LocalDate checkout) {
    for (LocalDate date = checkin; date.isBefore(checkout); date = date.plusDays(1)) {
      Booking booking = Booking.create(date);
      addBooking(booking);
    }
  }

  public void removeBooking(Booking booking) {
    bookings.remove(booking);
  }

  public void removeBookings(LocalDate checkin, LocalDate checkout) {
    for (LocalDate date = checkin; date.isBefore(checkout); date = date.plusDays(1)) {
      Booking booking = findBookingByDate(date);
      removeBooking(booking);
    }
  }

  public List<Booking> findBookings(LocalDate checkin, LocalDate checkout) {
    List<Booking> bookings = new ArrayList<>();
    for (LocalDate date = checkin; date.isBefore(checkout); date = date.plusDays(1)) {
       bookings.add(Booking.create(date));
    }
    return bookings;
  }

  private Booking findBookingByDate(LocalDate date) {
    for (Booking booking : this.bookings) {
      if (booking.isEqualsBookDate(date)) {
        return booking;
      }
    }
    throw new NotFoundDataException("해당 기간에 예약이 없습니다.");
  }

  private boolean checkNull(Object input) {
    return Objects.isNull(input);
  }
}
