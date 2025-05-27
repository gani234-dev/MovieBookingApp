<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Form</title>
    <link rel="icon" href="logo.png" type="image/png">
    <link rel="stylesheet" href="registerstyle.css">
</head>
<body>
<form action="<%=request.getContextPath() %>/Mba" style="border:1px solid #ccc" >
  <div class="container">
    <h1>Register here to Book your Movie Tickets!!</h1>
    <p>Please fill in this form to create an account.</p>
    <hr>
    <label for="name"><b>Name: </b></label>
    <input type="text" placeholder="Enter your Name" name="name" required>
    
    <label for="dob"><b>Enter Date of Birth: </b></label>
    <input type="date" placeholder="" name="dob" required>
    <br>

    <label for="email"><b>Email: </b></label>
    <input type="text" placeholder="Enter Email" name="email" required>

    <label for="psw"><b>Password: </b></label>
    <input type="password" placeholder="Enter Password" name="psw" required>


    <label>
      <input type="checkbox" checked="checked" name="remember" style="margin-bottom:15px"> Remember me
    </label>

    <p>By creating an account you agree to our <a href="#" style="color:dodgerblue">Terms & Privacy</a>.</p>

    <div class="clearfix">
      <button type="button" class="cancelbtn">Cancel</button>
      <button type="submit" class="signupbtn">Sign Up</button>
    </div>
  </div>
</form>
</body>
</html>