package dev.codesquad.airbnb02.domain.room.entity;

public enum RoomType {
  APARTMENT(0, "아파트"),
  HOUSE(1, "단독주택"),
  OFFICE(2, "사무실");

  private final int code;
  private final String type;

  RoomType(int code, String type) {
    this.code = code;
    this.type = type;
  }

  public int getCode() {
    return code;
  }

  public String getType() {
    return type;
  }
}
