<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>

<html>
<head><title>답변쓰기</title></head>
<body>

<form action="./reply.jsp" method="post" >
<input type="hidden" name="parentArticleId" value="${param.parentId }" />
<input type="hidden" name="p" value="${param.p }" />
<table border="">
	<tr>
		<td align="right" width="80">
			제목:
		</td>
		<td>
			<input type="text" size="20" name="title"/>
		</td>
	</tr>
	<tr>
		<td align="right" width="80">
			작성자:
		</td>
		<td>
			<input type="text" name="writerName"/>
		</td>
	</tr>
	<tr>
		<td align="right" width="80">
			글암호:
		</td>
		<td>
			<input type="password" name="password"/>
		</td>
	</tr>
	<tr>
		<td align="right" width="80">
			글내용:
		</td>
		<td>
			<textarea name="content" cols="40" rows="5"></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="전송"/>
		</td>		
	</tr>
</table>

</form>

</body>
</html>
