<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import = "kh.logon.*" %>
<%@ include file = "../view/color.jsp" %>

<html>
<head>
<title>회원정보수정</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<script language="Javascript">
<!--	
	function checkIt(){
		var userinput = eval("document.userinput");
		
		if(!userinput.passwd.value){
			alert("비밀번호를 입력하세요");
			return false;
		}
		if(userinput.passwd.value != userinput.passwd2.value){
			alert("비밀번호를 동일하게 입력하세요");
			return false;
		}
		if(!userinput.name.value){
			alert("사용자 이름을 입력하세요");
			return false;
		}
		if(!userinput.jumin1.value || !userinput.jumin2.value){
			alert("주민등록번호를 입력하세요");
			return false;
		}
	}
-->
</script>

<%
	String id = (String)session.getAttribute("memId");

	LogonDBBean manager = LogonDBBean.getInstance();
	LogonDataBean c = manager.getMember(id);
	
	try{	%>
		<body></body>

<%	} catch (Exception e) {} %>
</head>
<body>


</body>
</html>