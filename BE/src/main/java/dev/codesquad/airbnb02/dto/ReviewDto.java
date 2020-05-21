package dev.codesquad.airbnb02.dto;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class ReviewDto {
    private Double rating;
    private Integer count;

    public ReviewDto() {}

    private ReviewDto(Double rating, Integer count) {
        this.rating = rating;
        this.count = count;
    }

    public static ReviewDto create(Double rating, Integer count) {
        return new ReviewDto(rating, count);
    }
}
