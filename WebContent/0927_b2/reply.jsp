<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import = "kh.b2.service.ReplyArticleService" %>
<%@ page import = "kh.b2.model.Article" %>

<%	request.setCharacterEncoding("utf-8");	%>

<jsp:useBean id="replyingRequest" class="kh.b2.model.ReplyingRequest" />
<jsp:setProperty name="replyingRequest" property="*" />

<%
	String viewPage = null;
	try{
		Article postedArticle = ReplyArticleService.getInstance().reply(replyingRequest);
		request.setAttribute("postedArticle", postedArticle);
		viewPage = "./reply_success.jsp";
	}catch(Exception ex){
		viewPage = "./reply_error.jsp";
		request.setAttribute("replyException", ex);
	}
%>
<jsp:forward page="<%= viewPage %>" />