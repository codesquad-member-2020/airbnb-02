package dev.codesquad.airbnb02.domain.user.business;

import dev.codesquad.airbnb02.common.jwt.JwtService;
import dev.codesquad.airbnb02.domain.room.business.RoomService;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
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
	private final RoomRepository roomRepository;
	private final JwtService jwtService;

	@Transactional
	public RoomResponseDto addBookmark(Long userId, Long roomId) {
		User user = findUser(userId);
		Room room = findRoom(roomId);
		user.addBookmark(room);
		userRepository.save(user);
		return RoomResponseDto.create(room, true);
	}

	@Transactional
	public RoomResponseDto removeBookmark(Long userId, Long roomId) {
		User user = findUser(userId);
		Room room = findRoom(roomId);
		user.removeBookmark(room);
		userRepository.save(user);
		return RoomResponseDto.create(room, false);
	}

	public boolean isUserBookmarkedRoom(Long userId, Long roomId) {
		User user = findUser(userId);
		Room room = findRoom(roomId);
		return user.isBookmarked(room);
	}

	public User findUser(Long userId) {
		return userRepository.findById(userId).orElseThrow(() -> new NotFoundDataException("해당 유저를 찾을 수 없습니다."));
	}

	public Room findRoom(Long roomId) {
		return roomRepository.findById(roomId).orElseThrow(() -> new NotFoundDataException("해당 숙소를 찾을 수 없습니다."));
	}

	public List<RoomResponseDto> getBookmarkedRooms(Long userId) {
		User user = findUser(userId);
		List<Room> bookmarkedRoom = user.getRooms();
		return bookmarkedRoom.stream()
				.map(room -> RoomResponseDto.create(room, true))
				.collect(Collectors.toList());
	}

	public User findUserByGithubId(String githubId) {
		return userRepository.findUserByGithubId(githubId).orElseThrow(() -> new NotFoundDataException("해당 유저를 찾을 수 없습니다."));
	}

	public Long findUserIdByToken() {
		String githubId = jwtService.getUserId();
		return findUserByGithubId(githubId).getId();
	}

	@Transactional
	public void save(String githubId) {
		User user = userRepository.findUserByGithubId(githubId).orElse(null);
		if (!Objects.isNull(user)) {
			return;
		}
		User newUser = User.create(githubId);
		userRepository.save(newUser);
	}
}
