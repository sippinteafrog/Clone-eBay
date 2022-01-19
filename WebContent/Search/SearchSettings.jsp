<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.time.LocalDate,java.time.LocalTime,java.time.ZoneId,java.util.Date" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Browse Listings</title>
</head>
<body>


<%

//make a date with current date
		CheckAuctions.checkAuctions();

%>




Select your search settings below.
<br>
<br>
<b>Listing Type</b>
<form method="post" action="SearchResults.jsp">
	<input type="radio" id="all" name="type" value="" checked>
	<label for="all">All</label><br>
	
	<input type="radio" id="pants" name="type" value="pants">
	<label for="pants">Pants</label><br>
	
	<input type="radio" id="shirts" name="type" value="shirt">
	<label for="shirts">Shirts</label><br>
	
	<input type="radio" id="shoes" name="type" value="shoes">
	<label for="shoes">Shoes</label><br>
	
	<br>
	Gender
	<br>
	
	<input type="radio" id="any" name="any" value="" checked>
	<label for="any">All</label><br>
	
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
		<td>Min Current Bid</td><td><input type="text" name="minCurrentBid"></td>
		</tr>
		<td>Max Current Bid</td><td><input type="text" name="maxCurrentBid"></td>
		</tr>
		</tr>
		<td>Buyer</td><td><input type="text" name="buyer"></td>
		</tr>
		</tr>
		<td>Seller</td><td><input type="text" name="seller"></td>
		</tr>
	</table>
	<br>
	Sort By
	<br>
	<input type="radio" id="priceUp" name="sortBy" value="priceUp">
	<label for="priceUp">Price Increasing</label><br>
	
	<input type="radio" id="priceDown" name="sortBy" value="priceDown">
	<label for="priceDown">Price Decreasing</label><br>
	
	<input type="radio" id="Alphabetical" name="sortBy" value="Alphabetical" checked>
	<label for="Alphabetical">Brand Alphabetical</label><br>

	
	<input type="submit" value="Search">
	</form>
</body>
</html>