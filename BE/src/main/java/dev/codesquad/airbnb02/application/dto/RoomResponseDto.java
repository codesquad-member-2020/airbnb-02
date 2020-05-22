package dev.codesquad.airbnb02.application.dto;

import dev.codesquad.airbnb02.domain.room.domain.Image;
import dev.codesquad.airbnb02.domain.room.domain.Room;
import java.util.List;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class RoomResponseDto {

  private Long id;
  private String title;
  private String type;
  private String location;
  private List<Image> images;
  private Integer price;
  private boolean favorite;
  private ReviewDto review;
  private boolean superhost;

  public RoomResponseDto() {
  }

  private RoomResponseDto(Long id, String title, String type, String location, List<Image> images,
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

//    public static RoomResponseDto create(Long id, String title, String type, String location, String imageUrl, Integer price, boolean favorite, ReviewDto review, boolean superhost) {
//        return new RoomResponseDto(id, title, type, location, imageUrl, price, favorite, review, superhost);
//    }

  public static RoomResponseDto create(Room room) {
    return new RoomResponseDto(room.getId(), room.getName(), "아파트", room.getLocation(),
        room.getImages(), room.getPrice(), false,
        ReviewDto.create(room.getReviewRating(), room.getReviewCount()), false);
  }
}
