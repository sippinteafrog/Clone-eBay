<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Delete Bid</title>
<link rel="stylesheet" href="style.css?v=1.0"/>
</head>
<body> 	
 	
 	<% if (session.getAttribute("userID") == null) { 
    		response.sendRedirect("LoginPage.jsp");
       } else { %>
    	<%@ include file="RepNav.jsp" %>
    	<div class="content">
    	<%
	    	String url = "jdbc:mysql://localhost:3306/AuctionSiteDB";
			Statement s = null;
    		ResultSet rs = null;
    	
    		try {
    			ApplicationDB db = new ApplicationDB();	
				Connection conn = db.getConnection();
				Locale locale = new Locale("en", "US");
				NumberFormat currency = NumberFormat.getCurrencyInstance(locale);
				String allAuctionsQuery = "select * from Auction a, Clothes c where isActive=true and a.itemId=c.itemId";
				s = conn.createStatement();
				rs = s.executeQuery(allAuctionsQuery);
				if (rs.next()) { %>
					<h2>All Live Auctions</h2>
					<table>
						<tr>
							<th>Item</th>
							<th>Seller</th>
							<th>Current Bid</th>
							<th>End Date</th>
						</tr>
						<%	do { %>
						<tr>
							<td>
								<a href="AuctionSelect.jsp?auctionId=<%= rs.getInt("auctionId") %>">
									<%= rs.getString("c.brand") + " " + rs.getString("c.type") + " " + rs.getString("c.gender") +  " " + rs.getString("c.size") %>
								</a>
							</td>
							<td><%= rs.getString("seller") %></td>
							<td><%= currency.format(rs.getDouble("currentBid")) %></td>
							<td><%= rs.getString("closeDate") %></td>
						</tr>
				 <%		} while (rs.next()); %> 
					</table>
				<%	} else { %>
						<br><h3>There are currently no live auctions.</h3>
				<%	} %>		
			<%	
			
				
				
    		} catch (SQLException e){
    			out.print("<p>Error connecting to MYSQL server.</p>");
			    e.printStackTrace();    			
    		} finally {
				try { rs.close(); } catch (Exception e) {} 
				try { s.close(); } catch (Exception e) {} 
    		}   	
    	%>
    	</div>
    <% } %>
</body>
</html>