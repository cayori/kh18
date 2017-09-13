<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import="util.CookieBox" %>

<%
	CookieBox cookiebox = new CookieBox(request);
%>

<html>
<head><title>CoocieBox 사용</title></head>
<body>

name 쿠키 = <%= cookiebox.getValue("name") %><br>
<% if (cookiebox.exists("id")){ %>
id 쿠키 = <%= cookiebox.getValue("id") %><br>
<% } %>

</body>
</html>