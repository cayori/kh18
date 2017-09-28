package kh.b2.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.Date;

import kh.b2.dao.ArticleDao;
import kh.b2.model.Article;
import kh.b2.model.ReplyingRequest;
import kh.b2.JdbcUtil;
import kh.b2.ConnectionProvider;
import kh.b2.exception.*;

public class ReplyArticleService {
	private ReplyArticleService() {}
	private static ReplyArticleService instance = new ReplyArticleService();
	public static ReplyArticleService getInstance() {	return instance;	}
	
	public Article reply(ReplyingRequest replyingRequest)
			throws ArticleNotFoundException, CannotReplyArticleException, LastChildAlreadyExistsException{
		Connection conn = null;
		Article article = replyingRequest.toArticle();
		
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			
			ArticleDao articleDao = ArticleDao.getInstance();
			Article parentArticle = articleDao.selectById(conn, replyingRequest.getParentArticleId()); 
			
			try {
				checkParent(parentArticle, replyingRequest.getParentArticleId());
			}catch(Exception e) {
				JdbcUtil.rollback(conn);
				if(e instanceof ArticleNotFoundException)			throw (ArticleNotFoundException)e;
				if(e instanceof CannotReplyArticleException)		throw (CannotReplyArticleException)e;
				if(e instanceof LastChildAlreadyExistsException)	throw (LastChildAlreadyExistsException)e;
			}
			
			String searchMaxSeqNum = parentArticle.getSequenceNumber();
			String searchMinSeqNum = getSearchMinSeqNum(parentArticle);
			String lastChildSeq = articleDao.selectLastSequenceNumber(conn, searchMaxSeqNum, searchMinSeqNum);
			String sequenceNumber = getSequenceNumber(parentArticle, lastChildSeq);
			
			article.setGroupId(parentArticle.getGroupId());
			article.setSequenceNumber(sequenceNumber);
			article.setPostingDate(new Date());
			
			int articleId = articleDao.insert(conn, article);
			if(articleId == -1) {
				throw new RuntimeException("DB 삽입 안됨: "+articleId);
			}
			conn.commit();
			article.setId(articleId);
						
		}catch(SQLException e) {
			JdbcUtil.rollback(conn);
			throw new RuntimeException("DB 작업 실패: "+e.getMessage(), e);
		}finally {
			if(conn != null) {
				try {
					conn.setAutoCommit(true);
				}catch(SQLException e) {}
			}
			JdbcUtil.close(conn);
		}
		
		return article;
	}
	
	private void checkParent(Article parentArticle, int parentId) 
			throws ArticleNotFoundException, CannotReplyArticleException{
		if(parentArticle == null) {
			throw new ArticleNotFoundException("부모글이 존재하지 않음: "+parentId);
		}
		int parentLevel = parentArticle.getLevel();
		if(parentLevel == 3) {
			throw new CannotReplyArticleException("마지막 레벨 글에는 답글을 달 수 없습니다: "+parentArticle.getId());
			
		}
	}
	
	private String getSearchMinSeqNum(Article parentArticle) {
		String parentSeqNum = parentArticle.getSequenceNumber();
		DecimalFormat decimalFormat = new DecimalFormat("0000000000000000");
		long parentSeqLongValue = Long.parseLong(parentSeqNum);
		long searchMinLongValue = 0;
		switch (parentArticle.getLevel()) {
		case 0:
			searchMinLongValue = parentSeqLongValue / 1000000L * 1000000L;
			break;
		case 1:
			searchMinLongValue = parentSeqLongValue / 10000L * 10000L;
			break;
		case 2:
			searchMinLongValue = parentSeqLongValue / 100L * 100L;
			break;
		}
		return decimalFormat.format(searchMinLongValue);
	}
	
	private String getSequenceNumber(Article parentArticle, String lastChildSeq) 
			throws LastChildAlreadyExistsException{
		long parentSeqLong = Long.parseLong(parentArticle.getSequenceNumber());
		int parentLevel = parentArticle.getLevel();
		
		long decUnit = 0;
		if		(parentLevel == 0) {	decUnit = 10000L;	}
		else if	(parentLevel == 1) {	decUnit = 100L;		}
		else if	(parentLevel == 2) {	decUnit = 1L;		}
		
		String sequenceNumber = null;
		
		DecimalFormat decimalFormat = new DecimalFormat("0000000000000000");
		
		if(lastChildSeq == null) {
			sequenceNumber = decimalFormat.format(parentSeqLong - decUnit);
		}else {
			String orderOfLastChildSeq = null;
			if(parentLevel == 0) {
				orderOfLastChildSeq = lastChildSeq.substring(10,12);
				sequenceNumber = lastChildSeq.substring(0,12) + "9999";
			}else if(parentLevel == 1) {
				orderOfLastChildSeq = lastChildSeq.substring(12,14);
				sequenceNumber = lastChildSeq.substring(0,14)+"99";
			}else if(parentLevel == 2) {
				orderOfLastChildSeq = lastChildSeq.substring(14,16);
				sequenceNumber = lastChildSeq;
			}
			
			if(orderOfLastChildSeq.equals("00")) {
				throw new LastChildAlreadyExistsException("해당 답글단계의 한도에 도달했습니다: "+lastChildSeq);
			}
			
			long seq = Long.parseLong(sequenceNumber) - decUnit;
			sequenceNumber = decimalFormat.format(seq);
		}		
		return sequenceNumber;
	}
	
}
