package dev.codesquad.airbnb02.domain.user.business;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dev.codesquad.airbnb02.application.dto.RoomResponseDto;
import dev.codesquad.airbnb02.common.exception.NotFoundDataException;
import dev.codesquad.airbnb02.domain.room.data.RoomRepository;
import dev.codesquad.airbnb02.domain.room.entity.Room;
import dev.codesquad.airbnb02.domain.user.data.UserRepository;
import dev.codesquad.airbnb02.domain.user.entity.User;

@Service
@Transactional(readOnly = true)
public class UserService {

	private final UserRepository userRepository;
	private final RoomRepository roomRepository;

	public UserService(UserRepository userRepository,
		RoomRepository roomRepository) {
		this.userRepository = userRepository;
		this.roomRepository = roomRepository;
	}

	@Transactional
	public RoomResponseDto addBookmark(Long userId, Long roomId) {
		User user = userRepository.findById(userId).orElseThrow(NotFoundDataException::new);
		Room room = roomRepository.findById(roomId).orElseThrow(NotFoundDataException::new);
		user.addBookmark(room);
		userRepository.save(user);
		return RoomResponseDto.create(room, true);
	}

	@Transactional
	public RoomResponseDto removeBookmark(Long userId, Long roomId) {
		User user = userRepository.findById(userId).orElseThrow(NotFoundDataException::new);
		Room room = roomRepository.findById(roomId).orElseThrow(NotFoundDataException::new);
		user.removeBookmark(room);
		userRepository.save(user);
		return RoomResponseDto.create(room, false);
	}

	public boolean isUserBookmarkedRoom(Long userId, Long roomId) {
		User user = userRepository.findById(userId).orElseThrow(NotFoundDataException::new);
		Room room = roomRepository.findById(roomId).orElseThrow(NotFoundDataException::new);
		return user.isBookmarked(room);
	}

	public User findUser(Long userId) {
		return userRepository.findById(userId).orElseThrow(NotFoundDataException::new);
	}
}
