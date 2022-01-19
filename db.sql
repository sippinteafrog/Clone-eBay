UNLOCK TABLES;
CREATE DATABASE  IF NOT EXISTS `AuctionSiteDB`;
USE `AuctionSiteDB`;

DROP TABLE IF EXISTS `alertfor`;
DROP TABLE IF EXISTS `bid`;

DROP TABLE IF EXISTS `automaticbidding`;
DROP TABLE IF EXISTS `auctionalert`;
DROP TABLE IF EXISTS `auction`;
DROP TABLE IF EXISTS `clothes`;
DROP TABLE IF EXISTS `Questions`;

DROP TABLE IF EXISTS `assists`;
DROP TABLE IF EXISTS Questions;
DROP TABLE IF EXISTS `accounts`;
 

CREATE TABLE `accounts` (
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `type` varchar(15) DEFAULT 'User',
  PRIMARY KEY (`username`) 
);

LOCK TABLES `accounts` WRITE;

INSERT INTO `accounts` VALUES ('user1', 'yerr', 'User'), ('user2', 'yerr', 'User'), ('admin', 'yerr', 'Admin'), ('rep', 'yerr', 'CustomerRep');

UNLOCK TABLES;


CREATE TABLE `assists` (
  `ticketId` INT AUTO_INCREMENT PRIMARY KEY,
  `rep` varchar(50) NOT NULL,
  `user` varchar(50) NOT NULL,
  `date` Date,
  CONSTRAINT `rep_username` FOREIGN KEY (`rep`) REFERENCES `accounts` (`username`),
  CONSTRAINT `user_username` FOREIGN KEY (`user`) REFERENCES `accounts` (`username`) 
);


CREATE TABLE `clothes`(
  `itemId` INT AUTO_INCREMENT PRIMARY KEY,
  `color` varchar(50) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `gender` ENUM('male', 'female', 'unisex'),
  `type` ENUM('shirt', 'shoes', 'pants') NOT NULL,
  `isHalfSleeve` BOOLEAN,
  `material` varchar(50),
  `size` varchar(50),
  `style` varchar(50),
  `year` INT,
  `isShorts` BOOLEAN,
  `waistSize` FLOAT,
  `length` FLOAT
);

LOCK TABLES `clothes` WRITE;

INSERT INTO `clothes` (`color`, `brand`, `gender`, `material`) VALUES ('red', 'nike', 'male', 'cotton'), ('red', 'nike', 'female',  'cotton'), ('blue', 'nike', 'male',  'cotton'), ('red', 'adidas', 'male',  'cotton');

UNLOCK TABLES;


CREATE TABLE `auction` (
  `auctionId` INT AUTO_INCREMENT PRIMARY KEY,
  `itemId` INT,
  `startingBid` FLOAT,
  `currentBid` FLOAT DEFAULT 0.00,
  `isActive` BOOLEAN,
  `closeDate` Date,
  `closeTime` Time,
  `seller` varchar(50),
  `winner` varchar(50),
  CONSTRAINT `auction_seller` FOREIGN KEY (`seller`) REFERENCES `accounts` (`username`) ON DELETE cascade,
  CONSTRAINT `auction_winner` FOREIGN KEY (`winner`) REFERENCES `accounts` (`username`) ON DELETE set null,
  CONSTRAINT `auction_itemId` FOREIGN KEY (`itemId`) REFERENCES `clothes` (`itemId`)
);

LOCK TABLES `auction` WRITE;

INSERT INTO `auction` (`itemId`, `startingBid`, `currentBid`, `isActive`, `seller`, `closeDate`, `closeTime` ) VALUES (1, 10, 35, true, 'user1', '2021-7-04', '12:30:00'), (2, 10, 10, true, 'user1', '2022-7-04', '12:30:00') ;
UNLOCK TABLES;



CREATE TABLE `alertfor` (
  `alertId` INT AUTO_INCREMENT PRIMARY KEY,
  `username` varchar(50),
  `color` varchar(50) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `gender` ENUM('male', 'female', 'unisex'),
  `type` ENUM('shirt', 'shoes', 'pants') DEFAULT NULL,
  CONSTRAINT `alert_username` FOREIGN KEY (`username`) REFERENCES `accounts` (`username`)
);

CREATE TABLE `auctionalert` (
	`username` varchar(50),
    `auctionId` INT,
    `type` ENUM('auto', 'manual', 'win') DEFAULT 'manual',
    PRIMARY KEY(`username`, `auctionId`),
    CONSTRAINT `auctionalert_username` FOREIGN KEY (`username`) REFERENCES `accounts` (`username`) on delete cascade,
    CONSTRAINT `auctionalert_auctionId` FOREIGN KEY (`auctionId`) REFERENCES `auction` (`auctionId`) on delete cascade
);


CREATE TABLE `automaticbidding` (
  `username` varchar(50),
  `auctionId` INT,
  `maxPrice` FLOAT,
  `increment` FLOAT,
  PRIMARY KEY(`username`, `auctionId`),
  CONSTRAINT `auto_username` FOREIGN KEY (`username`) REFERENCES `accounts` (`username`) ON DELETE cascade,
  CONSTRAINT `auto_auctionId` FOREIGN KEY (`auctionId`) REFERENCES `auction` (`auctionId`)  on delete cascade
);

CREATE TABLE `bid` (
  `username` varchar(50),
  `auctionId` INT,
  `amount` FLOAT,
  PRIMARY KEY(`username`, `auctionId`, `amount`),
  CONSTRAINT `bid_username` FOREIGN KEY (`username`) REFERENCES `accounts` (`username`) ON DELETE cascade,
  CONSTRAINT `bid_auctionId` FOREIGN KEY (`auctionId`) REFERENCES `auction` (`auctionId`) ON DELETE cascade
);

LOCK TABLES `bid` WRITE;

INSERT INTO `bid`VALUES ('user1', 1, 10), ('user2', 1, 20), ('user1', 1, 35) ;

UNLOCK TABLES;


CREATE TABLE Questions(
	`questionId` INT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(50),
    `question` VARCHAR(250) NOT NULL,
    `answer` VARCHAR(250) DEFAULT NULL,
    FOREIGN KEY (`username`) REFERENCES accounts(`username`)
		ON DELETE CASCADE
);


