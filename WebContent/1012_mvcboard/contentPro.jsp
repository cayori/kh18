<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import = "kh.board.CommentDBBean" %>
<%@ page import = "java.sql.Timestamp" %>

<%	request.setCharacterEncoding("utf-8");	%>

<jsp:useBean id="cdb" scope="page" class="kh.board.CommentDataBean">
	<jsp:setProperty name="cdb" property="*" />
</jsp:useBean>

<%
	CommentDBBean comt = CommentDBBean.getInstance();
	cdb.setReg_date(new Timestamp(System.currentTimeMillis()));
	cdb.setIp(request.getRemoteAddr());
	comt.insertComment(cdb);
	
	String content_num = request.getParameter("content_num");
	String p_num = request.getParameter("p_num");
	String url = "content.jsp?num="+content_num+"&pageNum="+p_num;
	response.sendRedirect(url);
%>
