<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>

<%
	String ID = (String)session.getAttribute("ID");
	if(ID != null){
		out.println(ID +" 로 로그인되었습니다");
	}else{
		out.println("로그인 중이 아닙니다");
	}


%>
