<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import="java.io.*" %>

<html>
<head><title>절대 경로 사용하여 자원 읽기</title></head>
<body>

<%
FileReader fr = null;
char[] buff = new char[512];
int len = -1;

try{
	fr = new FileReader("C:\\JAVA\\workspace\\KH18\\WebContent\\0906\\message\\notice\\notice.txt");
	while( (len = fr.read(buff)) != -1 ) {
		out.print(new String(buff));
	}
}catch(IOException ex){
	out.println("예외발생: "+ex.getMessage());
}finally{
	if(fr != null) try{fr.close();} catch(IOException e){}
}

%>

</body>
</html>