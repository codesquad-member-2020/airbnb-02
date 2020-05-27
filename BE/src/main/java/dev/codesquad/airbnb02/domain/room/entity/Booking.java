package dev.codesquad.airbnb02.domain.room.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
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
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Getter
@Setter
@ToString
public class Booking {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @JsonIgnore
  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(foreignKey = @ForeignKey(name = "room_id"))
  private Room room;

  @NotNull
  private LocalDate bookDate;

  @NotNull
  private int guest;

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
}
