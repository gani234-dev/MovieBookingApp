<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("user");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Your Tickets</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #1f1f1f, #2c2c2c);
            color: #f4f4f4;
            padding: 40px;
        }

        h2 {
            text-align: center;
            color: #ff3c3c;
            margin-bottom: 30px;
        }

        table {
            width: 90%;
            margin: 0 auto;
            border-collapse: collapse;
            background-color: #2b2b2b;
            box-shadow: 0 0 15px rgba(0,0,0,0.4);
        }

        th, td {
            padding: 12px 18px;
            text-align: center;
        }

        th {
            background-color: #ff3c3c;
            color: #fff;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #3a3a3a;
        }

        tr:nth-child(odd) {
            background-color: #2e2e2e;
        }

        td form {
            margin: 0;
        }
                /* Navbar Styles */
        header {
            width: 95%;
            margin: 20px auto 30px auto;
            background-color: #1e1e2f;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 25px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.4);
            border-radius: 15px;
            flex-wrap: wrap;
        }

        .navbar-left {
            display: flex;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .navbar-left img {
            height: 42px;
        }

        .navbar-left a {
            color: #00bcd4;
            text-decoration: none;
            font-weight: bold;
            font-size: 1rem;
        }

        .navbar-left a:hover {
            color: #ff3c3c;
        }
                .logout-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s ease;
            font-size: 0.95rem;
        }

        .logout-btn:hover {
            background-color: #b92d3b;
        }

        .delete-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .delete-btn:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
<header>
    <div class="navbar-left">
        <img src="logo1.png" alt="Logo">
        <a href="movieList.jsp">Now Showing</a>
        <a href="tickets.jsp">Tickets</a>
    </div>
    <form action="logout.jsp" method="post">
        <button type="submit" class="logout-btn">Logout</button>
    </form>
</header>
    <h2> Your Booking History</h2>
    <table>
        <tr>
            <th>Movie</th>
            <th>Date</th>
            <th>Time</th>
            <th>Seats</th>
            <th>Action</th>
        </tr>
<%
    boolean hasResults = false;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mba", "root", "root123");
        pst = con.prepareStatement("SELECT * FROM booking WHERE name = ?");
        pst.setString(1, username);
        rs = pst.executeQuery();

        while (rs.next()) {
            hasResults = true;
%>
        <tr>
            <td><%= rs.getString("movie") %></td>
            <td><%= rs.getString("dob") %></td>
            <td><%= rs.getString("time") %></td>
            <td><%= rs.getString("ticket") %></td>
            <td>
                <form action="delete.jsp" method="post">
                    <input type="hidden" name="ticketId" value="<%= rs.getInt("id") %>">
                    <input type="submit" value="Delete" class="delete-btn">
                </form>
            </td>
        </tr>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (con != null) con.close();
    }

    if (!hasResults) {
%>
        <tr>
            <td colspan="5" style="text-align: center; color: #aaa;">No bookings found.</td>
        </tr>
<%
    }
%>
    </table>
</body>
</html>
