package dev.codesquad.airbnb02.domain.host.data;

import dev.codesquad.airbnb02.domain.host.domain.Host;
import org.springframework.data.jpa.repository.JpaRepository;

public interface HostRepository extends JpaRepository<Host,Long> {
    Host findByName(String name);
}
