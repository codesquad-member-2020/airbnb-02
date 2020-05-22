package dev.codesquad.airbnb02.domain.host.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.sun.istack.NotNull;
import dev.codesquad.airbnb02.domain.room.entity.Room;
import java.util.List;
import javax.persistence.OneToMany;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
@Getter
@Setter
@ToString(exclude = "rooms")
public class Host {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private String name;

    @NotNull
    private String email;

    @OneToMany(mappedBy = "host")
    @JsonIgnore
    private List<Room> rooms;

    @NotNull
    @ColumnDefault("0")
    private boolean superhost;

    public Host() {}

    private Host(String name, String email) {
        this.name = name;
        this.email = email;
    }

    public static Host create(String name, String email) {
        return new Host(name, email);
    }
}
