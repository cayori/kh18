package kh.b2.exception;

public class ArticleNotFoundException extends Exception{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4075416289660700204L;

	public ArticleNotFoundException(String msg) {
		super(msg);
	}
}
