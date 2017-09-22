package kh.guest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import kh.guest.MessageDao;
import kh.guest.Message;
import kh.guest.JdbcUtil;

public class OracleMessageDao extends MessageDao{

	@Override
	public int insert(Connection conn, kh.guest.Message message) throws SQLException {
		// TODO Auto-generated method stub
		PreparedStatement pstmt = null;
		int result = -1;
		try {
			pstmt = conn.prepareStatement(
					"INSERT INTO guestbookjpjp_message "+
					"(message_id, guest_name, passwd, message) "+
					"VALUES "+
					"(messagejpjp_id_seq.NEXTVAL,?,?,?)");
			pstmt.setString(1, message.getGuestName());
			pstmt.setString(2, message.getPasswd());
			pstmt.setString(3, message.getMessage());
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(pstmt);
		}		
		return result;
	}

	@Override
	public List<kh.guest.Message> selectList(Connection conn, int firstRow, int endRow) throws SQLException {
		// TODO Auto-generated method stub
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Message> resultList = null;
		
		try {
			pstmt = conn.prepareStatement(
					"SELECT message_id, guest_name, passwd, message FROM ("+
						"SELECT rownum rnum, message_id, guest_name, passwd, message FROM ("+
							"SELECT * FROM guestbookjpjp_message m ORDER BY m.message_id DESC"+
						") WHERE rownum >=? "+
					") WHERE rnum >=?");
			pstmt.setInt(1, endRow);
			pstmt.setInt(2, firstRow);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				resultList = new ArrayList<Message>();
				do {
					resultList.add(super.makeMessageFromResultSet(rs));
				}while(rs.next());
			}else {
				resultList = Collections.emptyList();
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs, pstmt);
		}		
		return resultList;
	}
	
}
