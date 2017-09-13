<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URLDecoder" %>

<%
	Cookie cookie = new Cookie("name", URLEncoder.encode("최범균","utf-8"));
	cookie.setMaxAge(10);
	response.addCookie(cookie);
%>

<html>
<head><title>쿠키생성</title></head>
<body>
<%= cookie.getName() %> 쿠키의 값 = "<%= cookie.getValue() %>"<br>
<%= cookie.getName() %> 쿠키의 값 = "<%= URLDecoder.decode(cookie.getValue(),"utf-8") %>"
</body>
</html>