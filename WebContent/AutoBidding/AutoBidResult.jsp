<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>


<html>
<head>
<meta charset="UTF-8">
<title>Auto Bid Submitted</title>
</head>
<body>
		

<%
	// debug stuff
	System.out.println("Auto bidding params: ");
	Enumeration<String> params = request.getParameterNames(); 
	while(params.hasMoreElements()){
	 String paramName = params.nextElement();
	 System.out.println("Parameter Name: "+paramName+", Value: "+request.getParameter(paramName));
	}
	System.out.println();
	
	try {

		
		String userID = request.getSession().getAttribute("userID").toString();
		String auctionID = request.getParameter("auctionId").toString();
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String query = "select a.isActive from auction a where auctionId = ?";
		PreparedStatement ps = con.prepareStatement(query);
		
		ps.setInt(1, Integer.parseInt(auctionID));
		ResultSet rs = ps.executeQuery();
		if (rs.next()){
			if (!rs.getBoolean("isActive")){
				out.println("Your automatic bid for " + auctionID + " was not submitted because the auction is closed!");
				return;
			}
		}
		else{
			out.println("Your automatic bid for " + auctionID + " was not submitted. That auction could not be found!");
		}

		//Get parameters from the HTML form at the index.jsp
		String upper = request.getParameter("upper");
		String increment = request.getParameter("increment");
		

		//make an insert statement for the users table
		String insert = "replace into automaticbidding values(?, ?, ?, ?)";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		ps = con.prepareStatement(insert);			
		ps.setString(1, userID);
		ps.setInt(2, Integer.parseInt(auctionID));
		ps.setFloat(3, Float.parseFloat(upper));
		ps.setFloat(4, Float.parseFloat(increment));
		//execute command
		ps.executeUpdate();
		
		//Close the connection
		con.close();
		RunAutoBids.runThem(Integer.parseInt(auctionID));
		//output messages
		out.println("Your automatic bid was set..");
		out.println("You can go to your alerts tab to monitor status of your automatic bid");
		
		
		

		CheckAuctions.checkAuctions();

		
	} catch (SQLIntegrityConstraintViolationException e) {
	    // Duplicate entry
	    out.println("Automatic bid not set! You already have an open automatic bid for this item! ");
	} catch (Exception ex) {
		out.println(ex);
		out.println("Failed to create automatic bid.");
		out.print("Please return to the auction page to try again.");
	}
	%>
	
	<form method="post" action="../ViewAuctionAlerts.jsp">
	<input type="submit" value="View Alerts">
	</form>
</body>
</html>