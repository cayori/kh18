<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${param.dest == '1' }">
	<c:redirect url="/use_c_set.jsp" />
</c:if>

<c:if test="${param.dest == '2' }">
	<c:redirect url="use_c_set.jsp" />
</c:if>

<c:if test="${param.dest == '3' }">
	<c:redirect url="/0925_EL/viewToday.jsp" context="/KH18" />
</c:if>

<c:if test="${param.dest == '4' }">
	<c:redirect url="https://www.youtube.com/results">
		<c:param name="search_query" value="omg"/>
	</c:redirect>
</c:if>