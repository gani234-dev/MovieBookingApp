<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String movieId = request.getParameter("movieId");

    String movieName = "";
    String imageUrl = "";
    String duration = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mba", "root", "root123");
        PreparedStatement ps = conn.prepareStatement("SELECT name, image_url, duration FROM movies WHERE id = ?");
        ps.setInt(1, Integer.parseInt(movieId));
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            movieName = rs.getString("name");
            imageUrl = rs.getString("image_url");
            duration = rs.getString("duration");
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        out.println("<h3>Error loading movie: " + e.getMessage() + "</h3>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Book Ticket - <%= movieName %></title>
    <link rel="icon" href="logo.png" type="image/png">
    <style>
        body {
            background-color: #1b1b1b;
            color: #f0f0f0;
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
        }

        .page-container {
            display: flex;
            flex-direction: row;
            height: 100vh;
        }

        .poster-container {
            flex: 1;
            background-color: #111;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .movie-poster {
            width: 100%;
            height: auto;
            max-height: 90vh;
            border-radius: 10px;
            box-shadow: 0 0 6px rgba(255, 60, 60, 0.3);

            object-fit: contain;
        }

        .booking-form {
            flex: 1;
            max-width: 600px;
            background-color: #2b2b2b;
            padding: 40px;
            border-radius: 12px;
            margin: auto;
            box-shadow: 0 0 20px rgba(255, 60, 60, 0.6);
        }

        h2 {
            color: #ff3c3c;
            margin-bottom: 25px;
        }

        input, select {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            margin-bottom: 20px;
            border: none;
            border-radius: 6px;
            font-size: 1em;
        }

        button {
            background-color: #ff3c3c;
            color: white;
            border: none;
            padding: 14px;
            border-radius: 8px;
            font-size: 1em;
            cursor: pointer;
        }

        button:hover {
            background-color: #e13232;
        }

        label {
            font-weight: 600;
        }
    </style>
</head>
<body>

<div class="page-container">

    <!-- LEFT: Movie Poster -->
    <div class="poster-container">
        <img src="<%= imageUrl %>" alt="<%= movieName %>" class="movie-poster" />
    </div>

    <!-- RIGHT: Booking Form -->
    <div class="booking-form">
        <h2>Book Your Ticket for "<%= movieName %>"</h2>

        <%
            String x = (String) session.getAttribute("user");
            String y = (String) session.getAttribute("email");
        %>

        <form action="<%= request.getContextPath() %>/Bookingservlet" method="">
            <input type="hidden" name="movieId" value="<%= movieId %>">

            <label>Your Name</label>
            <input type="text" name="hidi" value="<%= x %>" required>

            <label>Movie</label>
            <input type="text" name="movie" value="<%= movieName %>" readonly>

            <label>Date</label>
            <input type="date" id="date" name="date" required>

            <label>Time</label>
            <select name="time" required>
                <option value="10:00 AM">10:00 AM</option>
                <option value="1:00 PM">1:00 PM</option>
                <option value="4:00 PM">4:00 PM</option>
                <option value="7:00 PM">7:00 PM</option>
                <option value="10:00 PM">10:00 PM</option>
            </select>

            <label>Number of Tickets</label>
            <input type="number" name="seats" min="1" max="10" required>

            <button type="submit">Confirm Booking</button>
        </form>
    </div>

</div>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const today = new Date().toISOString().split("T")[0];
        document.getElementById("date").setAttribute("min", today);
    });
</script>
</body>
</html>
