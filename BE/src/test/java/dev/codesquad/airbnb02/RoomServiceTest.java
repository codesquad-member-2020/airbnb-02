package dev.codesquad.airbnb02;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertAll;

import dev.codesquad.airbnb02.domain.room.business.RoomService;
import java.time.LocalDate;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class RoomServiceTest {

  private final RoomService roomService;

  public RoomServiceTest(RoomService roomService) {
    this.roomService = roomService;
  }

  @DisplayName("체크인 날짜와 체크아웃 날짜에 따라 필터링이 된다.")
  @CsvSource({"2020-05-20, 2020-05-21, 2", "2020-05-16, 2020-05-21, 1",
      "2020-05-25, 2020-05-26, 0"})
  @ParameterizedTest
  void 체크인_체크아웃_날짜에_따라_리턴된다(String checkin, String checkout, Integer result) {
    assertThat(roomService.findFilteredBy(null, null, null,
        LocalDate.parse(checkin), LocalDate.parse(checkout))
        .size()).isEqualTo(result);
  }
}
