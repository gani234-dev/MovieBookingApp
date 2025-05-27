<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String name = (String) request.getAttribute("name");
    String movie = (String) request.getAttribute("movie");
    String date = (String) request.getAttribute("dob");
    String time = (String) request.getAttribute("time");
    String seats = (String) request.getAttribute("nt");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Confirmation</title>
    <link rel="icon" href="logo1.png" type="image/png">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #1f1f1f, #2c2c2c);
            color: #f4f4f4;
            height: 100vh;
            margin: 0;
            position: relative;
        }

        .cancel-container {
            position: absolute;
            top: 20px;
            right: 20px;
            z-index: 10;
        }

        .logout-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            font-size: 0.95rem;
            transition: background-color 0.3s ease;
        }

        .ticket-wrapper {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100%;
        }

        .ticket {
            background: #222;
            border: 2px dashed #ff3c3c;
            border-radius: 12px;
            padding: 30px 40px;
            max-width: 600px;
            width: 100%;
            box-shadow: 0 0 30px rgba(255, 60, 60, 0.4);
            position: relative;
        }

        .ticket::before, .ticket::after {
            content: '';
            position: absolute;
            width: 30px;
            height: 30px;
            background: #1f1f1f;
            border-radius: 50%;
            top: 50%;
            transform: translateY(-50%);
        }

        .ticket::before {
            left: -15px;
        }

        .ticket::after {
            right: -15px;
        }

        h2 {
            color: #ff3c3c;
            text-align: center;
            margin-bottom: 25px;
            font-size: 2em;
        }

        .ticket-details {
            font-size: 1.1em;
            line-height: 1.7em;
            padding: 15px 0;
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

        .label {
            color: #bbb;
            font-weight: bold;
            margin-right: 8px;
        }

        .highlight {
            color: #ff3c3c;
            font-weight: bold;
        }

        .footer {
            text-align: center;
            margin-top: 25px;
            font-size: 0.95em;
            color: #aaa;
        }
    </style>
</head>
<body>

<div class="navbar-left">
    <div class="logout-btn">
    <a href="movieList.jsp">Home</a>
    </div>
    <form action="cancel.jsp" method="post">
        <button type="submit" class="logout-btn">Cancel Ticket</button>
    </form>
</div>

<div class="ticket-wrapper">
    <div class="ticket">
        <h2>🎟 Booking Confirmed!</h2>
        <div class="ticket-details">
            <p><span class="label">Name:</span> <span class="highlight"><%= name %></span></p>
            <p><span class="label">Movie:</span> <span class="highlight"><%= movie %></span></p>
            <p><span class="label">Date:</span> <span class="highlight"><%= date %></span></p>
            <p><span class="label">Time:</span> <span class="highlight"><%= time %></span></p>
            <p><span class="label">No. of Tickets:</span> <span class="highlight"><%= seats %></span></p>
        </div>
        <div class="footer">
            Enjoy your movie! 🍿<br/>
            Please arrive 15 minutes early for seat confirmation.
        </div>
    </div>
</div>

</body>
</html>
