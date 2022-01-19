<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%><%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe - Register</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<%@ include file="AdminNav.jsp" %>
	<% if (session.getAttribute("userID") == null) { 
			response.sendRedirect("LoginPage.jsp");
    	
       } else { 
			String url = "jdbc:mysql://localhost:3306/AuctionSiteDB";
			//Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
		   	try {
		   		ApplicationDB db = new ApplicationDB();	
				Connection conn = db.getConnection();	
				
				String user = (session.getAttribute("userID")).toString();
				String accountQuery = "SELECT * FROM accounts WHERE username=?";
				
				ps = conn.prepareStatement(accountQuery);
				ps.setString(1, user);
				rs = ps.executeQuery();
				rs.next();
				
			} catch (SQLException e) {
				out.print("<p>Error connecting to MYSQL server.</p>");
			    e.printStackTrace();
			} finally {
				try { rs.close(); } catch (Exception e) {} 
				try { ps.close(); } catch (Exception e) {} 
				//try { conn.close(); } catch (Exception e) {} 
			} %>
	    
		    <div class="content center">
		    	<h2>Create a Customer Representative account</h2>
		        <form action="customerRepHandler.jsp" method="POST">
		           
		            
		            <label for="username">Username</label>
		            <input type="text" name="username" id="username" placeholder="Username"> <br>
		    
		            <label>Password</label>
		            <input type="password" name="password" placeholder="Password"> <br>
		    
		           
		    
		            <input type="submit" value="Create Account">
		        </form>
	   		</div>
	<% } %>
</body>
</html>