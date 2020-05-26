package dev.codesquad.airbnb02.application.controller;

import dev.codesquad.airbnb02.application.dto.RoomResponseDto;
import dev.codesquad.airbnb02.domain.room.business.RoomService;
import java.util.Date;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class RoomController {

  private Logger logger = LoggerFactory.getLogger(RoomController.class);

  private final RoomService roomService;

  @GetMapping("/")
  public ResponseEntity<List<RoomResponseDto>> viewFilteredRooms(
      @RequestParam(value = "checkin", required = false) String checkin,
      @RequestParam(value = "checkout", required = false) String checkout,
      @RequestParam(value = "adults", required = false) Integer adults,
      @RequestParam(value = "price_min", required = false, defaultValue = "0") Integer priceMin,
      @RequestParam(value = "price_max", required = false) Integer priceMax,
      @RequestParam(value = "location", required = false) String location) {

    return new ResponseEntity<>(roomService.findFilteredBy(location, priceMin, priceMax, checkin, checkout),
        HttpStatus.OK);
  }

  @GetMapping(value = "/", params = {"!checkin", "!checkout", "!adults", "!price_min", "!price_max",
      "!location"})
  public ResponseEntity<List<RoomResponseDto>> viewAllRooms() {
    return new ResponseEntity<>(roomService.findAll(), HttpStatus.OK);
  }
}
