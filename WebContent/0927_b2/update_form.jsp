<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import = "kh.b2.service.ReadArticleService" %>
<%@ page import = "kh.b2.model.Article" %>
<%@ page import = "kh.b2.exception.ArticleNotFoundException" %>

<%
	String viewPage = null;
	try{
		int articleId = Integer.parseInt(request.getParameter("articleId"));
		Article article = ReadArticleService.getInstance().getArticle(articleId);
		viewPage = "./update_form_view.jsp";
		request.setAttribute("article", article);
	}catch(ArticleNotFoundException e){
		viewPage = "./article_not_found.jsp";
	}
%>

<jsp:forward page="<%=viewPage %>" />