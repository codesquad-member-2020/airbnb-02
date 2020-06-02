package dev.codesquad.airbnb02.application.dto;

import dev.codesquad.airbnb02.domain.room.entity.Booking;
import dev.codesquad.airbnb02.domain.room.entity.Room;
import dev.codesquad.airbnb02.domain.user.entity.User;
import java.util.ArrayList;
import java.util.List;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class BookingResponseDto {

  private Long userId;
  private Long roomId;
  private List<Booking> bookings = new ArrayList<>();

  private BookingResponseDto(User user, Room room) {
    this.userId = user.getId();
    this.roomId = room.getId();
    this.bookings = room.findBookingsByUser(user);
  }

  public static BookingResponseDto create(User user, Room room) {
    return new BookingResponseDto(user, room);
  }
}
