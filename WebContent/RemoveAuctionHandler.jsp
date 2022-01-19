<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Auction</title>
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
		Connection conn = null;
		try {
			ApplicationDB db = new ApplicationDB();	
			 conn = db.getConnection();	

			int auctionId = Integer.parseInt(request.getParameter("auctionId"));
			String seller = request.getParameter("seller");
			
			String delete = "delete from Auction where auctionId=? and seller=?";
			ps1 = conn.prepareStatement(delete);
			ps1.setInt(1, auctionId);
			ps1.setString(2, seller);
			
			int insertResult = 0;
			insertResult = ps1.executeUpdate();
			if (insertResult < 1) {
				response.sendRedirect("RepError.jsp"); 
			} else {
			 %>
				
				<div class="content center">
					<h1>Auction was successfully deleted.</h1>
				</div>
		<%	}
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