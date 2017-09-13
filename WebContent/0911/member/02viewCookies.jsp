<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import="java.net.URLDecoder" %>
<!DOCTYPE=html>

<html>
<head><title>쿠키목록</title></head>
<body>
쿠키목록<br>
<% 
	Cookie[] cookies = request.getCookies();
	if( cookies != null && cookies.length>0){
		for(int i=0; i<cookies.length; i++){
			out.print(cookies[i].getName() + " : \""+
			URLDecoder.decode(cookies[i].getValue(),"utf-8")+"\"");
			out.println("<br>");
		}
	} else {
		out.println("쿠키가 존재하지 않습니다");
	}
%>

</body>
</html>