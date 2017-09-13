<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>

<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.SQLException" %>

<%
	String idValue = request.getParameter("id");

//	Class.forName("oracle.jdbc.driver.OracleDriver");

	Connection conn = null;
	PreparedStatement pstmtItem = null;
	PreparedStatement pstmtDetail = null;
	
//	String jdbcDriver = "jdbc:oracle:thin:@istudy.iptime.org:7000:ORCL";
//	String dbUser = "KH18";
//	String dbPass = "oracle";
	
	Throwable occurredException = null;
	
	try{
		int id = Integer.parseInt(idValue);
		
		conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:/pool");
//		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		conn.setAutoCommit(false);
		
		pstmtItem = conn.prepareStatement("INSERT INTO itemjp VALUES(?,?)");
		pstmtDetail = conn.prepareStatement("INSERT INTO itemjp_detail VALUES(?,?)");
		
		pstmtItem.setInt(1, id);
		pstmtItem.setString(2,"name : "+id);
		pstmtItem.executeUpdate();
		
		if(request.getParameter("error") != null){
			throw new Exception("의도적 예외 발생");
		}
		
		pstmtDetail.setInt(1,id);
		pstmtDetail.setString(2,"상세설명 : "+id);
		pstmtDetail.executeUpdate();
		
		conn.commit();
		
	}catch(Throwable e){
		e.printStackTrace();
		if( conn != null ){
			try{
				conn.rollback();
			}catch(SQLException ex){}
		}
		occurredException = e;
	}finally{
		if( pstmtItem != null )		{try{ pstmtItem.close(); }		catch(SQLException ex){}	}
		if( pstmtDetail != null )	{try{ pstmtDetail.close(); }	catch(SQLException ex){}	}
		if( conn != null )			{try{ conn.close(); } 			catch(SQLException ex){}	}
	}

%>



<html>
<head><title>ITEM 값 입력</title></head>
<body>

<%	if(occurredException != null) { %>
에러가 발생했습니다: <%= occurredException.getMessage() %>	
<%	} else { %>
데이터가 성공적으로 들어감
<%  } %>
</body>
</html>