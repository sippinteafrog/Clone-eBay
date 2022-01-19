<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>

<%
	String url = "jdbc:mysql://localhost:3306/AuctionSiteDB";
	PreparedStatement ps = null;
	PreparedStatement pwPs = null;
	ResultSet rs = null;
	Connection conn = null;
	
	try {
		ApplicationDB db = new ApplicationDB();	
		 conn = db.getConnection();	
		
		String username = request.getParameter("username");
		
		String currPassword = request.getParameter("curr_password");

		
		String newPassword = request.getParameter("new_password");
		String confirmNewPassword = request.getParameter("confirm_new_password");
		
	
		String validation = "SELECT password FROM Accounts WHERE username=?";
		pwPs = conn.prepareStatement(validation);
		pwPs.setString(1, username);
		rs = pwPs.executeQuery();
		
		if (rs.next()) {
			String db_password = rs.getString("password");
			if (!currPassword.equals(db_password)) { %>
				
				<jsp:include page="EditAccount.jsp" flush="true"/>
				<div class="content center">
					<h1>
						<br>Error: Current password is incorrect.<br>
						You must enter your correct password to make changes to your account.
					</h1>
				</div>
	    <%    	return;
			} else if (currPassword.equals(newPassword)) { %>
				<jsp:include page="EditAccount.jsp" flush="true"/>
				<div class="content center">
					<h1>
						<br>Error: New password cannot be the same as current password.
					</h1>
				</div>
				<%		return;
			} %>
		<%	} else {
			
			response.sendRedirect("error.jsp");
			return;
		} 
		
		if (!newPassword.equals(confirmNewPassword)) { %>
			<jsp:include page="EditAccount.jsp" flush="true"/>
			<div class="content center">
				<h1>Error: Failed to confirm new password. <br> Make sure you enter it correctly in both fields.</h1>
			</div>
	<%		return;
		} %>
	
	<%	
		String updateAccount = "UPDATE Accounts SET password=? WHERE username=?";
		ps = conn.prepareStatement(updateAccount);
		
		if (newPassword.isEmpty() || newPassword == null) {
			ps.setString(1, currPassword);
		} else {
			ps.setString(1, newPassword);
		}
		ps.setString(2, username);
		int updateResult = 0;
		updateResult = ps.executeUpdate();
		if (updateResult < 1) {
			response.sendRedirect("error.jsp");
			return;
		} else { 
	%>
			<jsp:include page="CustomerRepActionsPage.jsp" flush="true"/>
			<div class="content center">
				<h1>Successfully updated your account settings.</h1>
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