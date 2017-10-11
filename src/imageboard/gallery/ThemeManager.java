package imageboard.gallery;

import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.sql.SQLException;

import imageboard.sequence.Sequencer;
import imageboard.JdbcUtil;

public class ThemeManager {
	private ThemeManager() {}
	private static ThemeManager instance = new ThemeManager();
	public static ThemeManager getInstance() {	return instance;	}
	
	private Connection getConnection() throws Exception{
		return DriverManager.getConnection("jdbc:apache:commons:dbcp:/pool");
	}
	
	//새로운 글 삽입
	public void insert(Theme theme) throws Exception{
		Connection conn = null;
		// 새로운 글의 그룹번호를 구할때 사용된다.
		Statement stmtGroup = null;
		ResultSet rsGroup = null;
		// 특정 글의 답글에 대한 출력 순서를 구할 때 사용된다.
		PreparedStatement pstmtOrder = null;
		ResultSet rsOrder = null;
		PreparedStatement pstmtOrderUpdate = null;
		// 글을 삽입할때 사용된다.
		PreparedStatement pstmtInsertMessage = null;
		PreparedStatement pstmtInsertContent = null;
		
		try {
			conn = getConnection();
			conn.setAutoCommit(false);
			
			if(theme.getParentId() == 0) {
				// 답글이 아닌 경우 그룹번호를 새롭게 구한다.
				stmtGroup = conn.createStatement();
				rsGroup = stmtGroup.executeQuery("SELECT MAX(group_id) FROM theme_message_jp");
				int maxGroupId = 0;
				if(rsGroup.next()) {
					maxGroupId = rsGroup.getInt(1);
				}
				maxGroupId++;
				
				theme.setGroupId(maxGroupId);
				theme.setOrderNo(0);
			}else {
				// 특정 글의 답글인 경우,
				// 같은 그룹 번호 내에서의 출력 순서를 구한다.
				pstmtOrder = conn.prepareStatement("SELECT MAX(order_no) FROM theme_message_jp "
						+ "WHERE parent_id=? OR theme_message_id=?");
				pstmtOrder.setInt(1, theme.getParentId());
				pstmtOrder.setInt(2, theme.getParentId());
				rsOrder = pstmtOrder.executeQuery();
				int maxOrder = 0;
				if(rsOrder.next()) {
					maxOrder = rsOrder.getInt(1);
				}
				maxOrder++;
				theme.setOrderNo(maxOrder);
			}
				
			// 특정 글의 답변 글인 경우 같은 그룹 내에서 순서 번호를 변경한다.
			if(theme.getOrderNo() > 0) {
				pstmtOrderUpdate = conn.prepareStatement("UPDATE theme_message_jp SET order_no = order_no +1 "
						+ "WHERE group_id=? AND order_no=?");
				pstmtOrderUpdate.setInt(1, theme.getGroupId());
				pstmtOrderUpdate.setInt(2, theme.getOrderNo());
				pstmtOrderUpdate.executeUpdate();
			}
			
			// 새로운 글(특정 글의 답변글)의 번호를 구한다.
			theme.setId(Sequencer.nextId(conn, "theme_message_jp"));
			// 글을 삽입한다
			pstmtInsertMessage = conn.prepareStatement("INSERT INTO theme_message_jp VALUES(?,?,?,?,?,?,?,?,?,?,?)");
			pstmtInsertMessage.setInt(1, theme.getId());
			pstmtInsertMessage.setInt(2, theme.getGroupId());
			pstmtInsertMessage.setInt(3, theme.getOrderNo());
			pstmtInsertMessage.setInt(4, theme.getLevels());
			pstmtInsertMessage.setInt(5, theme.getParentId());
			pstmtInsertMessage.setTimestamp(6, theme.getRegister());
			pstmtInsertMessage.setString(7, theme.getName());
			pstmtInsertMessage.setString(8, theme.getEmail());
			pstmtInsertMessage.setString(9, theme.getImage());
			pstmtInsertMessage.setString(10, theme.getPassword());
			pstmtInsertMessage.setString(11, theme.getTitle());
			pstmtInsertMessage.executeUpdate();
			
			pstmtInsertContent = conn.prepareStatement("INSERT INTO theme_content_jp VALUES (?,?)");
			pstmtInsertContent.setInt(1, theme.getId());
			pstmtInsertContent.setCharacterStream(2,
					new StringReader(theme.getContent()),
					theme.getContent().length());
			pstmtInsertContent.executeUpdate();
						
			conn.commit();
		}catch(SQLException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			}catch(SQLException ex) {}
			throw new Exception("insert", e);
		}finally {
			JdbcUtil.close(rsGroup, stmtGroup);
			JdbcUtil.close(rsOrder, pstmtOrder);
			JdbcUtil.close(pstmtOrderUpdate);
			JdbcUtil.close(pstmtInsertMessage);
			JdbcUtil.close(pstmtInsertContent);
			if(conn!=null)	try {	conn.setAutoCommit(true);	conn.close();}		catch(SQLException e) {}
		}
	}
	
	//제목과 내용만 변경
	public void update(Theme theme) throws Exception{
		Connection conn = null;
		PreparedStatement pstmtUpdateMessage = null;
		PreparedStatement pstmtUpdateContent = null;
		
		try {
			conn = getConnection();
			conn.setAutoCommit(false);
			
			pstmtUpdateMessage = conn.prepareStatement("UPDATE theme_message_jp SET "
					+ "name=?, email=?, image=?, title=? "
					+ "WHERE theme_message_id=?");
			pstmtUpdateContent = conn.prepareStatement("UPDATE theme_content_jp SET "
					+ "content=? WHERE theme_message_id=?");
			
			pstmtUpdateMessage.setString(1, theme.getName());
			pstmtUpdateMessage.setString(2, theme.getEmail());
			pstmtUpdateMessage.setString(3, theme.getImage());
			pstmtUpdateMessage.setString(4, theme.getTitle());
			pstmtUpdateMessage.setInt(5, theme.getId());
			pstmtUpdateMessage.executeUpdate();
			
			pstmtUpdateContent.setCharacterStream(1,
					new StringReader(theme.getContent()),
					theme.getContent().length());
			pstmtUpdateContent.setInt(2, theme.getId());
			pstmtUpdateContent.executeUpdate();
			
			conn.commit();
		}catch(SQLException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			}catch(SQLException ex) {}
			throw new Exception("update", e);
		}finally {
			JdbcUtil.close(pstmtUpdateMessage);
			JdbcUtil.close(pstmtUpdateContent);
			if(conn!=null)	try {	conn.setAutoCommit(true);	conn.close();}		catch(SQLException e) {}
		}
		
	}
	
	//등록된 글의 갯수를 구한다.
	public int count(List whereCond, Map valueMap) throws Exception {
		if(valueMap == null) valueMap = Collections.EMPTY_MAP;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = -1;
		
		try {
			conn = getConnection();
			StringBuffer query = new StringBuffer(200);
			query.append("SELECT COUNT(*) FROM theme_message_jp ");
			if(whereCond != null && whereCond.size() >0) {
				query.append("WHERE ");
				for(int i=0; i<whereCond.size(); i++) {
					query.append(whereCond.get(i));
					if(i< whereCond.size()-1) {
						query.append(" or ");
					}
				}
			}			
			pstmt = conn.prepareStatement(query.toString());
			
			Iterator keyIter = valueMap.keySet().iterator();
			while(keyIter.hasNext()) {
				Integer key = (Integer)keyIter.next();
				Object obj = valueMap.get(key);
				if(obj instanceof String) {
					pstmt.setString(key.intValue(), (String)obj);
				}else if(obj instanceof Integer) {
					pstmt.setInt(key.intValue(), ((Integer)obj).intValue());
				}else if(obj instanceof Timestamp) {
					pstmt.setTimestamp(key.intValue(), (Timestamp)obj);
				}
			}
			
			rs = pstmt.executeQuery();
			count = 0;
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
			throw new Exception("count", e);
		}finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
		return count;		
	}
	
	//목록을 읽어온다.
	public List<Theme> selectList(List whereCond, Map valueMap, int startRow, int endRow) throws Exception{
		if(valueMap==null)	valueMap = Collections.EMPTY_MAP;
		
		Connection conn = null;
		PreparedStatement pstmtMessage = null;
		ResultSet rsMessage = null;
		List<Theme> result = null;
		
		try {
			StringBuffer query = new StringBuffer(200);
			
			query.append("SELECT * FROM (");
			query.append("SELECT theme_message_id, group_id, order_no, levels, parent_id, register, name, email, image, password, title, ROWNUM rnum FROM (");
			query.append("SELECT theme_message_id, group_id, order_no, levels, parent_id, register, name, email, image, password, title FROM theme_message_jp ");
			
			if(whereCond!=null && whereCond.size()>0) {
				query.append("WHERE ");
				for(int i=0; i<whereCond.size(); i++) {
					query.append(whereCond.get(i));
					if(i<whereCond.size()-1) {
						query.append(" OR ");
					}
				}
			}
			query.append(" ORDER BY group_id DESC, order_no ASC ");
			query.append(") WHERE rownum <=?");
			query.append(") WHERE rnum >=?");
			
			conn = getConnection();
			
			pstmtMessage = conn.prepareStatement(query.toString());
			Iterator keyIter = valueMap.keySet().iterator();
			while(keyIter.hasNext()) {
				Integer key = (Integer)keyIter.next();
				Object obj = valueMap.get(key);
				if(obj instanceof String) {
					pstmtMessage.setString(key.intValue(), (String)obj);
				}else if(obj instanceof Integer) {
					pstmtMessage.setInt(key.intValue(), ((Integer)obj).intValue());
				}else if(obj instanceof Timestamp) {
					pstmtMessage.setTimestamp(key.intValue(), (Timestamp)obj);
				}
			}
			pstmtMessage.setInt(valueMap.size()+1, endRow+1);
			pstmtMessage.setInt(valueMap.size()+2, startRow+1);
			
			rsMessage = pstmtMessage.executeQuery();
			
			if(rsMessage.next()) {
				result = new java.util.ArrayList<Theme>(endRow-startRow+1);
				do {
					Theme theme = new Theme();
					theme.setId(rsMessage.getInt("theme_message_id"));
					theme.setGroupId(rsMessage.getInt("group_id"));
					theme.setOrderNo(rsMessage.getInt("order_no"));
					theme.setLevels(rsMessage.getInt("levels"));
					theme.setParentId(rsMessage.getInt("parent_id"));
					theme.setRegister(rsMessage.getTimestamp("register"));
					theme.setName(rsMessage.getString("name"));
					theme.setEmail(rsMessage.getString("email"));
					theme.setImage(rsMessage.getString("image"));
					theme.setPassword(rsMessage.getString("password"));
					theme.setTitle(rsMessage.getString("title"));
					result.add(theme);
				}while(rsMessage.next());
			}else {
				result = Collections.EMPTY_LIST;
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
			throw new Exception("selectList", e);
		}finally {
			JdbcUtil.close(rsMessage, pstmtMessage, conn);
		}
		return result;
	}
	
	//지정한 글을 읽어온다
	public Theme select(int id) throws Exception{
		Connection conn = null;
		PreparedStatement pstmtMessage = null;
		ResultSet rsMessage = null;
		PreparedStatement pstmtContent = null;
		ResultSet rsContent = null;
		Theme theme = null;
		
		try {
			conn = getConnection();
			pstmtMessage = conn.prepareStatement("SELECT * FROM theme_message_jp WHERE theme_message_id=?");
			pstmtMessage.setInt(1,id);
			rsMessage = pstmtMessage.executeQuery();
			
			if(rsMessage.next()) {
				theme = new Theme();
				theme.setId(rsMessage.getInt("theme_message_id"));
				theme.setGroupId(rsMessage.getInt("group_id"));
				theme.setOrderNo(rsMessage.getInt("order_no"));
				theme.setLevels(rsMessage.getInt("levels"));
				theme.setParentId(rsMessage.getInt("parent_id"));
				theme.setRegister(rsMessage.getTimestamp("register"));
				theme.setName(rsMessage.getString("name"));
				theme.setEmail(rsMessage.getString("email"));
				theme.setImage(rsMessage.getString("image"));
				theme.setPassword(rsMessage.getString("password"));
				theme.setTitle(rsMessage.getString("title"));
				
				pstmtContent = conn.prepareStatement("SELECT content FROM theme_content_jp WHERE theme_message_id=?");
				pstmtContent.setInt(1, id);
				rsContent = pstmtContent.executeQuery();
				
				if(rsContent.next()) {
					Reader reader = null;
					try {
						reader = rsContent.getCharacterStream("content");
						char[] buff = new char[512];
						int len = -1;
						StringBuffer buffer = new StringBuffer(512);
						while( (len=reader.read(buff)) != -1) {
							buffer.append(buff,0,len);
						}
						theme.setContent(buffer.toString());
					}catch(IOException e) {
						e.printStackTrace();
						throw new Exception("select", e);
					}finally {
						if(reader != null) {
							try {
								reader.close();
							}catch(IOException e) {}
						}
					}
				}				
			}			
		}catch(SQLException e) {
			e.printStackTrace();
			throw new Exception("select", e);
		}finally {
			JdbcUtil.close(rsMessage, pstmtMessage);
			JdbcUtil.close(rsContent, pstmtContent, conn);
		}
		return theme;		
	}
	
	//글을 삭제한다.
	public void delete(int id) throws Exception{
		Connection conn = null;
		PreparedStatement pstmtMessage = null;
		PreparedStatement pstmtContent = null;
		
		try {
			conn = getConnection();
			conn.setAutoCommit(false);
			
			pstmtMessage = conn.prepareStatement("DELETE FROM theme_message_jp WHERE theme_message_id=?");
			pstmtMessage.setInt(1, id);
			pstmtContent = conn.prepareStatement("DELETE FROM theme_content_jp WHERE theme_message_id=?");
			pstmtContent.setInt(1, id);
			
			int updateCount1 = pstmtMessage.executeUpdate();
			int updateCount2 = pstmtContent.executeUpdate();
			
			if(updateCount1 + updateCount2 == 2) {
				conn.commit();
			}else {
				conn.rollback();
				throw new Exception("invalid id: "+id);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
			try {	conn.rollback();	}	catch(SQLException ex) {}
			throw new Exception("delete", e);
		}finally {
			JdbcUtil.close(pstmtMessage);
			JdbcUtil.close(pstmtContent);
			if(conn!=null)	try {conn.setAutoCommit(true); conn.close();}	catch(SQLException e) {}
		}
	}	
}
