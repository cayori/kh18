<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ include file="./color.jsp" %>

<html>


<head>
<title>회원가입</title>
<link href="./style.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="./script.js"></script>
</head>


<body>
	<form action="./registerPro.jsp" name="regForm" method="post" onsubmit="return inputCheck()">
		<table border="1" cellpadding="5" cellspacing="0" width="800" >
			<colgroup>
				<col width="20%" />
				<col width="*" />
				<col width="30%" /> 
			</colgroup>
			<tr>
				<td colspan="3"><strong>회원가입</strong></td>
			</tr>
			<tr>
				<th id="title">아이디</th>
				<td id="value"><input type="text" name="id" size="20" /></td>
				<td id="value">아이디를 입력하세요</td>
			</tr>
			<tr>
				<th id="title">비밀번호</th>
				<td id="value"><input type="password" name="passwd" size="20" /></td>
				<td id="value">비밀번호를 입력하세요</td>
			</tr>
			<tr>
				<th id="title">비밀번호</th>
				<td id="value"><input type="password" name="repasswd" size="20" /></td>
				<td id="value">비밀번호를 재입력하세요</td>
			</tr>
			<tr>
				<th id="title">이름</th>
				<td id="value"><input type="text" name="name" size="20" /></td>
				<td id="value">이름을 입력하세요</td>
			</tr>
			<tr>
				<th id="title">이메일</th>
				<td id="value"><input type="text" name="email" size="30" /></td>
				<td id="value">이메일을 입력하세요</td>
			</tr>
			<tr>
				<th id="title">전화번호</th>
				<td id="value"><input type="text" name="tel" size="20" /></td>
				<td id="value">전화번호를 입력하세요</td>
			</tr>
			<tr>
				<td colspan="3" height="50" align="center">
				<input type="submit" value="회원가입" />
				<input type="reset" value="다시작성" />
				</td>
			</tr>
		</table>
	</form>

</body>


</html>