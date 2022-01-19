<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.time.LocalTime" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Listing Details</title>
</head>
<body>

<% 
	try {
		
		LocalTime myObj = LocalTime.now();
		String currentTime = myObj.toString();
		currentTime = currentTime.substring(0, 5);
		
		SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date(System.currentTimeMillis());
		String dateString = formatter.format(date);
		
		/*
		Date tomorrowDate = new Date(System.currentTimeMillis());
		int dayNum = tomorrowDate.getDate() + 1;
		tomorrowDate.setDate(dayNum);
		String nextDayDateString = formatter.format(tomorrowDate);
		*/
		
		//out.println(dateString);

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the index.jsp
		String color = request.getParameter("color");
		String brand = request.getParameter("brand");
		String gender = request.getParameter("gender");
		String type = request.getParameter("type");
		
		String insert = "insert into clothes values(0, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS);
		ps.setString(1, color);
		ps.setString(2, brand);
		ps.setString(3, gender);
		ps.setString(4, type);
		
		String itemID = "";
		
		if(type.equals("shirt")) {
			ps.setString(8, null);
			ps.setString(9, null);
			ps.setString(10, null);
			ps.setString(11, null);
			ps.setString(12, null);
			Boolean isShortSleeved = request.getParameter("isShortSleeved").equals("true");
			int isHalfSleeved = 0;
			if(isShortSleeved) {
				isHalfSleeved = 1;
			}
			
			String material = request.getParameter("material");
			String size = request.getParameter("size");
			ps.setInt(5, isHalfSleeved);
			ps.setString(6, material);
			ps.setString(7, size);
			
			ps.executeUpdate();
			
			ResultSet generatedKey = ps.getGeneratedKeys();
			generatedKey.next();
			itemID = String.valueOf(generatedKey.getInt(1));
			//out.println(itemID);
			
		} else if(type.equals("shoes")) {
			
			ps.setString(5, null);
			ps.setString(6, null);
			ps.setString(10, null);
			ps.setString(11, null);
			ps.setString(12, null);
			
			String size = request.getParameter("size");
			String style = request.getParameter("style");
			
			ps.setString(7, size);
			ps.setString(8, style);
			
			String yearString = request.getParameter("year");
			if(yearString.equals("")) {
				ps.setString(9, null);
			} else {
				int year = Integer.parseInt(yearString);
				ps.setInt(9, year);
			}
			
			ps.executeUpdate();
			
			ResultSet generatedKey = ps.getGeneratedKeys();
			generatedKey.next();
			itemID = String.valueOf(generatedKey.getInt(1));
			//out.println(itemID);
			
		} else {
			ps.setString(5, null);
			String material = request.getParameter("material");
			ps.setString(6, material);
			ps.setString(7, null);
			ps.setString(8, null);
			ps.setString(9, null);
			
			Boolean isShorts = request.getParameter("isShorts").equals("true");
			int isHalfLength = 0;
			if(isShorts) {
				isHalfLength = 1;
			}
			
			ps.setInt(10, isHalfLength);
			
			String waistString = request.getParameter("waistSize");
			String lengthString = request.getParameter("length");
			
			if(waistString.equals("")) {
				ps.setString(11, null);
			} else {
				float waistSize = Float.parseFloat(waistString);
				ps.setFloat(11, waistSize);
			}
			
			if(lengthString.equals("")) {
				ps.setString(12, null);
			} else {
				float length = Float.parseFloat(lengthString);
				ps.setFloat(12, length);
			}
			
			ps.executeUpdate();
			
			ResultSet generatedKey = ps.getGeneratedKeys();
			generatedKey.next();
			itemID = String.valueOf(generatedKey.getInt(1));
			//out.println(itemID);
		}
	
		//Close the connection
		con.close();
		
		out.print("Please enter the following information for your listing.");
				
		%>
		
		<br>
	
		<form method="post" action="ListingCreationStatusPage.jsp">
	
			<input type ="hidden" name="itemId" id="itemID" value=<%=itemID%>>
		
			<table>
				<tr>    
					<td>Reserve Price</td><td><input type="number" name="startingBid" min="0" step=".01" value="0"></td>
				</tr>
			</table>
			<label for="closingDate">Closing Date ("YYYY-MM-DD"):</label>

			<input type="date" id="closingDate" name="closingDate"
       				value=<%=dateString%>
       				min=<%=dateString%>>
			<br>
			<label for="closingTime">Closing Time ("HH:MM" in Military Time):</label>
			
			<input type="time" id="closingTime" name="closingTime"
      				 value=<%=currentTime%> required>
			<br>
			
			<input type="submit" value="Create Listing">
		</form>
		
		
		
		
		<%
	
	} catch (Exception ex) {
		out.println("An error occurred, please go back and try again or logout below.");
	}

%>
	<br>
		<form method="get" action="LoginPage.jsp">
			<input type="submit" value="Return to Login Page">
		</form>
	<br>

</body>
</html>