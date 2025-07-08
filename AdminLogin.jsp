<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>
<style>
    body {
        margin: 0;
        padding: 0;
        background-color: lightblue;
        font-family: Arial, sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    .login-box {
        padding: 40px;
        border: 2px solid black;
        border-radius: 5px;
        width: 500px;
        text-align: center;
        background: white;
    }

    .login-box h2 {
        margin-bottom: 60px;
    }

    .login-box label {
        display: block;
        text-align: left;
        margin: 10px 0 5px;
        font-weight: bold;
    }

    .login-box input[type="text"],
    .login-box input[type="password"] {
        width: 100%;
        padding: 2px;
        border: none;
        border-bottom: 2px solid black;
        background: transparent;
        font-size: 16px;
    }

    .login-box input[type="submit"] {
        background-color: blue;
        color: white;
        padding: 10px 20px;
        margin-top: 25px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
    }

    .login-box input[type="submit"]:hover {
        background-color: #8000ff;
    }

    .btn-link-button {
        display: inline-block;
        margin-top: 20px;
        text-decoration: none;
        color: white;
        background-color: darkgreen;
        padding: 8px 12px;
        border-radius: 4px;
    }
    <script type="text/javascript">
    function preventBack(){
    window.history.forward()};
    window.onunload=function(){
    null;}
    </script>
</style>
</head>
<body style="background-image: url('images/admin-images-8.jpg'); background-size: cover;">

<div class="login-box">
    <h2>Login Here</h2>
    <form action="adminLoginAction.jsp" method="post">
        <label for="username">Username</label>
        <input type="text" id="username" name="username" required>

        <label for="password">Password</label>
        <input type="password" id="password" name="password" required>

        <input type="submit" value="Submit">
    </form>

    
</div>

</body>
</html>
