package dev.codesquad.airbnb02.application.dto;

import dev.codesquad.airbnb02.domain.room.entity.Booking;
import dev.codesquad.airbnb02.domain.room.entity.Room;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class BookingResponseDto {

  private List<Booking> bookings = new ArrayList<>();

  protected BookingResponseDto(Room room) {
    this.bookings = room.getBookings();
  }

  public static BookingResponseDto create(Room room) {
    return new BookingResponseDto(room);
  }
}
