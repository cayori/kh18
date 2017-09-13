<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<html>
<head><title>include using directive</title></head>
<body>

<% int number = 10; %>

<%@ include file="./10includee.jspf" %>

공통변수 DATAFOLDER = "<%= dataFolder %>"

</body>
</html>