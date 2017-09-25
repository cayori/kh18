package kh.guest;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

import kh.guest.MessageDao;
import kh.guest.MessageDaoProvider;
import kh.guest.Message;
import kh.guest.MessageListView;
import kh.guest.Exceptions.ServiceException;
import kh.guest.JdbcUtil;
import kh.guest.ConnectionProvider;

public class GetMessageListService {
	private GetMessageListService() {}
	private static GetMessageListService instance = new GetMessageListService();
	public static GetMessageListService getInstance() {	return instance;	}
	
	private static final int MESSAGE_COUNT_PER_PAGE = 3;
	
	public MessageListView getMessageList(int pageNumber) throws ServiceException{
		Connection conn = null;
		int currentPageNumber = pageNumber;
		MessageListView mlv = null;
		try {
			conn = ConnectionProvider.getConnection();
			MessageDao messageDao = MessageDaoProvider.getInstance().getMessageDao();
			
			int messageTotalCount = messageDao.selectCount(conn);

			List<Message> messageList = null;
			int firstRow = 0;
			int endRow = 0;
			if(messageTotalCount > 0) {
				firstRow = (pageNumber-1) * MESSAGE_COUNT_PER_PAGE + 1;
				endRow = firstRow + MESSAGE_COUNT_PER_PAGE - 1;
				messageList = messageDao.selectList(conn, firstRow, endRow);
			}else {
				currentPageNumber = 0;
				messageList = Collections.emptyList();
			}
			mlv = new MessageListView(messageList, messageTotalCount, currentPageNumber, MESSAGE_COUNT_PER_PAGE, firstRow, endRow);
		}catch(SQLException e) {
			throw new ServiceException("메세지 목록 구하기 실패: "+e.getMessage());
		}finally {
			JdbcUtil.close(conn);
		}
		return mlv;
	}
}
