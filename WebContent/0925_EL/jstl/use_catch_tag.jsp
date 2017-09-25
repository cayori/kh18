<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head><title>catch 태그</title></head>
<body>

<c:catch var="ex">
	name 파라미터의 값 = <%=request.getParameter("name") %><br>
	<%	if(request.getParameter("name").equals("test")){ %>
	${param.name } 은 test 입니다.
	<%	} %>
</c:catch>
<p>
<c:if test="${ex != null }">
	예외가 발생했습니다: <br>
</c:if>
</body>


</html>