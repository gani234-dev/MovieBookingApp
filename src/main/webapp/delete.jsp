<%@ page import="java.sql.*" %>
<%
    int ticketId = Integer.parseInt(request.getParameter("ticketId"));

    Connection con = null;
    PreparedStatement pst = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mba", "root", "root123");

        pst = con.prepareStatement("DELETE FROM booking WHERE id = ?");
        pst.setInt(1, ticketId);
        pst.executeUpdate();

        response.sendRedirect("tickets.jsp"); // Redirect back to history
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pst != null) pst.close();
        if (con != null) con.close();
    }
%>
