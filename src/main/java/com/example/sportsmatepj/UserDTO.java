package com.example.sportsmatepj;

public class UserDTO {

    private String userid;
    private String userpwd;
    private String username;
    private Number userpt;
    private String userpic;

    public UserDTO(String userId, String userPwd , String userName,Number userPt,String userPic) {
        this.userid = userId;
        this.userpwd = userPwd;
        this.username = userName;
        this.userpt = userPt;
        this.userpic = userPic;

    }

    public String getUserid() {

        return userid;
    }

    public void setUserid(String userid) {

        this.userid = userid;
    }

    public String getUserpwd() {
        return userpwd;
    }

    public void setUserpwd(String userpwd) {
        this.userpwd = userpwd;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Number getUserpt() {
        return userpt;
    }

    public String getUserpic() {
        return userpic;
    }

    public void setUserpic(String userpic) {
        this.userpic = userpic;
    }

    public void setUserpt(Number userpt) {
        this.userpt = userpt;
    }
}