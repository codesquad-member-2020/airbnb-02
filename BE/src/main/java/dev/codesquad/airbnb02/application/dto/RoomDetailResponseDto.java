package dev.codesquad.airbnb02.application.dto;

import java.util.List;
import java.util.stream.Collectors;

import dev.codesquad.airbnb02.domain.room.entity.Image;
import dev.codesquad.airbnb02.domain.room.entity.Locale;
import dev.codesquad.airbnb02.domain.room.entity.Room;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class RoomDetailResponseDto {
	private Long id;
	private String title;
	private String type;
	private Locale locale;
	private List<String> images;
	private boolean favorite;
	private String host;
	private boolean superhost;
	private int totalGuest;
	private int bedroom;
	private int bed;
	private int bath;
	private ReviewDto review;
	private int price;

	@Builder
	private RoomDetailResponseDto(Long id, String title, String type,
		Locale locale, List<String> images, boolean favorite, String host, boolean superhost, int totalGuest,
		int bedroom,
		int bed, int bath, ReviewDto review, int price) {
		this.id = id;
		this.title = title;
		this.type = type;
		this.locale = locale;
		this.images = images;
		this.favorite = favorite;
		this.host = host;
		this.superhost = superhost;
		this.totalGuest = totalGuest;
		this.bedroom = bedroom;
		this.bed = bed;
		this.bath = bath;
		this.review = review;
		this.price = price;
	}

	public static RoomDetailResponseDto create(Room room, boolean favorite) {
		return RoomDetailResponseDto.builder()
			.id(room.getId())
			.title(room.getName())
			.type(room.getType().getName())
			.locale(room.getLocale())
			.images(room.getImages().stream().map(Image::getImageUrl).collect(Collectors.toList()))
			.favorite(favorite)
			.host(room.getHost().getName())
			.superhost(room.getHost().isSuperhost())
			.totalGuest(room.getMaximumGuest())
			.bedroom(room.getBedroom())
			.bed(room.getBed())
			.bath(room.getBath())
			.review(ReviewDto.ofRatingAndCount(room.getReviewRating(), room.getReviewCount()))
			.price(room.getPrice())
			.build();
	}
}
