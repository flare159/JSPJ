<%@ page import="com.example.sportsmatepj.JDBCConnect" %>
<%@ page import="com.example.sportsmatepj.UserDTO" %>
<%@ page import="com.example.sportsmatepj.UserDAO" %>
<%@ page import="java.sql.Connection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<%
    String driver = application.getInitParameter("OracleDriver");
    String url = application.getInitParameter("OracleURL");
    String dbId = application.getInitParameter("OracleId");
    String dbPwd = application.getInitParameter("OraclePwd");

    JDBCConnect jdbc = new JDBCConnect(driver, url, dbId, dbPwd);
    Connection conn = jdbc.conn;

    if (conn == null) {
        out.println(" DATA연결 실패 에러");
    } else {
        String userId = request.getParameter("USERID");
        String userPwd = request.getParameter("USERPWD");

        UserDTO user = new UserDTO(userId, userPwd);
        UserDAO userDAO = new UserDAO(conn);

        if (userDAO.addUser(user)) { // DAO 파일의 addUser
            out.println("<script>alert('회원가입 성공'); location.href='SportsMate3.jsp';</script>");
        } else {
            out.println("<script>alert('회원가입 실패'); location.href='MemPlus.jsp';</script>");
        }

        jdbc.close();
    }
%>
