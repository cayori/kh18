<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page errorPage = "./errorView.jsp" %>
<%@ page import = "kh.guest.Message" %>
<%@ page import = "kh.guest.WriteMessageService" %>

<%	request.setCharacterEncoding("utf-8");	%>

<jsp:useBean id="message" class="kh.guest.Message">
	<jsp:setProperty name="message" property="*" />
</jsp:useBean>

<%
	WriteMessageService writeService = WriteMessageService.getInstance();
	writeService.write(message);
%>

<html>
<head>
<title>방명록 메세지 남기기</title>
</head>
<body>
방명록에 메세지를 남겼습니다<br>
<a href="./list.jsp">[목록보기]</a>


</body>
</html>