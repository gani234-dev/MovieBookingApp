<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Upcoming Movies</title>
    <link rel="icon" href="logo1.png" type="image/png">
    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-color: #1e1e2f;
            --card-bg: #2a2a40;
            --text-color: #f0f0f0;
            --accent-color: #00bcd4;
            --border-radius: 16px;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-color);
            padding: 40px 20px;
        }

        /* --- NAVBAR STYLES --- */
        .navbar {
            max-width: 1200px;
            margin: 0 auto 40px auto;
            padding: 12px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: var(--card-bg);
            border-radius: var(--border-radius);
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
        }

        .logo {
            display: flex;
            align-items: center;
            color: var(--accent-color);
            font-weight: 600;
            font-size: 1.5rem;
            cursor: default;
        }

        .logo img {
            height: 40px;
            margin-right: 12px;
        }

        .nav-links {
            list-style: none;
            display: flex;
            gap: 30px;
        }

        .nav-links li a {
            color: var(--text-color);
            font-weight: 600;
            font-size: 1.1rem;
            text-decoration: none;
            padding-bottom: 3px;
            transition: color 0.3s, border-bottom 0.3s;
            border-bottom: 3px solid transparent;
        }

        .nav-links li a:hover {
            color: #e13232;
            border-bottom: 3px solid #e13232;
        }

        .nav-links li a.active {
            color: var(--accent-color);
            border-bottom: 3px solid var(--accent-color);
        }

        /* --- MOVIE PAGE STYLES --- */
        h2 {
            text-align: left;
            font-size: 2.5rem;
            margin-bottom: 40px;
            color: var(--accent-color);
        }

        .movie-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 25px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .movie-card {
            background-color: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 20px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.25);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .movie-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.35);
        }

        .movie-card h3 {
            font-size: 1.4rem;
            color: var(--accent-color);
            margin-bottom: 10px;
        }

        .movie-card p {
            font-size: 0.95rem;
            margin-bottom: 15px;
            color: #cccccc;
        }

        .video-container {
            position: relative;
            padding-bottom: 56.25%; /* 16:9 aspect ratio */
            height: 0;
            overflow: hidden;
            border-radius: 10px;
        }

        .video-container iframe {
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 100%;
            border: none;
        }

        /* Scrollbar (optional) */
        ::-webkit-scrollbar {
            width: 10px;
        }

        ::-webkit-scrollbar-thumb {
            background: #555;
            border-radius: 10px;
        }

        ::-webkit-scrollbar-track {
            background: #1a1a2e;
        }

        @media (max-width: 600px) {
            .navbar {
                flex-direction: column;
                gap: 12px;
                padding: 16px 20px;
            }
            .nav-links {
                flex-direction: column;
                gap: 10px;
            }
        }

        @media (max-width: 400px) {
            .movie-card {
                padding: 15px;
            }
        }
    </style>
</head>
<body>
<nav class="navbar">
    <div class="logo">
        <img src="logo1.png" alt="Logo" />
        <span>Cine Snap</span>
    </div>
    <ul class="nav-links">
        <li><a href="upcomingMovies.jsp" class="active">Upcoming</a></li>
        <li><a href="movieList.jsp">Now</a></li>
    </ul>
</nav>

<h2>Upcoming Movies</h2>

<div class="movie-container">
<%
    String dbURL = "jdbc:mysql://localhost:3306/mba";
    String dbUser = "root";
    String dbPass = "root123";
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM upcoming");

        while (rs.next()) {
            String title = rs.getString("name");
            String releaseDate = rs.getString("release_date");
            String URL = rs.getString("url"); // Must be embeddable like YouTube
%>
    <div class="movie-card">
        <h3><%= title %></h3>
        <p>Release Date: <%= releaseDate %></p>
        <div class="video-container">
            <iframe src="<%= URL %>" allowfullscreen="true"></iframe>
        </div>
    </div>
<%
        }
    } catch (Exception e) {
        out.println("<p style='color:red; text-align:center;'>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
</div>
</body>
</html>
