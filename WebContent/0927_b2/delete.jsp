<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import = "kh.b2.service.DeleteArticleService" %>


<jsp:useBean id="deleteRequest" class="kh.b2.model.DeleteRequest"/>
<jsp:setProperty name="deleteRequest" property="*"/>

<%
	String viewPage = null;
	try{
		DeleteArticleService.getInstance().deleteArticle(deleteRequest);
		viewPage = "./delete_success.jsp";
	}catch(Exception e){
		request.setAttribute("deleteException", e);
		viewPage = "./delete_error.jsp";
	}
%>

<jsp:forward page="<%=viewPage%>" />