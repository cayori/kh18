<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import="kh.board.BoardDBBean" %>
<%@ page import="java.sql.Timestamp" %>

<%	request.setCharacterEncoding("utf-8");	%>

<jsp:useBean id="article" scope="page" class="kh.board.BoardDataBean">
	<jsp:setProperty name="article" property="*" />
</jsp:useBean>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String passwd = request.getParameter("passwd");
	String pageNum = request.getParameter("pageNum");
	
	BoardDBBean dbPro = BoardDBBean.getInstance();
	int check = dbPro.deleteArticle(num, passwd);
	
	if(check == 1){	%>00
		<meta http-equiv="Refresh" content="0;url=list.jsp?pagenum=<%=pageNum%>">
<%	}else { %>
		<script language="Javascript">
		<!--
			alert("비밀번호가 맞지 않습니다");
			history.go(-1);
		-->
		</script>
	
<%	}	%>