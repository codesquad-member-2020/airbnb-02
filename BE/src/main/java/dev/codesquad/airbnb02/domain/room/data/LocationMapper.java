package dev.codesquad.airbnb02.domain.room.data;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import dev.codesquad.airbnb02.application.dto.RoomResponseDtoSimplified;

@Component
public class LocationMapper implements RowMapper<List<RoomResponseDtoSimplified>> {

	@Override
	public List<RoomResponseDtoSimplified> mapRow(ResultSet rs, int rowNum) throws SQLException {
		List<RoomResponseDtoSimplified> roomList = new ArrayList<>();

		do {
			Long id = rs.getLong("id");
			String name = rs.getString("name");
			String location = rs.getString("location");
			String address = rs.getString("address");
			Double latitude = rs.getDouble("latitude");
			Double longitude = rs.getDouble("longitude");
			BigDecimal nearby = rs.getBigDecimal("nearby");

			RoomResponseDtoSimplified dto = new RoomResponseDtoSimplified(id, name, location, address, latitude,
				longitude, nearby);
			roomList.add(dto);
		} while (rs.next());

		return roomList;
	}
}
