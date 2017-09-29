<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>

<html>
<head><title>수정하기</title></head>
<body>

게시물을 수정했습니다<br>
<a href="./list.jsp?p=${param.p }">목록보기</a>
<a href="./read.jsp?articleId=${updatedArticle.id }&p=${param.p }">게시글 읽기</a>

</body>
</html>