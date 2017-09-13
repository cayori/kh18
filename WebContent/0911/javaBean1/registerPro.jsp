<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="regBean" class="kh.member.RegisterBean" scope="page"></jsp:useBean>
<jsp:setProperty name="regBean" property="*" />

<html>
<head>

<title>회원가입 확인</title>
<link href="./style.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="./script.js"></script>

</head>
<body>

<table border="1" cellpadding="5" cellspacing="0" width="800">
	<colgroup>
		<col width="20%" />
		<col width="*" />
	</colgroup>
	<tr>
		<th>아이디</th>
		<td><jsp:getProperty name="regBean" property="id" /></td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td><jsp:getProperty name="regBean" property="passwd" /></td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td><jsp:getProperty name="regBean" property="repasswd" /></td>
	</tr>
	<tr>
		<th>이름</th>
		<td><jsp:getProperty name="regBean" property="name" /></td>
	</tr>
	<tr>
		<th>이메일</th>
		<td><jsp:getProperty name="regBean" property="email" /></td>
	</tr>
	<tr>
		<th>전화번호</th>
		<td><jsp:getProperty name="regBean" property="tel" /></td>
	</tr>

</table>

</body>

</html>