<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true"%>
<%
	String memberId = (String)session.getAttribute("MEMBERID");
	String name = (String)session.getAttribute("NAME");
%>

<html>
<head><title>세션에서 정보 가져오기</title></head>
<body>
세션에서 가져온 정보:  <br>
memberID = <%= memberId %><br>
name = <%= name %><br>
</body>
</html>
