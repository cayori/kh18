package kh.board;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import kh.board.JdbcUtil;
import kh.board.CommentDataBean;

public class CommentDBBean {
	// singleton pattern
	private CommentDBBean() {}
	private static CommentDBBean instance = new CommentDBBean();
	public static CommentDBBean getInstance()	{	return instance;	}
	
	private Connection getConnection() throws Exception{
		String jdbcDriver = "jdbc:apache:commons:dbcp:/pool";
		return DriverManager.getConnection(jdbcDriver);
	}
	
	public void insertComment(CommentDataBean cdb) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "INSERT INTO b_commentjpjp VALUES(?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cdb.getContent_num());
			pstmt.setString(2, cdb.getCommenter());
			pstmt.setString(3, cdb.getCommentt());
			pstmt.setString(4, cdb.getPasswd());
			pstmt.setTimestamp(5, cdb.getReg_date());
			pstmt.setString(6, cdb.getIp());
			pstmt.setInt(7, cdb.getComment_num());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(pstmt, conn);
		}
	}
	
	public ArrayList<CommentDataBean> getComments(int con_num, int start, int end) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<CommentDataBean> cm = null;
		
		try {
			conn = getConnection();
			String sql = "SELECT content_num, commenter, commentt, reg_date, ip, comment_num, r "+
					"FROM (SELECT content_num, commenter, commentt, reg_date, ip, comment_num, rownum r "+
					"FROM (SELECT content_num, commenter, commentt, reg_date, ip, comment_num "+
					"FROM b_commentjpjp WHERE content_num="+con_num+" ORDER BY reg_date DESC) "+
					"ORDER BY reg_date desc) WHERE r >= ? AND r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cm = new ArrayList<CommentDataBean>();
				do {
					CommentDataBean cdb = new CommentDataBean();
					cdb.setComment_num(rs.getInt("comment_num"));
					cdb.setContent_num(rs.getInt("content_num"));
					cdb.setCommenter(rs.getString("commenter"));
					cdb.setCommentt(rs.getString("commentt"));
					cdb.setIp(rs.getString("ip"));
					cdb.setReg_date(rs.getTimestamp("reg_date"));
					cm.add(cdb);
				}while(rs.next());
			}	
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
		return cm;
	}
	
	public int getCommentCount(int con_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<CommentDataBean> cm = null;
		int count = 0;
		
		try {
			conn = getConnection();
			String sql = "SELECT * FROM b_commentjpjp WHERE content_num="+con_num+" ORDER BY reg_date DESC";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cm = new ArrayList<CommentDataBean>();
				do {
					CommentDataBean cdb = new CommentDataBean();
					cdb.setCommenter(rs.getString("commenter"));
					cdb.setCommentt(rs.getString("commentt"));
					cdb.setIp(rs.getString("ip"));
					cdb.setReg_date(rs.getTimestamp("reg_date"));
					cm.add(cdb);
				}while(rs.next());
				count = cm.size();
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs, pstmt, conn);
		}		
		return count;
	}

	public int deleteComment(int content_num, String passwd, int comment_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("SELECT passwd FROM b_commentjpjp WHERE content_num=? AND comment_num=?");
			pstmt.setInt(1, content_num);
			pstmt.setInt(2, comment_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(passwd.equals(rs.getString("passwd"))) {
					pstmt = conn.prepareStatement("DELETE FROM b_commentjpjp WHERE content_num=? AND comment_num=?");
					pstmt.setInt(1, content_num);
					pstmt.setInt(2, comment_num);
					pstmt.executeUpdate();
					x = 1;
				}else {
					x = 0;
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
		
		return x;
	}
}