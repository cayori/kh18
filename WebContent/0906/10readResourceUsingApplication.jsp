<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import="java.io.*" %>

<html>
<head><title>application 기본 객체 사용하여 자원 읽기</title></head>
<body>

<% String resourcePath = "/0906/message/notice/notice.txt"; %>
자원의 실제경로: <br>
<%= application.getRealPath(resourcePath) %><br>
-------------<br>
<%= resourcePath %>의 내용<br>
-------------<br>
<%
BufferedReader br = null;
char[] buff = new char[512];
int len = -1;

try{
	br = new BufferedReader( new InputStreamReader(application.getResourceAsStream(resourcePath)) );
	while( (len = br.read(buff)) != -1){
		out.print(new String(buff));
	}
}catch(IOException ioe){
	out.println("예외 발생 :"+ioe.getMessage());
}finally{
	br.close();
}



%>

</body>
</html>