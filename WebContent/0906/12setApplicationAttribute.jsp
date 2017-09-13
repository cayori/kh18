<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>

<%
	String name = request.getParameter("name");
	String value = request.getParameter("value");
	
	if(name != null && value != null){
		application.setAttribute(name,value);
	}

%>
<html>
<head><title>application 속성 지정</title></head>
<body>

<%	if( name!=null && value!=null) {	%>
application 기본 객체의 속성 설정:
<%= name%> = <%= value%>
<%	}else { 	%>
application 기본객체의 속성 설정 안됨.
<%	}	%>

</body>
</html>