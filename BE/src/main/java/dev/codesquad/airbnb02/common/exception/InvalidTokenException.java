package dev.codesquad.airbnb02.common.exception;

public class InvalidTokenException extends RuntimeException {

  public InvalidTokenException() {}

  public InvalidTokenException(String message) {
    super(message);
  }

  public InvalidTokenException(String message, Throwable cause) {
    super(message, cause);
  }

  public InvalidTokenException(Throwable cause) {
    super(cause);
  }
}
