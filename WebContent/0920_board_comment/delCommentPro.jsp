<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "kh.board.CommentDBBean" %>

<%	request.setCharacterEncoding("utf-8");	%>

<%
	int content_num = Integer.parseInt(request.getParameter("content_num"));
	int comment_num = Integer.parseInt(request.getParameter("comment_num"));
	
	String pageNum = request.getParameter("p_num");
	String passwd = request.getParameter("passwd");
	
	CommentDBBean cmtPro = CommentDBBean.getInstance();
	int check = cmtPro.deleteComment(content_num, passwd, comment_num);
	
	if(check == 1){		%>
	<meta http-equiv=Refresh
	content="0;url=content.jsp?num=<%=content_num%>&pageNum=<%=pageNum%>">
<%	}else{	%>
	<script language="Javascript">
	<!--
		alert("비밀번호가 맞지 않습니다");
		history.go(-1);
	-->	
	</script>
<%	}	%>