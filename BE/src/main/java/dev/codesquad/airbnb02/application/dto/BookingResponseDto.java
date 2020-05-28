package dev.codesquad.airbnb02.application.dto;

import dev.codesquad.airbnb02.domain.room.entity.Booking;
import java.time.LocalDate;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class BookingResponseDto {

  private Long roomId;
  private LocalDate bookDate;

  protected BookingResponseDto(Long roomId, LocalDate bookDate) {
    this.roomId = roomId;
    this.bookDate = bookDate;
  }

  public static BookingResponseDto create(Long roomId, Booking booking) {
    return new BookingResponseDto(roomId, booking.getBookDate());
  }
}
