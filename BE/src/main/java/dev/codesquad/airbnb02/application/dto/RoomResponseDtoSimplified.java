package dev.codesquad.airbnb02.application.dto;

import java.math.BigDecimal;

public class RoomResponseDtoSimplified {
	private Long id;
	private String title;
	private String location;
	private String address;
	private double latitude;
	private double longitude;
	private BigDecimal nearby;

	public RoomResponseDtoSimplified(Long id, String title, String location, String address, double latitude,
		double longitude, BigDecimal nearby) {
		this.id = id;
		this.title = title;
		this.location = location;
		this.address = address;
		this.latitude = latitude;
		this.longitude = longitude;
		this.nearby = nearby;
	}
}
