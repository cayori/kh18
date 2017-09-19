<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>

<!DOCTYPE html>
<html>
<head>
<link href="./style.css" type="text/css" rel="stylesheet">
<script src="./script.js" type="text/javascript"></script>
<title>메인페이지</title>
</head>
<%	try {
		if(session.getAttribute("memId") == null){	%>
<body onLoad="focusIt();">
	<form name="inform" method="post" action="./login/loginPro.jsp" onsubmit="return checkIt();">
	<table id="mainTable" border="1">
		<tr>
			<td width="300" height="20">&nbsp;</td>
			<td id="title">아이디</td>
			<td id="value"><input type="text" name="id" size="15" maxlength="10" /></td>
		</tr>
		<tr>
			<td rowspan="2">메인입니다</td>
			<td id="title">비밀번호</td>
			<td id="value"><input type="password" name="passwd" size="15" maxlength="10" /></td>
		</tr>
		<tr>
			<td id="btns" colspan="2" align="center">
				<input type="submit" name="loginBtn" value="로그인" />
				<input type="button" name="regBtn" value="회원가입" onclick="javascript:window.location='./register/inputForm.jsp'"/>
			</td>
		</tr>
	</table>
	</form>
</body>
<%		}else{ %>
<body>
	<table border="1">
		<tr>
			<td width="300" height="20">하하하</td>
			<td rowspan="3" align="center">
				<%= session.getAttribute("memId") %> 님이 <br>방문하셨습니다
				<form method="post" action="logout.jsp">
				<input type="submit" value="로그아웃" />
				<input type="button" value="회원정보변경" onclick="javascript:window.location='./modify/modify.jsp'"/>
				</form>
			</td>
		</tr>
		<tr>
			<td rowspan="2" width="300">메인입니다</td>
		</tr>
	</table>
</body>
<%		}
	}catch(NullPointerException npe){}	%>
</html>
	