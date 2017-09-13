<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<%@ page import = "java.io.Reader" %>
<%@ page import = "java.io.IOException" %>

<html>
<head><title>LONG VARCHAR 스트림으로 읽어오기</title></head>
<body>

<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");

	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	String jdbcDriver = "jdbc:oracle:thin:@istudy.iptime.org:7000:ORCL";
	String dbUser = "KH18";
	String dbPass = "oracle";
	String sql = "SELECT history FROM memberjp_history WHERE memberID = '"+id+"'";
	
	Connection	conn = null;
	Statement	stmt = null;
	ResultSet	rs = null;
	
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	
	if(rs.next()){
%>

<table border="1">
	<tr>
		<td>아이디</td><td><%= id %></td>
	</tr>
	<tr>
		<td>히스토리</td>
		<td>
<%
		Reader reader = null;		
		try{
			reader = rs.getCharacterStream("history");
			
			if(reader != null){
				StringBuffer sb = new StringBuffer();
				char[] ch = new char[512];
							int len = -1;
				
				while( (len=reader.read(ch)) != -1 ){
					sb.append(ch,0,len);
				}
				out.println(sb.toString());
			}
		} catch (IOException e) {
			out.println("예외발생 : "+e.getMessage());
		} finally {
			if(reader != null){
				try{reader.close();} catch(IOException e){}	
			}
		}
%>			
		</td>
	</tr>

</table>

<%
	}else{
%>
<%= id %> 회원의 history가 없습니다
<%
	}
%>
</body>
</html>