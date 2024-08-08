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

    // 중복 ID 검사
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

    // 사용자 유효성 검사
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

    // 사용자 추가
    public boolean addUser(UserDTO user) {
        String sql = "INSERT INTO PJMEMBER (USERNUMBER, USERID, USERPWD, USERNAME) " +
                "VALUES (PJMemNum.nextval, ?, ?, ?)";
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

    // 사용자 정보 가져오기
    public UserDTO getUserById(String userId) {
        String sql = "SELECT USERID, USERPWD, USERNAME, USERPT, USERPIC FROM PJMEMBER WHERE USERID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new UserDTO(
                        rs.getString("USERID"),
                        rs.getString("USERPWD"),
                        rs.getString("USERNAME"),
                        rs.getDouble("USERPT"),
                        rs.getString("USERPIC") // 프로필 사진 경로 추가
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 비밀번호 변경 및 닉네임 수정
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

    // 닉네임 가져오기
    public String getUserName(String userId) {
        String userName = null;
        String sql = "SELECT USERNAME FROM PJMEMBER WHERE USERID = ?";
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
