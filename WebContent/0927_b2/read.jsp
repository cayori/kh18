<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import="kh.b2.service.ReadArticleService" %>
<%@ page import="kh.b2.exception.ArticleNotFoundException" %>
<%@ page import="kh.b2.model.Article" %>

<%
	int articleId = Integer.parseInt(request.getParameter("articleId"));
	String viewPage = null;
	
	try{
		Article article = ReadArticleService.getInstance().readArticle(articleId);
		request.setAttribute("article", article);
		viewPage = "./read_view.jsp";
	}catch(ArticleNotFoundException ex){
		viewPage = "./article_not_found.jsp";
	}
%>

<jsp:forward page="<%=viewPage %>"/>