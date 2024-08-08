package com.example.sportsmatepj;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.nio.file.Paths;

public class FileUtil {

    /**
     * 파일을 지정된 경로에 업로드하는 메소드
     *
     * @param request     HttpServletRequest 객체
     * @param saveDirectory 파일을 저장할 경로
     * @return 업로드된 파일의 원본 이름
     * @throws IOException
     * @throws ServletException
     */
    public static String uploadFile(HttpServletRequest request, String saveDirectory) throws IOException, ServletException {
        // 파일 파트 가져오기
        Part filePart = request.getPart("USERPIC");

        // 원본 파일 이름 가져오기
        String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // 저장할 파일 경로 설정
        File saveDir = new File(saveDirectory);
        if (!saveDir.exists()) {
            saveDir.mkdirs(); // 디렉토리가 없으면 생성
        }

        // 파일 저장
        File file = new File(saveDir, originalFileName);
        try (InputStream fileContent = filePart.getInputStream()) {
            // 파일을 지정된 경로에 저장
            Files.copy(fileContent, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        return originalFileName; // 원본 파일 이름 반환
    }
}
