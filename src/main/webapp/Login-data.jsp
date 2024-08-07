<%@ page import="com.example.sportsmatepj.JDBCConnect" %>
<%@ page import="com.example.sportsmatepj.UserDTO" %>
<%@ page import="com.example.sportsmatepj.UserDAO" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<%
    // 데이터베이스 연결 정보 설정
    String driver = application.getInitParameter("OracleDriver");
    String url = application.getInitParameter("OracleURL");
    String dbId = application.getInitParameter("OracleId");
    String dbPwd = application.getInitParameter("OraclePwd");

    JDBCConnect jdbc = new JDBCConnect(driver, url, dbId, dbPwd);
    Connection conn = jdbc.conn;

    if (conn == null) {
        out.println("Database connection failed.");
    } else {
        // 요청 파라미터 가져오기
        String userId = request.getParameter("USERID");
        String userPwd = request.getParameter("USERPWD");
        String userName = request.getParameter("USERNAME");
        String userPtStr = request.getParameter("USERPT");

        // 사용자 포인트를 숫자로 변환
        Number userPt = null;
        try {
            if (userPtStr != null && !userPtStr.isEmpty()) {
                userPt = Integer.parseInt(userPtStr); // Integer로 변환. 필요에 따라 다른 타입으로 변경 가능
            }
        } catch (NumberFormatException e) {
            out.println("<script>alert('포인트 형식이 올바르지 않습니다.'); location.href='SportsMate3.jsp';</script>");
            jdbc.close();
            return;
        }

        // UserDTO 객체 생성
        UserDTO user = new UserDTO(userId, userPwd, userName, userPt);
        UserDAO userDAO = new UserDAO(conn);

        // 사용자 검증 및 리다이렉트
        if (userDAO.validateUser(user)) {

             userName = userDAO.getUserName(userId); // 사용자 이름을 가져오는 메소드
            session.setAttribute("userid", userId);
            session.setAttribute("username",userName);
            response.sendRedirect("SportsMate3.jsp");
        } else {
            out.println("<script>alert('ID 또는 PWD가 맞지 않습니다'); location.href='SportsMate3.jsp';</script>");
        }

        jdbc.close();
    }
%>