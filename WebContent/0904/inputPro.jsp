<%@ page contentType="text/html; charset=utf-8" pageEncoding="euc-kr" trimDirectiveWhitespaces="true"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html>
<html>
<head>
<link href="style.css" rel="stylesheet" type="text/css" />
<title>입력받은 값 출력</title>
</head>
<body>
<div id = "wrap">
		<div id = "body">
			<table width="500px;">
			<h1>★값 출력★</h1>
				<colgroup>
					<col width="20%" />
					<col width="*" />
				</colgroup>
				<tr>
					<th colspan="2" class="subTitle">*아이디 정보</th>
				</tr>
				<tr>
					<th>사용자 ID</th>
					<td>
						<%= request.getParameter("id") %></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><%= request.getParameter("passwd") %></td>
				</tr>
				<tr>
					<th colspan="2" class="subTitle">*개인정보 </th>
				</tr>
				<tr>
					<th>사용자 이름</th>
					<td><%= request.getParameter("name") %></td>
				</tr>
				<tr>
					<th>주민번호 등록</th>
					<td><%= request.getParameter("jumin1") %>-<%= request.getParameter("jumin2") %></td>
					<tr>
						<th>E-mail</th>
						<td><%= request.getParameter("email") %></td>
					</tr>
					<tr>
						<th>Blog</th>
						<td><%= request.getParameter("blog") %></td>
					</tr>
					<tr>
						<th>주소</th>
						<td><%= request.getParameter("address") %>
						</td>
					</tr>
			</table>
		</div>
</div>
</body>
</html>