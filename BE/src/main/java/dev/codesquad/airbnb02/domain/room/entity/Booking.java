package dev.codesquad.airbnb02.domain.room.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import dev.codesquad.airbnb02.domain.user.entity.User;
import java.time.LocalDate;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Getter
@ToString(exclude = {"room", "user"})
@NoArgsConstructor
public class Booking {

  @Id
  @JsonIgnore
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @JsonIgnore
  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(foreignKey = @ForeignKey(name = "user_id"))
  private User user;

  @JsonIgnore
  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(foreignKey = @ForeignKey(name = "room_id"))
  private Room room;

  @NotNull
  private LocalDate bookDate;

  @NotNull
  private int guest;

  @Builder
  private Booking(LocalDate bookDate, User user, Room room, int guest) {
    this.bookDate = bookDate;
    this.user = user;
    this.room = room;
    this.guest = guest;
  }

  public static Booking create(LocalDate bookDate, User user, Room room) {
    return Booking.builder()
        .bookDate(bookDate)
        .user(user)
        .room(room)
        .build();
  }

  /**
   *  checkin - checkout 범위에 bookDate 있는지 확인
   *  이미 예약된 bookDate 있으면(예약 불가 하면) false, 없으면(해당 일에 예약 가능 하면) true
   */
  public boolean isAvailable(LocalDate checkin, LocalDate checkout) {
    for (LocalDate date = checkin; date.isBefore(checkout); date = date.plusDays(1)) {
      if (date.equals(this.bookDate)) {
        return false;
      }
    }
    return true;
  }

  public boolean isEqualsBookDate(LocalDate date) {
    return date.equals(this.bookDate);
  }

  public boolean isEqualsUserId(Long userId) {
    return userId.equals(this.user.getId());
  }

  public boolean isEqualsBookDateAndUserId(LocalDate date, Long userId) {
    return isEqualsBookDate(date) && isEqualsUserId(userId);
  }
}
