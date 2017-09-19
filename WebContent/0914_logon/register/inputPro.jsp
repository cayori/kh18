<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "kh.LogonDBBean" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="memberData" class="kh.LogonDataBean">
	<jsp:setProperty name="memberData" property="*" />
</jsp:useBean>

<%
	memberData.setReg_date(new Timestamp(System.currentTimeMillis()) );
	LogonDBBean manager = LogonDBBean.getInstance();
	manager.insertMember(memberData);
	
	response.sendRedirect("../login/loginForm.jsp");
%>
	