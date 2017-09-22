package kh.guest;

import kh.guest.OracleMessageDao;

public class MessageDaoProvider {
	private MessageDaoProvider() {}
	private static MessageDaoProvider instance = new MessageDaoProvider();
	public static MessageDaoProvider getInstance() {	return instance;	}
	
	private OracleMessageDao oracleDao = new OracleMessageDao();
	private String dbms;
	
	void setDbms(String dbms) {
		this.dbms = dbms;
	}
	
	public MessageDao getMessageDao() {
		if("oracle".equals(dbms)) {
			return oracleDao;
		}else	return null;
	}
}
