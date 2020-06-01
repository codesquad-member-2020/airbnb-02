package dev.codesquad.airbnb02.domain.user.business;

import dev.codesquad.airbnb02.application.dto.RoomResponseDto;
import dev.codesquad.airbnb02.domain.room.data.RoomRepository;
import dev.codesquad.airbnb02.domain.room.entity.Room;
import dev.codesquad.airbnb02.domain.user.data.UserRepository;
import dev.codesquad.airbnb02.domain.user.entity.User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserService {

  private final UserRepository userRepository;
  private final RoomRepository roomRepository;

  public UserService(UserRepository userRepository,
      RoomRepository roomRepository) {
    this.userRepository = userRepository;
    this.roomRepository = roomRepository;
  }

  @Transactional
  public RoomResponseDto addLikedRoom(Long userId, Long roomId) {
    User user = userRepository.findById(userId).orElseThrow(RuntimeException::new);
    Room room = roomRepository.findById(roomId).orElseThrow(RuntimeException::new);
    user.addLikedRoom(room);
    userRepository.save(user);
    return RoomResponseDto.create(room);
  }

  @Transactional
  public RoomResponseDto deleteLikedRoom(Long userId, Long roomId) {
    User user = userRepository.findById(userId).orElseThrow(RuntimeException::new);
    Room room = roomRepository.findById(roomId).orElseThrow(RuntimeException::new);
    user.deleteLikedRoom(room);
    userRepository.save(user);
    return RoomResponseDto.create(room);
  }

}
