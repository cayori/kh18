package kh.mvcboard.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteCommentFormAction implements CommandAction {

	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable{
		int content_num = Integer.parseInt(request.getParameter("ctn"));
		int comment_num = Integer.parseInt(request.getParameter("cmn"));		
		String cPageNum = request.getParameter("p_num");
		
		request.setAttribute("ctn", new Integer(content_num));
		request.setAttribute("cmn", new Integer(comment_num));
		request.setAttribute("p_num", new Integer(cPageNum));
		
		return "/MVC/deleteCommentForm.jsp";
	}
}
