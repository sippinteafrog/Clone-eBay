<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>


<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
			<title>Submit automatic bid for <% out.print("hi"); %></title>
	</head>
	
	
	
	<body>
	<p> Set your automatic bid. Previous auto bids for this item will be overwritten. </p>
	<form method="post" action="AutoBidResult.jsp">
	<table>
		<tr>    
		<td>Upper Bid (this will be kept secret): </td><td><input type="text" name="upper"></td>
		</tr>
		<tr>
		<td>Bid Increment:</td><td><input type="text" name="increment"></td>
		</tr>
	</table>
	<input type='hidden' name='auctionId' id='auctionId' value=<%=request.getParameter("auctionId")%> />
	<input type="submit" value="Create">
	</form>
	

</body>
	
</html>