<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%><!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe - Error</title>
    <link rel="stylesheet" href="style.css?v=1.0"/>
</head>
<body>
    <% if(session.getAttribute("userID") == null) { 
    		response.sendRedirect("LoginPage.jsp");
       } else { %>
    	<div class="content">
    		<h2>Well this is embarrassing! Something went wrong.</h2>
    	</div>
    <% } %>
</body>
</html>