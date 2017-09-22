<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>


<html>
<head>
<title>방명록 메세지 삭제 확인</title>
</head>
<body>

<form action="./deleteMessage.jsp" method="post">
	<input type="hidden" name="messageId" value="<%= request.getParameter("messageId") %>">
	메세지를 삭제하시려면 암호를 입력하세요: <br>
	암호: <input type="password" name="passwd"><br>
	<input type="submit" value="삭제하기">
</form>

</body>
</html>