<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<html>
<head><title>INFO</title></head>
<body>

<table width="100%" border="1" cellpadding="0" cellspacing="0">
<tr>
	<td>제품번호</td>	<td>XXXX</td>
</tr>
<tr>
	<td>가격</td>	<td>10,000원</td>
</tr>
</table>
<%-- 06infoSub.jsp?type=A --%>

<%-- <jsp:include page="./06infoSub.jsp?type=B" flush="false" /> --%>

<jsp:include page="./06infoSub.jsp" flush="false" >
	<jsp:param name="type" value="B"></jsp:param> 
</jsp:include>

</body>
</html>