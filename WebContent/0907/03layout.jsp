<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>

<html>
<head><title>layout1</title></head>
<body>

<table width="1024" border="1" cellpadding="0" cellspacing="0">
<tr height=150>
	<td colspan="2">
		<jsp:include page="./module/top.jsp" flush="false" />
	</td>
</tr>
<tr height=500>
	<td width="124" valign="top">
		<jsp:include page="./module/left.jsp" flush="false" />
	</td>
	<td>
	<!--  내용 부분 : 시작 -->
	레이아웃 1
	<br><br><br>
	<!--  내용 부분 : 시작 -->
	</td>
</tr>
<tr height=150>
	<td colspan="2">
		<jsp:include page="./module/bottom.jsp" flush="false" />
	</td>
</tr>
</table>

</body>
</html>