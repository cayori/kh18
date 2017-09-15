<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.Enumeration" %>

<html>
<head><title>초기화 파라미터 읽어오기</title></head>
<body>

초기화 파라미터 목록:
<ul>
<%
	Enumeration initParamEnum = application.getInitParameterNames();
	while(initParamEnum.hasMoreElements()){
		String initParamName = (String)initParamEnum.nextElement();
%>
	<li><%= initParamName %> = <%= application.getInitParameter(initParamName) %>
<%
	} 
%>
</ul>

</body>
</html>