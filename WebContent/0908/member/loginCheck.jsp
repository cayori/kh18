<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import="util.CookieBox" %>

<html>
<head><title>로그인 체크</title></head>
<body>

<%
	CookieBox cookiebox = new CookieBox(request);
// LOGIN 쿠키 값이 SUCCESS 인지 검사해서 맞으면 성공, 아니면 실패
	if(cookiebox.exists("LOGIN") && cookiebox.getValue("LOGIN").equals("SUCCESS")){
		out.println("아이디 \""+cookiebox.getValue("ID")+"\"로 로그인 한 상태");
	}else{
		out.println("로그인하지 않은 상태");
	}
%>


</body>
</html>