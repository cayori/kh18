package kh.guest;

public class Message {

	private int id;
	private String guestName;
	private String passwd;
	private String message;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getGuestName() {
		return guestName;
	}
	public void setGuestName(String guestName) {
		this.guestName = guestName;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
	public boolean hasPasswd() {
		return passwd != null && !passwd.isEmpty();
	}

	public boolean matchPasswd(String input) {
		return (passwd.equals(input));
	}
}
