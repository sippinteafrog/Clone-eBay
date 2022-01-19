<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>Listing Creation Status</title>
</head>
<body>
<%

	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//out.println(session.getAttribute("userID"));
		
		
		//Get parameters from the HTML form at the index.jsp
		int auctionId = 0;
		int itemId = Integer.parseInt(request.getParameter("itemId"));
		
		
		float startingBid = Float.parseFloat(request.getParameter("startingBid"));
		//int startingBid = request.getParameter
		
		float currentBid = 0;
		int isActive = 1;
		String closingDate = request.getParameter("closingDate");
		String closingTime = request.getParameter("closingTime");
		
		//String closingDateTime = closingDate + " " + closingTime;
		
		String sellerId = (String) session.getAttribute("userID");
		String winner = null;
		
		//Make a SELECT query from the users table with the given username and password
		String str = "insert into auction values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(str);
		
		//insert parameters
		ps.setInt(1, auctionId);
		ps.setInt(2, itemId);
		ps.setFloat(3, startingBid);
		ps.setFloat(4, currentBid);
		ps.setInt(5, isActive);
		ps.setString(6, closingDate);
		ps.setString(7, closingTime);
		ps.setString(8, sellerId);
		ps.setString(9, winner);
		
		
		//Run the query against the database.
		ps.executeUpdate();
		con.close();
		%>

		Listing created successfully.
		
		<br>
		<br>
					
		<form method="get" action="CreateListingPage.jsp">
	   		<input type="submit" value="Create Another Listing">
		</form>
		<br>
		<br>
		If you wish to log out, you may do so below. 
		<form method="get" action="LogoutPage.jsp">
			<input type="submit" value="Logout">
		</form>
		
		
		<%
		
		
	} catch (Exception e) {
		out.println("Failed to create listing, please go back and try again.");
		out.println(e.toString());
	}

%>


</body>
</html>