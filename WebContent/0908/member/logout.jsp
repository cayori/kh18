<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import="util.CookieBox" %>

<html>
<head><title>로그아웃</title></head>
<body>
<% 
	response.addCookie(CookieBox.createCookie("LOGIN","","/",0));

	
	//response.addCookie(CookieBox.createCookie("ID","","/",0));
	
%>

<script>
alert("로그아웃 되었습니다");
location.href='./loginForm.jsp';

</script>

</body>
</html>