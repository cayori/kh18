<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.Enumeration" %>

<html>
<head><title>application 기본 객체의 속성 보기</title></head>
<body>
<%
	Enumeration attrEnum = application.getAttributeNames();
	while(attrEnum.hasMoreElements()){
		String attrName = (String)attrEnum.nextElement();
		Object attrValue = application.getAttribute(attrName);
%>
application 속성: <br>
<b><%= attrName%></b> = <%= attrValue %><br>
<%
	}
%>



</body>
</html>