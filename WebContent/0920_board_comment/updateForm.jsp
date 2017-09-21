<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import = "kh.board.BoardDBBean" %>
<%@ page import = "kh.board.BoardDataBean" %>
<%@ include file = "./color.jsp" %>

<html>
<head>
<link href="./style.css" rel="stylesheet" type="text/css">
<script language="Javascript" src="./script.js"></script>
<title>게시판</title>
</head>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	try{
		BoardDBBean dbPro = BoardDBBean.getInstance();
		BoardDataBean article = dbPro.updateGetArticle(num);	%>
<body bgcolor="<%=bodyback_c%>">
	<center><b>글수정</b></center>
	<br>
		<form method="post" name="writeform" action="./updatePro.jsp?pageNum=<%=pageNum%>" onsubmit="return writeSave()">
		<input type="hidden" name="num" value="<%=article.getNum()%>">
			<table width="400" border="1" cellspacing="0" cellpadding="0" bgcolor="<%= bodyback_c %>" align="center">
				<tr>
					<td width="70" bgcolor="<%=value_c %>" align="center">이  름</td>
					<td width="330">
						<input type="text" size="10" maxlength="10" name="writer" value="<%=article.getWriter()%>">
					</td>
				</tr>
				<tr>
					<td width="70" bgcolor="<%=value_c %>" align="center">제  목</td>
					<td width="330">
						<input type="text" size="40" maxlength="50" name="subject" value="<%=article.getSubject()%>">

					</td>
				</tr>
					<td width="70" bgcolor="<%=value_c %>" align="center">Email</td>
					<td width="330">
						<input type="text" size="40" maxlength="30" name="email" value="<%=article.getEmail()%>">
					</td>
				<tr>
					<td width="70" bgcolor="<%=value_c %>" align="center">내  용</td>
					<td width="330">
						<textarea name="content" rows="13" cols="40"><%=article.getContent()%></textarea>
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
						<input type="submit" value="수정하기">
						<input type="reset" value="다시작성">
						<input type="button" value="목록보기" onclick="window.location.href='list.jsp?pageNum=<%=pageNum%>'">
					</td>
				</tr>
				
			</table>
		</form>
<%		} catch(Exception e){}	%>
</body>

</html>