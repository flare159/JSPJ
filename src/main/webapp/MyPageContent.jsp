<%@ page import="com.example.sportsmatepj.UserDTO" %>
<%@ page import="com.example.sportsmatepj.UserDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<%
  UserDTO user = (UserDTO) request.getAttribute("user");


%>

<html>
<head>
  <meta charset="UTF-8">
  <title>마이페이지</title>
  <link rel="stylesheet" href="./Newbie/PJCSS.css">
</head>
<body>
<div>
  <h1 style="text-align: center">마이페이지</h1>
</div>

<div class="memberdata" style="text-align: center">
  <form action="UpdateUser.jsp" method="post" >
    회원님의 로그인 ID <input type="text" name="USERID" value="<%= user.getUserid() %>" readonly>
    <br><br>
    변경할 PWD: <input type="password" name="USERPWD" value="<%= user.getUserpwd() %>">
    <br><br>
    변경할 닉네임: <input type="text" name="USERNAME" placeholder="한글8자,영어16자 허용">
    <br><br>

    <!-- 프로필 사진 업로드 -->
    프로필 사진: <input type="file" name="USERPIC">
    <br><br>
    내 글목록
    <br>
    매너점수 : <%=user.getUserpt() %> , <a href="#" > 후기 </a> <br>
    <input type="submit" value="수정완료">
  </form>
</div>
</body>
</html>
