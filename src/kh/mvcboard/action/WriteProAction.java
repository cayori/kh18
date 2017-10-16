package kh.mvcboard.action;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.board.BoardDataBean;
import kh.board.JdbcUtil;
import kh.board.BoardDBBean;

public class WriteProAction implements CommandAction{

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		
		request.setCharacterEncoding("utf-8"); // 한글인코딩
		
		BoardDataBean article = new BoardDataBean();		// 데이터 처리빈
		article.setNum(Integer.parseInt(request.getParameter("num")));
		article.setWriter(request.getParameter("writer"));
		article.setEmail(request.getParameter("email"));
		article.setSubject(request.getParameter("subject"));
		article.setPasswd(request.getParameter("passwd"));
		article.setReg_date(new Timestamp(System.currentTimeMillis()));
		article.setRef(Integer.parseInt(request.getParameter("ref")));
		article.setRe_step(Integer.parseInt(request.getParameter("re_step")));
		article.setRe_level(Integer.parseInt(request.getParameter("re_level")));
		article.setContent(request.getParameter("content"));
		article.setIp(JdbcUtil.getClientIpAddr(request));
		
		BoardDBBean dbPro = BoardDBBean.getInstance();		
		dbPro.insertArticle(article);
		
		return "./writePro.jsp";
		
	}
	
}
