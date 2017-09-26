<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setLocale value="en"/>

<fmt:bundle basename="resource.message">
<fmt:message key="TITLE" var="title" />
<html>
<head><title>${title }</title></head>
<body>

<fmt:message key="GREETING" />
<br>
<c:if test="${ !empty param.id }">
	<fmt:message key="VISITOR">
		<fmt:param value="${param.id }"></fmt:param>
	</fmt:message>
</c:if>

</body>
</html>


</fmt:bundle>