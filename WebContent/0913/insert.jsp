<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>

<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.SQLException" %>

<%
	request.setCharacterEncoding("utf-8"); 
	
	String memberID = request.getParameter("memberID");
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String email = request.getParameter("email");

	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try{
		String jdbcDriver = "jdbc:oracle:thin:@istudy.iptime.org:7000:ORCL";
		String dbUser = "KH18";
		String dbPass = "oracle";
		
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		pstmt = conn.prepareStatement("INSERT INTO memberjp (memberID, name, password, email) VALUES(?,?,?,?)");
	
		pstmt.setString(1, memberID);
		pstmt.setString(2, name);
		pstmt.setString(3, password);
		pstmt.setString(4, email);
		
		pstmt.executeUpdate();
	}finally{
		if( pstmt != null) try{ pstmt.close(); } catch(SQLException e){}
		if( conn != null) try{ conn.close(); } catch(SQLException e){}
	}

%>


<html>
<head><title>삽입</title></head>
<body>
MEMBERJP 테이블에 새로운 레코드를 삽입했습니다.
</body>
</html>