package dev.codesquad.airbnb02.application.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertAll;

import java.util.Objects;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class UserControllerTest {

  @LocalServerPort
  private int port;

  HttpHeaders headers = new HttpHeaders();

  // @DisplayName("컨트롤러 접속을 통하여 정상적으로 즐겨찾기가 등록되는 지 확인한다.")
  // @CsvSource({"11", "12", "13"})
  // @ParameterizedTest
  // void 즐겨찾기가_등록된다(Long roomId) {
  //   String baseUrl = "http://localhost:" + port;
  //   UriComponents builder = UriComponentsBuilder
  //       .fromHttpUrl(baseUrl)
  //       .path("/user/1")
  //       .path("/favorite/add")
  //       .queryParam("roomid", roomId)
  //       .build(false);
  //
  //   ResponseEntity<UserFavoriteResponseDto> response = new TestRestTemplate().exchange(
  //       builder.toUri(), HttpMethod.PUT, new HttpEntity<String>(headers),
  //       UserFavoriteResponseDto.class);
  //
  //   assertAll(
  //       () -> assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK),
  //       () -> assertThat(Objects.requireNonNull(response.getBody()).isFavor()).isEqualTo(true)
  //   );
  // }
  //
  // @DisplayName("컨트롤러 접속을 통하여 정상적으로 즐겨찾기가 삭제되는 지 확인한다.")
  // @CsvSource({"11", "12", "13"})
  // @ParameterizedTest
  // void 즐겨찾기가_삭제된다(Long roomId) {
  //   String baseUrl = "http://localhost:" + port;
  //   UriComponents builder = UriComponentsBuilder
  //       .fromHttpUrl(baseUrl)
  //       .path("/user/1")
  //       .path("/favorite/delete")
  //       .queryParam("roomid", roomId)
  //       .build(false);
  //
  //   ResponseEntity<UserFavoriteResponseDto> response = new TestRestTemplate().exchange(
  //       builder.toUri(), HttpMethod.PUT, new HttpEntity<String>(headers),
  //       UserFavoriteResponseDto.class);
  //
  //   assertAll(
  //       () -> assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK),
  //       () -> assertThat(Objects.requireNonNull(response.getBody()).isFavor()).isEqualTo(true)
  //   );
  // }
}
