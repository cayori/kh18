<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>

<jsp:useBean id="member" class="kh.member.MemberInfo" scope="request" />

<html>
<head><title>인사말</title></head>
<body>
<%= member.getName() %> (<%=member.getId() %>) 회원님 안녕하세요
</body>
</html>