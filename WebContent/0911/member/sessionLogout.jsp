<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>

<%
	session.invalidate();
%>


<html>
<head><title>로그아웃</title></head>
<body>

<script>
alert("로그아웃 되었습니다.");
location.href = "./sessionLoginForm.jsp";

</script>


</body>
</html>