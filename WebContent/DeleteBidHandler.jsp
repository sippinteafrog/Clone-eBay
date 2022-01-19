<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Bid</title>
<link rel="stylesheet" href="style.css?v=1.0"/>
</head>
<body>
<%@ include file="RepNav.jsp" %>
<%
	if(session.getAttribute("userID") == null) { 
		response.sendRedirect("LoginPage.jsp");
	} else {
		String url = "jdbc:mysql://localhost:3306/AuctionSiteDB";
		PreparedStatement ps1 = null;
		try {
			ApplicationDB db = new ApplicationDB();	
			Connection conn = db.getConnection();

			int auctionId = Integer.parseInt(request.getParameter("auctionId"));
			int amount = Integer.parseInt(request.getParameter("amount"));
			String username = request.getParameter("username");
			
			String delete = "delete from Bid where auctionId=? and amount=? and username=?";
			ps1 = conn.prepareStatement(delete);
			ps1.setInt(1, auctionId);
			ps1.setDouble(2, amount);
			ps1.setString(3, username);
			
			int insertResult = 0;
			insertResult = ps1.executeUpdate();
			if (insertResult < 1) {
				response.sendRedirect("RepError.jsp"); 
			} else {
			 %>
				
				<div class="content center">
					<h1>Bid was successfully deleted.</h1>
				</div>
		<%	} %>
		
		<%
		
		String query = "update auction a set currentBid=(select max(amount) from bid b where b.auctionId=? ) where a.auctionId=?";
		ps1 = conn.prepareStatement(query);
		ps1.setInt(1, auctionId);
		ps1.setInt(2, auctionId);

		int updateResult = 0;
		updateResult = ps1.executeUpdate();
		
		if (updateResult < 1) {
			response.sendRedirect("error.jsp");
			return;
			
		} else { 
	%>
			
				<h1>Successfully deleted user's bid.</h1>
			</div>
	<% 	}
		
		String query2 = "update auction a set currentBid=0 where currentBid is NULL";
		ps1 = conn.prepareStatement(query2);
			
			
		} catch(Exception e) {
			out.print("<p>Error connecting to MYSQL server.</p>");
		    e.printStackTrace();
		} finally {
			try { ps1.close(); } catch (Exception e) {}
		}
	}
%>
</body>
</html>