<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PCS Global Pvt. Ltd.</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #A259FF, #3CDCFF);
            color: white;
        }
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 40px;
        }
        .logo {
            font-size: 20px;
            font-weight: bold;
        }
        nav a {
            color: black;
            text-decoration: none;
            margin-left: 30px;
            font-weight: bold;
        }
        .title {
            padding: 20px 40px;
            font-size: 20px;
            font-weight: bold;
            margin: 0 auto;           
    width: fit-content;   
        }
        .centers {
            display: flex;
            justify-content: center;
            gap: 20px;
            padding: 30px;
        }
        .card {
            background-color: #d8f3dc;
            color: black;
            border-radius: 10px;
            padding: 10px;
            width: 300px;
            height: 450px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            background-color: lightblue;
        }
      
        .card img {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-radius: 5px;
        }
    .card:hover {
    transform: scale(1.05);
    box-shadow: 0 12px 20px rgba(0, 0, 0, 0.3);
    cursor: pointer;}
        .card h3 {
            margin: 10px 0;
            
        }
        .btn-container {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-bottom: 10px;
        }
        .btn {
            background-color: #4361ee;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
        }
        .btn-link-button {
            background-color: #4361ee;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
        }
        .btn:hover{
        transform: scale(1.05);
    box-shadow: 0 12px 20px rgba(0, 0, 0, 0.3);
    cursor: pointer;}
    .btn-link-button:hover{
        transform: scale(1.05);
    box-shadow: 0 12px 20px rgba(0, 0, 0, 0.3);
    cursor: pointer;}
        footer {
            text-align: center;
            padding: 20px;
            background-color: transparent;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <header>
        <div class="logo">
            <img src="https://www.pcsglobal360.com/static/media/pcs%20logo.4790cc5f49bd9caa4a6a.png" alt="Logo" style="height: 100px; vertical-align: middle;"> PCS Global Pvt. Ltd.
        </div>
        <nav>
            <a href="#">About</a>
            <a href="#">Career</a>
            <a href="#">Our Socials</a>
        </nav>
    </header>

    <div class="title">PCS India Development Center</div>

    <div class="centers">
        <div class="card">
            <h3>Bangalore</h3>
            <img src="https://www.tripsavvy.com/thmb/GZPnW6gFsxQP0owZiINigDrtJno=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-946935770-5b5d72ec46e0fb002c82edda.jpg" alt="Bangalore">
            <div class="btn-container">
                <button class="btn">About Us</button><br><br>  
                <a href="Registration.jsp" class="btn-link-button">Registration</a>
            </div>
        </div>

        <div class="card">
            <h3>Kolkata</h3>
            <img src="https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/33/fe/ac/kolkata-calcutta.jpg?w=600&h=500&s=1" alt="Kolkata">
            <div class="btn-container">
                <button class="btn">About Us</button><br><br>
                <a href="Registration.jsp" class="btn-link-button">Registration</a>
            </div>
        </div>

        <div class="card">
            <h3>Noida</h3>
            <img src="https://staticimg.amarujala.com/assets/images/2023/07/03/akshardham-temple-noida_1688384739.jpeg" alt="Noida">
            <div class="btn-container">
                <button class="btn">About Us</button><br><br>
                <a href="Registration.jsp" class="btn-link-button" >Registration</a>
                
            </div>
        </div>
    </div>

    <footer>
        An empowering workplace where employees design impactful solutions for a global future.
    </footer>
</body>
</html>
