<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create New Shirt Listing</title>
</head>
<body>
Please enter the required information below
	<br>
	<br>
	Is the shirt short sleeved?
	<br>
	<form method="post" action="ListingDetailsPage.jsp">
	
	<input type ="hidden" name="type" id="type" value="shirt">
	
	<input type="radio" id="shortSleeved" name="isShortSleeved" value="true" checked>
	<label for="shortSleeved">Yes</label><br>
	
	<input type="radio" id="longSleeved" name="isShortSleeved" value="false">
	<label for="longSleeved">No</label><br>
	
	<br>
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
		<td>Material</td><td><input type="text" name="material"></td>
		</tr>
		<tr>
		<td>Size</td><td><input type="text" name="size"></td>
		</tr>
	</table>
	
	<input type="submit" value="Next">
	</form>

</body>
</html>