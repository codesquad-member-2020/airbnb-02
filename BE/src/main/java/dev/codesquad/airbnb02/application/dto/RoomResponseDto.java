package dev.codesquad.airbnb02.application.dto;

import dev.codesquad.airbnb02.domain.room.entity.Image;
import dev.codesquad.airbnb02.domain.room.entity.Room;

import java.util.List;
import java.util.stream.Collectors;

import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class RoomResponseDto {

  private Long id;
  private String title;
  private String type;
  private String location;
  private List<String> images;
  private Integer price;
  private boolean favorite;
  private ReviewDto review;
  private boolean superhost;

  public RoomResponseDto() {
  }

  @Builder
  private RoomResponseDto(Long id, String title, String type, String location, List<String> images,
      Integer price, boolean favorite, ReviewDto review, boolean superhost) {
    this.id = id;
    this.title = title;
    this.type = type;
    this.location = location;
    this.images = images;
    this.price = price;
    this.favorite = favorite;
    this.review = review;
    this.superhost = superhost;
  }

  public static RoomResponseDto create(Room room) {
    return RoomResponseDto.builder()
            .id(room.getId())
            .title(room.getName())
            .type(room.getType().getName())
            .location(room.getLocale().getLocation())
            .images(room.getImages().stream().map(Image::getImageUrl).collect(Collectors.toList()))
            .price(room.getPrice())
            .favorite(false)
            .review(ReviewDto.ofRatingAndCount(room.getReviewRating(), room.getReviewCount()))
            .superhost(room.getHost().isSuperhost())
            .build();
  }
}
