<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import = "kh.b2.service.WriteArticleService" %>
<%@ page import = "kh.b2.model.Article" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%	request.setCharacterEncoding("utf-8");	%>

<jsp:useBean id="writingRequest" class="kh.b2.model.WritingRequest" />
<jsp:setProperty name="writingRequest" property="*"/>

<%
	Article postedArticle = WriteArticleService.getInstance().write(writingRequest);
	request.setAttribute("postedArticle", postedArticle);

%>

<html>
<head><title>게시글 작성</title></head>
<body>
게시글을 등록했습니다<br><br>

<a href="<c:url value="./list.jsp"/>">목록보기</a>
<a href="<c:url value="./read.jsp?articleId=${postedArticle.id }"/>">게시글 읽기</a>
</body>

</html>