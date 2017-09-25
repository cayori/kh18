<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>

<% request.setAttribute("name", "최범균"); %>

<html>
<head><title>EL Object</title></head>
<body>

요청 URI: <br> 
\${ pageContext.request.requestURI } <br>
${ pageContext.request.requestURI } <br>
request 의 name 속성: <br>
\${ requestScope.name } <br>
${ requestScope.name } <br>
code 파라미터: <br>
\${ param.code } <br>
${ param.code } <br>

</body>
</html>