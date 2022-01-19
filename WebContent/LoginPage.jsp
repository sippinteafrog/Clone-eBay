<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Account Login Page</title>
	</head>
	
	<body>
	
		If you already have an account, you may log in below.

		<br>
			<form method="post" action="AccountPage.jsp">
			<table>
			<tr>    
			<td>Username</td><td><input type="text" name="username"></td>
			</tr>
			<tr>
			<td>Password</td><td><input type="password" name="password"></td>
			</tr>
			</table>
			<input type="submit" value="Login">
			</form>
		<br>
		
		
		If you would like to create an account, please enter a username and password below.
		
		<br>
			<form method="post" action="AccountCreationPage.jsp">
			<table>
			<tr>    
			<td>Username</td><td><input type="text" name="username"></td>
			</tr>
			<tr>
			<td>Password</td><td><input type="password" name="password"></td>
			</tr>
			</table>
			<input type="submit" value="Create Account">
			</form>
		<br>

</body>
</html>