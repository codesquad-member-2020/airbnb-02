package dev.codesquad.airbnb02.application.controller;

import dev.codesquad.airbnb02.application.dto.RoomResponseDto;
import dev.codesquad.airbnb02.domain.user.business.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {

  private final UserService userService;

  @GetMapping("/{userId}/favorite/add")
  public ResponseEntity<RoomResponseDto> addFavorite(@PathVariable Long userId,
      @RequestParam(value = "roomId") Long roomId) {
    return ResponseEntity.ok(userService.addLikedRoom(userId, roomId));
  }

  @GetMapping("/{userId}/favorite/delete")
  public ResponseEntity<RoomResponseDto> deleteFavorite(@PathVariable Long userId,
      @RequestParam(value = "roomId") Long roomId) {
    return ResponseEntity.ok(userService.deleteLikedRoom(userId, roomId));
  }
}
