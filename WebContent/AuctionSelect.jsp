<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%><%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe</title>
    <link rel="stylesheet" href="style.css?v=1.0"/>
</head>
<body>
    <% if(session.getAttribute("userID") == null) { 
    		response.sendRedirect("LoginPage.jsp");
       } else { %>
    	<%@ include file="RepNav.jsp" %>
    	<div class="content">
			<%
				String url = "jdbc:mysql://localhost:3306/AuctionSiteDB";
				Connection conn = null;
				PreparedStatement ps1 = null;
				PreparedStatement ps3 = null;

				ResultSet rs = null;
				ResultSet bids2 = null;
				
				boolean isStartingBid = false;
				
				try {
					ApplicationDB db = new ApplicationDB();	
					conn = db.getConnection();	
				
					String user = session.getAttribute("userID").toString();
					int auctionId = Integer.parseInt(request.getParameter("auctionId"));
		    	   	String type = request.getParameter("type"); 
		    	 
					String productQuery = "select * from Auction a, clothes c where a.itemId=c.itemId and auctionId=?";
					ps1 = conn.prepareStatement(productQuery);
					ps1.setInt(1, auctionId);
					
					rs = ps1.executeQuery();
					if (!rs.next()) {
						response.sendRedirect("error.jsp"); 
						return;
					} 
			%>
				
				
				
				<h2>Auction Category: <%= rs.getString("c.type") %></h2> <br>
				Brand: <%= rs.getString("c.brand") %> <br>
			
				Size: <%= rs.getString("c.gender") %> <%= rs.getString("c.size") %> <br>
				Color: <%= rs.getString("c.color") %> <br>
				Seller: <%= rs.getString("a.seller") %> <br>
				End Date/Time: <%= rs.getString("a.closeDate") %> <br>
				
				<%  %>
							<form action="RemoveAuctionHandler.jsp?auctionId=<%= auctionId %>&seller=<%= rs.getString("seller") %>" method="POST">
								<br><input type="submit" value="Delete auction">
							</form>
					<%  
					Locale locale = new Locale("en", "US");
					NumberFormat currency = NumberFormat.getCurrencyInstance(locale);
					
				
					String bidQuery = "SELECT * FROM Bid WHERE auctionId=? order by amount DESC";
						ps3 = conn.prepareStatement(bidQuery);
						ps3.setInt(1, auctionId);
						
						bids2 = ps3.executeQuery();
						if (bids2.next()) { 
					%>
							<h2>Bid History</h2>
							<p style="font-size: 10pt;">
					--Please select the bid you would like to delete--</p>
							<table>
								<tr>
									<th>Bidder</th>
									<th>Bid Amount</th>
								</tr>
						<%	do { %>
								<tr>
									<td><%= bids2.getString("username") %></td>
									<td>
								<a href="DeleteBidHandler.jsp?auctionId=<%= rs.getInt("auctionId") %>&amount=<%= (bids2.getInt("amount"))%>&username=<%= bids2.getString("username") %>">
									<%= currency.format(bids2.getInt("amount")) %>
								</a>
								
							</td>
									
								</tr>
						<%	} while (bids2.next()); %>
							</table>		
					<%	} else { %>
							<h2>There are currently no bids for this auction.</h2> <br>
					<%	} 
					
					
					
										
				} catch(SQLException e) {
					out.print("<p>Error connecting to MYSQL server.</p>");
			        e.printStackTrace();
				} finally {
					try { rs.close(); } catch (Exception e) {}
					
			        try { conn.close(); } catch (Exception e) {}
				}
			%>
    	</div> 	        
    <% } %>
</body>
</html>