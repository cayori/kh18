<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:set var="exceptionType" value="${deleteException.class.simpleName }" />

<html>
<head><title>삭제실패</title></head>
<body>
에러: 
<c:choose>
	<c:when test="${exceptionType == 'ArticleNotFoundException }">
		삭제할 게시물이 존재하지 않습니다.
	</c:when>
	<c:when test="${exceptionType == 'InvalidPasswordException' }">
		암호를 잘못 입력하셨습니다.
	</c:when>
</c:choose>

</body>

</html>