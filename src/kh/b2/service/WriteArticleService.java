package kh.b2.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.Date;

import kh.b2.dao.ArticleDao;
import kh.b2.model.Article;
import kh.b2.model.WritingRequest;
import kh.b2.JdbcUtil;
import kh.b2.ConnectionProvider;
import kh.b2.exception.*;

public class WriteArticleService {
	private WriteArticleService() {}
	private static WriteArticleService instance = new WriteArticleService();
	public static WriteArticleService getInstance() {	return instance;	}
	
	public Article write(WritingRequest writingRequest) throws IdGenerationFailedException{
		int groupId = IdGenerator.getInstance().generateNextId("article_jp");
		Article article = writingRequest.toArticle();
		
		article.setGroupId(groupId);
		article.setPostingDate(new Date());
		DecimalFormat decimalFormat = new DecimalFormat("0000000000");
		article.setSequenceNumber(decimalFormat.format(groupId)+"999999");
		
		Connection conn = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			
			int articleId = ArticleDao.getInstance().insert(conn, article);
			if(articleId == -1) {
				JdbcUtil.rollback(conn);
				throw new RuntimeException("DB 삽입안됨: "+articleId);
			}else {
				conn.commit();
			}			
			article.setId(articleId);
		}catch(SQLException e) {
			JdbcUtil.rollback(conn);
			throw new RuntimeException("DB 에러: "+e.getMessage(), e);
		}finally {
			
		}		
		return article;
	}

	
}
