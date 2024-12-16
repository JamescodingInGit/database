<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Error403.aspx.cs" Inherits="Assignment.Error403" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>403 Forbidden</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .error-container {
            text-align: center;
            padding: 20px;
            border-radius: 5px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            font-size: 36px;
            color: #ff6347;
        }
        p {
            font-size: 18px;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>403 Forbidden</h1>
        <p>Access to this resource on the server is denied!</p>
    </div>
</body>
</html>