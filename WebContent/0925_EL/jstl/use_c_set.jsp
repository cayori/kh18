<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "kh.jstl.Member" %>
<%@ page import = "java.util.HashMap" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%	Member member = new Member();
	HashMap<String, String> pref = new HashMap<String, String>();
%>
	

<html>
<head></head>
<body>

<%--
set태그는 변수를 설정할때 사용한다. 그리고 기본객체의 영역에 속성설정까지한다.
<c:set var="member" value="<%= member %>" scope="request"/>
<c:set target="${member}" property="name" value="최범균" />

Member member = new Member();
member.setName("최범균");
pageContext.setAttribute("member", member);

${member.name}
Member member=(Member)pageContext.getAttribute("member");
member.getName();
 --%>
 
<c:set var="member" value="<%=member %>" scope="page" />
<c:set target="${member }" property="name" value="최범균" />

<c:set var="pref" value="<%=pref %>"  />
<c:set var="favoriteColor" value="#{pref.color }" />

회원이름: ${member.name }<br>
좋아하는색: ${favoriteColor }<br>
<br>
<c:set target="${pref }" property="color" value="red" />
설정이후 좋아하는색: ${favoriteColor }<br>

</body>
</html>