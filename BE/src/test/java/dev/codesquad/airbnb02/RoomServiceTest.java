package dev.codesquad.airbnb02;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertAll;

import dev.codesquad.airbnb02.application.dto.RoomResponseDto;
import dev.codesquad.airbnb02.domain.room.business.RoomService;
import dev.codesquad.airbnb02.domain.room.entity.Room;
import java.time.LocalDate;
import java.util.List;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class RoomServiceTest {

  @Autowired
  private RoomService roomService;

  @DisplayName("체크인 날짜와 체크아웃 날짜에 따라 필터링이 된다.")
  @CsvSource({"2020-05-20, 2020-05-21, 47", "2020-05-25, 2020-05-26, 50"})
  @ParameterizedTest
  void 체크인_체크아웃_날짜에_따라_리턴된다(String checkin, String checkout, Integer result) {
    assertThat(roomService.findFilteredBy(null, null, null,
        checkin, checkout)
        .size()).isEqualTo(result);
  }
}
