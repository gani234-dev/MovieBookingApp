<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("user");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Change Password</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #1f1f1f, #2c2c2c);
            color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .form-container {
            background-color: #2c2c2c;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(255, 60, 60, 0.3);
            width: 100%;
            max-width: 400px;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #ff3c3c;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #ccc;
        }

        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #444;
            border-radius: 6px;
            background-color: #1f1f1f;
            color: #f4f4f4;
        }

        input[type="submit"] {
            background-color: #ff3c3c;
            color: white;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Change Password</h2>
        <form method="post" action="updatePassword.jsp">
            <label>Current Password:</label>
            <input type="password" name="currentPassword" required>

            <label>New Password:</label>
            <input type="password" name="newPassword" required>

            <label>Confirm New Password:</label>
            <input type="password" name="confirmPassword" required>

            <input type="submit" value="Update Password">
        </form>
    </div>
</body>
</html>
