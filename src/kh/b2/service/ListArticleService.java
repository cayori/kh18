package kh.b2.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import kh.b2.dao.ArticleDao;
import kh.b2.model.Article;
import kh.b2.model.ArticleListModel;
import kh.b2.JdbcUtil;
import kh.b2.ConnectionProvider;

public class ListArticleService {
	private ListArticleService() {}
	private static ListArticleService instance = new ListArticleService();
	public static ListArticleService getInstance() {	return instance;	}
	
	public static final int COUNT_PER_PAGE = 10;
	
	public ArticleListModel getArticleList(int requestPageNumber) {
		ArticleListModel alm = null;
		if(requestPageNumber < 0) {
			throw new IllegalArgumentException("page number < 0 : "+requestPageNumber);
		}
		ArticleDao articleDao = ArticleDao.getInstance();
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			int totalArticleCount = articleDao.selectCount(conn);
			
			if(totalArticleCount == 0) {
				alm = new ArticleListModel();
			}else {
				int totalPageCount = calculateTotalPageCount(totalArticleCount);
				int firstRow = (requestPageNumber - 1) * COUNT_PER_PAGE +1;
				int endRow = firstRow + COUNT_PER_PAGE - 1;
				
				if(endRow > totalArticleCount) {
					endRow = totalArticleCount;
				}
				
				List<Article> articleList = articleDao.select(conn, firstRow, endRow);
				alm = new ArticleListModel(articleList, requestPageNumber, totalPageCount, firstRow, endRow);
			}
		}catch(SQLException e) {
			throw new RuntimeException("DB 에러발생 : "+ e.getMessage(), e);
		}finally {
			JdbcUtil.close(conn);
		}
		return alm;
	}
	
	private int calculateTotalPageCount(int totalArticleCount) {
		if(totalArticleCount == 0) {
			return 0;
		}
		int pageCount = totalArticleCount / COUNT_PER_PAGE;
		if(totalArticleCount % COUNT_PER_PAGE > 0) {
			pageCount++;
		}
		return pageCount;
	}
	
	
	
}
