package dev.codesquad.airbnb02.repository;

import dev.codesquad.airbnb02.entity.Host;
import org.springframework.data.jpa.repository.JpaRepository;

public interface HostRepository extends JpaRepository<Host,Long> {
    Host findByName(String name);
}
