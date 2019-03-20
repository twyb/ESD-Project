SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Create Database -- 

DROP DATABASE IF EXISTS project_product;
CREATE DATABASE IF NOT EXISTS project_product DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE project_product;

-- Add Table --

DROP TABLE IF EXISTS product;
CREATE TABLE product (
  PID 			INT 			NOT NULL	AUTO_INCREMENT,
  Pname 		VARCHAR(45) 	NOT NULL,
  Pdesc 		VARCHAR(1000)	NOT NULL,
  price 		DECIMAL(10,2) 	NOT NULL,
  availability 	INT(11) 		NOT NULL,
  category 		VARCHAR(45) 	NOT NULL,
  
  PRIMARY KEY (PID)
);

-- Add Data --

INSERT INTO product(Pname, Pdesc, price, availability, category)
VALUES 
('The Shining', 'The Torrance Family slowly go insane in the Overlook Hotel', 5.99, 3, 'books'),
('The Kite Runner', 'The cruelties of living in Afghanistan', 12.99, 4, 'books'),
('Zoo', 'Animals turn haywire and turn on humans', 6.99, 10, 'books'),
('Samsung S10', 'Same phone different design', 1200.00, 25, 'phones');

-- Create Database -- 

DROP DATABASE IF EXISTS project_cart;
CREATE DATABASE IF NOT EXISTS project_cart DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE project_cart;

-- Add Table --

DROP TABLE IF EXISTS cart;
CREATE TABLE cart (
  CartID 		INT 			NOT NULL	AUTO_INCREMENT,
  CID           VARCHAR(30)     NOT NULL,
  timestamp     timestamp       NOT NULL    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  PRIMARY KEY (CartID)
);

-- Add Data --

INSERT INTO cart(CID, timestamp)
VALUES 
('James Tan', '2018-11-14 14:42:31'),
('James Tan', '2018-11-15 20:42:31'),
('James Tan', '2018-11-16 21:42:31'),
('James Tan', '2018-11-17 22:42:31');

-- Add Table --

DROP TABLE IF EXISTS cart_items;
CREATE TABLE IF NOT EXISTS cart_items (
  CIID          INT             NOT NULL    AUTO_INCREMENT,
  PID           INT             NOT NULL,
  Pname 		VARCHAR(45) 	NOT NULL,
  Pdesc 		VARCHAR(1000)	NOT NULL,
  price 		DECIMAL(10,2) 	NOT NULL,
  qty			INT				NOT NULL,
  Pstatus		VARCHAR(20),
  CartID        INT             NOT NULL,

  PRIMARY KEY (CIID),
  FOREIGN KEY (CartID) REFERENCES cart (CartID)
);

-- Add Data --

INSERT INTO cart_items(PID, Pname, Pdesc, price, qty, Pstatus, CartID)
VALUES 
(1, 'The Shining', 'The Torrance Family slowly go insane in the Overlook Hotel', 5.99, 3, '', 1),
(2, 'The Kite Runner', 'The cruelties of living in Afghanistan', 12.99, 4, '', 2),
(3, 'Zoo', 'Animals turn haywire and turn on humans', 6.99, 10, '', 3),
(4, 'Samsung S10', 'Same phone different design', 1200.00, 25, '', 4);

-- Create Database -- 

DROP DATABASE IF EXISTS project_corder;
CREATE DATABASE IF NOT EXISTS project_corder DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE project_corder;

-- Add Table --

DROP TABLE IF EXISTS corder;
CREATE TABLE corder (
  OID 			INT 			NOT NULL	AUTO_INCREMENT,
  CID           VARCHAR(30)     NOT NULL,
  Pstatus		VARCHAR(20),
  timestamp     timestamp       NOT NULL    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  PRIMARY KEY (OID)
);

-- Add Data --

INSERT INTO corder(OID, CID, Pstatus, timestamp)
VALUES 
(1, 'James Tan', '', '2018-11-14 14:42:31'),
(2, 'James Tan', '', '2018-11-15 20:42:31'),
(3, 'James Tan', '', '2018-11-16 21:42:31'),
(4, 'James Tan', '', '2018-11-17 22:42:31');

-- Add Table --

DROP TABLE IF EXISTS order_items;
CREATE TABLE IF NOT EXISTS order_items (
  IID           INT             NOT NULL AUTO_INCREMENT,
  PID           INT             NOT NULL,
  Pname 		VARCHAR(45) 	NOT NULL,
  price 		DECIMAL(10,2) 	NOT NULL,
  qty			INT				NOT NULL,
  OID           INT             NOT NULL,

  PRIMARY KEY (IID),
  FOREIGN KEY (OID) REFERENCES corder (OID)
);

-- Add Data --

INSERT INTO order_items(PID, Pname, price, qty, OID)
VALUES 
(1, 'The Shining', 5.99, 3, 1),
(2, 'The Kite Runner', 12.99, 4, 2),
(3, 'Zoo', 6.99, 10, 3),
(4, 'Samsung S10', 1200.00, 25, 4);

-- Create Database -- 

DROP DATABASE IF EXISTS project_payment;
CREATE DATABASE IF NOT EXISTS project_payment DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE project_payment;

-- Add Table --

DROP TABLE IF EXISTS payment;
CREATE TABLE payment (
  PayID 		INT 			NOT NULL	AUTO_INCREMENT,
  Pstatus		VARCHAR(20)		NOT NULL,
  price 		DECIMAL(10,2) 	NOT NULL,
  qty			INT				NOT NULL,
  
  PRIMARY KEY (PayID)
);

-- Create Database -- 

DROP DATABASE IF EXISTS project_notification;
CREATE DATABASE IF NOT EXISTS project_notification DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE project_notification;

-- Add Table --

DROP TABLE IF EXISTS notification;
CREATE TABLE notification (
  NID			INT 			NOT NULL AUTO_INCREMENT,
  Pstatus		VARCHAR(20)		NOT NULL,
  OID           INT             NOT NULL,
  
  PRIMARY KEY (NID),
  FOREIGN KEY (OID) REFERENCES corder (OID)
);

-- Add Data -- 
INSERT INTO notification(NID, Pstatus, OID)
VALUES 
(1, 'Pending',4),
(2, 'Order received',2),
(3, 'Ready to ship',3),
(4, 'Out for delivery',1);