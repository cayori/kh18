<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${result == 0 }">
	<script>
	<!--
		alert("비밀번호가 맞지 않습니다");
		history.go(-1);
	-->	
	</script>
</c:if>

<c:if test="${result == 1 }">
	<meta http-equiv=Refresh content="0;url=./content.go?num=${ctn }&pageNum=${p_num}">
</c:if>
