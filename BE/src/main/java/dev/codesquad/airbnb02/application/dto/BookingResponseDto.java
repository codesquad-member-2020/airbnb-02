package dev.codesquad.airbnb02.application.dto;

import dev.codesquad.airbnb02.domain.room.entity.Booking;
import dev.codesquad.airbnb02.domain.room.entity.Room;
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

  private BookingResponseDto(Long userId, Room room) {
    this.userId = userId;
    this.roomId = room.getId();
    this.bookings = room.findBookingsByUserId(userId);
  }

  public static BookingResponseDto create(Long userId, Room room) {
    return new BookingResponseDto(userId, room);
  }
}
