package dev.codesquad.airbnb02.application.controller;

import dev.codesquad.airbnb02.domain.room.business.RoomService;
import java.time.LocalDate;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/booking")
public class BookingController {

  private final RoomService roomService;

  @GetMapping("/create/{roomId}")
  public ResponseEntity createBooking(
      @PathVariable Long roomId,
      @RequestParam(value = "checkin", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkin,
      @RequestParam(value = "checkout", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkout) {

    roomService.createBooking(roomId, checkin, checkout);
    return new ResponseEntity(HttpStatus.OK);
  }

  @GetMapping("/remove/{roomId}")
  public ResponseEntity removeBooking(
      @PathVariable Long roomId,
      @RequestParam(value = "checkin", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkin,
      @RequestParam(value = "checkout", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkout) {

    roomService.removeBooking(roomId, checkin, checkout);
    return new ResponseEntity(HttpStatus.OK);
  }
}
