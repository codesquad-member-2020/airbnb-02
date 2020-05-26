package dev.codesquad.airbnb02.domain.room.business;

import dev.codesquad.airbnb02.application.dto.RoomResponseDto;
import dev.codesquad.airbnb02.domain.room.data.RoomRepository;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
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

  @Transactional
  public List<RoomResponseDto> findFilteredBy(String location, Integer priceMin, Integer priceMax,
      String checkin, String checkout) {
    return roomRepository.findAll().stream()
//        .filter(room -> room.getLocale().getLocation().equals(location))
//        .filter(room -> room.isValidPrice(priceMin, priceMax))
        .filter(room -> room.isValidDate(checkin, checkout))
        .map(RoomResponseDto::create)
        .collect(Collectors.toList());
  }
}
