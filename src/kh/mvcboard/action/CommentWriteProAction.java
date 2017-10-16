package kh.mvcboard.action;

import kh.board.CommentDataBean;
import kh.board.JdbcUtil;
import kh.board.CommentDBBean;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class CommentWriteProAction implements CommandAction{

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		
		request.setCharacterEncoding("utf-8"); 
		
		int content_num = Integer.parseInt(request.getParameter("content_num"));
		int comment_num = Integer.parseInt(request.getParameter("comment_num"));
		String p_num = request.getParameter("p_num");
		
		CommentDataBean comment = new CommentDataBean();
		CommentDBBean cdb = CommentDBBean.getInstance();
				
		comment.setContent_num(content_num);
		comment.setCommenter(request.getParameter("commenter"));
		comment.setCommentt(request.getParameter("commentt"));
		comment.setPasswd(request.getParameter("passwd"));
		comment.setReg_date(new Timestamp(System.currentTimeMillis()));	
		comment.setIp(JdbcUtil.getClientIpAddr(request));
		comment.setComment_num(comment_num);
		
		cdb.insertComment(comment);
		
		// 뷰에서 사용할 속성 제공
		request.setAttribute("content_num", content_num);
		request.setAttribute("p_num", p_num);
		
		return "/MVC/commentWritePro.jsp";
	}

}
