package dev.codesquad.airbnb02.user.business;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatExceptionOfType;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.junit.jupiter.api.Assertions.assertAll;

import dev.codesquad.airbnb02.domain.user.business.UserService;
import dev.codesquad.airbnb02.domain.user.data.UserRepository;
import dev.codesquad.airbnb02.domain.user.entity.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

@SpringBootTest
public class UserServiceTest {

  @Autowired
  private UserService userService;

  @Autowired
  private UserRepository userRepository;

  User user;

  @BeforeEach
  void setUp() {
    user = userRepository.findById(1L).get();
  }

  @DisplayName("사용자의 즐겨찾기가 새롭게 게시글 DB에 추가된다.")
  @Transactional
  @Test
  void 즐겨찾기가_추가된다() {
    //given
    int previousSize = user.getFavorites().size();
    //when
    Long nextRoomId = (long) user.getFavorites().size() + 5;
    boolean afterResult = userService.addFavorite(nextRoomId, user.getId()).isFavor();
    //then
    assertAll(
        () -> assertThat(afterResult).isEqualTo(true),
        () -> assertThat(userRepository.findById(1L).get().getFavorites().size())
            .isGreaterThan(previousSize),
        () -> assertThat(userRepository.findById(1L).get().getFavorites().get(
            userRepository.findById(1L).get().getFavorites().size() - 1
        ).isFavor()).isEqualTo(true)
    );
  }

  @DisplayName("사용자의 즐겨찾기를 게시글 DB에서 삭제한다.")
  @CsvSource({"1", "2"})
  @Transactional
  @ParameterizedTest
  void 즐겨찾기가_취소된다(Long roomId) {
    //given
    boolean beforeResult = user.getFavorites().get(0).isFavor();
    assertThat(beforeResult).isEqualTo(true);
    //when
    boolean afterResult = userService.deleteFavorite(roomId, user.getId()).isFavor();
    //then
    assertThat(userRepository.findById(1L).get().getFavorites().get(0).isFavor())
        .isEqualTo(afterResult);
  }

  @DisplayName("사용자의 즐겨찾기를 보여주는 DB 상에 존재하지 않는 방을 삭제하려고 하면 오류를 발생시킨다.")
  @CsvSource({"3", "4"})
  @ParameterizedTest
  void 즐겨찾기가_없으면_삭제시_오류를_뿜는다(Long roomId) {
    assertThatExceptionOfType(RuntimeException.class)
        .isThrownBy(() -> user.deleteFavorite(roomId));
  }
}
