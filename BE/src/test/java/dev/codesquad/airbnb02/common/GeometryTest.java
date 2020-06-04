package dev.codesquad.airbnb02.common;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.locationtech.jts.geom.Geometry;
import org.locationtech.jts.geom.Point;
import org.locationtech.jts.io.ParseException;
import org.locationtech.jts.io.WKTReader;

public class GeometryTest {

	@Test
	public void shouldConvertWktToGeometry() throws ParseException {
		Geometry geometry = wktToGeometry("POINT (2 5)");

		assertEquals("Point", geometry.getGeometryType());
		assertTrue(geometry instanceof Point);
	}

	public Geometry wktToGeometry(String wellKnownText) throws ParseException {
		return new WKTReader().read(wellKnownText);
	}
}
