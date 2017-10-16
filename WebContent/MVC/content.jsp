<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="color.jspf" %>


<html>
<head>
<title>게시판</title>
<link href="./style.css" rel="stylesheet" type="text/css">
<script>
function commenttSave(){
	if(document.comment.commentt.value==""){
		alert("내용을 입력하십시요.");
		document.comment.commentt.focus();
		return false;
	}
	if(document.comment.commenter.value==""){
		alert("작성자를 입력하십시요.");
		document.comment.commentt.focus();
		return false;
	}
	if(document.comment.passwd.value==""){
		alert("비밀번호를 입력하십시요.");
		document.comment.commentt.focus();
		return false;
	}
}
</script>
<style type="text/css"></style>
<!--
a:link { color:black; text-decoration:none; }
a:visited {  }
a:active { text-decoration:underline; }
a:hover { text-decoration:underline; background-image:url('text_dottdeline.gif'); background-repeat:repeat-x; background-position:50% 100%; }
-->
</style>
<style>
<!--
@font-face {font-family:굴림; src:url();}
body,td,a,div,p,pre,input,textarea {font-family:굴림;font-size:9pt;}
-->
</style>
</head>

<body bgcolor="${bodyback_c }">
<center><b>글 내용 보기</b>
<br>
<form method="post" action="./conmmentWritePro.go" name="comment" onsubmit="return commenttSave()">
	<table width="500" border="1" cellspacing="0" cellpadding="0" align="center">
		<tr height="30">
			<td align="center" width="125" bgcolor="${value_c }">글번호</td>
			<td align="center" width="125">${article.num }</td>
			<td align="center" width="125" bgcolor="${value_c }">조회수</td>
			<td align="center" width="125">${article.readcount }</td>
		</tr>
		<tr height="30">
			<td align="center" width="125" bgcolor="${value_c }">작성자</td>
			<td align="center" width="125">${article.writer }</td>
			<td align="center" width="125" bgcolor="${value_c }">작성일</td>
			<fmt:formatDate var="formattedDate" value="${article.reg_date}" pattern="yyyy-MM-dd HH:mm"/>
			<td align="center" width="125">${formattedDate }</td>
		</tr>
		<tr height="30">
			<td align="center" width="125" bgcolor="${value_c }">글제목</td>
			<td colspan="3" align="center" width="375">${article.subject }</td>
		</tr>
		<tr height="30">
			<td align="center" width="125" bgcolor="${value_c }">글내용</td>
			<td colspan="3" align="left" width="375"><pre>${article.content }</pre></td>
		</tr>
		<tr height="30">
			<td colspan="4" bgcolor="${value_c }" align="right">
				<input type="button" value="글수정" onclick="document.location.href='./updateForm.go?num=${article.num }&pageNum=${pageNum }'">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="글삭제" onclick="document.location.href='./deleteForm.go?num=${article.num }&pageNum=${pageNum }'">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="답글쓰기" onclick="document.location.href='./writeForm.go?num=${article.num }&ref=${article.ref }&re_step=${article.re_step }&re_level=${article.re_level }'">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="글목록" onclick="document.location.href='./list.go?pageNum=${pageNum }'">
		</tr>
<!-- 댓글달기 인터페이스  -->		
		<tr bgcolor="${value_c }" align="center">
			<td>코멘트 작성</td>
			<td colspan="2">
				<textarea name = commentt rows="6" cols="40"></textarea>
				<input type="hidden" name="content_num" value="${article.num }">
				<input type="hidden" name="p_num" value="${pageNum }">
				<input type="hidden" name="comment_num" value="${commentCount }">
			</td>
			<td align="center">
				작성자<br>
				<input type="text" name="commenter" size="10"><br>
				비밀번호<br>
				<input type="password" name="passwd" size="10"><p>
				<input type="submit" value="코멘트달기">
			</td>
		</tr>
	</table>
</form>


<!-- 댓글보기 인터페이스  -->
<c:if test="${commentCount > 0 }">
	<table width="500" border="1" cellspacing="0" cellpadding="0" bgcolor="${bodyback_c }" align="center">
		<tr>
			<td colspan="2">코멘트 수: ${commentCount }</td>
		</tr>
		<c:forEach var="dbc" items="${commentList }">
			<tr>
				<td align="left" size="250" bgcolor="${value_c }">
					<fmt:formatDate var="formattedCommentDate" value="${dbc.reg_date}" pattern="yyyy-MM-dd HH:mm"/>
					&nbsp;<b>${dbc.commenter }&nbsp;님</b>(${formattedCommentDate })				
				</td>
				<td align="right" size="250" bgcolor="${value_c }">
					접속IP: ${dbc.ip }
					&nbsp;
					<a href="./delCommForm.go?ctn=${dbc.content_num }&cmn=${dbc.comment_num }&p_num=${pageNum }">[삭제]</a>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="left">${dbc.commentt }</td>
			</tr>
		</c:forEach>
	</table>
</c:if>

<!-- 댓글페이징 인터페이스  -->
<table width="500" border="1" cellspacing="0" cellpadding="0" bgcolor="${bodyback_c }" align="center">
	<tr>
		<center>
<%		if(count>0){
			// 전체 페이지 수를 연산
			int pageCount = (count/pageSize) + (count % pageSize== 0 ? 0 : 1);
			
			int startPage = (int)(cCurrentPage/5)*5+1;
			int pageBlock=5;
			int endPage = startPage + pageBlock-1;
			if (endPage > pageCount) endPage = pageCount;
			
			if(startPage > 5) {	%>
				<a href="./content.jsp?num=<%=num %>&pageNum=<%=pageNum %>&cPageNum=<%= startPage-5 %>">[이전]</a>			
<%			}
			for(int i=startPage; i<= endPage; i++){	%>
				<a href="./content.jsp?num=<%=num %>&pageNum=<%=pageNum %>&cPageNum=<%= i %>">[<%= i %>]</a>
<%			}	
			if(endPage < pageCount){	%>				
				<a href="./content.jsp?num=<%=num %>&pageNum=<%=pageNum %>&cPageNum=<%= startPage+5 %>">[다음]</a>
<%			}
		}	%>
		
		
		<c:if test="${commentCount > 0 }">
			<c:set var="cPageCount" value="${commentCount }"
		</c:if>
		
	</tr>
</table>


</body>
</html>