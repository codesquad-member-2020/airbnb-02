package dev.codesquad.airbnb02.domain.room.business;

import static org.assertj.core.api.Assertions.*;

import java.util.Optional;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import dev.codesquad.airbnb02.application.dto.RoomDetailResponseDto;
import dev.codesquad.airbnb02.common.exception.NotFoundDataException;

@SpringBootTest
public class RoomServiceTest {

	@Autowired
	private RoomService roomService;

	@DisplayName("상세 페이지 DTO가 리턴된다.")
	@CsvSource("1, 2, 3, 4, 5")
	@ParameterizedTest
	void 상세_페이지_DTO가_리턴된다(Long roomId) {
		RoomDetailResponseDto roomDetailDto = Optional.ofNullable(roomService.findDetailByRoomId(roomId))
			.orElseThrow(NotFoundDataException::new);
		assertThat(roomDetailDto).isInstanceOf(RoomDetailResponseDto.class);
		assertThat(roomDetailDto.getId()).isEqualTo(roomId);
	}
}
