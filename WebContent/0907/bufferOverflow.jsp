<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page buffer="1kb" %>
<%@ page errorPage = "./error/15viewErrorMessage.jsp" %>
<html>
<head><title>���� �÷��� ���� ���� �߻� ���</title></head>
<body>

<%  for (int i = 0 ; i < 256 ; i++) { out.print(i); }  %>

<%-- <%= 1 / 0 %> --%>

</body>
</html>