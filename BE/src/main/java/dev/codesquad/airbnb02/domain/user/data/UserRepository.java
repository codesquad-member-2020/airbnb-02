package dev.codesquad.airbnb02.domain.user.data;

import dev.codesquad.airbnb02.domain.user.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {

}
