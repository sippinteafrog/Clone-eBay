<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%><!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe - Customer Representative Creation Error</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="content center">
    	<h2>Error: Customer Representative Creation failed. Please enter the correct information and try again.</h2>
        <form action="customerRepHandler.jsp" method="POST">
            
         
            
            <label for="username">Username</label>
            <input type="text" name="username" id="username" placeholder="Username"> <br>
    
            <label>Password</label>
            <input type="password" name="password" placeholder="Password"> <br>
    
           
            <input type="submit" value="Register">
        </form>
    </div>
	
</body>
</html>