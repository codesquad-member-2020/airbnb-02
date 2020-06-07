package dev.codesquad.airbnb02.domain.room.data;

import java.util.List;

import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import dev.codesquad.airbnb02.application.dto.RoomResponseDtoSimplified;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class RoomDao {
	private final NamedParameterJdbcTemplate namedJdbcTemplate;
	private final LocationMapper locationMapper;

	//TODO: stored procedure mysql java 활용하여 리팩토링하기
	private final String FIND_NEAREST_ROOM =
		"SELECT *, ST_DISTANCE_SPHERE(POINT(:lon, :lat), point) AS nearby\n"
			+ "FROM room FORCE INDEX FOR JOIN (`room-point`)\n"
			+ "WHERE MBRCONTAINS(ST_LINESTRINGFROMTEXT(CONCAT('LINESTRING(', :lon -  IF(:lon < 0, 1, -1) * :length / 2 / ST_DISTANCE_SPHERE(POINT(:lon, :lat), POINT(:lon + IF(:lon < 0, 1, -1), :lat)), ' ', :lat -  IF(:lon < 0, 1, -1) * :length / 2 / ST_DISTANCE_SPHERE(POINT(:lon, :lat), POINT(:lon, :lat + IF(:lat < 0, 1, -1))), ',', :lon +  IF(:lon < 0, 1, -1) *:length / 2 / ST_DISTANCE_SPHERE(POINT(:lon, :lat), POINT(:lon + IF(:lon < 0, 1, -1), :lat)), ' ', :lat +  IF(:lon < 0, 1, -1) * :length / 2 / ST_DISTANCE_SPHERE(POINT(:lon, :lat), POINT(:lon, :lat + IF(:lat < 0, 1, -1))), ')')), point);";

	public List<RoomResponseDtoSimplified> findNearestRoom(double lon, double lat, int length) {
		SqlParameterSource source = new MapSqlParameterSource()
			.addValue("lon", lon)
			.addValue("lat", lat)
			.addValue("length", length);
		return namedJdbcTemplate.queryForObject(FIND_NEAREST_ROOM, source, locationMapper);
	}
}
