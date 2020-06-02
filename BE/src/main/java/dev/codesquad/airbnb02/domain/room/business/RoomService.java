package dev.codesquad.airbnb02.domain.room.business;

import dev.codesquad.airbnb02.application.dto.BookingResponseDto;
import dev.codesquad.airbnb02.domain.user.entity.User;
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
import dev.codesquad.airbnb02.domain.user.business.UserService;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(readOnly = true)
public class RoomService {

	private final RoomRepository roomRepository;
	private final UserService userService;

	public RoomService(RoomRepository roomRepository, UserService userService) {
		this.roomRepository = roomRepository;
		this.userService = userService;
	}

	public List<RoomResponseDto> findAll() {
		Long userId = 1L;
		return roomRepository.findAll().stream()
			.map(room -> RoomResponseDto.create(room, isUserBookmarkedRoom(room.getId(), userId)))
			.collect(Collectors.toList());
	}

	public List<RoomResponseDto> findFilteredBy(String location, Integer priceMin, Integer priceMax,
		LocalDate checkin, LocalDate checkout) {

		Long userId = 1L;
		return roomRepository.findAll().stream()
			.filter(room -> room.isValidLocation(location))
			.filter(room -> room.isValidPrice(priceMin, priceMax))
			.filter(room -> room.isValidDate(checkin, checkout))
			.map(room -> RoomResponseDto.create(room, isUserBookmarkedRoom(room.getId(), userId)))
			.collect(Collectors.toList());
	}

	public RoomDetailResponseDto findDetailByRoomId(Long roomId) {
		Room room = findRoom(roomId);
		Long userId = 1L;
		boolean favorite = isUserBookmarkedRoom(roomId, userId);
		return RoomDetailResponseDto.create(room, favorite);
	}

	private boolean isUserBookmarkedRoom(Long roomId, Long userId) {
		Room room = findRoom(roomId);
		return userService.isUserBookmarkedRoom(userId, room.getId());
	}

	@Transactional
	public BookingResponseDto createBooking(Long roomId, LocalDate checkin, LocalDate checkout) {
		Long userId = 2L;
		User user = userService.findUser(userId);
		Room room = findRoom(roomId);
		if (!room.isValidDate(checkin, checkout)) {
			throw new BookingNotAllowedException("이미 예약된 날짜가 존재 합니다.");
		}
		room.addBookings(checkin, checkout, user);
		roomRepository.save(room);
		return BookingResponseDto.create(user, room);
	}

	@Transactional
	public BookingResponseDto removeBooking(Long roomId, LocalDate checkin, LocalDate checkout) {
		Long userId = 2L;
		User user = userService.findUser(userId);
		Room room = findRoom(roomId);
		room.removeBookings(checkin, checkout, user);
		roomRepository.save(room);
		return BookingResponseDto.create(user, room);
	}

	private Room findRoom(Long roomId) {
		return roomRepository.findById(roomId).orElseThrow(() -> new NotFoundDataException("해당 숙소를 찾을 수 없습니다."));
	}
}
