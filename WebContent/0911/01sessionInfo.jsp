<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page session = "true" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.net.URLDecoder" %>

<%
	Date time = new Date();
	SimpleDateFormat formatter = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss SSS");
%>

<html>
<head><title>세션정보</title></head>
<body>
세션ID: <%= session.getId() %>
<% time.setTime(session.getCreationTime()); %>
세션생성시간 : <%= formatter.format(time) %><br>
<% time.setTime(session.getLastAccessedTime()); %>
최근접속시간 : <%= formatter.format(time) %>
<br>
<br>
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