<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page session="true" %>
<%
	session.setAttribute("MEMBERID", "madvirus");
	session.setAttribute("NAME", "최범균");
%>
<html>
<head><title>세션에 정보저장</title></head>
<body>
세션에 정보를 저장하였습니다.
</body>
</html>