<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import = "kh.LogonDBBean" %>

<%
	request.setCharacterEncoding("utf-8"); 

	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	LogonDBBean manager = LogonDBBean.getInstance();
	int check = manager.userCheck(id,passwd);
	
	if(check == 1){
		session.setAttribute("memId",id);
		response.sendRedirect("../main.jsp");
	}else if(check == 0){	%>
	<script>
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);
	</script>
<%	}	%>