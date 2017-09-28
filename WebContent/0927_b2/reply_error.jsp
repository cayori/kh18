<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="exceptionType" value="${replyException.class.simpleName }" />

<html>
<head><title>답변실패</title></head>
<body>

에러: 
<c:choose>
	<c:when test="${exceptionType == 'ArticleNotFoundException' }">
		답변을 등록할 게시글이 존재하지 않습니다.
	</c:when>
	<c:when test="${exceptionType == 'CannotReplyArticleException' }">
		답변 글을 등록할 수 없는 게시물입니다.
	</c:when>
	<c:when test="${exceptionType == 'LastChildAlreadyExistsException' }">
		등록할 수 있는 답변 갯수를 초과했습니다.
	</c:when>
</c:choose>
<br>
<a href="<c:url value='./list.jsp?p=${param.p }' />">목록보기</a>
</body>
</html>