package dev.codesquad.airbnb02;

import org.flywaydb.core.Flyway;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.flyway.FlywayMigrationStrategy;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Profile;

@SpringBootApplication
public class Airbnb02Application implements CommandLineRunner {

	public static void main(String[] args) {
		SpringApplication.run(Airbnb02Application.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		cleanMigrateStrategy();
	}

	@Bean
	@Profile("dev")
	public FlywayMigrationStrategy cleanMigrateStrategy() {
		FlywayMigrationStrategy strategy = new FlywayMigrationStrategy() {
			@Override
			public void migrate(Flyway flyway) {
				flyway.clean();
				flyway.migrate();
			}
		};

		return strategy;
	}
}
