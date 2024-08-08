<%@ page import="com.example.sportsmatepj.UserDTO" %>
<%@ page import="com.example.sportsmatepj.UserDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<%
  UserDTO user = (UserDTO) request.getAttribute("user");
  session.setAttribute("userId", user.getUserid());

%>

<html>
<head>
  <meta charset="UTF-8">
  <title>마이페이지</title>

</head>
<body>
<div>
  <h1 style="text-align: center">마이페이지</h1>
</div>

<div class="memberdata" style="text-align: center">

  <div>
    <!-- 프로필 사진 표시 -->
    <%
      String userPic = user.getUserpic(); // DB에서 가져온 프로필 사진 경로
      if (userPic != null && !userPic.isEmpty()) {
    %>
    <img src="<%= request.getContextPath() + "/uploads/" + userPic %>" alt="프로필 사진" width="150" height="150" />
    <%
    } else {
    %>
    <img src="<%= request.getContextPath() + "/uploads/default.png" %>" alt="기본 프로필 사진" width="150" height="150" />
    <%
      }
    %>
  </div>


  <form action="UpdateUser.jsp" method="post" >
    회원님의 로그인 ID <input type="text" name="USERID" value="<%= user.getUserid() %>" readonly>
    <br><br>
    변경할 PWD: <input type="password" name="USERPWD" value="<%= user.getUserpwd() %>">
    <br><br>
    변경할 닉네임: <input type="text" name="USERNAME" placeholder="한글8자,영어16자 허용">


    <br><br>
    내 글목록
    <br>
    매너점수 : <%=user.getUserpt() %> , <a href="#" > 후기 </a> <br>
    <input type="submit" value="수정완료">
    <br><br>
  </form>
  <h2>프로필 사진 변경 </h2>
  <form action="MyPageContent.do" method="post" enctype="multipart/form-data">
    <input type="file" name="USERPIC" />
    <input type="submit" value="업로드" />
  </form>


</div>
</body>
</html>
