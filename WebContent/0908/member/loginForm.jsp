<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import = "util.CookieBox" %>

<% 
	CookieBox cookiebox = new CookieBox(request);
	String id;
	if((id=cookiebox.getValue("ID"))==null)	id = "";

	
%>

<html>
<head><title>로그인 폼</title></head>
<body>

<form action="<%= request.getContextPath() %>/0908/member/login.jsp" method="post">
<table>
	<tr>
		<td>
			아이디<input type="text" name="id" size="10" value="<%= id %>">
		</td>
		<td>
			비밀번호<input type="password" name="password" size="10">
		</td>
		<td>
			아이디저장<input type="checkbox" name="checked" value="on">
		</td>
		<td>
			<input type="submit" value="login">
		</td>
	</tr>
</table>
</form>

</body>
</html>