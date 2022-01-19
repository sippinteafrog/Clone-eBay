<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.DateTimeFormatter,java.time.temporal.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Auction Details</title>
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
	System.out.println("Auction Details Params:");
	while(params.hasMoreElements()){
	 String paramName = params.nextElement();
	 System.out.println("Parameter Name: "+paramName+", Value: "+request.getParameter(paramName));
	}
	
	// item details
	String auctionId = request.getParameter("auctionId");
	if(isInvalid(auctionId)) {
		out.println("Invalid request!  " + auctionId);
	}
	else {
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
					
			//Create a SQL statement
			//Statement stmt = con.createStatement();
			
			String auctionInfoSql = "SELECT * FROM auction JOIN clothes ON auction.itemId = clothes.itemId WHERE auctionId = ?";
			
			PreparedStatement ps = con.prepareStatement(auctionInfoSql);
			
			//insert parameters		
			ps.setString(1, auctionId);
			
			//Run the query against the database.
			ResultSet result = ps.executeQuery();
			
			//no results
			if(!(result.isBeforeFirst())) {
				out.println("No items found.");
			} 
			// got some results
			else {
				if(result.first()) {
					
					String color = result.getString("color");
					String gender = result.getString("gender");
					String type = result.getString("type");
					
					out.println(result.getString("color") + " " + 
		   					result.getString("brand") + " " + 
		   					result.getString("type") +  " | " + 
		   					"Current Bid: $" + result.getString("currentBid") + "<br>" + 
		   					"Ends: " + result.getDate("closeDate"));
					%>
					
					<p>Seller: <%=result.getString("seller")%></p>
					<p><%=(result.getBoolean("isActive") ? "Current Winner: " : "Winner: ") + (result.getString("winner") == null ? "None" : result.getString("winner")) %></p>
					<br>
					<p><b>Item Details</b></p>
					<%
					
					if(type.equals("shirt")) {
						%>
						<p>Half Sleeve: <%=result.getBoolean("isHalfSleeve") ? "Yes" : "No"%></p>
						<p>Material: <%=result.getString("material") == null ? "Unknown" : result.getString("material")%></p>
						<p>Size: <%=result.getString("size") == null ? "Unknown" : result.getString("size")%></p>
						<%
					}
					else if(type.equals("shoes")) {
						%>
						<p>Style: <%=result.getString("style") == null ? "Unknown" : result.getString("style")%></p>
						<p>Size: <%=result.getString("size") == null ? "Unknown" : result.getString("size")%></p>
						<p>Year: <%=result.getInt("year") == 0 ? "Unknown" : result.getInt("year")%></p>
						<%
					}
					else {
						%>
						<p>Shorts: <%=result.getBoolean("isShorts") ? "Yes" : "No"%></p>
						<p>Material: <%=result.getString("material") == null ? "Unknown" : result.getString("material")%></p>
						<p>Waist Size: <%=result.getFloat("waistSize") == 0 ? "Unknown" : result.getFloat("waistSize")%></p>
						<p>Length: <%=result.getFloat("length") == 0 ? "Unknown" : result.getFloat("length")%></p>
						<%
					}
					
					// auction history
					String bidsSql = "SELECT * FROM bid WHERE auctionId = ? ORDER BY amount DESC";
					
					ps = con.prepareStatement(bidsSql);
					
					//insert parameters		
					ps.setString(1, auctionId);
					
					//Run the query against the database.
					result = ps.executeQuery();
					out.println("<br><b>Auction History</b><br>");
					out.println("(most recent bid first)");
					while(result.next()) {
						%>
						<p>User: <%=result.getString("username")%> | Price: <%=result.getString("amount")%></p>
						<%
					}
					
					
					// similar auctions in precending month
					String similarSql = "SELECT * FROM auction JOIN clothes ON auction.itemId = clothes.itemId WHERE (color = ? OR gender = ? OR type = ?) AND auctionId != ? AND closeDate > ?";
					
					ps = con.prepareStatement(similarSql);
					
					//insert parameters		
					ps.setString(1, color);
					ps.setString(2, gender);
					ps.setString(3, type);
					ps.setString(4, auctionId);
					
					DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
					LocalDateTime now = LocalDateTime.now().minus(1, ChronoUnit.MONTHS);
					String dateCap = dtf.format(now);
					ps.setString(5, dateCap);
					
					//Run the query against the database.
					result = ps.executeQuery();
					out.println("<br><b>Similar Auctions</b><br>");
					while(result.next()) {
						out.println(result.getString("color") + " " + 
		   					result.getString("brand") + " " + 
		   					result.getString("type") +  " | " + 
		   					"Current Bid: $" + result.getString("currentBid") + "<br>" + 
		   					"Ends: " + result.getDate("closeDate"));
						%>
		   				<form method="post" action="AuctionDetails.jsp">
		   					<input type='hidden' name='auctionId' id='studentid' value=<%=result.getString("auctionId")%> />
		   					<input type="submit" value="Details">
						</form>
		   				<%
		   				if(result.getBoolean("isActive")) {
		   					%>
			   				<form method="post" action="AuctionDetails.jsp">
			   					<input type='hidden' name='auctionId' id='auctionId' value=<%=result.getString("auctionId")%> />
			   					<input type="submit" value="Bid">
							</form>
			   				<%
		   				}
					}
				}
			}
		}
		catch (Exception e) {
			out.println(e);
		}
	}
	
	// set alerts
	%>
</body>
</html>