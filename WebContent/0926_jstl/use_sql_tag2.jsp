<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<html>
<head><title>JSTL SQL 예제 - update, param</title></head>
<body>

<sql:update var="rs" dataSource="jdbc:apache:commons:dbcp:/pool" >
	UPDATE membersjpjp SET passwd=? WHERE memberid=?
	<sql:param value="${'kkk' }"/>
	<sql:param value="${'zzz' }"/>
</sql:update>

</body>
</html>