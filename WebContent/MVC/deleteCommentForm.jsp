<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="./color.jspf" %>

<html>
<head>
<title>게시판</title>
<link href="./style.css" type="text/css" rel="stylesheet" >
<script language="Javascript">
<!--
	function deleteSave(){
		if(document.delForm.passwd.value == ''){
			alert("비밀번호를 입력하십시오.");
			document.delForm.passwd.focus();
			return false;
		}	
}
// -->
</script>
</head>
<body bgcolor="${bodyback_c }">
<center>
	<form method="post" name="delForm" action="./delCommPro.go" onsubmit="return deleteSave()">
		<table border="1" align="center" cellspacing="0" cellpadding="0" width="360">
			<tr height="30">
				<td align="center" bgcolor="${value_c }">
					<b>비밀번호를 입력해 주세요</b>
				</td>
			</tr>
			<tr height="30">
				<td align="center">
					비밀번호:<input type="password" name="passwd" size="8" maxlength="12">
					<input type="hidden" name="content_num" value="${ctn }">
					<input type="hidden" name="comment_num" value="${cmn }">
					<input type="hidden" name="p_num" value="${p_num }">
				</td>
			</tr>
			<tr height="30">
				<td align="center" bgcolor="${value_c }">
					<input type="submit" value="코멘트 삭제">
					<input type="button" value="취소" onclick="javascript:history.go(-1)">
				</td>
			</tr>
		</table>
	</form>

</body>
</html>