<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import = "kh.b2.service.UpdateArticleService" %>
<%@ page import = "kh.b2.model.Article" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%	request.setCharacterEncoding("utf-8");	%>

<jsp:useBean id="updateRequest" class="kh.b2.model.UpdateRequest" />
<jsp:setProperty name="updateRequest" property="*"/>

<%
	String viewPage = null;
	try{	
		Article updatedArticle = UpdateArticleService.getInstance().update(updateRequest);
		request.setAttribute("updatedArticle", updatedArticle);
		viewPage = "./update_success.jsp";
	}catch(Exception e){
		request.setAttribute("updateException", e);
		viewPage = "./update_error.jsp";
	}
%>

<jsp:forward page="<%=viewPage %>"/>