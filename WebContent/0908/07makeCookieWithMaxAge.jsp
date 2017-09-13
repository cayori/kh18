<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>

<%
	Cookie cookie = new Cookie("onem", "whatever");
	cookie.setMaxAge(60);
	response.addCookie(cookie);

%>


<html>
<head><title>쿠키유효시간설정</title></head>
<body>

유효시간이 1분인 onem 쿠키 생성.

</body>
</html>