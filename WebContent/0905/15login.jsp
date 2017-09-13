<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.net.URLDecoder" %>
<%
	
	request.setCharacterEncoding("UTF-8");
	String param = request.getParameter("memberId");
	//param = new String(param.getBytes("8859_1"),"UTF-8");
	
	if (param.equals("KH08")) response.sendRedirect("./11requestInfo.jsp");
	else{
%>

<!DOCTYPE=html>
<html>
<head>
<title>
로그인에 실패했습니다.
</title>
</head>
<body>
<%= param %><br>
ID가 KH08이 아닙니다
</body>
</html>

<% 
	}
%>