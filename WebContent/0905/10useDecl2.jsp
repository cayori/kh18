<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>

<%!
public int add(int a, int b){
	return a+b;
}
public int subtract(int a, int b){
	return a-b;
}
%>

<html>
<head><title>스크립트릿에서 선언부 사용하기</title></head>
<body>
<%
int value1 = 3;
int value2 = 9;

int addResult = add(value1,value2);
int subResult = subtract(value1,value2);
%>

<%= value1 %> + <%= value2 %> = <%= addResult %>
<br>
<%= value1 %> - <%= value2 %> = <%= subResult %>
</body>
</html>