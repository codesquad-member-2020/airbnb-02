package dev.codesquad.airbnb02.domain.user.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

import dev.codesquad.airbnb02.domain.room.entity.Room;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor
public class User {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(name = "github_id")
  private String githubId;

  @ManyToMany
  @JoinTable(
      name = "favorite",
      joinColumns = @JoinColumn(name = "user_id"),
      inverseJoinColumns = @JoinColumn(name = "room_id")
  )
  private List<Room> rooms = new ArrayList<>();

  public Room addBookmark(Room room) {
    rooms.add(room);
    return room;
  }

  public Room removeBookmark(Room room) {
    rooms.remove(room);
    return room;
  }

  public Room findLikedRoomByRoomId(Long roomId) {
    return this.rooms.stream()
        .filter(room -> room.getId().equals(roomId))
        .findAny()
        .orElse(null);
  }

  public boolean isBookmarked(Room inputRoom) {
    return this.rooms.stream()
        .anyMatch(room -> room.equals(inputRoom));
  }
}
