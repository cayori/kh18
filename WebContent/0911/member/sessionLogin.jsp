<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>


<html>
<%
	String ID = request.getParameter("ID");
	String PW = request.getParameter("PW");
	boolean CK = false;
	
	if(request.getParameter("CK") != null){
		CK = true;
	}
	

	if(ID.length() > 0 && PW.length() > 0){
		if(ID.equals(PW)){
			session.setAttribute("ID", ID);
			if(CK)	response.addCookie(new Cookie("ID",ID));
			else	response.addCookie(new Cookie("ID",""));
			%>
			<head><title>로그인 성공</title></head>
			<body>
			로그인에 성공했습니다. <br>
			<form action="./sessionLogout.jsp">
			<input type="submit" value="logout">
			</form>
			</body>
			<%			
		}else{
			%>
			<head><title>로그인 실패</title></head>
			<body>

			<script>
			alert("로그인에 실패했습니다.");
			history.go(-1);
			</script>

			</body>	
			<%
		}
	}
%>
</html>
