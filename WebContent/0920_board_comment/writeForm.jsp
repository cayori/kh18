<%@ page contentType = "text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ include file ="./color.jsp" %>

<html>
<head>
<link href="./style.css" type="text/css" rel="stylesheet">
<script language = "Javascript" src="./script.js" ></script>
<title>게시판</title>
</head>

<%
	int num=0, ref=1, re_step=0, re_level=0;
	try{
		if(request.getParameter("num") != null){
			num = Integer.parseInt(request.getParameter("num"));
			ref = Integer.parseInt(request.getParameter("ref"));
			re_step = Integer.parseInt(request.getParameter("re_step"));
			re_level = Integer.parseInt(request.getParameter("re_level"));
		}
		%>

<body bgcolor="<%= bodyback_c %>">
	<center><b>글쓰기</b>
	<br>
	<form method="post" name="writeform" action="writePro.jsp" onsubmit="return writeSave()">
	<input type="hidden" name="num" 		value="<%= num %>">
	<input type="hidden" name="ref" 		value="<%= ref %>">
	<input type="hidden" name="re_step" 	value="<%= re_step %>">
	<input type="hidden" name="re_level" 	value="<%= re_level %>">
	
		<table width="400" border="1" cellspacing="0" cellpadding="0" bgcolor="<%= bodyback_c %>" align="center">
			<tr>
				<td align="right" colspan="2" bgcolor="<%= value_c %>">
					<a href="./list.jsp">글목록</a>
				</td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c %>" align="center">이  름</td>
				<td width="330">
					<input type="text" size="10" maxlength="10" name="writer">
				</td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c %>" align="center">제  목</td>
				<td width="330">
				<% if(request.getParameter("num")==null){ %>
					<input type="text" size="40" maxlength="50" name="subject">
				<% } else { %>
					<input type="text" size="40" maxlength="50" name="subject" value="[답변]">
				<% }  %>
				</td>
			</tr>
				<td width="70" bgcolor="<%=value_c %>" align="center">Email</td>
				<td width="330">
					<input type="text" size="40" maxlength="30" name="email">
				</td>
			<tr>
				<td width="70" bgcolor="<%=value_c %>" align="center">내  용</td>
				<td width="330">
					<textarea name="content" rows="13" cols="40"></textarea>
				</td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c %>" align="center">비밀번호</td>
				<td width="330">
					<input type="password" size="8" maxlength="12" name="passwd">
				</td>
			</tr>
			<tr>
				<td colspan="2" bgcolor="<%=value_c %>" align="center">
					<input type="submit" value="글쓰기">
					<input type="reset" value="다시작성">
					<input type="button" value="목록보기" onclick="window.location='list.jsp'">
				</td>
			</tr>
			
		</table>
	</form>
</body>


<%	}catch(Exception e){} %>

</html>