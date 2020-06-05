package dev.codesquad.airbnb02.application.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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

  @PostMapping("/favorite/add")
  public ResponseEntity<RoomResponseDto> addFavorite(@RequestParam(value = "room_id") Long roomId) {
    Long userId = userService.findUserIdByToken();
    return ResponseEntity.ok(userService.addBookmark(userId, roomId));
  }

  @DeleteMapping("/favorite/delete")
  public ResponseEntity<RoomResponseDto> deleteFavorite(@RequestParam(value = "room_id") Long roomId) {
    Long userId = userService.findUserIdByToken();
    return ResponseEntity.ok(userService.removeBookmark(userId, roomId));
  }

  @GetMapping("/favorite/all")
  public ResponseEntity<List<RoomResponseDto>> viewBookmarkedRooms() {
    Long userId = userService.findUserIdByToken();
    return ResponseEntity.ok(userService.getBookmarkedRooms(userId));
  }
}
