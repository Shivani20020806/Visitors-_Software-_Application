<%@ page import="visitor.VisitorApp" %>
<%
    String city = request.getParameter("city");
    boolean registrationSuccess = false;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        VisitorApp vb = new VisitorApp();
        vb.setName(request.getParameter("name"));
        vb.setEmail(request.getParameter("email"));
        vb.setMobile(request.getParameter("mobile"));

        String qualification = request.getParameter("qualification");
        if ("Other".equalsIgnoreCase(qualification)) {
            qualification = request.getParameter("otherQualification");
        }
        vb.setQualification(qualification);

        vb.setYop(request.getParameter("yop"));
        vb.setCity(request.getParameter("city"));
        VisitorApp.insertVisitor(vb);
        registrationSuccess = true;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Here</title>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Poppins', sans-serif;
    }

    body {
        background: linear-gradient(155deg, #001f3f, #007BFF, #FFFFFF);
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .container {
        display: flex;
        background: #fff;
        width: 900px;
        border-radius: 15px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        overflow: hidden;
    }

    .image-section {
        flex: 1;
        position: relative;
        background: url('https://img.freepik.com/premium-vector/flat-illustration-website-software-development-boy-working-app-optimization-programming_830469-320.jpg') no-repeat center;
        background-size: cover;
    }

    .logo {
        position: absolute;
        top: 15px;
        left: 15px;
        display: flex;
        align-items: center;
        background: rgba(255,255,255,0.7);
        padding: 5px 10px;
        border-radius: 8px;
    }

    .logo img {
        height: 40px;
    }

    .logo span {
        margin-left: 8px;
        font-weight: bold;
        color: #007B7F;
        font-size: 14px;
    }

    .form-section {
        flex: 1;
        padding: 40px 30px;
        position: relative;
    }

    .form-section h2 {
        text-align: center;
        color: #007B7F;
        margin-bottom: 20px;
        font-size: 26px;
    }

    .form-section label {
        font-weight: 600;
        color: #333;
        display: block;
        margin: 10px 0 5px;
    }

    .form-section input[type="text"],
    .form-section input[type="email"],
    .form-section input[type="tel"],
    .form-section select {
        width: 100%;
        padding: 12px;
        border: 1px solid #ccc;
        border-radius: 8px;
        outline: none;
        transition: border 0.3s;
    }

    .form-section input[type="text"]:focus,
    .form-section input[type="email"]:focus,
    .form-section input[type="tel"]:focus,
    .form-section select:focus {
        border-color: #00b3b3;
    }

    .form-section input[type="submit"] {
        width: 100%;
        padding: 12px;
        margin-top: 20px;
        border: none;
        background: #00b3b3;
        color: #fff;
        font-size: 16px;
        border-radius: 8px;
        cursor: pointer;
        transition: background 0.3s ease;
    }

    .form-section input[type="submit"]:hover {
        background: #007B7F;
    }

    .home-icon {
        position: absolute;
        top: 15px;
        right: 15px;
    }

    .home-icon img {
        width: 30px;
        cursor: pointer;
    }

    .message-popup {
        position: fixed;
        top: 20px;
        left: 50%;
        transform: translateX(-50%);
        background-color: #dff0d8;
        color: #3c763d;
        padding: 12px 25px;
        border-radius: 8px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        display: none;
        z-index: 999;
        font-size: 16px;
    }

    .qualification-group {
        display: flex;
        gap: 10px;
        align-items: center;
    }

    .qualification-group select,
    .qualification-group input[type="text"] {
        flex: 1;
    }
</style>

<script>
    function showOtherInput() {
        var qualificationDropdown = document.getElementById("qualification");
        var otherInput = document.getElementById("otherQualification");
        if (qualificationDropdown.value === "Other") {
            otherInput.style.display = "block";
            otherInput.required = true;
        } else {
            otherInput.style.display = "none";
            otherInput.required = false;
        }
    }
</script>
</head>
<body>

<div class="message-popup" id="successPopup">Registration Successful!</div>

<div class="container">
    <div class="image-section">
        <div class="logo">
            <img src="https://www.pcsglobal360.com/static/media/pcs%20logo.4790cc5f49bd9caa4a6a.png" alt="Logo">
            <span>PCS Global Pvt. Ltd.</span>
        </div>
    </div>

    <div class="form-section">
        <div class="home-icon">
            <a href="index.jsp">
                <img src="IMAGE/Home.jpg" alt="Home">
            </a>
        </div>
        <h2>Registration Form</h2>
        <form method="post">
            <input type="hidden" name="city" value="<%= city %>">

            <label>Name</label>
            <input type="text" name="name" placeholder="Full Name" required>

            <label>Email</label>
            <input type="email" name="email" placeholder="Email Address" required>

            <label>Mobile</label>
            <input type="tel" name="mobile" pattern="[0-9]{10}" maxlength="10" placeholder="Mobile Number" required title="Exactly 10 digits">

            <label>Qualification</label>
            <div class="qualification-group">
                <select name="qualification" id="qualification" onchange="showOtherInput()" required>
                   <option value="">-- Select Qualification --</option>
                   <option value="B.Tech">B.Tech</option>
                   <option value="M.Tech">M.Tech</option>
                   <option value="B.Sc">B.Sc</option>
                   <option value="M.Sc">M.Sc</option>
                   <option value="MBA">MBA</option>
                   <option value="Other">Other</option>
                </select>

                <input type="text" name="otherQualification" id="otherQualification"
                       placeholder="Enter your qualification" style="display:none;">
            </div>

            <label>YOP</label>
            <select name="yop" required>
                <option value="">-- Select Year of Passing --</option>
                <%
                    int currentYear = java.time.Year.now().getValue();
                    for (int i = currentYear; i >= 2000; i--) {
                %>
                    <option value="<%= i %>"><%= i %></option>
                <%
                    }
                %>
            </select>

            <input type="submit" value="Submit">
        </form>
    </div>
</div>

<% if(registrationSuccess){ %>
<script>
    document.getElementById('successPopup').style.display = 'block';
    setTimeout(function() {
        document.getElementById('successPopup').style.display = 'none';
    }, 3000);
</script>
<% } %>

</body>
</html>