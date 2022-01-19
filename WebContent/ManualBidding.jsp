<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>Bid Details Page</title>
</head>
<body>
<%
	
try {
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	
	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	//Get parameters from the HTML form at the index.jsp
	int auctionId = Integer.parseInt(request.getParameter("auctionId"));
	//String userId = session.getAttribute("userID").toString();
	
	//Make a SELECT query from the users table with the given username and password
	String str = "SELECT * FROM auction WHERE auctionId = ?";
	
	//Create a Prepared SQL statement allowing you to introduce the parameters of the query
	PreparedStatement ps = con.prepareStatement(str);
	
	//insert parameters
	ps.setInt(1, auctionId);
	
	//Run the query against the database.
	ResultSet result = ps.executeQuery();
	
	if(!(result.isBeforeFirst())) {
		out.println("An error occured, please go back and try again.");
		
	} else {
		result.next();
		Float currentBid = result.getFloat("currentBid");
					
		%>
		
		This items highest current bid is $<%out.print(currentBid);%>
		<br>
		<br>
		Please enter your bid below.
		<br>
		<br>
		
		<form method="post" action="ManualBidStatus.jsp">
			<input type="hidden" name="auctionId" id="auctionID" value=<%=auctionId%>>  
	   		<input type="number" min="<%=currentBid+.01%>" name="newBid" step=".01">
	   		<input type="submit" value="Submit Bid">
		</form>
				
		<%
	}	
	
	con.close();
	
} catch (Exception e) {
	out.println("An error occured, please go back and try again.");
}

%>
	
	

</body>
</html>