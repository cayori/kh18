package kh.b2.exception;

public class InvalidPasswordException extends Exception{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6984742586799394939L;

	public InvalidPasswordException(String message) {
		super(message);
	}
}
