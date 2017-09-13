<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>

<html>
<head><title>16view</title></head>
<body>

<% 
	String code = request.getParameter("code");
	String viewPageURI = null;

	if(code.equals("A"))		viewPageURI = "./viewModule/a.jsp";
	else if(code.equals("B"))	viewPageURI = "./viewModule/b.jsp";
	else if(code.equals("C"))	viewPageURI = "./viewModule/c.jsp";
	else 						viewPageURI = "./15select.jsp";

%>

<jsp:forward page="<%= viewPageURI %>" />

</body>
</html>

