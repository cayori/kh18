package kh.board;

import java.sql.*;
import java.util.*;
import javax.sql.*;
import javax.naming.*;

public class BoardDBBean {
	private BoardDBBean() {}
	private static BoardDBBean instance = new BoardDBBean();
	public static BoardDBBean getInstance() {
		return instance;
	}
	private Connection getConnection() throws Exception{
		String jdbcDriver = "jdbc:apache:commons:dbcp:/pool";
		return DriverManager.getConnection(jdbcDriver);
	}
	
// - void insertArticle(BoardDataBean b) : writePro.jsp (게시물 입력)
	public void insertArticle(BoardDataBean article) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 답글인지 일반글인지 구분해서 입력시켜주는 로직
		int num 		= article.getNum();
		int ref 		= article.getRef();
		int re_step 	= article.getRe_step();
		int re_level 	= article.getRe_level();
		int number		= 0;
		String sql = "";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("SELECT MAX(NUM) FROM boardjpjp");
			rs = pstmt.executeQuery();
			
			if(rs.next())	number = rs.getInt(1)+1;		// 첫번째 인자(num 컬럼) 에서 int 를 받아와라
			else			number = 1;
			
			if( num != 0 ) {
				sql = "UPDATE boardjpjp SET re_step=re_step+1 WHERE ref=? and re_step>?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step = re_step + 1;
				re_level = re_level + 1;
			}else {
				ref = number;
				re_step = 0;
				re_level = 0;
			}
			// 쿼리를 작성
			sql = "INSERT INTO boardjpjp(num, writer, email, subject, passwd, reg_date, ref, re_step, re_level, content, ip) VALUES(boardjpjp_num.NEXTVAL,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString( 1, article.getWriter());
			pstmt.setString( 2, article.getEmail());
			pstmt.setString( 3, article.getSubject());
			pstmt.setString( 4, article.getPasswd());
			pstmt.setTimestamp(5, article.getReg_date());
			pstmt.setInt( 6, article.getRef());
			pstmt.setInt( 7, article.getRe_step());
			pstmt.setInt( 8, article.getRe_level());
			pstmt.setString( 9, article.getContent());
			pstmt.setString(10, article.getIp());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)	try {rs.close();}		catch(SQLException e) {}
			if(pstmt!=null)	try {pstmt.close();}	catch(SQLException e) {}
			if(conn!=null)	try {conn.close();}		catch(SQLException e) {}
		}		
	}
	
//	- int getArticleCount(): list.jsp (입력글의 갯수 리턴)
	public int getArticleCount() throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int x = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("SELECT COUNT(*) FROM boardjpjp");
			rs = pstmt.executeQuery();
			
			if(rs.next())	x = rs.getInt(1);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)	try {rs.close();}		catch(SQLException e) {}
			if(pstmt!=null)	try {pstmt.close();}	catch(SQLException e) {}
			if(conn!=null)	try {conn.close();}		catch(SQLException e) {}
		}
		return x;
	}
	
//	- List getArticles(int s, int e) : list.jsp (s부터 e 까지의 데이터 가져옴)
	public List getArticles(int start, int end) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List articleList = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
					"SELECT num, writer, email, subject, passwd, reg_date, ref, re_step, re_level, content, ip, readcount, r "+
					"FROM(SELECT num, writer, email, subject, passwd, reg_date, ref, re_step, re_level, content, ip, readcount, rownum r "+
					"FROM(SELECT num, writer, email, subject, passwd, reg_date, ref, re_step, re_level, content, ip, readcount "+
					"FROM boardjpjp ORDER BY ref DESC, re_step ASC, reg_date DESC) ORDER BY ref DESC, re_step ASC, reg_date DESC) WHERE r>=? AND r<=?"
					);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				articleList = new ArrayList<BoardDataBean>(end);
				do {
					BoardDataBean article = new BoardDataBean();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPasswd(rs.getString("passwd"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					article.setContent(rs.getString("content"));
					article.setIp(rs.getString("ip"));
					
					articleList.add(article);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)	try {rs.close();}		catch(SQLException e) {}
			if(pstmt!=null)	try {pstmt.close();}	catch(SQLException e) {}
			if(conn!=null)	try {conn.close();}		catch(SQLException e) {}
		}
		return articleList;
	}

//	- BoardDataBean getArticle(int num) : content.jsp (글번의 해당하는 데이터 한줄을 가져옴)	
	public BoardDataBean getArticle(int num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDataBean article = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("UPDATE boardjpjp SET readcount+1 WHERE num = ?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement("SELECT * FROM boardjpjp WHERE num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				article = new BoardDataBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcound"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) 	try {rs.close();}		catch(SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();}	catch(SQLException ex) {}
			if(conn!=null) 	try {conn.close();}		catch(SQLException ex) {}
		}
		
		return article;				
	}

//	- BoardDataBean updateGetArticle(int num) : updateForm.jsp (수정하기 위한 데이터 한줄을 가져옴)
	public BoardDataBean updateGetArticle(int num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDataBean article = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("SELECT * FROM boardjpjp WHERE num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				article = new BoardDataBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcound"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) 	try {rs.close();}		catch(SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();}	catch(SQLException ex) {}
			if(conn!=null) 	try {conn.close();}		catch(SQLException ex) {}
		}
		
		return article;				
	}

//	- int updateArticle(BoardDataBean b) : updatePro.jsp (글수정)
	public int updateArticle(BoardDataBean article) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		String sql = "";
		int x = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("SELECT passwd FROM boardjpjp WHERE num=?");
			pstmt.setInt(1, article.getNum());
			rs = pstmt.executeQuery();
			
			if(rs.next())	dbpasswd = rs.getString("passwd");
			if(dbpasswd.equals(article.getPasswd())) {
				sql = "UPDATE boardjpjp SET writer=?, email=?, subject=?, passwd=?, content=? WHERE num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, article.getWriter());
				pstmt.setString(2, article.getEmail());
				pstmt.setString(3, article.getSubject());
				pstmt.setString(4, article.getPasswd());
				pstmt.setString(5, article.getContent());
				pstmt.setInt(6, article.getNum()); 
				pstmt.executeUpdate();
				x = 1;
			}else {
				x = 0;
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)	try{rs.close();}	catch(SQLException e) {}
			if(pstmt!=null)	try{pstmt.close();}	catch(SQLException e) {}
			if(conn!=null)	try{conn.close();}	catch(SQLException e) {}
		}
		
		return x;
	}

//	- int deleteArticle(int num, String passwd) : deletePro.jsp (글삭제)
	public int deleteArticle(int num, String passwd) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		int x = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("SELECT passwd FROM boardjpjp WHERE num=?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next())	dbpasswd = rs.getString("passwd");
			if(dbpasswd.equals(passwd)) {
				pstmt = conn.prepareStatement("DELETE FROM boardjpjp WHERE num=?");
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
				x = 1;
			}else {
				x = 0;
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)	try{rs.close();}	catch(SQLException e) {}
			if(pstmt!=null)	try{pstmt.close();}	catch(SQLException e) {}
			if(conn!=null)	try{conn.close();}	catch(SQLException e) {}
		}		
		return x;
	}

//검색 int getArticleCount(int n, String searchKeyword) : list.jsp 키워드로 검색된 글 갯수 리턴
	public int getArticleCount(int n, String searchKeyword) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String[] columnName = {"writer","subject","content"};
		
		int x = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("SELECT COUNT(*) FROM boardjpjp WHERE "+columnName[n]+" LIKE '%"+searchKeyword+"%'");
			rs = pstmt.executeQuery();
			
			if(rs.next())	x = rs.getInt(1);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)	try {rs.close();}		catch(SQLException e) {}
			if(pstmt!=null)	try {pstmt.close();}	catch(SQLException e) {}
			if(conn!=null)	try {conn.close();}		catch(SQLException e) {}
		}
		return x;
	}

//검색 List getArticles(int s, int e, int n, String searchKeyword) : list.jsp (검색된 글의 s부터 e까지 가져옴)
	public List getArticles(int start, int end, int n, String searchKeyword) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List articleList = null;
		String[] columnName = {"writer","subject","content"};
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
					"SELECT num, writer, email, subject, passwd, reg_date, ref, re_step, re_level, content, ip, readcount, r "+
					"FROM(SELECT num, writer, email, subject, passwd, reg_date, ref, re_step, re_level, content, ip, readcount, rownum r "+
					"FROM(SELECT num, writer, email, subject, passwd, reg_date, ref, re_step, re_level, content, ip, readcount "+
					"FROM boardjpjp ORDER BY ref DESC, re_step ASC) WHERE "+columnName[n]+"LIKE '%"+searchKeyword+"%' ORDER BY ref DESC, re_step ASC) WHERE r>=? AND r<=?"
					);

			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				articleList = new ArrayList<BoardDataBean>(end);
				do {
					BoardDataBean article = new BoardDataBean();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPasswd(rs.getString("passwd"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcound"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					article.setContent(rs.getString("content"));
					article.setIp(rs.getString("ip"));
					
					articleList.add(article);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)	try {rs.close();}		catch(SQLException e) {}
			if(pstmt!=null)	try {pstmt.close();}	catch(SQLException e) {}
			if(conn!=null)	try {conn.close();}		catch(SQLException e) {}
		}
		return articleList;
	}
}
