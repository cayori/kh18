<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>

<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<html>
<head><title>회원 목록</title></head>
<body>
MEMBER 테이블 내용
<table border="1">
	<tr>
		<td>이름</td><td>아이디</td><td>이메일</td>
	</tr>
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	try{
		String sql = "SELECT * FROM memberjp ORDER BY memberid";
		
		conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:/pool");
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		while(rs.next()){	%>
	<tr>
		<td><%= rs.getString("name") %></td>
		<td><%= rs.getString("memberid") %></td>
		<td><%= rs.getString("email") %></td>
	</tr>
<%		}
	}catch(Exception e){
		
	}finally{
		if(rs != null)		try{rs.close();} 	catch(SQLException ex){}
		if(stmt != null)	try{stmt.close();} 	catch(SQLException ex){}
		if(conn != null)	try{conn.close();} 	catch(SQLException ex){}
	}
	
%>

</table>

</body>
</html>