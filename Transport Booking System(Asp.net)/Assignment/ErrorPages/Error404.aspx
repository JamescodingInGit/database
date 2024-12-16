<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Error404.aspx.cs" Inherits="Assignment.Error404" %>

<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>404 - Page Not Found</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            flex-direction: column;
            text-align: center;
        }

        .error-code {
            font-size: 5em;
            color: #333;
            margin: 0;
        }

        .error-message {
            font-size: 1.5em;
            color: #555;
        }

        .link-back {
            margin-top: 20px;
            text-decoration: none;
            color: #007bff;
        }
    </style>
</head>

<body>
    <h1 class="error-code">404</h1>
    <p class="error-message">Oops! The page you are looking for could not be found.</p>
</body>

</html>

