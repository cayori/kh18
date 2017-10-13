package kh.mvcboard.action;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.board.BoardDataBean;
import kh.board.BoardDBBean;

public class WriteProAction implements CommandAction{

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		
		request.setCharacterEncoding("utf-8"); // 한글인코딩
		
		BoardDataBean article = new BoardDataBean();		// 데이터 처리빈
		article.setNum(Integer.parseInt(request.getParameter("num")));
		
		return "/MVC/writePro.jsp";
		
	}
	
}
