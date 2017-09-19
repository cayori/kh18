<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import = "kh.LogonDBBean" %>
<%@ include file = "../view/color.jsp" %>

<html>
<head>
<%	request.setCharacterEncoding("utf-8"); 
	String id = request.getParameter("id");
	LogonDBBean manager = LogonDBBean.getInstance();
	boolean unique = manager.confirmId(id);
%>
<link href="../style.css" rel="stylesheet" type="text/css" />
<script language="Javascript">
	funtion setId(){
		opener.document.userinput.id.value="<%= id %>";
		self.close();
	}
</script>
<title>중복확인</title>
</head>
<body bgcolor = "<%= bodyback_c %>">
<%	if(unique){	%>
<table width="270" border="0">
	<tr bgcolor="<%= title_c %>">
		<td height="39"><%= id %> 이미 사용중인 아이디입니다</td>
	</tr>
</table>
<form name="checkForm" method="post" action="confirmId.jsp">
	<table width="270" border="0">
		<tr>
			<td bgcolor="<%= value_c %>" align="center">
				다른 아이디를 선택하세요<p>
				<input type="text" size="10" maxlength="12" name="id">
				<input type="submit" value="ID중복확인">
			</td>
		</tr>
	</table>
</form>
<%	}else{ %>
<table width="270" border="0">
	<tr bgcolor="<%= title_c %>">
		<td align="center">
			<p>입력하신 <%= id %> 는 사용하실 수 있는 ID 입니다</p>
			<input type="button" value="닫기" onclick="setId()">
		</td>
	</tr>
</table>
<%	} %>
</body>
</html>




