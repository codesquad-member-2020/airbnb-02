package dev.codesquad.airbnb02;

import java.text.SimpleDateFormat;
import java.util.Date;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class Airbnb02ApplicationTests {

	@Test
	void contextLoads() {
		String checkin = "2020-05-26";
		String checkout = "2020-05-28";
		try {
			Date date1 = new SimpleDateFormat("yyyy-MM-DD").parse(checkin);
			Date date2 = new SimpleDateFormat("yyyy-MM-DD").parse(checkout);
		} catch (Exception e) {
			throw new RuntimeException();
		}
	}

}
