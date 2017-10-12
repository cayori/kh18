<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import="kh.board.BoardDBBean" %>
<%@ page import="kh.board.JdbcUtil" %>
<%@ page import="java.sql.Timestamp" %>

<%	request.setCharacterEncoding("utf-8");	%>

<jsp:useBean id="article" scope="page" class="kh.board.BoardDataBean">
	<jsp:setProperty name="article" property="*" />
</jsp:useBean>

<%
	article.setReg_date(new Timestamp(System.currentTimeMillis()) );
	article.setIp(JdbcUtil.getClientIpAddr(request));
	
	BoardDBBean dbPro = BoardDBBean.getInstance();
	dbPro.insertArticle(article);
	
	response.sendRedirect("list.jsp");
%>