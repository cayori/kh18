<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>

<%
	String IdInCookie = "";

	Cookie[] cookies = request.getCookies();
	if(cookies != null && cookies.length>0){
		for(int i=0; i<cookies.length; i++){
			if(cookies[i].getName().equals("ID"))
				IdInCookie = cookies[i].getValue();
		}
	}
%>

<html>
<head><title>로그인 폼</title></head>
<body>

<form action="<%= request.getContextPath() %>/0911/member/sessionLogin.jsp">
<table border="">
	<tr>
		<td>아이디<input type="text" name="ID" size="10" value="<%= IdInCookie %>">	</td>
		<td>암호<input type="password" name="PW" size="10" value="">	</td>
		<td>아이디저장<input type="checkbox" name="CK" value="on">	</td>
		<td><input type="submit" value="login">	</td>
	</tr>
</table>
</form>

</body>
</html>