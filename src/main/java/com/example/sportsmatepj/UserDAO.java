package com.example.sportsmatepj;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    private Connection conn;

    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    //중복 ID 검사
    public boolean isUsernameUN(String username) {
        String sql = "SELECT 1 FROM PJMEMBER WHERE USERNAME = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }



    public boolean validateUser(UserDTO user) {
        String sql = "SELECT USERID FROM PJMEMBER WHERE USERID = ? AND USERPWD = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getUserid());
            pstmt.setString(2, user.getUserpwd());
            ResultSet rs = pstmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean addUser(UserDTO user) {
        //회원가입 addUser
        String sql = "INSERT INTO PJMEMBER p (USERNUMBER, USERID, USERPWD, USERNAME)" +
                " values(PJMemNum.nextval, ?, ?, ? )";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getUserid());
            pstmt.setString(2, user.getUserpwd());
            pstmt.setString(3, user.getUsername());
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

    }

    public UserDTO getUserById(String userId) {
        String sql = "SELECT USERID, USERPWD, USERNAME, USERPT FROM PJMEMBER WHERE USERID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                // USERPT를 Double로 가져옵니다.
                return new UserDTO(
                        rs.getString("USERID"),
                        rs.getString("USERPWD"),
                        rs.getString("USERNAME"),
                        rs.getDouble("USERPT") // USERPT를 Double로 가져옵니다.
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    //비번변경 , 닉네임 수정
    public boolean updateUser(UserDTO user) {
        String sql = "UPDATE PJMEMBER SET USERPWD = ?, USERNAME = ? WHERE USERID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getUserpwd());
            pstmt.setString(2, user.getUsername());
            pstmt.setString(3, user.getUserid());
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
        //닉네임 가져오기
    public String getUserName(String userId) {
        String userName = null;
        String sql = "SELECT username FROM pjmember WHERE userid = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                userName = rs.getString("USERNAME");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userName;
    }


}