<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("user");
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmPassword");

    if (!newPassword.equals(confirmPassword)) {
        out.println("New passwords do not match.");
        return;
    }

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mba", "root", "root123");

        // Verify current password
        pst = con.prepareStatement("SELECT * FROM movie_data WHERE name=? AND password=?");
        pst.setString(1, username);
        pst.setString(2, currentPassword);
        rs = pst.executeQuery();

        if (rs.next()) {
            // Update password
            pst = con.prepareStatement("UPDATE movie_data SET password=? WHERE name=?");
            pst.setString(1, newPassword);
            pst.setString(2, username);
            int i = pst.executeUpdate();
            if (i > 0) {
                out.println("Password updated successfully.");
            } else {
                out.println("Failed to update password.");
            }
        } else {
            out.println("Current password is incorrect.");
        }
        response.sendRedirect("login.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (con != null) con.close();
    }
%>
