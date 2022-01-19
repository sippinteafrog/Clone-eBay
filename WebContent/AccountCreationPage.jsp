<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Account Creation Status Page</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the index.jsp
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		//make an insert statement for the users table
		String insert = "insert into accounts values(?, ?, 'User')";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);
				
		//insert parameters
		ps.setString(1, username);
		ps.setString(2, password);
		
		//execute command
		ps.executeUpdate();
		
		//Close the connection
		con.close();
		
		//output messages
		out.println("Account Created.");
		out.print("Please return to the login page to log into your new account.");
		
	} catch (SQLIntegrityConstraintViolationException e) {
	    // Duplicate entry
	    out.println("An account with this info already exists.");
	    out.println("Please return to the login page and login.");
	} catch (Exception ex) {
		//out.println(ex);
		out.println("Failed to create account.");
		out.print("Please return to the login page to try again.");
	}
%>

	<br>
		<form method="get" action="LoginPage.jsp">
			<input type="submit" value="Return to Login Page">
		</form>
	<br>
</body>
</html>