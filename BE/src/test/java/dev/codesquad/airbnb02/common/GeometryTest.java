package dev.codesquad.airbnb02.common;

import static org.assertj.core.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.vividsolutions.jts.geom.Geometry;
import com.vividsolutions.jts.geom.Point;
import com.vividsolutions.jts.io.ParseException;
import com.vividsolutions.jts.io.WKTReader;
import dev.codesquad.airbnb02.application.dto.RoomResponseDtoSimplified;
import dev.codesquad.airbnb02.domain.room.data.RoomDao;

@SpringBootTest
public class GeometryTest {

	@Autowired
	private RoomDao roomDao;

	@Test
	public void shouldConvertWktToGeometry() throws ParseException {
		Geometry geometry = wktToGeometry("POINT (2 5)");

		assertEquals("Point", geometry.getGeometryType());
		assertTrue(geometry instanceof Point);
	}

	public Geometry wktToGeometry(String wellKnownText) throws ParseException {
		return new WKTReader().read(wellKnownText);
	}

	@DisplayName("주어진 좌표에 따라 주위 5km 근처의 방이 가까운 순서대로 주어진다.")
	@Test
	void 현재_위치_기준으로_가까운_방의_리스트가_리턴된다() {
		double lon = 127.06533399999999;
		double lat = 37.493712000000002;
		int length = 5000;
		assertThat(roomDao.findNearestRoom(lon, lat, length)).isNotNull();
		assertThat(roomDao.findNearestRoom(lon, lat, length)).isInstanceOf(List.class);
		assertThat(roomDao.findNearestRoom(lon, lat, length).get(0)).isInstanceOf(RoomResponseDtoSimplified.class);
	}
}
