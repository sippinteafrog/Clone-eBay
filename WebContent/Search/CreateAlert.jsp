<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.DateTimeFormatter,java.time.temporal.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Alert</title>
</head>
<body>

<%!
public boolean isInvalid(String s){
	return s == null || s.length() == 0;
}

%>

	<%
	// debug request params
	Enumeration<String> params = request.getParameterNames(); 
	System.out.println("Create Alert Params:");
	while(params.hasMoreElements()){
	 String paramName = params.nextElement();
	 System.out.println("Parameter Name: "+paramName+", Value: "+request.getParameter(paramName));
	}

	if(isInvalid(request.getParameter("color")) &&
		isInvalid(request.getParameter("gender")) &&
		isInvalid(request.getParameter("brand")) &&
		isInvalid(request.getParameter("type"))) {
	
		out.println("Invalid request!");
	}
	else {
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
					
			//Create a SQL statement
			//Statement stmt = con.createStatement();
			
			String create = "INSERT INTO alertfor(username, color, brand, gender, type) VALUES(?, ?, ?, ?, ?)";
			
			
			PreparedStatement ps = con.prepareStatement(create);
			//insert parameters		
			ps.setString(1, request.getParameter("username"));
			ps.setString(2, request.getParameter("color"));
			ps.setString(3, request.getParameter("brand"));
			ps.setString(4, request.getParameter("gender"));
			ps.setString(5, request.getParameter("type"));
			
			//Run the query against the database.
			ps.execute();
			out.println("Successfully created alert! You may now return to the Alert management page by pressing the back button on your browser.");
			
		}
		catch (Exception e) {
			out.println(e);
		}
	}
	
	// set alerts
	%>
</body>
</html>