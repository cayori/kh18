package kh.guest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import kh.guest.Message;
import kh.guest.JdbcUtil;

public abstract class MessageDao {
	public abstract int insert(Connection conn, Message message) throws SQLException;
	
	public Message select(Connection conn, int messageId) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Message result = null;
		try {
			pstmt = conn.prepareStatement("SELECT * FROM guestbookjpjp_message WHERE message_id = ?");
			pstmt.setInt(1, messageId);
			rs = pstmt.executeQuery();
			
			if(rs.next())	result = makeMessageFromResultSet(rs);
						
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs,pstmt);
		}
		return result;
	}

	protected Message makeMessageFromResultSet(ResultSet rs) throws SQLException{
		Message message = new Message();
		
		message.setId(rs.getInt("message_Id"));
		message.setGuestName(rs.getString("guest_name"));
		message.setPasswd(rs.getString("passwd"));
		message.setMessage(rs.getString("message"));
		
		return message;
	}
	
	public int selectCount(Connection conn) throws SQLException{
		Statement stmt = null;
		ResultSet rs = null;
		int count = -1;
		
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT COUNT(*) FROM guestbookjpjp_message");
			rs.next();
			count = rs.getInt(1);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs, stmt);
		}
		return count;
	}
	
	public abstract List<Message> selectList(Connection conn, int firstRow, int endRow) throws SQLException;
	
	public int delete(Connection conn, int messageId) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = -1;
		
		try {
			pstmt = conn.prepareStatement("DELETE FROM guestbookjpjp_message WHERE message_id=?");
			pstmt.setInt(1, messageId);
			result = pstmt.executeUpdate();			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs, pstmt);
		}
		return result;
	}
}
