<%@ page contentType="text/html; charset=utf-8" pageEncoding="EUC-KR" trimDirectiveWhitespaces="true" %>
<%@ page buffer="8kb" autoFlush="false" %>

<html>
<head><title>buffer information</title></head>
<body>

���� ũ��: <%= out.getBufferSize() %> <br>
���� ũ��: <%= out.getRemaining() %> <br>
autoflush: <%= out.isAutoFlush() %>

</body>
</html>
