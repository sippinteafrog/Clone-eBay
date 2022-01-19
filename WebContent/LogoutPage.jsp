<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout Page</title>
<%
session.invalidate();
%>
</head>
<body>
	Logout successful. 
	<br>
	<form method="post" action="LoginPage.jsp">
	<input type="submit" value="Return to Login Page">
	</form>


</body>
</html>