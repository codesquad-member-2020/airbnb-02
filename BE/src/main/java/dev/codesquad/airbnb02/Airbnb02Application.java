package dev.codesquad.airbnb02;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;

@SpringBootApplication
@EntityScan
public class Airbnb02Application {

	public static void main(String[] args) {
		SpringApplication.run(Airbnb02Application.class, args);
	}

}
