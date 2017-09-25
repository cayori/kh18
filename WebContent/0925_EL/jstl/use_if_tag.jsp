<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head><title>if 태그</title></head>
<body>

<c:if test="true">
	무조건 수행<br>
</c:if>

<c:if test="${param.name == 'bk' }">
	name 파라미터의 값이 ${param.name } 입니다.<br>
</c:if>

<c:if test="${param.age > 18 }">
	당신의 나이는 18세 이상입니다.
</c:if>



</body>
</html>