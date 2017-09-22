<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page errorPage="./errorView.jsp" %>
<%@ page import = "kh.guest.DeleteMessageService" %>
<%@ page import = "kh.guest.Exceptions.InvalidMessagePasswordException" %>

<%
	int messageId = Integer.parseInt(request.getParameter("messageId"));
	String passwd = request.getParameter("passwd");
	boolean invalidPasswd = false;
	
	try{
		DeleteMessageService deleteService = DeleteMessageService.getInstance();
		deleteService.deleteMessage(messageId, passwd);
	}catch(InvalidMessagePasswordException e){
		invalidPasswd = true;
	}
%>

<html>
<head>
<title>방명록 메세지 삭제함</title>
</head>
<body>
<%	if(!invalidPasswd){	 %>
메세지를 삭제하였습니다.
<%	}else {	%>
입력한 암호가 올바르지 않습니다. 암호를 확인해 주세요.
<%	}	%>
<br>
<a href="./list.jsp">[]목록보기]</a>

</body>
</html>