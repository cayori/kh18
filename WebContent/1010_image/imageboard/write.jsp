<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page errorPage = "./error/error_view.jsp" %>

<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.io.File" %>
<%@ page import = "org.apache.commons.fileupload.FileItem" %>

<%@ page import = "imageboard.util.ImageUtil" %>
<%@ page import = "imageboard.fileupload.FileUploadRequestWrapper" %>

<%@ page import = "imageboard.gallery.Theme" %>
<%@ page import = "imageboard.gallery.ThemeManager" %>
<%@ page import = "imageboard.gallery.ThemeManagerException" %>

<%
	//request.setCharacterEncoding("utf-8");
	FileUploadRequestWrapper requestWrap = new FileUploadRequestWrapper(request, -1, -1, "C:\\JAVA\\workspace\\KH18\\WebContent\\1010_image\\temp");
	HttpServletRequest tempRequest = request;
	request = requestWrap;
%>

<jsp:useBean id="theme" class="imageboard.gallery.Theme">
	<jsp:setProperty name="theme" property="*" />
</jsp:useBean>

<%
	FileItem imageFileItem = requestWrap.getFileItem("imageFile");
	String image = "";
	if(imageFileItem.getSize() > 0){
		image = Long.toString(System.currentTimeMillis());
		
		// 이미지를 지정한 경로에 저장
		File imageFile = new File("C:\\JAVA\\workspace\\KH18\\WebContent\\1010_image\\image",image);
		// 같은 이름의 파일이름처리
		if(imageFile.exists()){
			for(int i=0; true; i++){
				imageFile = new File("C:\\JAVA\\workspace\\KH18\\WebContent\\1010_image\\image", image+"_"+i);
				if(!imageFile.exists()){
					image = image + "_" + i;
					break;
				}
			}
		}
		imageFileItem.write(imageFile);
		
		// 썸네일 이미지 생성
		File destFile = new File("C:\\JAVA\\workspace\\KH18\\WebContent\\1010_image\\image", image+"_small.jpg");
		ImageUtil.resize(imageFile, destFile, 50, ImageUtil.RATIO);
	}
	
	theme.setRegister(new Timestamp(System.currentTimeMillis()));
	theme.setImage(image);
	
	ThemeManager manager = ThemeManager.getInstance();
	manager.insert(theme);
%>

<script>
	alert("새로운 이미지를 등록했습니다.");
	location.href="list.jsp";
</script>
















