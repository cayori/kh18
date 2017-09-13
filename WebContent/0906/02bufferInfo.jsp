<%@ page contentType="text/html; charset=utf-8" pageEncoding="EUC-KR" trimDirectiveWhitespaces="true" %>
<%@ page buffer="8kb" autoFlush="false" %>

<html>
<head><title>buffer information</title></head>
<body>

버퍼 크기: <%= out.getBufferSize() %> <br>
남은 크기: <%= out.getRemaining() %> <br>
autoflush: <%= out.isAutoFlush() %>

</body>
</html>
