<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import = "kh.guest.Message" %>
<%@ page import = "kh.guest.MessageListView" %>
<%@ page import = "kh.guest.GetMessageListService" %>
<%@ page import = "java.util.List" %>

<%
	String pageNumberStr = request.getParameter("page");
	int pageNumber = 1;
	if(pageNumberStr != null){
		pageNumber = Integer.parseInt(pageNumberStr);
	}
	
	GetMessageListService messageListService = GetMessageListService.getInstance();
	MessageListView viewData = messageListService.getMessageList(pageNumber);
%>

<html>
<head>
<title>방명록 메세지 목록</title>
</head>
<body>

<form action="writeMessage.jsp" method="post">
	<table width="400" border="0" align="center">
		<tr> 
			<td width="100">
				이름:
			</td>
			<td>
				<input type="text" name="guestName">
			</td>
		</tr>
		<tr>
			<td width="100">
				암호:
			</td>
			<td>
				<input type="password" name="passwd">
			</td>
		</tr>
		<tr>
			<td width="100">
				메세지:
			</td>
			<td>
				<textarea name="message" cols="30" row="3"></textarea>
			</td>
		</tr>
		<tr align="center">
			<td colspan="2">
				<input type="submit" value="메세지 남기기">
			</td>
		</tr>
	</table>
</form>
<hr>

<%	if(viewData.isEmpty()){	%>
	<center>등록된 메세지가 없습니다.
<%	}else{	%>
	<table width="400" border="1" align="center">
<%		for(Message message : viewData.getMessageList()){	
				
%>
		<tr>
			<td width="160" colspan="2">메세지번호: <%=message.getId() %></td>
			<td width="160">손님이름: <%=message.getGuestName() %></td>
			<td width="80">
				<a href="./confirmDeletion.jsp?messageId=<%=message.getId()%>">[삭제]</a>
			</td>
		</tr>
		<tr>
			<td width="100">메세지</td>
			<td colspan="3">
				<%=message.getMessage() %>
			</td>
		</tr>
<%		}	%>
	</table>
<center>
<%		for(int i=1; i<= viewData.getPageTotalCount(); i++){	%>
			<a href="list.jsp?page=<%=i%>">[<%=i%>]</a>
<%		}	%>
<%	}	%>


</body>
</html>