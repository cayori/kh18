<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"
	trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.util.Map"%>

<%
	request.setCharacterEncoding("euc-kr");
%>

<html>
<head>
<title>��û �Ķ���� ���</title>
</head>
<body>

	<b>request.getParameter() �޼ҵ� ���</b>
	<br> 
	name �Ķ���� =<%=request.getParameter("name")%><br> 
	addr �Ķ���� =<%=request.getParameter("addr")%>
	<p>
		<b>request.getParameterValues() �޼ҵ� ���</b>
		<%
			String[] values = request.getParameterValues("pet");
			if (values != null) {
				for (int i = 0; i < values.length; i++) {
		%>
		<%=values[i]%>
		<%
			}
			}
		%>
	
	<p>
		<b>request.getParameterNames() �޼ҵ� ���</b>
		<%
			Enumeration paramEnum = request.getParameterNames();
			while (paramEnum.hasMoreElements()) {
				String name = (String) paramEnum.nextElement();
		%>
		<%=name%>
		<%
			}
		%>
	
	<p>
		<b>request.getParameterMap() �޼ҵ� ���</b>
		<%
			Map parameterMap = request.getParameterMap();
			String[] nameParam = (String[]) parameterMap.get("name");
			if (nameParam != null) {
		%>
		name =	<%=nameParam[0]%>
		<%
}
%>
	
</body>
</html>