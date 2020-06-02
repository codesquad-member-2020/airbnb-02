package dev.codesquad.airbnb02.domain.room.data;

import dev.codesquad.airbnb02.domain.room.entity.Room;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoomRepository extends JpaRepository<Room,Long> {
}
