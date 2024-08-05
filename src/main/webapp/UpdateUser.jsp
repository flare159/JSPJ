<%@ page import="com.example.sportsmatepj.JDBCConnect" %>
<%@ page import="com.example.sportsmatepj.UserDTO" %>
<%@ page import="com.example.sportsmatepj.UserDAO" %>
<%@ page import="java.sql.Connection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<%
  // 데이터베이스 연결 정보를 가져옵니다.
  String driver = application.getInitParameter("OracleDriver");
  String url = application.getInitParameter("OracleURL");
  String dbId = application.getInitParameter("OracleId");
  String dbPwd = application.getInitParameter("OraclePwd");

  // 데이터베이스 연결을 설정합니다.
  JDBCConnect jdbc = new JDBCConnect(driver, url, dbId, dbPwd);
  Connection conn = jdbc.conn;

  if (conn == null) {
    out.println("Database connection failed.");
  } else {
    // 사용자 입력 값 가져오기
    String userId = request.getParameter("USERID");
    String userPwd = request.getParameter("USERPWD");
    String userName = request.getParameter("USERNAME");
    Double userPt = null;

    // USERPT 값이 null이 아닐 경우에만 변환
    if (request.getParameter("USERPT") != null && !request.getParameter("USERPT").isEmpty()) {
      userPt = Double.valueOf(request.getParameter("USERPT"));
    }

    UserDAO userDAO = new UserDAO(conn);

    // 중복된 사용자 이름 확인
    if (userDAO.isUsernameUN(userName)) {
      out.println("<script>alert('중복된 이름입니다. 다른 이름을 사용해주세요.'); location.href='MyPage.jsp';</script>");
    } else {
      // UserDTO 객체를 생성하여 사용자 정보를 설정합니다.
      UserDTO user = new UserDTO(userId, userPwd, userName, userPt);

      // 사용자 정보 업데이트
      if (userDAO.updateUser(user)) {
        out.println("<script>alert('정보 수정 성공'); location.href='SportsMate3.jsp';</script>");
      } else {
        out.println("<script>alert('정보 수정 실패'); location.href='MyPage.jsp';</script>");
      }

      jdbc.close();
    }
  }
%>