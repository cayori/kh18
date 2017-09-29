<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import = "java.io.InputStream" %>
<%@ page import = "java.io.IOException" %>

<%
	InputStream inputStream = null;
	
	out.print("[");
	out.print(request.getContentType());
	out.println("]");
	
	try{
		inputStream = request.getInputStream();
		int data = -1;
		
		while( (data=inputStream.read()) != -1 ){
			out.println((char)data);
		}
	}catch(IOException e){
		e.printStackTrace();
	}finally{
		if( inputStream != null ) try{ inputStream.close();	}catch(IOException ex){}
	}

%>