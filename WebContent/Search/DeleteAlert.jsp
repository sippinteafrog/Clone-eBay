<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.DateTimeFormatter,java.time.temporal.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Alert</title>
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
	System.out.println("Delete Alert Params:");
	while(params.hasMoreElements()){
	 String paramName = params.nextElement();
	 System.out.println("Parameter Name: "+paramName+", Value: "+request.getParameter(paramName));
	}
	
	// item details
	String alertId = request.getParameter("alertId");
	if(isInvalid(alertId)) {
		out.println("Invalid request!  " + alertId);
	}
	else {
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
					
			//Create a SQL statement
			//Statement stmt = con.createStatement();
			
			String delete = "DELETE FROM alertfor WHERE alertId = ?";
			
			PreparedStatement ps = con.prepareStatement(delete);
			
			//insert parameters		
			ps.setString(1, alertId);
			
			//Run the query against the database.
			ps.execute();
			out.println("Successfully deleted alert! You may now return to the Alert management page by pressing the back button on your browser.");
			
		}
		catch (Exception e) {
			out.println(e);
		}
	}
	
	// set alerts
	%>
</body>
</html>