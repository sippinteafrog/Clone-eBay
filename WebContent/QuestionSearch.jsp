<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Questions</title>
<link rel="stylesheet" href="style.css?v=1.0" />

</head>
<body>
<%@ include file="RepNav.jsp"%>
<% 
		String url = "jdbc:mysql://localhost:3306/AuctionSiteDB";
		PreparedStatement ps = null;
		ResultSet rs = null;
		Connection conn = null;

			
		try {
			ApplicationDB db = new ApplicationDB();	
			 conn = db.getConnection();	
			
			String username = (session.getAttribute("userID")).toString();
			String keyword = request.getParameter("SearchQ");

			if(username != null && !username.isEmpty() && keyword != null && !keyword.isEmpty()){
				
				String insert = "select * from Questions where question like CONCAT('%', ? ,'%')";
				String check = "---Waiting for customer representative to answer---";

				
				ps = conn.prepareStatement(insert);
				
				ps.setString(1, keyword);
			
				rs = ps.executeQuery();
				
				if(rs.next()){ %> 
					<h1> Searched Results: </h1>
					<p style="font-size: 10pt;">
						**Can't find the question you are looking for? Please make sure you have searched using an appropriate keyword(s) and try again. 
						If there are still no results, please post your questions and a representative will answer you shortly** 
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
			}
			
		}catch(Exception e) {
	        out.print("<p>Error connecting to MYSQL server.</p>" + e);
	        e.printStackTrace();
	    } finally {
	        try { ps.close(); } catch (Exception e) {}
	        try { conn.close(); } catch (Exception e) {}
	    }
		        
		        
	%>

</body>
</html>