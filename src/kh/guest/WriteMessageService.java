package kh.guest;

import java.sql.Connection;
import java.sql.SQLException;

import kh.guest.MessageDao;
import kh.guest.MessageDaoProvider;
import kh.guest.Exceptions.ServiceException;
import kh.guest.Message;
import kh.guest.JdbcUtil;
import kh.guest.ConnectionProvider;

public class WriteMessageService {
	private WriteMessageService() {}
	private static WriteMessageService instance = new WriteMessageService();
	public static WriteMessageService getInstance() {	return instance;	}
	
	public void write(Message message) throws ServiceException{
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			MessageDao messageDao = MessageDaoProvider.getInstance().getMessageDao();
			
			messageDao.insert(conn,message);
			
		}catch(SQLException e) {
			throw new ServiceException("메세지 등록실패: "+e.getMessage(), e);
		}finally {
			JdbcUtil.close(conn);
		}
	}
}
