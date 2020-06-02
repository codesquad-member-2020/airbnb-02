package dev.codesquad.airbnb02.domain.user.business;

import dev.codesquad.airbnb02.domain.room.business.RoomService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dev.codesquad.airbnb02.application.dto.RoomResponseDto;
import dev.codesquad.airbnb02.common.exception.NotFoundDataException;
import dev.codesquad.airbnb02.domain.room.data.RoomRepository;
import dev.codesquad.airbnb02.domain.room.entity.Room;
import dev.codesquad.airbnb02.domain.user.data.UserRepository;
import dev.codesquad.airbnb02.domain.user.entity.User;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class UserService {

	private final UserRepository userRepository;
	private final RoomService roomService;

	@Transactional
	public RoomResponseDto addBookmark(Long userId, Long roomId) {
		User user = findUser(userId);
		Room room = roomService.findRoom(roomId);
		user.addBookmark(room);
		userRepository.save(user);
		return RoomResponseDto.create(room, true);
	}

	@Transactional
	public RoomResponseDto removeBookmark(Long userId, Long roomId) {
		User user = findUser(userId);
		Room room = roomService.findRoom(roomId);
		user.removeBookmark(room);
		userRepository.save(user);
		return RoomResponseDto.create(room, false);
	}

	public boolean isUserBookmarkedRoom(Long userId, Long roomId) {
		User user = findUser(userId);
		Room room = roomService.findRoom(roomId);
		return user.isBookmarked(room);
	}

	public User findUser(Long userId) {
		return userRepository.findById(userId).orElseThrow(() -> new NotFoundDataException("해당 유저를 찾을 수 없습니다."));
	}
}
