<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
    <link
        href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
        rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Mukta"
        rel="stylesheet">
    <link
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
        rel="stylesheet">
    <style>
        body {
            font-family: 'Mukta', sans-serif;
            height: 100vh;
            background: #dc3545 url(http://www.planwallpaper.com/static/images/Free-Wallpaper-Nature-Scenes.jpg) no-repeat center/cover;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .forgot-password-panel {
            background-color: white;
            width: 40%;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 10px 3px rgba(0, 0, 0, 0.1);
            text-align: center;
            color: #444;
        }

        .forgot-password-panel h2 {
            color: #dc3545;
            margin-bottom: 20px;
        }

        .forgot-password-panel input[type="email"] {
            width: 100%;
            padding: 15px;
            margin: 20px 0;
            border: 1px solid #ccc;
            border-radius: 10px;
            outline: none;
            transition: border-color 0.3s;
        }

        .forgot-password-panel input[type="submit"] {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            transition: background-color 0.3s, color 0.3s;
        }

        .forgot-password-panel input[type="submit"]:hover {
            background-color: #a60000;
        }

        .forgot-password-panel a {
            color: #dc3545;
            text-decoration: none;
            display: inline-block;
            margin-top: 10px;
        }

        .forgot-password-panel a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="forgot-password-panel">
        <h2>Forgot Password</h2>
        <p>Enter your registered email to reset your password</p>
        <form action="forgotPasswordAction.jsp" method="POST" onsubmit="return validateForgotPassword()">
            <input type="email" id="forgot-email" name="email" placeholder="Enter your email">
            <input type="submit" value="Submit">
        </form>
        <a href="log.jsp">Back to Login</a>
    </div>
    <script>
        function validateForgotPassword() {
            var email = document.getElementById("forgot-email").value;
            var emailRegex = /^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$/;
            if (email === '') {
                alert("Please enter your email");
                document.getElementById("forgot-email").focus();
                return false;
            }
            if (!emailRegex.test(email)) {
                alert("Please enter a valid email");
                document.getElementById("forgot-email").focus();
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
