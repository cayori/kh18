<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"
	trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.util.Map"%>

<%
	request.setCharacterEncoding("euc-kr");
%>

<html>
<head>
<title>요청 파라미터 출력</title>
</head>
<body>

	<b>request.getParameter() 메소드 사용</b>
	<br> 
	name 파라미터 =<%=request.getParameter("name")%><br> 
	addr 파라미터 =<%=request.getParameter("addr")%>
	<p>
		<b>request.getParameterValues() 메소드 사용</b>
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
		<b>request.getParameterNames() 메소드 사용</b>
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
		<b>request.getParameterMap() 메소드 사용</b>
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