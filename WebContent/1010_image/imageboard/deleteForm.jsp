<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>

<%	request.setCharacterEncoding("utf-8");	%>

<jsp:forward page="./template/template.jsp">
	<jsp:param name="CONTENTPAGE" value="../deleteForm_view.jsp" />
</jsp:forward>