package dev.codesquad.airbnb02.domain.user.business;

import static org.assertj.core.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import dev.codesquad.airbnb02.domain.room.data.RoomRepository;
import dev.codesquad.airbnb02.domain.room.entity.Room;
import dev.codesquad.airbnb02.domain.user.data.UserRepository;
import dev.codesquad.airbnb02.domain.user.entity.User;

@SpringBootTest
public class UserServiceTest {

	@Autowired
	private UserService userService;

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private RoomRepository roomRepository;

	User user;

	@BeforeEach
	void setUp() {
		user = userRepository.findById(1L).get();
	}

	@DisplayName("다대다 관계로 연결된 사용자는 게시글의 정보를 찾아서 담는다.")
	@Transactional
	@Test
	void 사용자는_게시글_정보를_담는다() {
		//given
		int previousSize = user.getRooms().size();
		//when
		Long nextRoomId = (long) previousSize + 5;
		Room room = roomRepository.findById(nextRoomId).orElseThrow(RuntimeException::new);
		user.addBookmark(room);
		//then
		assertAll(
			() -> assertThat(user.findLikedRoomByRoomId(nextRoomId)).isNotNull(),
			() -> assertThat(userRepository.findById(1L).get().getRooms().size())
				.isGreaterThan(previousSize),
			() -> assertThat(userRepository.findById(1L).get().getRooms().get(
				userRepository.findById(1L).get().getRooms().size() - 1 //last index
			).getId()).isEqualTo((long) previousSize + 5)
		);
	}

	@DisplayName("다대다 관계로 연결된 사용자는 게시글의 정보 중 즐겨찾기를 찾아서 삭제한다.")
	@Transactional
	@Test
	void 사용자는_게시글_정보를_삭제한다() {
		//given
		int previousSize = user.getRooms().size();
		//when
		Long nextRoomId = 1L;
		Room room = roomRepository.findById(nextRoomId).orElseThrow(RuntimeException::new);
		user.removeBookmark(room);
		//then
		assertAll(
			() -> assertThat(user.findLikedRoomByRoomId(nextRoomId)).isNull(),
			() -> assertThat(userRepository.findById(1L).get().getRooms().size())
				.isLessThan(previousSize),
			() -> assertThat(userRepository.findById(1L).get().getRooms().get(
				userRepository.findById(1L).get().getRooms().size() - 1 //last index
			).getId()).isNotEqualTo(nextRoomId)
		);
	}

	@DisplayName("사용자의 즐겨찾기를 보여주는 DB 상에 존재하지 않는 방을 삭제하려고 하면 오류를 발생시킨다.")
	@CsvSource({"49", "50"})
	@ParameterizedTest
	void 즐겨찾기가_없으면_삭제시_오류를_뿜는다(Long roomId) {
		Room room = roomRepository.findById(roomId).orElseThrow(RuntimeException::new);
		assertThatExceptionOfType(RuntimeException.class)
			.isThrownBy(() -> user.removeBookmark(room));
	}

	@DisplayName("사용자 아이디와 방 아이디를 입력하면, 해당 사용자가 해당 방을 좋아요 했는 지 알려준다.")
	@CsvSource({"1,1,true", "1,2,true", "2,1,true", "2,2,true", "3,1,true", "3,2,true",
		"1,5,false", "1,9,false", "1,48,false", "1,18,false", "1,21,false"})
	@ParameterizedTest
	void 사용자가_방을_좋아요_했는지_알려준다(Long userId, Long roomId, boolean result) {
		assertThat(userService.isUserBookmarkedRoom(userId, roomId)).isEqualTo(result);
	}
}
