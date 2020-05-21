package dev.codesquad.airbnb02.dto;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class RoomResponseDto {
    private Long id;
    private String title;
    private String type;
    private String location;
    private String imageUrl;
    private Integer price;
    private boolean favorite;
    private ReviewDto review;
    private boolean superhost;

    public RoomResponseDto() {}

    private RoomResponseDto(Long id, String title, String type, String location, String imageUrl, Integer price, boolean favorite, ReviewDto review, boolean superhost) {
        this.id = id;
        this.title = title;
        this.type = type;
        this.location = location;
        this.imageUrl = imageUrl;
        this.price = price;
        this.favorite = favorite;
        this.review = review;
        this.superhost = superhost;
    }

    public static RoomResponseDto create(Long id, String title, String type, String location, String imageUrl, Integer price, boolean favorite, ReviewDto review, boolean superhost) {
        return new RoomResponseDto(id, title, type, location, imageUrl, price, favorite, review, superhost);
    }
}
