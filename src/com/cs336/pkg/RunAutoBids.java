package com.cs336.pkg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLIntegrityConstraintViolationException;

public class RunAutoBids {
	
	public RunAutoBids(){
		
	}
	
	public static void runThem(int auctionId) {
		try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		con.setAutoCommit(false);
		String query = "select * from automaticbidding where automaticbidding.auctionId=? order by automaticbidding.maxPrice desc";
		PreparedStatement ps = con.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, 
				ResultSet.CONCUR_UPDATABLE);
		ps.setInt(1, auctionId);
		ResultSet resultSet = ps.executeQuery();
		
		query = "select isActive from auction where auctionId=?";
		ps = con.prepareStatement(query);
		ps.setInt(1, auctionId);
		ResultSet active = ps.executeQuery();
		if (active.next()) {
			if (!active.getBoolean("isActive")) {
				return;
			}
		}
		else {
			return;
		}
	
		//get the current top bidder
		query = "select username, amount from bid where auctionId=? order by amount desc limit 1;";
		ps = con.prepareStatement(query);
		ps.setInt(1, auctionId);
		ResultSet topUserAndAmount = ps.executeQuery();
		String topBidder;
		float topBid;
		if (!topUserAndAmount.next()) {
			// there's no bid. bid the minimum bid
			query = "select startingBid from auction where auctionId=? and isActive=true;";
			ps = con.prepareStatement(query);
			ps.setInt(1, auctionId);
			ResultSet startingBid = ps.executeQuery();
			if (startingBid.next()) {
				float start = startingBid.getFloat("startingBid");
				if (resultSet.next()) {
					String firstAutoBidder = resultSet.getString("username");
					float maxBid = resultSet.getFloat("automaticbidding.maxPrice");
					if (maxBid >= start) {
						topBidder = firstAutoBidder;
						topBid = start;
						Connection con2 = db.getConnection();
						String insert = "insert into bid values(?, ?, ?)";
						ps = con2.prepareStatement(insert);							
						ps.setString(1, resultSet.getString("username"));
						ps.setInt(2, auctionId);
						ps.setFloat(3, topBid);
						ps.executeUpdate();
						con2.close();
					}
					else { return ; } // the highest max price is not high enough to start a bid
				}
				else { // there are no auto bids for this auctionID
					return;
				}
			}
			else { return; } // was unable to fetch starting bid for this auction
		}
		else {
			topBidder = topUserAndAmount.getString("username");
			topBid = topUserAndAmount.getFloat("amount");
		}
		
		
		resultSet.beforeFirst();
		while (resultSet.next()){
			float mPrice = resultSet.getFloat("automaticbidding.maxPrice");
			float inc = resultSet.getFloat("increment");
			if (resultSet.getString("username").equals(topBidder)) {
				continue;
			}
			if (topBid + inc <= mPrice){
				
				//insert their bid
				String insert = "insert into bid values(?, ?, ?)";
				Connection con2 = db.getConnection();
				ps = con2.prepareStatement(insert);							
				ps.setString(1, resultSet.getString("username"));
				ps.setInt(2, auctionId);
				topBid += inc;
				topBidder = resultSet.getString("username");
				ps.setFloat(3, topBid);
				ps.executeUpdate();
				
				String str2 = "update auction a set a.currentBid = ? where a.auctionId = ?";
				
				PreparedStatement ps2 = con2.prepareStatement(str2);
				
				ps2.setFloat(1, topBid);
				ps2.setInt(2, auctionId);
				
				ps2.execute();
				con2.close();

			}
			else{
				// ALERT THEM
				String insert = "replace into auctionalert values(?, ?, ?)";
				Connection con2 = db.getConnection();
				ps = con2.prepareStatement(insert);							
				ps.setString(1, resultSet.getString("username"));
				ps.setInt(2, auctionId);
				ps.setString(3, "auto");
				ps.executeUpdate();
				con2.close();
				// their autobid is no longer relevant
				resultSet.deleteRow();
			}
			if (resultSet.isLast()){
				String lastBidder = resultSet.getString("username");
				resultSet.first();
				if (lastBidder.equals(resultSet.getString("username"))) // there is only 1 bidder left
					resultSet.last();
				else
					resultSet.beforeFirst();
			}
		}
		con.rollback();
		con.close();

		
	} catch (SQLIntegrityConstraintViolationException e) {
	    // Duplicate entry
	    System.out.println("Automatic bid not set! The auction may have closed!");
	} catch (Exception ex) {
		System.out.println(ex);
	}
	CheckAuctions.checkAuctions();

	}
}