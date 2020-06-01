package dev.codesquad.airbnb02.domain.room.business;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dev.codesquad.airbnb02.application.dto.RoomDetailResponseDto;
import dev.codesquad.airbnb02.application.dto.RoomResponseDto;
import dev.codesquad.airbnb02.common.exception.BookingNotAllowedException;
import dev.codesquad.airbnb02.common.exception.NotFoundDataException;
import dev.codesquad.airbnb02.domain.room.data.RoomRepository;
import dev.codesquad.airbnb02.domain.room.entity.Room;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(readOnly = true)
public class RoomService {

  private final RoomRepository roomRepository;

  public RoomService(RoomRepository roomRepository) {
    this.roomRepository = roomRepository;
  }

  public List<RoomResponseDto> findAll() {
    return roomRepository.findAll().stream()
        .map(RoomResponseDto::create)
        .collect(Collectors.toList());
  }

  public List<RoomResponseDto> findFilteredBy(String location, Integer priceMin, Integer priceMax,
      LocalDate checkin, LocalDate checkout) {
    return roomRepository.findAll().stream()
        .filter(room -> room.isValidLocation(location))
        .filter(room -> room.isValidPrice(priceMin, priceMax))
        .filter(room -> room.isValidDate(checkin, checkout))
        .map(RoomResponseDto::create)
        .collect(Collectors.toList());
  }

  public RoomDetailResponseDto findDetailByRoomId(Long roomId) {
    Room room = roomRepository.findById(roomId).orElseThrow(NotFoundDataException::new);
    return RoomDetailResponseDto.create(room);
  }

  @Transactional
  public void createBooking(Long roomId, LocalDate checkin, LocalDate checkout) {
    Room room = findRoom(roomId);
    if (! room.isValidDate(checkin, checkout)) {
      throw new BookingNotAllowedException("이미 예약된 날짜가 존재 합니다.");
    }
    room.addBookings(checkin, checkout);
    roomRepository.save(room);
  }

  @Transactional
  public void removeBooking(Long roomId, LocalDate checkin, LocalDate checkout) {
    Room room = findRoom(roomId);
    room.removeBookings(checkin, checkout);
    roomRepository.save(room);
  }

  private Room findRoom(Long roomId) {
    return roomRepository.findById(roomId).orElseThrow(() -> new NotFoundDataException("해당 숙소를 찾을 수 없습니다."));
  }
}
