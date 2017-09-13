<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import="util.CookieBox" %>

<%
	String id = request.getParameter("id");
	String password = request.getParameter("password");

	if(id.equals(password)){
		response.addCookie(CookieBox.createCookie("LOGIN", "SUCCESS", "/", -1));
		if(request.getParameter("checked") == null){
			response.addCookie(CookieBox.createCookie("ID", "", "/", -1));
		}else{
		response.addCookie(CookieBox.createCookie("ID", id, "/", -1));
		}
%>

<html>
<head><title>로그인 성공</title></head>
<body>
로그인에 성공했습니다.<br>




<form action="./logout.jsp" >
<input type="submit" value="로그아웃">
</form>

</body>
</html>

	
<%	
	}else{
%>		
	
<script>
alert("로그인에 실패했습니다");
history.go(-1);
</script>	
	
	
		
<%		
	}
%>





