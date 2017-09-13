<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%--<%@ page import="kh.member.MemberInfo" %> --%>

<jsp:useBean id="member" scope="request" class="kh.member.MemberInfo" />

<%
	member.setId("KH");
	member.setName("케이에이치");
%>

<jsp:forward page="./useObject.jsp" />