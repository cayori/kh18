<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>

<% request.setCharacterEncoding("utf-8"); %>

<html>
<head><title>표현언어의 사용예제2</title></head>
<body>

<h3>표현언어의 사용예제2 - 파라미터값 처리</h3>
<p>
<form action="eLEx2.jsp" method="pose">
	이름:		<input type="text" name="name" value="${ param.name }">
			<input type="submit" value="확인">
</form>
<p>
이름은: ${ param.name } 입니다.

</body>
</html>