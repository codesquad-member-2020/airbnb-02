package dev.codesquad.airbnb02.application.controller;

import java.time.LocalDate;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import dev.codesquad.airbnb02.application.dto.RoomDetailResponseDto;
import dev.codesquad.airbnb02.application.dto.RoomResponseDto;
import dev.codesquad.airbnb02.domain.room.business.RoomService;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class RoomController {

  private Logger logger = LoggerFactory.getLogger(RoomController.class);

  private final RoomService roomService;

  @GetMapping("/search")
  public ResponseEntity<List<RoomResponseDto>> viewFilteredRooms(
      @RequestParam(value = "checkin", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkin,
      @RequestParam(value = "checkout", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkout,
      @RequestParam(value = "adults", required = false, defaultValue = "1") Integer adults,
      @RequestParam(value = "price_min", required = false, defaultValue = "0") Integer priceMin,
      @RequestParam(value = "price_max", required = false) Integer priceMax,
      @RequestParam(value = "location", required = false) String location) {

    return new ResponseEntity<>(
        roomService.findFilteredBy(location, priceMin, priceMax, checkin, checkout),
        HttpStatus.OK);
  }

  @GetMapping("/all")
  public ResponseEntity<List<RoomResponseDto>> viewAllRooms() {
    return new ResponseEntity<>(roomService.findAll(), HttpStatus.OK);
  }

  @GetMapping("/detail/{roomId}")
  public ResponseEntity<RoomDetailResponseDto> viewRoomDetail(@PathVariable Long roomId) {
    return new ResponseEntity<>(roomService.findDetailByRoomId(roomId), HttpStatus.OK);
  }
}
