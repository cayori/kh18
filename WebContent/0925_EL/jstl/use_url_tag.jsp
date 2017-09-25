<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head><title>be</title></head>
<body>

<c:url value="http://search.daum.net/search" var="searchUrl">
	<c:param name="w" value="blog" />
	<c:param name="q" value="박지성" />
</c:url>

<ul>
	<li>${searchUrl }</li>
	<li><c:url value="/use_if_tag.jsp" /></li>
	<li><c:url value="./use_if_tag.jsp" /></li>
</ul>


</body>
</html>