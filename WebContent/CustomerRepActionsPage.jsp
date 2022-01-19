<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Representative Home</title>
<link rel="stylesheet" href="style.css?v=1.0" />

</head>
<body>
	<%@ include file="RepNav.jsp"%>
	<h2>Customer Representative Homepage</h2>
	<form method="post" action="Questions.jsp">
	<input type="submit" value="Questions">
	</form>
	<form method="post" action="UserToEdit.jsp">
	<input type="submit" value="Edit User Account">
	</form>
	<form method="post" action="DeleteAccount.jsp">
	<input type="submit" value="Delete User Account">
	</form>
	<form method="post" action="DeleteBid.jsp">
	<input type="submit" value="Remove Bids">
	</form>
	<form method="post" action="AllAuctions.jsp">
	<input type="submit" value="Cancel Auction">
	</form>
</body>
</html>