<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.SQLException" %>


<%
	request.setCharacterEncoding("utf-8");


	String id = request.getParameter("id");
	String name = request.getParameter("name");

	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	Connection	conn = null;
	Statement	stmt = null;
	
	String jdbcDriver = "jdbc:oracle:thin:@istudy.iptime.org:7000:ORCL";
	String dbUser = "KH18";
	String dbPass = "oracle";
	String query = "UPDATE memberjp SET name='"+name+"' where memberid='"+id+"'"; 
	
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	stmt = conn.createStatement();
	int counter = stmt.executeUpdate(query);
%>

<html>
<head><title></title></head>
<body>
<%
	if(counter>0){
		%>
		<%= id %> 의 이름이  <%= name %> 으로 변경되었습니다.
		<%
	} else {
		%>
		변경사항이 없습니다.
		<%
	}

%>


</body>
</html>