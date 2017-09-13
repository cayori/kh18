<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<html>
<head><title>회원목록</title></head>
<body>

MEMBERJP 테이블의 내용
<table width="100%" border="1">
	<tr>
		<td>이름</td>
		<td>아이디</td>
		<td>이메일</td>
	</tr>
<%
//JDBC 드라이버 로드
	Class.forName("oracle.jdbc.driver.OracleDriver");

	Connection	conn = null;	
	Statement	stmt = null;
	ResultSet	rs = null;
	
try{
	String jdbcDriver = "jdbc:oracle:thin:@istudy.iptime.org:7000:ORCL";
	String dbUser = "KH18";
	String dbPass = "oracle";
	
	String query = "select * from MEMBERJP order by MEMBERID";
	
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass); // connection 생성
	stmt = conn.createStatement();									// statement 생성
	rs = stmt.executeQuery(query);									// query 실행
	
	while (rs.next()){
%>	
	<tr>
		<td><%= rs.getString("NAME") %></td>
		<td><%= rs.getString("MEMBERID") %></td>
		<td><%= rs.getString("EMAIL") %></td>
	</tr>
<%
	}
		
} catch (SQLException sqle){
	out.println(sqle.getMessage());
	sqle.printStackTrace();
} finally {
	// 사용한 statement 종료
	if(rs != null) try{ rs.close(); } catch(SQLException e) {}
	if(stmt != null) try{ stmt.close(); } catch(SQLException e) {}
	// connection 종료
	if(conn != null) try{ conn.close(); } catch(SQLException e) {}
}
%>	

</table>
</body>
</html>