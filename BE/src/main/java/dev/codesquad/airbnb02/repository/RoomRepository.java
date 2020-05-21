package dev.codesquad.airbnb02.repository;

import dev.codesquad.airbnb02.entity.Room;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoomRepository extends JpaRepository<Room,Long> {
}
