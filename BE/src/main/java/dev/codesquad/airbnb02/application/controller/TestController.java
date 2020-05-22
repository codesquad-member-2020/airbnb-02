package dev.codesquad.airbnb02.application.controller;

import dev.codesquad.airbnb02.domain.host.data.HostRepository;
import dev.codesquad.airbnb02.domain.room.data.RoomRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    private final HostRepository hostRepository;

    public TestController(HostRepository hostRepository) {
        this.hostRepository = hostRepository;
    }

    @Autowired
    private RoomRepository roomRepository;

    @GetMapping("/")
    public ResponseEntity test() {
        return ResponseEntity.ok(hostRepository.findAll());
    }
}
