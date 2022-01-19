package com.cs336.pkg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.sql.Date;




public class CheckAuctions {
	
	public static void checkAuctions() {
		
LocalDate currentDate = LocalDate.now(); 
		
		//get the current time
		LocalTime currentTime = LocalTime.now();
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String str = "SELECT * from auction where auction.isActive = 1";
		
		try {
			
			Statement stmt = con.createStatement();
			
			ResultSet rs = stmt.executeQuery(str);
			
			if(!(rs.isBeforeFirst())) {
				//no auctions
				return;
			} else {
				
				//go through auctions and compare closing dates to current date
				//if closing datetime has passed, compare reserve and current bid, and set the auction to inactive
				//if someone wins, alert them
				while(rs.next()) {
					
					Date date = rs.getDate("closeDate");
					String dateString = date.toString();
					//LocalDate auctionDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
					
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
					LocalDate auctionDate = LocalDate.parse(dateString, formatter);
					
					
					
					
					
					
					
					
					Time time = rs.getTime("closeTime");
					LocalTime auctionTime = time.toLocalTime();
					
					if(auctionDate.isBefore(currentDate)) {
						//auction over
						//endAuction(con, rs);
						
						int auctionId = rs.getInt("auctionId");
						float startingBid = rs.getFloat("startingBid");
						float currentBid = rs.getFloat("currentBid");
						
						if(currentBid < startingBid) {
							
							//no winner
							
							String update = "UPDATE auction set auction.isActive = 0 where auction.auctionId = ?";
							PreparedStatement ps = con.prepareStatement(update);
							ps.setInt(1, auctionId);
							ps.executeUpdate();
							
						} else {
							
							//find out who has the highest bid
							//set "winner" to that person's username
							//send that person an alert
							//set auction to inactive
							
							String str2 = "Select bid.username from bid where bid.auctionId = ? order by bid.amount desc limit 1";
							
							PreparedStatement ps2 = con.prepareStatement(str2);
							ps2.setInt(1,  auctionId);
							
							ResultSet rs2 = ps2.executeQuery();
							
							rs2.next();
							
							String winnerUsername = rs2.getString("username");
							
							String winnerAlert = "Replace into auctionalert values (?, ?, 'win')";
							
							PreparedStatement ps3 = con.prepareStatement(winnerAlert);
							ps3.setString(1, winnerUsername);
							ps3.setInt(2, auctionId);
							
							//send the alert to the winner
							ps3.execute();
							
							//set winner and isActive in auctions table
							String updateTable = "Update auction set auction.isActive = 0, auction.winner = ? where auction.auctionId = ?";
							
							PreparedStatement ps4 = con.prepareStatement(updateTable);
							ps4.setString(1, winnerUsername);
							ps4.setInt(2, auctionId);
							
							ps4.executeUpdate();			
							
						}
						
						
						
						
						
					} else if(auctionDate.equals(currentDate)) {
						//check if time is before 
						if(auctionTime.isBefore(currentTime)) {
							//auction over
							//endAuction(con, rs);
							
							int auctionId = rs.getInt("auctionId");
							float startingBid = rs.getFloat("startingBid");
							float currentBid = rs.getFloat("currentBid");
							
							if(currentBid < startingBid) {
								
								//no winner
								
								String update = "UPDATE auction set auction.isActive = 0 where auction.auctionId = ?";
								PreparedStatement ps = con.prepareStatement(update);
								ps.setInt(1, auctionId);
								ps.executeUpdate();
								
							} else {
								
								//find out who has the highest bid
								//set "winner" to that person's username
								//send that person an alert
								//set auction to inactive
								
								String str2 = "Select bid.username from bid where bid.auctionId = ? order by bid.amount desc limit 1";
								
								PreparedStatement ps2 = con.prepareStatement(str2);
								ps2.setInt(1,  auctionId);
								
								ResultSet rs2 = ps2.executeQuery();
								
								rs2.next();
								
								String winnerUsername = rs2.getString("username");
								
								String winnerAlert = "Replace into auctionalert values (?, ?, 'win')";
								
								PreparedStatement ps3 = con.prepareStatement(winnerAlert);
								ps3.setString(1, winnerUsername);
								ps3.setInt(2, auctionId);
								
								//send the alert to the winner
								ps3.execute();
								
								//set winner and isActive in auctions table
								String updateTable = "Update auction set auction.isActive = 0, auction.winner = ? where auction.auctionId = ?";
								
								PreparedStatement ps4 = con.prepareStatement(updateTable);
								ps4.setString(1, winnerUsername);
								ps4.setInt(2, auctionId);
								
								ps4.executeUpdate();			
								
							}
							
							
						}
					}
					
				}

			}
			
			con.close();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
	
	}
	
}