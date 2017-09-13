<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>

<html>
<head><title>이름 변경 폼</title></head>
<body>

<form action="./update.jsp" method="post" >
	<table border="1">
		<tr>
			<td>아이디</td>
			<td><input type="text" name="id" size="10" /></td>
			<td>이름</td>
			<td><input type="text" name="name" size="10" /></td>
		</tr>
		<tr>
			<td colspan="4"><input type="submit" value="변경" />
		</tr>
	</table>
</form>

</body>
</html>