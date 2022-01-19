<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%><!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="style.css?v=1.0"/>
</head>
<body>
   	<%@ include file="AdminNav.jsp" %>
   	<h2>Admin Dashboard</h2>
    	<form method="post" action="CreateCustomerRepPage.jsp">
					<input type="submit" value="Create Customer Rep Account">
					</form>
					<form method="post" action="GenerateSalesReportsPage.jsp">
					<input type="submit" value="Generate Sales Reports">
					</form>
</body>
</html>