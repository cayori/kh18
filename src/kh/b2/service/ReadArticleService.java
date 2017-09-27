package kh.b2.service;

import java.sql.Connection;
import java.sql.SQLException;

import kh.b2.dao.ArticleDao;
import kh.b2.model.Article;
import kh.b2.JdbcUtil;
import kh.b2.ConnectionProvider;
import kh.b2.exception.*;

public class ReadArticleService {
	private ReadArticleService() {}
	private static ReadArticleService instance = new ReadArticleService();
	public static ReadArticleService getInstance() {	return instance;	}
	
	public Article readArticle(int articleId) throws ArticleNotFoundException{
		return selectArticle(articleId, true);
	}
	
	private Article selectArticle(int articleId, boolean increaseCount) throws ArticleNotFoundException{
		Connection conn = null;
		Article article = null;
		try {
			conn = ConnectionProvider.getConnection();
			ArticleDao articleDao = ArticleDao.getInstance();
			 article = articleDao.selectById(conn, articleId);
			
			if(article == null) {
				throw new ArticleNotFoundException("게시글이 존재하지 않습니다 : "+articleId);
			}
			if(increaseCount) {
				articleDao.increaseReadCount(conn, articleId);
				article.setReadCount(article.getReadCount()+1);
			}			
			
		}catch(SQLException e){
			throw new RuntimeException("DB 에러발생: "+ e.getMessage(), e);
		}finally {
			JdbcUtil.close(conn);
		}
		return article;
	}
	
	public Article getArticle(int articleId) throws ArticleNotFoundException{
		return selectArticle(articleId, false);
	}	
}
