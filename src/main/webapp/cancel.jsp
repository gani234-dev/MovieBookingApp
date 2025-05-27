<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Last Booking</title>
</head>
<body>
<%
    String jdbcURL = "jdbc:mysql://localhost:3306/mba";
    String dbUser = "root";
    String dbPassword = "root123";

    PreparedStatement ps = null;
    Connection conn = null;

    try {
        // Load JDBC Driver (optional in newer versions)
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // Delete the last booking by ID (assuming `id` is auto-increment)
        String getLastIdSQL = "SELECT id FROM booking ORDER BY id DESC LIMIT 1";
        ps = conn.prepareStatement(getLastIdSQL);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            int lastId = rs.getInt("id");
            ps.close(); // Close the previous statement

            String deleteSQL = "DELETE FROM booking WHERE id = ?";
            ps = conn.prepareStatement(deleteSQL);
            ps.setInt(1, lastId);
            ps.executeUpdate();
        }

        // Redirect or forward after deletion
        RequestDispatcher rd = request.getRequestDispatcher("/movieList.jsp");
        rd.forward(request, response);

    } catch (Exception e) {
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
    } finally {
        try {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (Exception ex) {
            out.println("<h3>Error closing resources: " + ex.getMessage() + "</h3>");
        }
    }
%>
</body>
</html>
