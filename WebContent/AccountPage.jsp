<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Account Page</title>
</head>
<body>
	<%
		//List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Get parameters from the HTML form at the index.jsp
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			if(password == null){ // try to get it from session. in case returning from other page
				password = session.getAttribute("password").toString();
			}
			if(username == null){ // try to get it from session. in case returning from other page
				username = session.getAttribute("userID").toString();
			}
			
			//Make a SELECT query from the users table with the given username and password
			String str = "SELECT * FROM accounts WHERE username = ? and password = ?";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(str);
			
			//insert parameters
			ps.setString(1, username);
			ps.setString(2, password);
			
			//Run the query against the database.
			ResultSet result = ps.executeQuery();
			
			
			//no user found with matching username + password
			if(!(result.isBeforeFirst())) {
				out.println("Unable to login to account, please return to login page and try again.");
				out.println("If you do not have an account already, you may create one there.");
				
				con.close();
						
				%>
				<br>
				<form method="get" action="LoginPage.jsp">
					<input type="submit" value="Return to Login Page">
				</form>
					
				<br>
				</body>
				
				<%
		
			} else {
				//User login sucessful
				result.next();
				String type = result.getString("type");
				
				session.setAttribute("userID", username);
				session.setAttribute("password", password);
				session.setAttribute("type", type);
				
				out.println("Welcome " + username +".");
				
				%>
				<%
				if(type.equals("User")) {
					%>
				<br>
				<br>
					<form method="post" action="CreateListingPage.jsp">
					<input type="submit" value="Create New Listing">
					</form>
					<form method="post" action="Search/SearchSettings.jsp">
					<input type="submit" value="Browse Listings">
					</form>
					
					<form method="post" action="Search/ManageAlerts.jsp">
					<input type='hidden' name='username' id='username' value=<%=result.getString("username")%> />
					<input type="submit" value="Manage Search Alerts">
					</form>
					<form method="post" action="ViewAuctionAlerts.jsp">
					<input type='hidden' name='username' id='username' value=<%=result.getString("username")%> />
					<input type="submit" value="View Auction Alerts">
					</form>
					<form method="post" action="Questions.jsp">
					<input type="submit" value="Ask Questions">
					</form>
				<br>
				
				<%
				} else if(type.equals("Admin")) {
					%>
					<form method="post" action="CreateCustomerRepPage.jsp">
					<input type="submit" value="Create Customer Rep Account">
					</form>
					<form method="post" action="GenerateSalesReportsPage.jsp">
					<input type="submit" value="Generate Sales Reports">
					</form>
					<%
				} else if(type.equals("CustomerRep")) {
					%>
					<form method="post" action="CustomerRepActionsPage.jsp">
					<input type="submit" value="Customer Rep Actions">
					</form>
					<%
				}
				%>
				
				<body>
				<br>
				If you wish to log out, you may do so below. 
				<form method="get" action="LogoutPage.jsp">
					<input type="submit" value="Logout">
				</form>
				</body>
				<%
				
				//close the connection.
				con.close();
			}
		} catch (Exception e) {
		}
	%>
</body>
</html>