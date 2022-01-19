<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Alerts</title>
</head>
<body>


	<%
	// debug stuff
	System.out.println("Manage Alerts params: ");
	Enumeration<String> params = request.getParameterNames(); 
	while(params.hasMoreElements()){
	 String paramName = params.nextElement();
	 System.out.println("Parameter Name: "+paramName+", Value: "+request.getParameter(paramName));
	}
	System.out.println();
	CheckAuctions.checkAuctions();
	
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		// current alerts
		out.println("<b>Current Alerts for " + request.getSession().getAttribute("userID").toString() + " :</b><br>");
		
		//Make a SELECT query from the table
		String str = "SELECT * from auctionalert where auctionalert.username = ?";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(str);
		
		//insert parameters		
		ps.setString(1, request.getSession().getAttribute("userID").toString());
		//System.out.println(ps);
		//Run the query against the database.
		ResultSet result = ps.executeQuery();
		
		//no results
		if(!(result.isBeforeFirst())) {
			out.println("No Alerts found.");
		} 
		// got some results
		else {
			while(result.next()) {
				String alertType = result.getString("type");
				if (alertType.equals("auto")){
					str = "SELECT * from automaticbidding where username = ? and "
							+ "auctionId = ?";
					ps = con.prepareStatement(str);
					ps.setString(1, request.getSession().getAttribute("userID").toString());
					ps.setInt(2, result.getInt("auctionId"));
					ResultSet autobidresult = ps.executeQuery();
					float maxBid;
					if(autobidresult.next()) {
						maxBid = autobidresult.getFloat("maxPrice");
					} 
					else{
						continue;
					}
					// alert that the user's auto bid was exceeded
					out.println(String.format("Your automatic bid with max of %.2f for auction id %s was exceeded.<br>", maxBid, 
							result.getString("auctionId")));
				}
				else if (alertType.equals("win")){
					out.println(String.format("You won the auction ID: %s !<br>",result.getString("auctionId")));

				}
				else{
					// alert that someone placed a higher bid than this user
					out.println(String.format("Your bid for auction id %s was exceeded.<br>", result.getString("auctionId")));
					
				}
			}
		}
		con.close();
	}
	catch (Exception e) {
		out.println(e);
	}
	%>
	<br>
	<button type="button" onClick="window.location.reload();">Reload your alerts</button><br>
	<a href="Search/SearchSettings.jsp">Back to Search</a>
	<a href="AccountPage.jsp">Back to Account Page</a>
	
	
	
</body>
</html>