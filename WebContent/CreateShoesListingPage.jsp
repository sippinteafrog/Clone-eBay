<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create New Shoes Listing</title>
</head>
<body>
Please enter the required information below
	<br>
	<br>
	
	<form method="post" action="ListingDetailsPage.jsp">
	
	<input type ="hidden" name="type" id="type" value="shoes">
	
	Please select the gender.
	<br>
	
	<input type="radio" id="male" name="gender" value="male">
	<label for="male">Male</label><br>
	
	<input type="radio" id="female" name="gender" value="female">
	<label for="female">Female</label><br>
	
	<input type="radio" id="unisex" name="gender" value="unisex" checked>
	<label for="unisex">Unisex</label><br>
	
	<br>
	
	<table>
		<tr>    
		<td>Color</td><td><input type="text" name="color"></td>
		</tr>
		<tr>
		<td>Brand</td><td><input type="text" name="brand"></td>
		</tr>
		<tr>    
		<td>Style</td><td><input type="text" name="style"></td>
		</tr>
		<tr>    
		<td>Size</td><td><input type="text" name="size"></td>
		</tr>
		<tr>
		<td>Year</td><td><input type="number" name="year" min="1900" max="2021" step="1" placeholder="2021"></td>
		</tr>
	</table>
	
	<input type="submit" value="Next">
	
	</form>

</body>
</html>