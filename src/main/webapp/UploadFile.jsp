<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<%

    boolean isMultipart = ServletFileUpload.isMultipartContent(request);

    if (isMultipart) {
        try {
            // 파일 업로드 처리
            ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());
            List<FileItem> items = upload.parseRequest(request); 

            String uploadPath = application.getRealPath("/") + "uploads/"; // 절대 경로로 지정
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir(); // 디렉토리가 없으면 생성
            }

            for (FileItem item : items) {
                if (!item.isFormField()) {
                    // 파일 업로드 처리
                    String fileName = item.getName();
                    // 파일 이름 중복 처리 (여기서는 간단하게 "upload_" 접두사 추가)
                    String newFileName = "upload_" + System.currentTimeMillis() + "_" + fileName;
                    File uploadedFile = new File(uploadDir, newFileName); // 파일 저장
                    item.write(uploadedFile); // 파일 저장
                    out.println("파일이 성공적으로 업로드되었습니다: " + newFileName);
                }
            }
        } catch (FileUploadException e) {
            e.printStackTrace();
            out.println("파일 업로드 중 오류가 발생했습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("파일 저장 중 오류가 발생했습니다.");
        }
    } else {
        out.println("multipart/form-data가 아닙니다.");
    }
%>
