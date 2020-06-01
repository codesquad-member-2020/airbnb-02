package dev.codesquad.airbnb02.domain.user.business;

import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dev.codesquad.airbnb02.application.dto.RoomResponseDto;
import dev.codesquad.airbnb02.common.exception.NotFoundDataException;
import dev.codesquad.airbnb02.domain.room.data.RoomRepository;
import dev.codesquad.airbnb02.domain.room.entity.Room;
import dev.codesquad.airbnb02.domain.user.data.UserRepository;
import dev.codesquad.airbnb02.domain.user.entity.User;

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
		User user = userRepository.findById(userId).orElseThrow(NotFoundDataException::new);
		Room room = roomRepository.findById(roomId).orElseThrow(NotFoundDataException::new);
		user.addLikedRoom(room);
		userRepository.save(user);
		//TODO: 아래 하드코딩한 favorite 결과를 리팩토링 어떻게 할 지 고민해본다.
		return RoomResponseDto.create(room, true);
	}

	@Transactional
	public RoomResponseDto deleteLikedRoom(Long userId, Long roomId) {
		User user = userRepository.findById(userId).orElseThrow(NotFoundDataException::new);
		Room room = roomRepository.findById(roomId).orElseThrow(NotFoundDataException::new);
		user.deleteLikedRoom(room);
		userRepository.save(user);
		//TODO: 아래 하드코딩한 favorite 결과를 리팩토링 어떻게 할 지 고민해본다.
		return RoomResponseDto.create(room, false);
	}

	@Transactional(readOnly = true)
	public boolean findLikedRoomByUserIdAndRoomId(Long userId, Long roomId) {
		User user = userRepository.findById(userId).orElseThrow(NotFoundDataException::new);
		// Room room = roomRepository.findById(roomId).orElseThrow(NotFoundDataException::new);
		//TODO: 아래 메소드가 roomId가 아니라 room을 받아서 처리하도록 리팩토링한다.
		return ! Objects.isNull(user.findLikedRoomByRoomId(roomId));
	}

}
