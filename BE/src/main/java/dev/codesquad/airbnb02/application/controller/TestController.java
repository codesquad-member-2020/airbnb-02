package dev.codesquad.airbnb02.application.controller;

import dev.codesquad.airbnb02.domain.host.data.HostRepository;
import dev.codesquad.airbnb02.domain.room.business.RoomService;
import dev.codesquad.airbnb02.domain.room.data.RoomRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

  private final HostRepository hostRepository;

  public TestController(HostRepository hostRepository) {
    this.hostRepository = hostRepository;
  }

  @Autowired
  private RoomRepository roomRepository;

  @Autowired
  private RoomService roomService;

  @GetMapping("/")
  public ResponseEntity viewRooms(@RequestParam(value = "checkin", required = false) String checkin,
      @RequestParam(value = "checkout", required = false) String checkout,
      @RequestParam(value = "adults", required = false) Integer adults,
      @RequestParam(value = "price_min", required = false) Integer priceMin,
      @RequestParam(value = "price_max", required = false) Integer priceMax,
      @RequestParam(value = "location", required = false) String location) {
    return ResponseEntity.ok(roomService.findAll());
  }
}
