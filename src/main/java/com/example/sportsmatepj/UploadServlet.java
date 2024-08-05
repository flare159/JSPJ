package com.example.sportsmatepj;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet("/UploadServlet")
@MultipartConfig
public class UploadServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if the request is a multipart request
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);

        if (isMultipart) {
            try {
                // Create a factory for disk-based file items
                DiskFileItemFactory factory = new DiskFileItemFactory();
                // Configure a repository (to ensure that files are written to disk)
                File repository = new File("/tmp");
                factory.setRepository(repository);

                // Create a new file upload handler
                ServletFileUpload upload = new ServletFileUpload(factory);
                // Parse the request
                java.util.List<FileItem> items = upload.parseRequest(request);

                // Process the uploaded items
                for (FileItem item : items) {
                    if (!item.isFormField()) {
                        // Process the uploaded file
                        String fileName = item.getName();
                        String filePath = getServletContext().getRealPath("/") + "uploads/" + fileName;
                        File uploadedFile = new File(filePath);
                        item.write(uploadedFile);
                        // Do something with the uploaded file
                    }
                }
                // Redirect or send a success response
                response.sendRedirect("success.jsp");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}
