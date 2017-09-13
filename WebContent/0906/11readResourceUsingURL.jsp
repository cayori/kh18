<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URL" %>

<html>
<head><title>application 기본 객체 사용하여 자원얻기 2</title></head>
<body>

<%
	String resourcePath = "/0906/message/notice/notice.txt";

	BufferedReader br = null;
	char[] buff = new char[512];
	int len = -1;

	try{
		URL url = application.getResource(resourcePath);
		
		br = new BufferedReader( new InputStreamReader(url.openStream()) );
		while( (len=br.read(buff)) != -1 ){
			out.print(new String(buff,0,len));
		}
	}catch(IOException ioe){
		out.println("예외 발생 : "+ioe.getMessage());
	}finally{
		
	}

%>

</body>
</html>