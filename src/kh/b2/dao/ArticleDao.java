package kh.b2.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import kh.b2.model.Article;
import kh.b2.JdbcUtil;

public class ArticleDao {
	// singleton
	private ArticleDao() {}
	private static ArticleDao instance = new ArticleDao();
	public static ArticleDao getInstance() {	return instance;	}
	
	public int selectCount(Connection conn) throws SQLException{
		Statement stmt = null;
		ResultSet rs = null;
		int result = 0;
		
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT COUNT(*) FROM article_jp");
			rs.next();
			result = rs.getInt(1);   //getInt(int columnIndex) 인데 왜 1??
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs, stmt);
		}
		return result;
	}

	public List<Article> select(Connection conn, int firstRow, int endRow) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Article> resultList = null;
		try {
			pstmt = conn.prepareStatement( // 서브쿼리 괄호 하나 줄여도 되나???
					"SELECT article_id, group_id, sequence_no, posting_date, read_count, writer_name, password, title FROM "+
					"(SELECT * FROM article_jp m ORDER BY m.sequence_no DESC) WHERE rownum >=? AND rownum <=?"	);
			pstmt.setInt(1, firstRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			if( !rs.next() ) {
				resultList = Collections.emptyList();
			}else {
				resultList = new ArrayList<Article>();
				do {
					Article article = makeArticleFromResultSet(rs, false);
					resultList.add(article);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs, pstmt);
		}
		return resultList;
	}

	private Article makeArticleFromResultSet(ResultSet rs, boolean readContent) throws SQLException{
		Article article = new Article();
		article.setId(rs.getInt("article_id"));
		article.setGroupId(rs.getInt("group_id"));
		article.setSequenceNumber(rs.getString("sequence_no"));
		article.setPostingDate(rs.getTimestamp("posting_date"));
		article.setReadCount(rs.getInt("read_count"));
		article.setWriterName(rs.getString("writer_name"));
		article.setPassword(rs.getString("password"));
		article.setTitle(rs.getString("title"));
		if(readContent) {
			article.setContent(rs.getString("content"));
		}		
		return article;
	}
	
	public int insert(Connection conn, Article article) throws SQLException{
		PreparedStatement pstmt = null;
		Statement stmt = null;
		ResultSet rs = null;
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(
					"INSERT INTO article_jp "+
					"(article_id, group_id, sequence_no, posting_date, read_count, writer_name, password, title, content) VALUES "+
					"(article_id_seq_jp.NEXTVAL,?,?,?,0,?,?,?,?)");
			pstmt.setInt(1, article.getGroupId());
			pstmt.setString(2, article.getSequenceNumber());
			pstmt.setTimestamp(3, new Timestamp(article.getPostingDate().getTime()));
			pstmt.setString(4, article.getWriterName());
			pstmt.setString(5, article.getPassword());
			pstmt.setString(6, article.getTitle());
			pstmt.setString(7, article.getContent());
			int insertedCount = pstmt.executeUpdate();
			
			if(insertedCount > 0) {
				stmt = conn.createStatement();
				rs = stmt.executeQuery("SELECT article_id_seq_jp.CURRVAL DROM dual");
				if(rs.next())	{	result = rs.getInt(1);	}
			}else {
				result = -1;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs, stmt);
			JdbcUtil.close(pstmt);
		}		
		return result;
	}
	
	public Article selectById(Connection conn, int articleId) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Article resultArticle = null;
		
		try {
			pstmt = conn.prepareStatement("SELECT * FROM article WHERE article_id=?");
			pstmt.setInt(1, articleId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				resultArticle = makeArticleFromResultSet(rs, true);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs, pstmt);
		}
		return resultArticle;
	}

	public void increaseReadCount(Connection conn, int articleId) throws SQLException{
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement("UPDATE article_jp SET read_count = read_count+1 WHERE article_id=?");
			pstmt.setInt(1, articleId);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(pstmt);
		}
	}
	
	public String selectLastSequenceNumber(Connection conn, String searMaxSeqNum, String searchMinSeqNum) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String resultString = "";
		
		try {
			pstmt = conn.prepareStatement("SELECT MIN(sequence_no) FROM article_jp WHERE sequence_no < ? AND sequence_no >= ?");
			pstmt.setString(1, searchMaxSeqNum);
			pstmt.setString(2, searchMinSeqNum);
			rs = pstmt
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs, pstmt);
		}
		return resultString;
	}
	
	
	
	
	
	
}
