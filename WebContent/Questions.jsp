<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%><%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Questions and Answers </title>
<link rel="stylesheet" href="style.css?v=1.0" />
</head>
<body>	
	<%@ include file="RepNav.jsp"%>
	<div class="content">
	<%	if (request.getParameter("submit") != null && (request.getParameter("submit")).toString().equals("success")) { %>
			<h1>Your question has been submitted successfully.</h1>
	<%	} %>
	
		<h1>Submit a new question:</h1>
		<form action="QuestionsHandler.jsp" method="post">
			<textarea style="font-size: 18pt" rows="1" cols="55" maxlength="250" id="msg" name="Question"></textarea> <br>
			<input type="submit" value="Submit">					
		</form>	
		<h1>Search Questions:</h1>
		<form action="QuestionSearch.jsp" method="post">
			<textarea style="font-size: 18pt" rows="1" cols="15" maxlength="250" id="msg" name="SearchQ"></textarea> <br>
			<input type="submit" value="Search">					
		</form>	
		
	<% 
		String url = "jdbc:mysql://localhost:3306/AuctionSiteDB";
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {   		
			ApplicationDB db = new ApplicationDB();	
			 conn = db.getConnection();
			String username = (session.getAttribute("userID")).toString();
			String questionsQuery = "SELECT * FROM Questions";
			String check = "---Waiting for customer representative to answer---";
			
			ps = conn.prepareStatement(questionsQuery);
			rs = ps.executeQuery();
			
			if(rs.next()){ %> 
				<h1> Questions and Answers: </h1>
				<p style="font-size: 10pt;">
					**Questions will be answered as soon as possible by a customer representative** 
				</p>
				<table> 
					<tr>
						<th>Question</th>
						<th>Answer</th>
					</tr>				
					<% do { %>
						<tr>
							<td><%= rs.getString("question") %> </td>
							<% if (check.equals(rs.getString("answer"))
									&& (!session.getAttribute("type").equals("User"))) { %>
								<form action="AnswersHandler.jsp?questionId=<%= rs.getInt("questionId") %>" method="POST">
									<td>
										<textarea type="textarea" name="Answer"></textarea>
										<input type="submit" value="Answer">
									</td>
								</form>
							<% } else { %>
							<td><%= rs.getString("answer") %> </td>
							<% } %>
						</tr>
			<% 		} while(rs.next()); %>
				</table>
			<% 	} else { %>
					<br><h2>No questions have been asked.</h2>	
			<%	}  %>	
			
		<%
		
		} catch (SQLException e){
			out.print("<p>Error connecting to MYSQL server.</p>");
		    e.printStackTrace();    			
		} finally {
			try { rs.close(); } catch (Exception e) {} 
			try { conn.close(); } catch (Exception e) {} 
		}   		
	%>
		
		
	</div>
</body>
</html>
