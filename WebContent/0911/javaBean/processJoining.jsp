<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="regInfo" class="kh.member.MemberInfo" scope="page" />
<jsp:setProperty name="regInfo" property="*" />
<jsp:setProperty name="regInfo" property="password" value="<%=regInfo.getId() %>"/>

<html>
<head><title>가입</title></head>
<body>
<table width="400" border="1" cellpadding="0" cellspacing="0">
	<tr>
		<td>아이디</td>
		<td><%= regInfo.getId() %></td>
		<td>암호</td>
		<td><jsp:getProperty name="regInfo" property="password" /></td>
	</tr>
	<tr>
		<td>이름</td>
		<td><jsp:getProperty name="regInfo" property="name" /></td>
		<td>이메일</td>
		<td><jsp:getProperty name="regInfo" property="email" /></td>
	</tr>
	<tr>
		<td>주소</td>
		<td colspan="3"><jsp:getProperty name="regInfo" property="address" /></td>
	</tr>
</table>

</body>
</html>