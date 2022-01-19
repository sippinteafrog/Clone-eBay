<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>	<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe - Sales Reports</title>
    <link rel="stylesheet" href="style.css?v=1.0"/>
</head>
<body>
    <% if(session.getAttribute("userID") == null) {
    		response.sendRedirect("LoginPage.jsp");
       } 
   			
    Connection conn = null;
    	   	String reportType = request.getParameter("type"); %>	
    	<%@ include file="AdminNav.jsp" %>
    	<div class="content">
	    <%	
		    String url = "jdbc:mysql://localhost:3306/AuctionSiteDB";
			PreparedStatement ps = null;
			ResultSet rs = null;
			 conn = null;
		
			
			Locale locale = new Locale("en", "US");
			NumberFormat currency = NumberFormat.getCurrencyInstance(locale);
			
			try {
				ApplicationDB db = new ApplicationDB();	
				conn = db.getConnection();	
				
				
				String query = null;
				
				
		    	if (reportType.equals("totalEarnings")) {
		    		query = "SELECT SUM(currentBid) FROM auction WHERE isActive=false";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report: Total Earnings</h2>
		    			<table>
		    				<tr>
		    					<th>Total Earnings</th>
		    				</tr>	
		    		<%	do { %>
		    				<tr>
		    					<td><%= currency.format(rs.getDouble("SUM(currentBid)")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    			</table>
		    			<br><a href="GenerateSalesReportsPage.jsp"> Click here to generate other sales reports.</a>
		    	<%	}		    		
		    	} else if (reportType.equals("earningsPerItem")) {
		    		query = "select c.brand, sum(a.currentBid) from auction a, clothes c where a.itemId=c.itemId and a.isActive=false group by brand;";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report: Earnings Per Item</h2>
		    			<table>
		    				<tr>
		    					<th>Brands</th>
		    					<th>Earnings</th>
		    				</tr>
		    		<%	do { %>
		    				<tr>
		    					<td><%= rs.getString("c.brand") %></td>
		    					<td><%= currency.format(rs.getDouble("SUM(a.currentBid)")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    		</table>
		    		<br><a href="GenerateSalesReportsPage.jsp">Click here to generate more sales reports.</a>
		    	<%	}
		    	} else if (reportType.equals("earningsPerItemType")) {
		    		query = "select c.type, sum(a.currentBid) from auction a, clothes c where a.itemId=c.itemId and a.isActive=false group by type;";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report: Earnings Per Item Type</h2>
		    			<table>
		    				<tr>
		    					<th>Item-Type</th>
		    					<th>Earnings</th>
		    				</tr>
		    		<%	do { %>
		    				<tr>
		    					<td><%= rs.getString("c.type") %></td>
		    					<td><%= currency.format(rs.getDouble("SUM(a.currentBid)")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    		</table>
		    		<br><a href="GenerateSalesReportsPage.jsp">Click here to generate more sales reports.</a>
		    	<%	}
		    	} else if (reportType.equals("earningsPerEndUser")) {
		    		query = "SELECT seller, SUM(currentBid) FROM auction WHERE isActive=false GROUP BY seller";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report: Earnings Per End-User</h2>
		    			<table>
		    				<tr>
		    					<th>User</th>
		    					<th></th>
		    					<th>Earnings</th>
		    				</tr>
		    		<%	do { %>
		    				<tr>
		    					<td><%= rs.getString("seller") %></td>
		    					<td></td>
		    					<td><%= currency.format(rs.getDouble("SUM(currentBid)")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    		</table>
		    		<br><a href="GenerateSalesReportsPage.jsp">Click here to generate more sales reports.</a>
		    	<%	}
		    	} else if (reportType.equals("bestSelling")) {
		    		query = "SELECT c.type, c.brand, COUNT(c.brand), SUM(a.currentBid) FROM auction a, clothes c WHERE a.isActive=false and a.itemId=c.itemId GROUP BY c.brand, c.type order by count(c.brand) desc LIMIT 5";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report: Best Selling Item</h2>
		    			<table>
		    				<tr>
		    					<th>Item Type</th>
		    					<th>Brand</th>
		    					<th>Number Sold</th>
		    					<th> Earnings</th>
		    				</tr>
		    		<%	do { %>
		    				<tr>
		    					<td><%= rs.getString("c.type") %></td>
		    					<td><%= rs.getString("c.brand") %></td>
		    					<td><%= rs.getInt("COUNT(c.brand)") %></td>
		    					<td><%= currency.format(rs.getDouble("SUM(a.currentBid)")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    	
		    		</table>
		    		<br><a href="GenerateSalesReportsPage.jsp">Click here to generate more sales reports.</a>
		    	<%	}
		    	} else if (reportType.equals("bestBuyers")) {
		    		query = "SELECT winner, COUNT(winner), SUM(currentBid) FROM auction where isActive=false GROUP BY winner ORDER BY COUNT(winner) DESC";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report: Best Buyers</h2>
		    			<table>
		    				<tr>
		    					<th>Buyer</th>
		    					<th>Number of purchases</th>
		    					<th>Total amount spent</th>
		    				</tr>
		    		<%	do { %>
		    				<tr>
		    					<td><%= rs.getString("winner") %></td>
		    					<td><%= rs.getInt("COUNT(winner)") %></td>
		    					<td><%= currency.format(rs.getDouble("SUM(currentBid)")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    		</table>
		    		<br><a href="GenerateSalesReportsPage.jsp">Click here to generate more sales reports.</a>
		    	<% }
		    	} else {
		    		response.sendRedirect("error.jsp");
		    		return;
		    	}
			} catch (SQLException e) {
				out.print("<p>Error connecting to MYSQL server.</p>");
			    e.printStackTrace();
			} finally {
				try { rs.close(); } catch (Exception e) {}
				try { ps.close(); } catch (Exception e) {}
			}
	    %>	
    	</div>
   
</body>
</html>