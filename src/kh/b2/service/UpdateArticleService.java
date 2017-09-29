package kh.b2.service;

import java.sql.Connection;
import java.sql.SQLException;

import kh.b2.exception.*;
import kh.b2.dao.ArticleDao;
import kh.b2.model.Article;
import kh.b2.model.UpdateRequest;
import kh.b2.JdbcUtil;
import kh.b2.ConnectionProvider;

public class UpdateArticleService {
	private UpdateArticleService() {}
	private static UpdateArticleService instance = new UpdateArticleService();
	public static UpdateArticleService getInstance() {	return instance;	}
	
	public Article update(UpdateRequest updateRequest) 
			throws ArticleNotFoundException, InvalidPasswordException{
		Connection conn = null;
		Article updatedArticle = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);

			ArticleCheckHelper helper = new ArticleCheckHelper();
			helper.checkExistsAndPassword(conn, updateRequest.getArticleId(), updateRequest.getPassword());
			
			updatedArticle = new Article();
			updatedArticle.setId(updateRequest.getArticleId());
			updatedArticle.setTitle(updateRequest.getTitle());
			updatedArticle.setContent(updateRequest.getContent());
			
			ArticleDao articleDao = ArticleDao.getInstance();
			int updateCount = articleDao.update(conn, updatedArticle);
			
			if(updateCount == 0) {
				throw new ArticleNotFoundException("게시글이 존재하지 않습니다: "+updateRequest.getArticleId());
			}
			
			updatedArticle = articleDao.selectById(conn, updateRequest.getArticleId());
			conn.commit();
			
			
		}catch(SQLException e) {
			JdbcUtil.rollback(conn);
			throw new RuntimeException("DB 에러 발생: "+e.getMessage(), e);
		}catch(ArticleNotFoundException e) {
			JdbcUtil.rollback(conn);
			throw e;
		}catch(InvalidPasswordException e) {
			JdbcUtil.rollback(conn);
			throw e;
		}finally {
			if(conn != null) {
				try {	conn.setAutoCommit(true);	}
				catch(SQLException e) {}
				JdbcUtil.close(conn);
			}
		}		
		return updatedArticle;
	}
}
