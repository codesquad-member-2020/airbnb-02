package dev.codesquad.airbnb02.application.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import dev.codesquad.airbnb02.application.dto.RoomResponseDto;
import dev.codesquad.airbnb02.domain.user.business.UserService;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {

  private final UserService userService;

  @GetMapping("/{userId}/favorite/add")
  public ResponseEntity<RoomResponseDto> addFavorite(@PathVariable Long userId,
      @RequestParam(value = "room_id") Long roomId) {
    return ResponseEntity.ok(userService.addBookmark(userId, roomId));
  }

  @GetMapping("/{userId}/favorite/delete")
  public ResponseEntity<RoomResponseDto> deleteFavorite(@PathVariable Long userId,
      @RequestParam(value = "room_id") Long roomId) {
    return ResponseEntity.ok(userService.removeBookmark(userId, roomId));
  }

  @GetMapping("/{userId}/favorite/all")
  public ResponseEntity viewBookmarkedRooms(@PathVariable Long userId) {
    return ResponseEntity.ok(userService.getBookmarkedRooms(userId));
  }
}
