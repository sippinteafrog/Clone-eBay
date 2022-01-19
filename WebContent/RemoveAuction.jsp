<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
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
    		<form action="RemoveAuctionHandler.jsp" method="POST">
           		<label>Seller</label>
           		<input type="text" name="seller" placeholder="Username" required><br>
            	
            	<label>Enter Your Password</label>
            	<input type="password" name="your_password" placeholder="Enter Password" required> <br>
            	
    			
    			<input type="submit" value="Cancel The Auction">
    		</form>
    		
    	</div>
    <% } %>
</body>
</html>