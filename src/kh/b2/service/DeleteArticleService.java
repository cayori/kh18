package kh.b2.service;

import java.sql.Connection;
import java.sql.SQLException;

import kh.b2.dao.ArticleDao;
import kh.b2.model.DeleteRequest;
import kh.b2.JdbcUtil;
import kh.b2.ConnectionProvider;
import kh.b2.exception.*;

public class DeleteArticleService {
	private DeleteArticleService() {}
	private static DeleteArticleService instance = new DeleteArticleService();
	public static DeleteArticleService getInstance() {	return instance;	}
	
	public void deleteArticle(DeleteRequest deleteRequest) 
			throws ArticleNotFoundException, InvalidPasswordException{
		Connection conn = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			
			ArticleCheckHelper helper = new ArticleCheckHelper();
			helper.checkExistsAndPassword(conn, deleteRequest.getArticleId(), deleteRequest.getPassword());
			
			ArticleDao articleDao = ArticleDao.getInstance();
			articleDao.delete(conn, deleteRequest.getArticleId());
			
			conn.commit();
			
		}catch(SQLException e) {
			JdbcUtil.rollback(conn);
			throw new RuntimeException(e);
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
			}
		}
	}
}
