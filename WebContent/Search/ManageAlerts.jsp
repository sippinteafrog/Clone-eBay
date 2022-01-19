<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Alerts</title>
</head>
<body>

<%!
public boolean isInvalid(String s){
	return s == null || s.length() == 0;
}
%>

	<%
	// debug stuff
	System.out.println("Manage Alerts params: ");
	Enumeration<String> params = request.getParameterNames(); 
	while(params.hasMoreElements()){
	 String paramName = params.nextElement();
	 System.out.println("Parameter Name: "+paramName+", Value: "+request.getParameter(paramName));
	}
	System.out.println();
	
	
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		// current alerts
		out.println("<b>Your current Alerts:</b><br>");
		
		//Make a SELECT query from the table
		String str = "SELECT * FROM alertfor WHERE username = ?";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(str);
		
		//insert parameters		
		ps.setString(1, request.getParameter("username"));
		System.out.println(ps);
		//Run the query against the database.
		ResultSet result = ps.executeQuery();
		
		//no results
		if(!(result.isBeforeFirst())) {
			out.println("No Alerts found.");
		} 
		// got some results
		else {
			while(result.next()) {
				
				// print alert fields
				if(!isInvalid(result.getString("type"))) out.println("Type: "+ result.getString("type") + "<br>");
				if(!isInvalid(result.getString("gender"))) out.println("Gender: "+ result.getString("gender") + "<br>");
				if(!isInvalid(result.getString("brand"))) out.println("Brand: "+ result.getString("brand") + "<br>");
				if(!isInvalid(result.getString("color"))) out.println("Color: "+ result.getString("color") + "<br>");
				
				out.println("Auctions Matching Alert: <br>");
				
				// check if auctions exist that match alert
				String clothesSql = "SELECT * FROM auction JOIN clothes ON auction.itemId = clothes.itemId WHERE isActive = True";
				if(!isInvalid(result.getString("type"))) clothesSql = clothesSql + " AND type = '" + result.getString("type") + "'";
				if(!isInvalid(result.getString("gender"))) clothesSql = clothesSql + " AND gender = '" + result.getString("gender") + "'";
				if(!isInvalid(result.getString("brand"))) clothesSql = clothesSql + " AND brand = '" + result.getString("brand") + "'";
				if(!isInvalid(result.getString("color"))) clothesSql = clothesSql + " AND color = '" + result.getString("color") + "'";
				
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				ps = con.prepareStatement(clothesSql);
				
				//Run the query against the database.
				ResultSet clothesResult = ps.executeQuery();
				while(clothesResult.next()) {
					if(clothesResult.getBoolean("isActive")) {
						
						String item_gender = clothesResult.getString("gender");
						if(item_gender.equals("male")) {
							out.println("Men's");
						}
						else if(item_gender.equals("female")) {
							out.println("Women's");
						}
						else {
							out.println("Unisex");
						}	   				
		   				// lol trash code right here
		   				out.println(clothesResult.getString("color") + " " + 
		   					clothesResult.getString("brand") + " " + 
		   					clothesResult.getString("type") +  " | " + 
		   					"Current Bid: $" + clothesResult.getString("currentBid") + "<br>" + 
		   					"Ends: " + clothesResult.getDate("closeDate"));
						
		   				%>
		   				<form method="post" action="AuctionDetails.jsp">
		   					<input type='hidden' name='auctionId' id='auctionId' value=<%=clothesResult.getString("auctionId")%> />
		   					<input type="submit" value="Details">
						</form>
						
						<form method="post" action="AuctionDetails.jsp">
		   					<input type='hidden' name='auctionId' id='auctionId' value=<%=clothesResult.getString("auctionId")%> />
		   					<input type="submit" value="Bid">
						</form>
		   				<%
					}
				}
				
				%>
				<form method="post" action="DeleteAlert.jsp">
		   			<input type='hidden' name='alertId' id='alertId' value=<%=result.getInt("alertId")%> />
		   			<input type="submit" value="Delete Alert">
				</form>
				<%
				
			}
		}
		
		// create new alert
		out.println("<br><br><b>Create new alert:</b>");
		out.println("<br>Alerts will notify you when an item you are interested in goes on sale. To check your alerts, just visit this page!");
		out.println("<br>If you don't care about a certain field, just leave it blank.");
		%>
		<form method="post" action="CreateAlert.jsp">
	<input type="radio" id="pants" name="type" value="pants">
	<label for="pants">Pants</label><br>
	
	<input type="radio" id="shirts" name="type" value="shirt">
	<label for="shirts">Shirts</label><br>
	
	<input type="radio" id="shoes" name="type" value="shoes">
	<label for="shoes">Shoes</label><br>
	
	<br>
	Gender
	<br>
	<input type="radio" id="male" name="gender" value="male">
	<label for="male">Men's</label><br>
	
	<input type="radio" id="female" name="gender" value="female">
	<label for="female">Women's</label><br>
	
	<input type="radio" id="unisex" name="gender" value="unisex">
	<label for="unisex">Unisex</label><br>
	
	<table>
		<tr>
		<td>Brand</td><td><input type="text" name="brand"></td>
		</tr>
		<tr>
		<td>Color</td><td><input type="text" name="color"></td>
		</tr>
	</table>
	<br>
	<input type='hidden' name='username' id='username' value=<%=request.getParameter("username")%> />
	<input type="submit" value="Create Alert">
	</form>
		<%		
		con.close();
	} 
	catch (Exception e) {
		out.println(e);
	}
	%>
</body>
</html>