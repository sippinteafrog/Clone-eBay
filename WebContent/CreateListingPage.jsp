<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
			<title>Create New Listing</title>
	</head>
	
	<body>
		What type of clothing would you like to list?
		<br>
		<form method="post" action="CreateShirtListingPage.jsp">
		<input type="submit" value="Shirt">
		</form>
		<form method="post" action="CreateShoesListingPage.jsp">
		<input type="submit" value="Shoes">
		</form>
		<form method="post" action="CreatePantsListingPage.jsp">
		<input type="submit" value="Pants">
		</form>

	</body>
	
</html>