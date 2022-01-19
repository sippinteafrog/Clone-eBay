<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>Manual Bid Status</title>
</head>
<body>

	<%
	
	try {
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		//Create a SQL statement
		//Statement stmt = con.createStatement();
		
		//Get parameters from the HTML form at the index.jsp
		int auctionId = Integer.parseInt(request.getParameter("auctionId"));
		String userId = session.getAttribute("userID").toString();
		float newBid = Float.parseFloat(request.getParameter("newBid").toString());
		
		//Make a SELECT query from the users table with the given username and password
		String str = "insert into bid values (?, ?, ?)";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(str);
		
		//insert parameters
		ps.setString(1, userId);
		ps.setInt(2, auctionId);
		ps.setFloat(3, newBid);
		
		ps.execute();
		
		//Statement stmt2 = con.createStatement();
		
		String str2 = "update auction a set a.currentBid = ? where a.auctionId = ?";
		
		PreparedStatement ps2 = con.prepareStatement(str2);
		
		ps2.setFloat(1, newBid);
		ps2.setInt(2, auctionId);
		
		ps2.execute();
		
		
		//Statement stmt3 = con.createStatement();
		
		String str3 = "Select * from bid where bid.auctionId = ? and bid.username <> ?";
		
		PreparedStatement ps3 = con.prepareStatement(str3);
		
		ps3.setInt(1, auctionId);
		ps3.setString(2, userId);
		
		ResultSet result = ps3.executeQuery();
		
		if(!(result.isBeforeFirst())) {
			//no people to alert
		} else {
			while(result.next()) {
				String username = result.getString("username");
				
				//Statement stmt4 = con.createStatement();
				try {
					String str4 = "Replace into auctionalert values (?, ?, 'manual')";
					PreparedStatement ps4 = con.prepareStatement(str4);
					ps4.setString(1, username);
					ps4.setInt(2, auctionId);
					
					ps4.execute();
				} catch(Exception e) {
					//person already has an alert for this item
				}
			}
		}
		

		con.close();
		RunAutoBids.runThem(auctionId);
		
		%>
		
		Bid entered successfully! You will receive an alert if someone out bids you on this item.
		
		<br>
		<br>
		 
		 You will also receive an alert if you win the auction. 
		 
		<br>
		<br>
		
		These alerts can be accessed through the "auction alerts" button on your account page. 
		
		
		<%
		
	} catch(Exception e) {
		out.println(e.toString());
	}
	
	
	%>

</body>
</html>