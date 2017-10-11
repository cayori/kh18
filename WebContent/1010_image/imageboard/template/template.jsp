<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page errorPage="../error/error_view.jsp" %>

<html>
<head>
<title>테마 갤러리</title>
<style>
	A {
	color: blue; 
	font-weight: bold; 
	text-decoration: none
	}
	A:hover { 
	color: blue; 
	font-weight: bold; 
	text-decoration: underline
	}
</style>
</head>

<body>

<table width="100%" border="1" cellpadding="2" cellspacing="0">
	<tr>
		<td>
			<jsp:include page="../module/top.jsp" flush="false" />
		</td>
	</tr>
	<tr>
		<!-- 내용부분 시작 -->
		<jsp:include page="${param.CONTENTPAGE }" flush="false" />
		<!-- 내용부분 끝 -->
	</tr>
	<tr>
		<td>
			<jsp:include page="../module/bottom.jsp" flush="false" />
		</td>
	</tr>
</table>

</body>

</html>