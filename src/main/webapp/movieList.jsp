<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Movies List</title>
    <link rel="icon" href="logo1.png " type="image/png">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #1a1a1a 0%, #2e2e2e 100%);
            color: #f0f0f0;
            min-height: 100vh;
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

        .container {
            max-width: 1100px;
            margin: auto;
            background: #181818;
            padding: 35px 30px;
            box-shadow: 0 8px 35px rgba(255, 60, 60, 0.5);
            border-radius: 15px;
            border: 1px solid #ff3c3c;
            box-sizing: border-box;
        }

        h2 {
            text-align: center;
            color: #ff3c3c;
            margin-bottom: 35px;
            text-shadow: 0 0 12px #ff3c3c;
            font-size: 2.8rem;
        }

        .movie-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(230px, 1fr));
            gap: 30px;
        }

        .movie-card {
            background: #222;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 6px 18px rgba(255, 60, 60, 0.3);
            transition: transform 0.4s ease, box-shadow 0.4s ease;
            cursor: pointer;
            display: flex;
            flex-direction: column;
        }

        .movie-card:hover {
            transform: translateY(-12px) scale(1.04);
            box-shadow: 0 14px 30px rgba(255, 60, 60, 0.8);
        }

        .movie-image {
            width: 100%;
            height: 320px;
            object-fit: cover;
            display: block;
            border-bottom: 4px solid #ff3c3c;
        }

        .movie-info {
            padding: 24px 20px 22px 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .movie-title {
            font-size: 1.5rem;
            margin: 0 0 12px 0;
            font-weight: 800;
            color: #ff3c3c;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .movie-duration {
            color: #ccc;
            font-size: 1.05rem;
            margin-bottom: 18px;
            font-weight: 600;
        }

        .book-button {
            align-self: center;
            padding: 13px 28px;
            background-color: #ff3c3c;
            border: none;
            border-radius: 10px;
            color: #fff;
            font-weight: 800;
            font-size: 1.1rem;
            cursor: pointer;
            text-align: center;
            border-bottom: 4px solid #e52b2b;
            width: 100%;
            box-sizing: border-box;
        }

        .book-button:hover {
            background-color: #e13232;
            box-shadow: 0 8px 30px rgba(225, 50, 50, 1);
        }

        .error-message {
            max-width: 700px;
            margin: 50px auto;
            padding: 20px;
            background-color: #660000cc;
            border-radius: 10px;
            text-align: center;
            font-weight: 700;
            color: #ffbbbb;
            font-size: 1.3rem;
            box-shadow: 0 0 10px #ff3c3c;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<header>
    <div class="navbar-left">
        <img src="logo1.png" alt="Logo">
        <a href="movieList.jsp">Now Showing</a>
        <a href="tickets.jsp">Tickets</a>
        <a href="upcomingMovies.jsp">Upcoming</a>
        <a href="changePassword.jsp">Change Password</a>
    </div>
    <form action="logout.jsp" method="post">
        <button type="submit" class="logout-btn">Logout</button>
    </form>
</header>

<!-- Main Content -->
<%
    String jdbcURL = "jdbc:mysql://localhost:3306/mba";
    String jdbcUsername = "root";
    String jdbcPassword = "root123";

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

        String sql = "SELECT id, name, image_url, duration FROM movies";
        ps = conn.prepareStatement(sql);
        rs = ps.executeQuery();
%>

<div class="container">
    <h2>Now Showing</h2>
    <div class="movie-grid">
        <% while(rs.next()) {
            int movieId = rs.getInt("id");
            String name = rs.getString("name");
            String imageUrl = rs.getString("image_url");
            String duration = rs.getString("duration");
        %>
        <div class="movie-card">
            <img src="<%=imageUrl%>" alt="<%=name%>" class="movie-image" />
            <div class="movie-info">
                <h3 class="movie-title"><%=name%></h3>
                <div class="movie-duration">Duration: <%=duration%></div>
                <form action="booking.jsp" method="post">
                    <input type="hidden" name="movieId" value="<%=movieId%>" />
                    <button type="submit" class="book-button">Book Now</button>
                </form>
            </div>
        </div>
        <% } %>
    </div>
</div>

<%
    } catch(Exception e) {
%>
    <div class="error-message">
        <strong>Error loading movies:</strong> <%= e.getMessage() %>
    </div>
<%
    } finally {
        try { if(rs != null) rs.close(); } catch(Exception ignored) {}
        try { if(ps != null) ps.close(); } catch(Exception ignored) {}
        try { if(conn != null) conn.close(); } catch(Exception ignored) {}
    }
%>

</body>
</html>
