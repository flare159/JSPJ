<%@ page import="com.example.sportsmatepj.UserDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"
%>

<%
    String userid = (String) session.getAttribute("userid");
    String username = (String) session.getAttribute("username");




%>
<%-- USERID --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SportsMate</title>

    <link rel="stylesheet" href="css/Sportsmate3.css">
</head>
<body>
<div id="header">
    <h1 class="header_title">Sportsmate</h1>

    <%
        if (userid == null){
    %>
    <form action="Login-data.jsp" method="post">
    <div class="login">
        <section class = "login-form">
  <%--로그인폼--%>
            <h2>Login</h2>

                <div class="user_info">
                    <input type="text" name="USERID" id="id" autocomplete="off" required placeholder="ID">
                    <label for="id"></label>
                </div>
                <div class="user_info">
                    <input type="password" name="USERPWD" id="pw" autocomplete="off" required  placeholder="PWD">
                    <label for="pw"></label>
                </div>
                <div class="login_btn">
                    <input type="submit"  id="btn"  value="로그인">
                </div>

            <div class="caption">
                <a href="">Forgot Password?</a> <br>
                <a href="MemPlus.jsp" target="_blank">
                    <input type="button" id="" value="회원가입">
                </a>
            </div>
        </section>
    </div>
    </form>
<%-- 로그인 했을때 (임시)--%>
    <%
    } else {

    %>



    <div class="login-box">
        <div class="profile-line" style="width: 300px" >
            <!-- 프로필 사진 표시 -->
            <%
                String userId = (String) request.getSession().getAttribute("userid");
            %>
            <img src="<%= request.getContextPath() + "/uploads/"+userId+"propic.jpg" %>" alt="프로필 사진" />

        </div>

        어서오세요 <%=username%> 님 <a href="Logout.jsp"><input type="button" value="로그아웃"></a>
        <a href="Mypage.jsp"><input type="button" value="마이페이지"></a>


        <h2>Ranking</h2>


    </div>
    <%
        }
    %>
</div>


<div id="main">
    <div class="main1">
        <h2 class="main_title">Find your mate!</h2>
    </div>
</div>
</body>
</html>