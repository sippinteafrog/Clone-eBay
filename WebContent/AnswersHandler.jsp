<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Answering Questions</title>
</head>
<body>
<% 
		String url = "jdbc:mysql://localhost:3306/AuctionSiteDB";
		Connection conn = null;
		PreparedStatement ps = null;
			
		try {
			ApplicationDB db = new ApplicationDB();	
			conn = db.getConnection();
			
			int questionId = Integer.parseInt(request.getParameter("questionId"));
			String answer = request.getParameter("Answer");

			if(answer != null && !answer.isEmpty()){
				
				String insert = "UPDATE Questions SET answer=? WHERE questionId=?";
				
				ps = conn.prepareStatement(insert);
				
				ps.setString(1, answer);
				ps.setInt(2, questionId);
				
				int result = 0;
		        result = ps.executeUpdate();
		        if (result < 1) {
		        	out.println("Error: Question failed.");
		        } else { %>
		        	<jsp:include page="Questions.jsp" flush="true"/>
					<div class="content center">
						<h1>Question was successfully answered.</h1>
					</div>
		    <%  }
			} else {
				response.sendRedirect("QuestionError.jsp");
				return;
			}    
		} catch(Exception e) {
	        out.print("<p>Error connecting to MYSQL server.</p>" + e);
	        e.printStackTrace();
	    } finally {
	        try { ps.close(); } catch (Exception e) {}
	        try { conn.close(); } catch (Exception e) {}
	    }
		        
		        
	%>
</body>
</html>