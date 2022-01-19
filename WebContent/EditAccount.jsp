<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit User Account</title>
    <link rel="stylesheet" href="style.css?v=1.0"/>
</head>
<body>
           		
    <% if(session.getAttribute("userID") == null) { 
    		response.sendRedirect("LoginPage.jsp");
       } else { %>
    	<%@ include file="RepNav.jsp" %>

    	<%
			String url = "jdbc:mysql://localhost:3306/AuctionSiteDB";
    		PreparedStatement ps = null;
    		ResultSet rs = null;
			
    		String oldPassword = null;
    		String username = request.getParameter("username");
    		
    		
    		
    		try {
    			ApplicationDB db = new ApplicationDB();	
				Connection conn = db.getConnection();
				String accountQuery = "SELECT * FROM Accounts WHERE username=?";
				ps = conn.prepareStatement(accountQuery);
				ps.setString(1, (request.getParameter("username")).toString());
				rs = ps.executeQuery();
				
				if (rs.next()) {
					
					oldPassword = rs.getString("password");
				} else {
					response.sendRedirect("error.jsp");
					return;
				}
				
    		} catch(SQLException e) {
				out.print("<p>Error connecting to MYSQL server.</p>");
		        e.printStackTrace();
			} finally {
				try { rs.close(); } catch (Exception e) {}
				try { ps.close(); } catch (Exception e) {}
			}
    	%>
    	
    	
    	<div class="content">
    		<form action="EditAccountHandler.jsp" method="POST">
    		
            	
            	<label>Username</label>
            	<input type="text" name="username" value="<%= username %>" placeholder="username"> <br>
    
            	<label>Current Password</label>
            	<input type="password" name="curr_password" placeholder="Current Password" required> <br>
            	
            	<label>New Password</label>
            	<input type="password" name="new_password" placeholder="New Password"> <br>
            	
            	<label>Confirm New Password</label>
            	<input type="password" name="confirm_new_password" placeholder="Confirm Password"> <br>
    			
    			<input type="submit" value="Update Account Settings">
    		</form>
    	
    	
    	</div>
    <% } %>
</body>
</html>