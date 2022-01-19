<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>

<%
	String url = "jdbc:mysql://localhost:3306/AuctionSiteDB";;
	Connection conn = null;
	PreparedStatement ps = null;
	
	try {
		ApplicationDB db = new ApplicationDB();	
		conn = db.getConnection();	

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String type = "CustomerRep";
		

		if(  username != null && !username.isEmpty()
				&& password != null && !password.isEmpty()) {
			
			String insert = "INSERT INTO accounts (username, password, type) VALUES(?, ?, ?)";
			ps = conn.prepareStatement(insert);
			
			ps.setString(1, username);
			ps.setString(2, password);
			
			ps.setString(3, type);
			
			
			
			int result = 0;
	        result = ps.executeUpdate();
	        if (result < 1) {
	        	out.println("Error: Registration failed.");
	        } else {
	        	response.sendRedirect("registerSuccess2.jsp");
	        	return;
	        }
		} else {
			response.sendRedirect("registerError.jsp");
			return;
		}
	} catch(Exception e) {
        out.print("<p>Error connecting to MYSQL server.</p>");
        e.printStackTrace();
    } finally {
        try { ps.close(); } catch (Exception e) {}
        try { conn.close(); } catch (Exception e) {}
    }

%>