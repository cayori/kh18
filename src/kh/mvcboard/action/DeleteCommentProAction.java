package kh.mvcboard.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.board.CommentDBBean;

public class DeleteCommentProAction implements CommandAction {

	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable{
		
		request.setCharacterEncoding("utf-8");
		
		int content_num = Integer.parseInt(request.getParameter("content_num"));
		int comment_num = Integer.parseInt(request.getParameter("comment_num"));		
		String cPageNum = request.getParameter("p_num");
		String passwd = request.getParameter("passwd");
		
		CommentDBBean cdb = CommentDBBean.getInstance();
		int result = cdb.deleteComment(content_num, passwd, comment_num); // 1 success 0 password not match
		
		
		request.setAttribute("ctn", new Integer(content_num));
		request.setAttribute("cmn", new Integer(comment_num));
		request.setAttribute("p_num", new Integer(cPageNum));
		request.setAttribute("result", new Integer(result));
				
		return "/MVC/deleteCommentPro.jsp";
	}
}
