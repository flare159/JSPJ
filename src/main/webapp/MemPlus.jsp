<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"
%>

<html>
<link rel="stylesheet" href="./Newbie/PJCSS.css">
<head>
    <meta charset="UTF-8">
    <title>name 회원가입</title>

</head>
<body>
<div>
    <h1 style="text-align: center"> 회원가입 페이지 입니다</h1>
</div>

    <div class="memberdata" style="text-align: center">
    <form action="MemData.jsp" method="post">
        ID
        <input type="text" name="USERID" class="MemID" placeholder="사용하실 ID">
        <br><br>
        PSW
        <input type="password" name="USERPWD" class="MemPWD">
        <br>
        <br>
        닉네임
        <input type="text" name="USERNAME" class="MemNAME" placeholder="한글8자,영어16자 내">
        <br>
        <input type="submit" value="작성완료">
    </form>

    </div>

</body>
</html>
