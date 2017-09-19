<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ include file = "../view/color.jsp" %>

<html>
<head>
<title>로그인</title>
<link href="../style.css" type="text/css" rel="stylesheet" >
<script language="Javascript">
	function begin(){
		document.myform.id.focus();
	}
	function checkIt(){
		if(!document.myform.id.value){
			alert("이름을 입력하지 않으셨습니다.");
			document.myform.id.focus();
			return false;
		}
		if(!document.myform.passwd.value){
			alert("비밀번호를 입력하지 않으셨습니다.");
			document.myform.passwd.focus();
			return false;
		}
	}
</script>
</head>
<body onload="begin()" bgcolor="<%= bodyback_c %>">

<form name="myform" action="./loginPro.jsp" method="post" onsubmit="return checkIt()">
	<table width="260" border="1" align="center">
		<tr height="30">
			<td colspan="2" align="middle" bgcolor="<%= title_c %>"><strong>회원로그인</strong></td>
		</tr>
		<tr height="30">
			<td bgcolor="<%= title_c %>" width="110" align="center">아이디</td>
			<td bgcolor="<%= value_c %>" width="150" align="center">
				<input type="text" name="id" size="15" maxlength="12">
			</td>
		</tr>
		<tr height="30">
			<td bgcolor="<%= title_c %>" width="110" align="center">비밀번호</td>
			<td bgcolor="<%= value_c %>" width="150" align="center">
				<input type="password" name="passwd" size="15" maxlength="12">
			</td>
		</tr>
		<tr height="30">
			<td bgcolor="<%= title_c %>" colspan="2" align="middle">
				<input type="submit" value="로그인">
				<input type="reset" value="다시입력">
				<input type="button" value="회원가입" onclick="javascript:window.location='../register/inputForm.jsp'">
			</td>
		</tr>
	</table>
</form>

</body>
</html>