<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Results</title>
</head>
<body>

<%!
public boolean isInvalid(String s){
	return s == null || s.length() == 0;
}
%>

	<%
	// debug stuff
	System.out.println("Search results params: ");
	Enumeration<String> params = request.getParameterNames(); 
	while(params.hasMoreElements()){
	 String paramName = params.nextElement();
	 System.out.println("Parameter Name: "+paramName+", Value: "+request.getParameter(paramName));
	}
	System.out.println();
	
	String type = request.getParameter("type");
	String gender = request.getParameter("gender");
	String brand = request.getParameter("brand");
	String color = request.getParameter("color");
	
	String buyer = request.getParameter("buyer");
	String seller = request.getParameter("seller");
	
	String orderBy = request.getParameter("sortBy");
	
	String auctionId = request.getParameter("auctionId");
	
	int maxBiddingPrice = isInvalid(request.getParameter("maxCurrentBid")) ? Integer.MAX_VALUE : Integer.parseInt(request.getParameter("maxCurrentBid"));
	int minBiddingPrice = isInvalid(request.getParameter("minCurrentBid")) ? 0 : Integer.parseInt(request.getParameter("minCurrentBid"));
	
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//Make a SELECT query from the table
		String str = "SELECT * FROM auction JOIN clothes ON auction.itemId = clothes.itemId WHERE 1=1 and currentBid <= ? and currentBid >= ?";
		if(!isInvalid(type)) str = str + " AND type = '" + type + "'";
		if(!isInvalid(gender)) str = str + " AND gender = '" + gender + "'";
		if(!isInvalid(brand)) str = str + " AND brand = '" + brand + "'";
		if(!isInvalid(color)) str = str + " AND color = '" + color + "'";
		if(!isInvalid(buyer)) str = str + " AND winner = '" + buyer  + "'";
		if(!isInvalid(seller)) str = str + " AND seller = '" + seller + "'";
		if(!isInvalid(auctionId)) str = str + " AND auctionId = " + auctionId;
		
		if(isInvalid(orderBy) || orderBy.equals("Alphabetical")) str = str + " ORDER BY brand";
		if(orderBy.equals("priceUp")) str = str + " ORDER BY currentBid ASC";
		if(orderBy.equals("priceDown")) str = str + " ORDER BY currentBid DESC";
		
		// System.out.println(str);
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(str);
		
		//insert parameters		
		ps.setInt(1, maxBiddingPrice);
		ps.setInt(2, minBiddingPrice);
		
		//Run the query against the database.
		ResultSet result = ps.executeQuery();
		
		//no results
		if(!(result.isBeforeFirst())) {
			out.println("No items found.");
		} 
		// got some results
		else {
			while(result.next()) {
				if(result.getBoolean("isActive")) {
					
					String item_gender = result.getString("gender");
					if(item_gender.equals("male")) {
						out.println("Men's");
					}
					else if(item_gender.equals("female")) {
						out.println("Women's");
					}
					else {
						out.println("Unisex");
					}	   				
	   				// lol trash code right here
	   				out.println(result.getString("color") + " " + 
	   					result.getString("brand") + " " + 
	   					result.getString("type") +  " | " + 
	   					"Current Bid: $" + result.getString("currentBid") + "<br>" + 
	   					"Ends: " + result.getDate("closeDate"));
					
	   				%>
	   				<form method="post" action="AuctionDetails.jsp">
	   					<input type='hidden' name='auctionId' id='auctionId' value=<%=result.getString("auctionId")%> />
	   					<input type="submit" value="Details">
					</form>
					
					<form method="post" action="../ManualBidding.jsp"> <%-- TODO MAKE THIS BID PAGE --%>
	   					<input type='hidden' name='auctionId' id='auctionId' value=<%=result.getString("auctionId")%> />
	   					<input type="submit" value="Bid">
					</form>
					<form method="post" action="../AutoBidding/AutoBidding.jsp">
	   					<input type='hidden' name='auctionId' id='auctionId' value=<%=result.getString("auctionId")%> />
	   					<input type="submit" value="Automatic Bid">
					</form>
	   				<%
				}
			}
		}
		con.close();
	} 
	catch (Exception e) {
		out.println(e);
	}
	%>
</body>
</html>