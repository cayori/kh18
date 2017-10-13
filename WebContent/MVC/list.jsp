<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file = "color.jspf" %>

<html>
<head>
<title>게시판</title>
<link href="./style.css" type="text/css" rel="stylesheet">
</head>

<body bgcolor="${bodyback_c }">

<center><b>글목록(전체 글:${count })</b>
<table width="700">
	<tr>
		<td align="right" bgcolor="${value_c }">
			<a href="./writeForm.go">글쓰기</a>
		</td>
	</tr>
</table>

<c:if test="${count == 0 }">
<table width="700" border="1" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center">	게시판에 저장된 글이 없습니다</td>
	</tr>
</table>
</c:if>

<c:if test="${count > 0 }">
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
	<tr height="30" bgcolor="${value_c }">
		<td align="center" width="50"	>번호</td>
		<td align="center" width="250"	>제      목</td>
		<td align="center" width="100"	>작성자</td>
		<td align="center" width="150"	>작성일</td>
		<td align="center" width="50"	>조회</td>
		<td align="center" width="100"	>IP</td>
	</tr>
	<c:forEach var="article" items="${articleList }">
		<tr height="30">
			<td align="center" width="50">
				${number }
				<c:set var="number" value="${number-1 }" />
			</td>
			<td width="250">
				<img src="./images/level.gif" width="${5*article.re_level }" height="16">
				<c:if test="${article.re_level > 0}">
					<img src="./images/re.gif">
				</c:if>
				<a href="./content.go?num=${article.num }&pageNum=${currentPage }">${article.subject }</a>
				<c:if test="${article.comment_count > 0 }" >
					[${article.comment_count }]
				</c:if>
				<c:if test="${article.readcount >= 20 }">
					<img src="./images/hot.gif" border="0" height="16">
				</c:if>
			</td>
			<td width="100" align="center">
				<a href="mailto:${article.email }">${article.writer }</a>
			</td>
			<td width="150" align="center">
				<fmt:formatDate var="formattedDate" value="${article.reg_date}" pattern="yyyy-MM-dd HH:mm"/>
				${formattedDate }
			</td>
			<td width="50" align="center">		${article.readcount }	</td>
			<td width="100" align="center">		${article.ip }			</td>
		</tr>
	</c:forEach>
</table>
</c:if>
<!-- 아래 페이지 카운트 -->
<c:if test="${count > 0 }">
	<c:set var="pageCount" value="${count / pageSize + (count % pageSize == 0 ? 0:1)}"/>	
	<c:set var="pageBlock" value="10" />													
	<fmt:parseNumber var="result" value="${currentPage / 10}" integerOnly="true" />
	<c:set var="startPage" value="${result * pageBlock +1}" />
	<c:set var="endPage" value="${startPage + pageBlock-1 }" />
	<c:if test="${endPage > pageCount }" >
		<c:set var="endPage" value="${pageCount }" />
	</c:if>
	
	<c:if test="${startPage > pageBlock }">
		<a href="./list.go?pageNum=${startPage - pageBlock }">[이전]</a>
	</c:if>
	
	<c:forEach var="i" begin="${startPage }" end="${endPage }">
		<a href="./list.go?pageNum=${i }">[${i }]</a>
	</c:forEach>
	
	<c:if test="${endPage < pageCount }">
		<a href="./list.go?pageNum=${startPage + pageBlock }">[다음]</a>
	</c:if>
</c:if>

<!-- 아래 검색 인터페이스 -->
<form>
	<select name="searchn">
		<option value="0">작성자</option>
		<option value="1">제목</option>
		<option value="2">내용</option>
	</select>
	
	<input type="text" name="search" size="15" maxlength="50" />
	<input type="submit" value="검색" />
</form>

<br></br>
</body>
</html>