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
	
		Enter the User's username to edit. 

		<br>
			<form method="post" action="EditAccount.jsp">
			<table>
			<tr>    
			<td>Username</td><td><input type="text" name="username"></td>
			</tr>
			</table>
			<input type="submit" value="Edit">
			</form>
		<br>

</body>
</html>