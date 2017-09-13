<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page trimDirectiveWhitespaces = "true" %>
<%@ page import = "java.util.*" %>
<% Calendar now = Calendar.getInstance(); %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>test JSP page</title>
</head>
<body>
HELLO JSP!!!<br>
현재시각: <br>
<%=now.get(Calendar.YEAR)%>년 
<%=now.get(Calendar.MONTH)%>월 
<%=(Calendar.DAY_OF_MONTH)%>일

<%	
	String bookTitle = "JSP 프로그래밍";
	String author = "최범균";
%>
<br>
<b> <%= bookTitle %> </b>
<br>
(<%= author %>) 입니다

</body>
</html>