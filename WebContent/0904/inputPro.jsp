<%@ page contentType="text/html; charset=utf-8" pageEncoding="euc-kr" trimDirectiveWhitespaces="true"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html>
<html>
<head>
<link href="style.css" rel="stylesheet" type="text/css" />
<title>�Է¹��� �� ���</title>
</head>
<body>
<div id = "wrap">
		<div id = "body">
			<table width="500px;">
			<h1>�ڰ� ��¡�</h1>
				<colgroup>
					<col width="20%" />
					<col width="*" />
				</colgroup>
				<tr>
					<th colspan="2" class="subTitle">*���̵� ����</th>
				</tr>
				<tr>
					<th>����� ID</th>
					<td>
						<%= request.getParameter("id") %></td>
				</tr>
				<tr>
					<th>��й�ȣ</th>
					<td><%= request.getParameter("passwd") %></td>
				</tr>
				<tr>
					<th colspan="2" class="subTitle">*�������� </th>
				</tr>
				<tr>
					<th>����� �̸�</th>
					<td><%= request.getParameter("name") %></td>
				</tr>
				<tr>
					<th>�ֹι�ȣ ���</th>
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
						<th>�ּ�</th>
						<td><%= request.getParameter("address") %>
						</td>
					</tr>
			</table>
		</div>
</div>
</body>
</html>