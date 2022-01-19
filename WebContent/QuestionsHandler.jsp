<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
		
	<% 
		String url = "jdbc:mysql://localhost:3306/AuctionSiteDB";
		PreparedStatement ps = null;
			
		try {
			ApplicationDB db = new ApplicationDB();	
			Connection conn = db.getConnection();	
			
			String username = (session.getAttribute("userID")).toString();
			String question = request.getParameter("Question");

			if(username != null && !username.isEmpty() && question != null && !question.isEmpty()){
				
				String insert = "insert into Questions (username, question, answer) values (?, ?, ?)";
				
				ps = conn.prepareStatement(insert);
				
				ps.setString(1, username);
				ps.setString(2, question);
				ps.setString(3, "---Waiting for customer representative to answer---");
				
				int result = 0;
		        result = ps.executeUpdate();
		        if (result < 1) {
		        	out.println("Error: Question failed to submit.");
		        } else {
		        	response.sendRedirect("Questions.jsp?submit=success");
		        	return;
		        }
			} else {
				response.sendRedirect("QuestionError.jsp");
				return;
			}    
		} catch(Exception e) {
	        out.print("<p>Error connecting to MYSQL server.</p>" + e);
	        e.printStackTrace();
	    } finally {
	        try { ps.close(); } catch (Exception e) {}
	    }
		        
		        
	%>
