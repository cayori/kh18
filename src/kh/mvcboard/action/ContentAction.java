package kh.mvcboard.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.board.BoardDataBean;
import kh.board.BoardDBBean;
import kh.board.CommentDataBean;
import kh.board.CommentDBBean;

public class ContentAction implements CommandAction{
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable{
		int num = Integer.parseInt(request.getParameter("num"));		// 해당 글번호
		String pageNum = request.getParameter("pageNum");				// 해당 페이지 번호
		
		BoardDBBean dbPro = BoardDBBean.getInstance();					// DB 처리
		BoardDataBean article = dbPro.getArticle(num);					// 해당 글번호에 대한 해당 레코드
		
		// 해당 뷰에서 사용할 속성
		request.setAttribute("num", new Integer(num));
		request.setAttribute("pageNum", new Integer(pageNum));
		request.setAttribute("article", article);
		
		// 댓글 인스턴스 셋업
		int pageSize = 10;
		String cPageNum = request.getParameter("cPageNum");
		if(cPageNum == null)	cPageNum = "1";
		int cCurrentPage = Integer.parseInt(cPageNum);
		int startRow = (cCurrentPage * pageSize) - (pageSize - 1); 
		int endRow = cCurrentPage * pageSize;
		
		CommentDBBean commentPro = CommentDBBean.getInstance();
		int commentCount = commentPro.getCommentCount(num);
		ArrayList<CommentDataBean> commentList = commentPro.getComments(num, startRow, endRow);
		
		// 댓글뷰 파트에서 사용할 속성
		request.setAttribute("cCurrentPage", new Integer(cCurrentPage));
		request.setAttribute("cPageNum", new Integer(cPageNum));
		request.setAttribute("commentCount", new Integer(commentCount));
		request.setAttribute("commentList", commentList);
		
		
		
		return "/MVC/content.jsp"; 				// 해당 뷰 페이지
	}
}
