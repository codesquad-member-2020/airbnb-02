package dev.codesquad.airbnb02.domain.room.entity;

public enum RoomType {
  아파트("아파트"),
  단독주택("단독주택"),
  사무실("사무실");

  private final String name;

  RoomType(String name) {
    this.name = name;
  }

  public String getName() {
    return name;
  }
}
