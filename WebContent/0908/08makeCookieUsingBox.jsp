<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import="util.CookieBox" %>

<%
	response.addCookie( CookieBox.createCookie("name", "최범균", "/KH18/0908", 50) );
	response.addCookie( CookieBox.createCookie("id", "madvirus", "/KH18/0908", -1) );

%>


<html>
<head><title>CookieBox 사용 예</title></head>
<body>
CookieBox 를 사용하여 쿠키 생성
</body>
</html>