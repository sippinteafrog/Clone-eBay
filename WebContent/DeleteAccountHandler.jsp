<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%><%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>

<%
	String url = "jdbc:mysql://localhost:3306/AuctionSiteDB";
	PreparedStatement ps = null;
	PreparedStatement ps2 = null;
	PreparedStatement pwPs = null;
	ResultSet rs = null;
	Connection conn = null;
	try {
		ApplicationDB db = new ApplicationDB();	
		conn = db.getConnection();
		
		String user = (session.getAttribute("userID")).toString();
		String deletedAccount = request.getParameter("deleted_account");
		String yourPassword = request.getParameter("your_password");
		String confirmYourPassword = request.getParameter("confirm_your_password");
	
		String validation = "SELECT password FROM Accounts WHERE username=?";
		pwPs = conn.prepareStatement(validation);
		pwPs.setString(1, user);
		rs = pwPs.executeQuery();
		
		if (rs.next()) {
			String db_password = rs.getString("password");
			if (!yourPassword.equals(db_password)) { %>
				<jsp:include page="DeleteAccount.jsp" flush="true"/>
				<div class="content center">
					<h1>
						<br>Error: Current password is incorrect.<br>
						Make sure you enter your password correctly in both fields to confirm deletion of account.
					</h1>
				</div>
	    <%    	return;
			}
		} else {
			
			response.sendRedirect("error.jsp");
			return;
		}
		
		if (!yourPassword.equals(confirmYourPassword)) { %>
			<jsp:include page="DeleteAccount.jsp" flush="true"/>
			<div class="content center">
				<h1>Error: Failed to confirm your password. <br> Make sure you enter your password correctly in both fields to confirm deletion of account.</h1>
			</div>
	<%		return;
		} %>
	
	<%	
	
		String query = "Delete from Accounts WHERE username=?";
		ps = conn.prepareStatement(query);
		ps.setString(1, deletedAccount);

		int updateResult = 0;
		updateResult = ps.executeUpdate();
		
		if (updateResult < 1) {
			response.sendRedirect("error.jsp");
			return;
			
		} else { 
	%>

				<h1>Successfully deleted user's account.</h1>
			</div>
	<% 	}
		
		
	} catch(Exception e) {
		out.print("<p>Error connecting to MYSQL server.</p>");
	    e.printStackTrace();
	} finally {
		try { rs.close(); } catch (Exception e) {}
		try { ps.close(); } catch (Exception e) {}
		try { pwPs.close(); } catch (Exception e) {}
        try { conn.close(); } catch (Exception e) {}
	}
%>