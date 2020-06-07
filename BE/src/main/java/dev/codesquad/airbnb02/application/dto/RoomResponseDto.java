package dev.codesquad.airbnb02.application.dto;

import java.util.List;
import java.util.stream.Collectors;

import dev.codesquad.airbnb02.domain.room.vo.Image;
import dev.codesquad.airbnb02.domain.room.entity.Room;
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
  private CoordinateDto coordinate;
  private List<String> images;
  private Integer price;
  private boolean favorite;
  private ReviewDto review;
  private boolean superhost;

  public RoomResponseDto() {
  }

  @Builder
  private RoomResponseDto(Long id, String title, String type, String location,
      CoordinateDto coordinate, List<String> images,
      Integer price, boolean favorite, ReviewDto review, boolean superhost) {
    this.id = id;
    this.title = title;
    this.type = type;
    this.location = location;
    this.coordinate = coordinate;
    this.images = images;
    this.price = price;
    this.favorite = favorite;
    this.review = review;
    this.superhost = superhost;
  }

  public static RoomResponseDto create(Room room, boolean favorite) {
    return RoomResponseDto.builder()
        .id(room.getId())
        .title(room.getName())
        .type(room.getType().getName())
        .location(room.getLocale().getLocation())
        .coordinate(CoordinateDto.ofLatitudeAndLongitude(room.getLocale().getLatitude(),
            room.getLocale().getLongitude()))
        .images(room.getImages().stream().map(Image::getImageUrl).collect(Collectors.toList()))
        .price(room.getPrice())
        .favorite(favorite)
        .review(ReviewDto.ofRatingAndCount(room.getReviewRating(), room.getReviewCount()))
        .superhost(room.getHost().isSuperhost())
        .build();
  }
}
