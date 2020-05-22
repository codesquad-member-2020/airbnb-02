package dev.codesquad.airbnb02.application.controller;


import dev.codesquad.airbnb02.domain.host.domain.Host;
import dev.codesquad.airbnb02.domain.host.data.HostRepository;
import dev.codesquad.airbnb02.domain.room.data.RoomRepository;
import dev.codesquad.airbnb02.domain.room.domain.Room;
import java.util.List;
import javassist.NotFoundException;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.transaction.annotation.Transactional;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class RepositoryTest {

    @Autowired
    private TestRestTemplate testRestTemplate;

    @Autowired
    private RoomRepository roomRepository;

    @Autowired
    private HostRepository hostRepository;

    @DisplayName("메인 페이지가 로딩된다.")
    @Test
    public void 메인_페이지_데이터가_로딩된다() {
        String body = this.testRestTemplate.getForObject("/", String.class);
        assertThat(body).isNotNull();
    }

    @DisplayName("HostRepository에 Host가 추가된다.")
    @Test
    public void HOST_REPO에_HOST가_추가된다() {

        //given
        String name = "javajigi";
        String email = "javajigi@gmail.com";
        Host host = Host.create(name, email);

        //when
        hostRepository.save(host);

        //then
//        assertThat(hostRepository.findByName(name).getEmail()).isEqualTo(email);
        assertThat(hostRepository.findByName(name).isSuperhost()).isEqualTo(true);
    }

    @DisplayName("RoomRepository에 Room이 가져와진다.")
    @Test
    public void ROOM_REPO에_ROOM이_가져와진다() {

        Host host = hostRepository.findByName("hoi");
        assertThat(roomRepository.findById(1L).get().getHost().getName()).isEqualTo(host.getName());
    }

    @DisplayName("한 명의 호스트가 여러 개의 방을 갖고 있다.")
    @Test
    public void 한_호스트가_여러_방_리스트_갖고있다() {
        Host host = hostRepository.findAll().get(0);
        assertThat(host.getRooms()).isNotNull();
    }

    @DisplayName("하나의 Room에서 여러 가지의 이미지가 잘 가져와진다.")
    @Test
    @Transactional
    public void ROOM이_여러_IMAGE를_갖고있다() {

        Room room = roomRepository.findById(1L).orElseThrow(() -> new RuntimeException("으악"));
        assertThat(room.getImages()).isInstanceOf(List.class);
        assertThat(room.getImages().size()).isGreaterThan(1);
    }
}
