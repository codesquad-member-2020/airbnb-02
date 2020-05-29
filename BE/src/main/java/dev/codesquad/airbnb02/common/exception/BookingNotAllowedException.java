package dev.codesquad.airbnb02.common.exception;

public class BookingNotAllowedException extends RuntimeException {

  public BookingNotAllowedException() {}

  public BookingNotAllowedException(String message) {
    super(message);
  }

  public BookingNotAllowedException(String message, Throwable cause) {
    super(message, cause);
  }

  public BookingNotAllowedException(Throwable cause) {
    super(cause);
  }
}
