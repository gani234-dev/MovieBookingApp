<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<head>
 <title>CineSnap</title>

    <!-- Favicon for browser tab -->
    <link rel="icon" href="logo1.png" type="image/png">

</head>

    <title>🎬 CineSnap</title>
    <style>
        body {
            margin: 0;
            height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #fff;
            display: flex;
            justify-content: flex-start;
            align-items: center;
            background:
                linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
                url('https://png.pngtree.com/thumb_back/fh260/background/20221205/pngtree-realistic-film-strip-with-popcorn-and-movie-ticket-image_1483983.jpg') no-repeat center center fixed;
            background-size: cover;
            padding-left: 35vw; /* shifts form right */
        }

    .main {
  background-color: rgba(44, 47, 74, 0.85);
  padding: 40px;
  border-radius: 12px;
  box-shadow: 0 0 25px rgba(255, 60, 60, 0.4);
  width: 350px;
  text-align: center;

  margin-left: 15vw;  /* <-- Shift form right by adding margin */
}

        h1 {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }

        h3 {
            margin-bottom: 30px;
            font-weight: 500;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        label {
            font-weight: 600;
            text-align: left;
            display: block;
        }

        input[type="text"],
        input[type="password"] {
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 1em;
        }

        button {
            background-color: #ff3c3c;
            color: white;
            padding: 14px;
            border: none;
            border-radius: 8px;
            font-size: 1.1em;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #e13232;
        }

        p {
            margin-top: 20px;
        }

        p a {
            color: #ff3c3c;
            font-weight: 600;
        }

        p a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
    <div class="main">
        <h1>🎬 CineSnap</h1>
        <h3>Enter your login credentials</h3>
        <form action="Loginservlet" method="post">
            <label for="first">Username:</label>
            <input type="text" id="first" name="first" placeholder="Enter your Username" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="psd" placeholder="Enter your Password" required>

            <button type="submit">Submit</button>
        </form>

        <p>Not registered? <a href="register.jsp">Create an account</a></p>
    </div>
</body>

</html>
