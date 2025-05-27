<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/mba";
    String dbUser = "root";
    String dbPass = "root123";

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String action = request.getParameter("action");
    String type = request.getParameter("type");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        if ("add".equals(action) && "movie".equals(type)) {
            String name = request.getParameter("name");
            String url = request.getParameter("image_url");
            String duration = request.getParameter("duration");
            ps = conn.prepareStatement("INSERT INTO movies (name, image_url, duration) VALUES (?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, url);
            ps.setString(3, duration);
            ps.executeUpdate();
        } else if ("add".equals(action) && "upcoming".equals(type)) {
            String name = request.getParameter("name");
            String url = request.getParameter("image_url");
            String releaseDate = request.getParameter("release_date");
            ps = conn.prepareStatement("INSERT INTO upcoming (name, release_date, url) VALUES (?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, releaseDate);
            ps.setString(3, url);
            ps.executeUpdate();
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            if ("movie".equals(type)) {
                ps = conn.prepareStatement("DELETE FROM movies WHERE id=?");
            } else if ("user".equals(type)) {
                ps = conn.prepareStatement("DELETE FROM movie_data WHERE id=?");
            } else if ("upcoming".equals(type)) {
                ps = conn.prepareStatement("DELETE FROM upcoming WHERE id=?");
            }
            ps.setInt(1, id);
            ps.executeUpdate();
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            if ("movie".equals(type)) {
                String name = request.getParameter("name");
                String image_url = request.getParameter("image_url");
                String duration = request.getParameter("duration");
                ps = conn.prepareStatement("UPDATE movies SET name=?, image_url=?, duration=? WHERE id=?");
                ps.setString(1, name);
                ps.setString(2, image_url);
                ps.setString(3, duration);
                ps.setInt(4, id);
                ps.executeUpdate();
            } else if ("upcoming".equals(type)) {
                String name = request.getParameter("name");
                String image_url = request.getParameter("image_url");
                String release_date = request.getParameter("release_date");
                ps = conn.prepareStatement("UPDATE upcoming SET name=?, release_date=?, url=? WHERE id=?");
                ps.setString(1, name);
                ps.setString(2, release_date);
                ps.setString(3, image_url);
                ps.setInt(4, id);
                ps.executeUpdate();
            }
        }
    } catch (Exception e) {
        out.println("<div style='color:red;'>Error occurred. Please try again later.</div>");
        e.printStackTrace();
    } finally {
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>

<html>
<head>
    <title>Admin Panel</title>
    <link rel="icon" href="logo1.png" type="image/png">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f4f4f4; margin: 0; padding: 40px; }
        .container { max-width: 1100px; margin: auto; background: #ffffff; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px #ccc; }
        h2 { border-bottom: 2px solid #333; padding-bottom: 5px; color: #333; }
        form.movie-form { display: grid; grid-template-columns: 1fr 1fr 1fr auto; gap: 15px; margin-top: 20px; }
        input[type="text"], input[type="email"] { padding: 10px; border: 1px solid #ccc; border-radius: 6px; font-size: 14px; }
        input[type="submit"] { background: #007bff; color: white; padding: 10px 18px; border: none; border-radius: 6px; cursor: pointer; transition: background 0.3s ease; }
        input[type="submit"]:hover { background: #0056b3; }
        .scroll-table { max-height: 400px; overflow-y: auto; margin-top: 20px; }
        table { width: 100%; border-collapse: collapse; min-width: 800px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; font-size: 14px; }
        th { background-color: #333; color: white; position: sticky; top: 0; z-index: 1; }
        .actions { display: flex; gap: 10px; }
    </style>
</head>
<body>
<div style="text-align: right; margin-bottom: 20px;">
    <form action="logout.jsp" method="post" style="display: inline;">
        <button type="submit" style="background-color: #dc3545; color: white; border: none; padding: 10px 20px; border-radius: 6px; cursor: pointer;">Logout</button>
    </form>
</div>

<div class="container">
    <h2>Movie Management</h2>
    <form class="movie-form" method="post" action="Admin.jsp">
        <input type="hidden" name="action" value="add">
        <input type="hidden" name="type" value="movie">
        <input type="text" name="name" placeholder="Movie Name" required>
        <input type="text" name="image_url" placeholder="Image URL" required>
        <input type="text" name="duration" placeholder="Duration" required>
        <input type="submit" value="Add Movie">
    </form>

    <div class="scroll-table">
        <table>
            <tr><th>ID</th><th>Name</th><th>Image URL</th><th>Duration</th><th>Actions</th></tr>
            <%
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                ps = conn.prepareStatement("SELECT * FROM movies");
                rs = ps.executeQuery();
                while (rs.next()) {
            %>
            <tr>
                <form method="post" action="Admin.jsp">
                    <td><%= rs.getInt("id") %><input type="hidden" name="id" value="<%= rs.getInt("id") %>"></td>
                    <td><input type="text" name="name" value="<%= rs.getString("name") %>"></td>
                    <td><input type="text" name="image_url" value="<%= rs.getString("image_url") %>"></td>
                    <td><input type="text" name="duration" value="<%= rs.getString("duration") %>"></td>
                    <td class="actions">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="type" value="movie">
                        <input type="submit" value="Update">
                    </td>
                </form>
                <form method="post" action="Admin.jsp">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="type" value="movie">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <td class="actions">
                        <input type="submit" value="Delete" style="background-color:#dc3545; color:white;">
                    </td>
                </form>
            </tr>
            <%
                }
                rs.close(); ps.close(); conn.close();
            %>
        </table>
    </div>

    <h2>Upcoming Movies Management</h2>
    <form class="movie-form" method="post" action="Admin.jsp">
        <input type="hidden" name="action" value="add">
        <input type="hidden" name="type" value="upcoming">
        <input type="text" name="name" placeholder="Upcoming Movie Name" required>
        <input type="text" name="image_url" placeholder="Image URL" required>
        <input type="text" name="release_date" placeholder="Release Date" required>
        <input type="submit" value="Add Upcoming Movie">
    </form>

    <div class="scroll-table">
        <table>
            <tr><th>ID</th><th>Name</th><th>Image URL</th><th>Release Date</th><th>Actions</th></tr>
            <%
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                ps = conn.prepareStatement("SELECT * FROM upcoming");
                rs = ps.executeQuery();
                while (rs.next()) {
            %>
            <tr>
                <form method="post" action="Admin.jsp">
                    <td><%= rs.getInt("id") %><input type="hidden" name="id" value="<%= rs.getInt("id") %>"></td>
                    <td><input type="text" name="name" value="<%= rs.getString("name") %>"></td>
                    <td><input type="text" name="image_url" value="<%= rs.getString("url") %>"></td>
                    <td><input type="text" name="release_date" value="<%= rs.getString("release_date") %>"></td>
                    <td class="actions">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="type" value="upcoming">
                        <input type="submit" value="Update">
                    </td>
                </form>
                <form method="post" action="Admin.jsp">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="type" value="upcoming">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <td class="actions">
                        <input type="submit" value="Delete" style="background-color:#dc3545; color:white;">
                    </td>
                </form>
            </tr>
            <%
                }
                rs.close(); ps.close(); conn.close();
            %>
        </table>
    </div>

    <h2>User Management</h2>
    <table>
        <tr><th>ID</th><th>Username</th><th>Email</th><th>Actions</th></tr>
        <%
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            ps = conn.prepareStatement("SELECT * FROM movie_data");
            rs = ps.executeQuery();
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("email") %></td>
            <td class="actions">
                <form method="post" action="Admin.jsp">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="type" value="user">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <input type="submit" value="Delete" style="background-color:#dc3545; color:white;">
                </form>
            </td>
        </tr>
        <%
            }
            rs.close(); ps.close(); conn.close();
        %>
    </table>
</div>
</body>
</html>
