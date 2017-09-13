<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import = "java.net.*" %>

<%
	Cookie cookie1 = new Cookie("path1", URLEncoder.encode("경로: /KH18/0908/path1","utf-8"));
	cookie1.setPath("/KH18/0908/path1");
	response.addCookie(cookie1);
	
	Cookie cookie2 = new Cookie("path2", URLEncoder.encode("경로: ","utf-8"));
	response.addCookie(cookie2);
	
	Cookie cookie3 = new Cookie("path3", URLEncoder.encode("경로: /","utf-8"));
	cookie3.setPath("/");
	response.addCookie(cookie3);
	
	Cookie cookie4 = new Cookie("path4", URLEncoder.encode("경로: /KH18/0908/path2","utf-8"));
	cookie4.setPath("/KH18/0908/path2");
	response.addCookie(cookie4);

%>

<html>
<head><title>쿠키 경로 지정</title></head>
<body>
다음과 같이 쿠키를 생성했습니다.
<br>
<%= cookie1.getName() %> : <%= URLDecoder.decode(cookie1.getValue(),"utf-8") %><br>
[<%= cookie1.getDomain() %>]<br>
[<%= cookie1.getPath() %>]<br><br>
<%= cookie2.getName() %> : <%= URLDecoder.decode(cookie2.getValue(),"utf-8") %><br>
[<%= cookie2.getDomain() %>]<br>
[<%= cookie2.getPath() %>]<br><br>
<%= cookie3.getName() %> : <%= URLDecoder.decode(cookie3.getValue(),"utf-8") %><br>
[<%= cookie3.getDomain() %>]<br>
[<%= cookie3.getPath() %>]<br><br>
<%= cookie4.getName() %> : <%= URLDecoder.decode(cookie4.getValue(),"utf-8") %><br>
[<%= cookie4.getDomain() %>]<br>
[<%= cookie4.getPath() %>]<br><br>

</body>
</html>