package dev.codesquad.airbnb02.domain.room.business;

import dev.codesquad.airbnb02.application.dto.RoomResponseDto;
import dev.codesquad.airbnb02.domain.room.data.RoomRepository;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class RoomService {

  private final RoomRepository roomRepository;

  public RoomService(RoomRepository roomRepository) {
    this.roomRepository = roomRepository;
  }

  @Transactional(readOnly = true)
  public List<RoomResponseDto> findAll() {

    return roomRepository.findAll().stream()
        .map(RoomResponseDto::create)
        .collect(Collectors.toList());
  }
}
