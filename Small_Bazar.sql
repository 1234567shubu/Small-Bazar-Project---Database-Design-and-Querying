
drop table address;
drop table customer;
drop table manager;
drop table branch;
drop table product;
drop table purchase_order;
drop table delivery;
drop table payment;
drop table product_order;
#__ADDRESS_______________________________________________________________________________________________________
create table address( address_id INT PRIMARY KEY AUTO_INCREMENT,
						address varchar(20),pin_code int,city_name varchar(20), state_name varchar(30),
                        country_name varchar(30), last_update timestamp);
insert into address value(1,'Raviwar Peth',411002,'pune','maharashtra','india',now());
insert into address(address,pin_code,city_name,state_name,country_name,last_update) value	
('Baner',260002,'pune','maharashtra','india',now()),
							('Borivali',521002,'mumbai','maharashtra','india',now()),
                            ('ramdara',980002,'surat','gujarat','india',now()),
                            ('kasba peth',451002,'jaypur','rajasthan','india',now()),
                            ('tokyo street',234002,'tokyo','kanto','japan',now());
select * from address;

#__CUSTOMER_______________________________________________________________________________________________________
CREATE TABLE customer (
    customer_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(45),
    last_name VARCHAR(45),
     address_id INT NOT NULL,
    FOREIGN KEY (address_id)
        REFERENCES address (address_id),
    contact_no VARCHAR(13),
    create_date DATETIME,
    last_update TIMESTAMP
);
insert into customer values( 101, 'Sanjana','Gurjar',1,'8421214545','1999-09-09',now());
insert into customer(first_name,last_name,address_id,contact_no,create_date,last_update) 
values( 'Shiv','Thakare',2,'9921214556','2000-09-10',now()),
							( 'Karan','Johar',4,'7221214521','2000-09-10',now()),
                            ( 'Hina','Khan',3,'8921214589','2005-09-10',now()),
                            ( 'Bharati','Singh',1,'9521214556','2010-09-10',now());


select * from customer;


#__MANAGER_______________________________________________________________________________________________________
CREATE TABLE manager (
    manager_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(45),
    last_name VARCHAR(45),
     address_id INT NOT NULL,
    FOREIGN KEY (address_id)
        REFERENCES address (address_id),
	contact_no VARCHAR(13),
    create_date DATETIME,
    last_update TIMESTAMP
);

insert into manager values( 201, 'Rakesh','Sharma',1,'8421214545','1999-09-09',now());
insert into manager(first_name,last_name,address_id,contact_no,create_date,last_update) 
values( 'Karan','Kundra',2,'9921214556','2000-09-10',now()),
							( 'Sanjay','Pardeshi',2,'7121214521','2020-09-10',now()),
                            ( 'Archana','Thakur',1,'8821214589','2015-09-10',now()),
                            ( 'Sajid','Khan',1,'9552214556','1995-09-10',now());

select * from manager;

#__BRANCH_______________________________________________________________________________________________________
CREATE TABLE branch (
    branch_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    branch_name VARCHAR(40) NOT NULL,
    address_id INT NOT NULL,
    FOREIGN KEY (address_id)
        REFERENCES address (address_id),
    manager_id smallint not null unique,
    FOREIGN KEY (manager_id)
        REFERENCES manager (manager_id),
    gst_no VARCHAR(15),
    contact_no VARCHAR(13),
    branch_status enum('activate','deactivate'),
    last_update TIMESTAMP
);
insert into branch values(301,'Raviwar Peth',1,201,'gst2343405','020-43589345','activate',now());
insert into branch(branch_name,address_id,manager_id,gst_no,contact_no, branch_status,last_update) 
values('Borivali',3,203,'gst9340495','020-943859039','activate',now()),
	('Joliet Street Branch',6,202,'gst34859045','020-34923890','activate',now()),
    ('Joliet Street Branch',5,204,'gst34859045','020-34923890','deactivate',now());
    
 select * from branch;
  
#__PRODUCT_______________________________________________________________________________________________________
CREATE TABLE product (
    product_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    branch_id SMALLINT NOT NULL,
    FOREIGN KEY (branch_id)
        REFERENCES branch (branch_id),
    discription VARCHAR(50) ,
    product_type VARCHAR(20),
    net_quantity SMALLINT NOT NULL,
    CHECK (net_quantity > 0),
    cost_price DECIMAL(7 , 2 ) NOT NULL,
    CHECK (cost_price > 0),
    selling_price DECIMAL(7 , 2 ) NOT NULL,
    CHECK (selling_price > 0),
    company VARCHAR(20),
    manuf_date DATE,
    state ENUM('activate', 'deactivate') NOT NULL,
    last_update TIMESTAMP,
	unique key(product_name,branch_id)
);
insert into product values(401,'ParleG',301,'Sweet','food',100,5,10,'Parle','2023-01-02','activate',now());
insert into product(product_name,branch_id,discription,product_type,net_quantity,cost_price,
selling_price,company,manuf_date,state,last_update) 
values
	('ParleG',302,'Sweet','food',100,5,10,'Parle','2023-01-02','activate',now()),
    ('ParleG',303,'Sweet','food',50,5,10,'Parle','2023-01-02','activate',now()),
    ('Hydro',301,'Water Bottle','Bottle',20,50,80,null,'2023-01-02','activate',now()),
    ('Synthol',301,'Cool,blue','Soap',600,20,40,null,'2023-01-02','activate',now()),
    ('Synthol',302,'Cool,blue','Soap',100,20,40,null,'2023-01-02','activate',now()),
    ('Bournvita',301,'Sweet','food',80,100,150,'Parle','2023-01-02','activate',now()),
    ('colgate',301,null,'toothpaste',90,80,90,null,'2023-01-02','activate',now()),
    ('colgate',302,null,'toothpaste',100,70,90,null,'2023-01-02','activate',now()),
    ('colgate',303,null,'toothpaste',70,60,80,null,'2023-01-02','activate',now()),
    ('Dove',303,null,'shampoo',90,5,10,null,'2023-01-02','activate',now()),
    ('Plastic Bag',301,null,null,100,5,10,null,'2023-01-02','activate',now()),
	('Plastic Bag',302,null,null,200,5,10,null,'2023-01-02','activate',now()),
	('Plastic Bag',303,null,null,100,5,10,null,'2023-01-02','activate',now());

select * from product;

#__PURCHASE  ORDER_______________________________________________________________________________________________________
CREATE TABLE purchase_order (
    order_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    order_date TIMESTAMP NOT NULL,
    customer_id SMALLINT NOT NULL,
    FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id),
    branch_id SMALLINT NOT NULL,
    FOREIGN KEY (branch_id)
        REFERENCES branch (branch_id),
	order_amount DECIMAL(7 , 2 ) default 0,
	order_status ENUM('in progress', 'complete'),
    delivery_type enum('home delivery','self pickup'),
    last_update TIMESTAMP
);

insert into purchase_order values(501,'2023-01-06 12:41:34',101,301,100,'complete','self pickup',now());
insert into purchase_order(order_date,customer_id,branch_id,order_amount,order_status,
delivery_type,last_update) 
values('2023-02-10 12:41:34',104,302,100,'complete','self pickup',now()),
('2023-03-26 12:41:34',105,303,100,'complete','home delivery',now());
insert into purchase_order(order_date,customer_id,branch_id,order_amount,order_status,
delivery_type,last_update) 
values('2023-04-10 12:41:34',103,302,100,'in progress','self pickup',now());
select * from branch;
select * from purchase_order;

#__PRODUCT AND ORDER_______________________________________________________________________________________________________
CREATE TABLE product_order (
    product_id SMALLINT not null,
    FOREIGN KEY (product_id)
        REFERENCES product (product_id),
    order_id SMALLINT not null,
    FOREIGN KEY (order_id)
        REFERENCES purchase_order (order_id),
	cost_price DECIMAL(7 , 2 ) NOT NULL,
    CHECK (cost_price > 0),
    selling_price DECIMAL(7 , 2 ) NOT NULL,
    CHECK (selling_price > 0),
    no_of_units SMALLINT NOT NULL,
    CHECK (no_of_units > 0),
    total_product_amount DECIMAL(7 , 2 ) NOT NULL,
    PRIMARY KEY (product_id , order_id),
    last_update TIMESTAMP
);
 								
insert into product_order values (401,501,5,10,2,20,now());
insert into product_order values (404,501,50,80,2,160,now()),
								(402,502,5,10,2,20,now()),
								(406,502,20,40,2,80,now()),
                                (410,503,60,80,2,160,now()),
                                (411,503,5,10,2,20,now());
 select * from    product_order;   
 
 
#__DELIVERY_______________________________________________________________________________________________________
CREATE TABLE delivery (
    delivery_id SMALLINT,
    delivery_date DATE,
    delivery_place int,
    FOREIGN KEY (delivery_place)
        REFERENCES address (address_id),
	order_id smallint unique not null ,
    FOREIGN KEY (order_id)
        REFERENCES purchase_order(order_id),
    delivery_charges DECIMAL(4 , 2 ) DEFAULT 0,
    last_update TIMESTAMP
);
insert into delivery values(601,'2023-03-26',4,503,80,now());

#__PAYMENT_______________________________________________________________________________________________________
CREATE TABLE payment (
    payment_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
    payment_date TIMESTAMP,
    order_id SMALLINT UNIQUE not null,
    FOREIGN KEY (order_id)
        REFERENCES purchase_order (order_id),
    total_payment DECIMAL(7 , 2 ),
    payment_details VARCHAR(50),
    last_update TIMESTAMP
);

insert into payment values(701,'2023-01-06 12:41:34',501,180,null,now());
insert into payment(payment_date,order_id,total_payment,payment_details,last_update) 
values('2023-02-10 12:41:34',502,100,null,now()),
('2023-03-26 12:41:34',503,180,null,now());


#Queries 
USE small_bazar2;
#____QUESTION NO 1___________________________________________________________________________________________________
/*1. The CEO of ‘Small Bazar’ wants to check the profitability of the Branches. Create a View
for his use which will show monthly Profit of all Branches for the current year. */

# grouping sum of profits of products by branch and month gives the result
CREATE VIEW display_monthly_profit_for_current_year AS
	SELECT 
		MONTHNAME(order_date) AS month,
		branch_id,
		SUM((selling_price - cost_price) * no_of_units) AS profit
	FROM
		
		product_order 
			INNER JOIN
		purchase_order USING (order_id)
	GROUP BY branch_id , month;

# check output
SELECT * FROM display_monthly_profit_for_current_year;

#____QUESTION NO 2___________________________________________________________________________________________________
/*2. Create a stored procedure having countryName, FromDate and ToDate as Parameter,
which will return Sitewise, Item Wise and Date Wise the number of items sold in the
given Date range as separate resultsets. Create appropriate Indexes on the tables.*/
DROP PROCEDURE display_no_of_items_for_country;
DELIMITER //
CREATE PROCEDURE display_no_of_items_for_country(in country varchar(30), in fromdate date, in todate date)
DETERMINISTIC
BEGIN
	# get no of items for given country with respect to city
		SELECT 
			city_name, SUM(no_of_units) AS units_of_items_sold
		FROM
			address
				JOIN
			branch USING (address_id)
				JOIN
			purchase_order USING (branch_id)
				JOIN
			product_order USING (order_id)
		WHERE
			country_name = country
				AND order_date BETWEEN fromdate AND todate
		GROUP BY city_name;
	
    	# get no of items for given country with respect to items
		SELECT 
			country_name,
			city_name,
			product_id,
			SUM(no_of_units) AS units_of_items_sold
		FROM
			product_order
				JOIN
			purchase_order USING (order_id)
				JOIN
			branch USING (branch_id)
				JOIN
			address USING (address_id)
		WHERE
			country_name = country
				AND order_date BETWEEN fromdate AND todate
		GROUP BY product_id;
	
    # get no of items for given country with respect to date
		SELECT 
			country_name,
			DATE(order_date),
			SUM(no_of_units) AS units_of_items_sold
		FROM
			product_order
				JOIN
			purchase_order USING (order_id)
				JOIN
			branch USING (branch_id)
				JOIN
			address USING (address_id)
		WHERE
			country_name = country
				AND order_date BETWEEN fromdate AND todate
		GROUP BY order_date;

END; //

#check output
CALL display_no_of_items_for_country('india','2023-01-01','2023-12-31');

#_____QUESTION NO 3__________________________________________________________________________________________________
/* 3. Create a stored procedure which will calculate the total bill for any order. Bill should
have details like:
CustomerName,
orderId,
OrderDate,
Branch,
ProductName,
Price per Unit,
No. Of Units,
Total Cost of that product,
Total Bill Amount,
Additional Charges (0 if none),
Delivery Option (‘Home Delivery&#39; or ‘self-Pickup’). */

DELIMITER //
CREATE PROCEDURE display_bill_details(in orderid int)
DETERMINISTIC
BEGIN
		SELECT 
			CONCAT(first_name,last_name) AS 'customer name',
			order_id,
			order_date,
			purchase_order.branch_id,
			product_name,
			product_order.selling_price AS 'price per unit',
			product_order.no_of_units,
			total_payment AS 'total bill amount',
			delivery_charges AS 'additional charges'
		FROM
			customer
				JOIN
			purchase_order USING (customer_id)
				LEFT JOIN
			delivery USING (order_id)
				JOIN
			payment USING (order_id)
				JOIN
			product_order USING (order_id)
				JOIN
			product USING (product_id)
				WHERE
			order_id = orderid;
END; //

#check output
CALL display_bill_details(501);

#______QUESTION NO 4_________________________________________________________________________________________________
/*4. Create a (function) Procedure having a parameter as country name, which displays all
the branches available in the country that are active. */

# compare given country with all branch's country and its status = activate
DELIMITER //
CREATE PROCEDURE display_active_branches(IN country varchar(30))
DETERMINISTIC
BEGIN
	SELECT 
		branch_id, branch_name
	FROM
		branch
	WHERE
		branch_status = 'activate'
			AND address_id IN (SELECT 
				address_id
			FROM
				address
			WHERE
				country_name = country);
END; //

#check output
CALL display_active_branches('INDIA');


#____QUESTION NO 5___________________________________________________________________________________________________
/*5. The CEO of ‘Small Bazar’ wants to check the profitability of the Branches. Create a
stored procedure that shows the branch profit if profit is below a certain threshold flag
that branch as below par performance. */
# whole profit of branches is compared with throshold and low performance branches are displayed
DELIMITER //
CREATE PROCEDURE get_low_performance_braches(in threshold decimal(7,2))
DETERMINISTIC
BEGIN
	SELECT 
		branch_id,
		SUM((po.selling_price - po.cost_price) * no_of_units) AS profit
	FROM
		product_order AS po
			JOIN
		product USING (product_id)
	GROUP BY branch_id
	HAVING profit < threshold;

END; //

# check output
CALL get_low_performance_braches(70);

#____QUESTION NO 6___________________________________________________________________________________________________
/*6.find out country where people are using least plastic bag while they are shopping. */
# plastic bags items are  added to product_order table
INSERT INTO product_order VALUES(412,501,5,10,2,20,now()),
								(413,502,5,10,3,30,now());


# get country using least palstic bags
select min(count_plastic_bags),country_name from (SELECT 
    country_name,
    SUM(product_order.no_of_units) AS count_plastic_bags
FROM
    product
        JOIN
    product_order USING (product_id)
        JOIN
    purchase_order USING (order_id)
        JOIN
    customer USING (customer_id)
        JOIN
    address USING (address_id)
WHERE
    product_name = 'Plastic Bag'
GROUP BY address.country_name) as count_plastic;

#____QUESTION NO 7___________________________________________________________________________________________________
/*
7. Many business owners focus only on customer acquisition, but customer retention can
also drive loyalty, word of mouth marketing, and higher order values. But CEO want to know if

when a customer shops if he is new customer or old customer, if old customer keep count of
that customer visited small bazar regardless or branch, city, country
If customer shops more than 10 times
Give me privilege customer category
*/
# customer table is alterd by adding count column to it and values are added to it
ALTER TABLE customer ADD COLUMN count SMALLINT;
UPDATE customer SET count = 10 WHERE customer_id = 101;
UPDATE customer SET count = 2 WHERE customer_id != 101;


# update count of customer for orders when customer places the order in small bazar after insert
DELIMITER //
CREATE TRIGGER update_customer_count AFTER INSERT
ON purchase_order FOR EACH ROW  
BEGIN  
	UPDATE customer 
	SET 
		count = count + 1
	WHERE
		customer.customer_id = NEW.customer_id;
END;  //

# get privilage customer category
CREATE VIEW privilaged_customers AS
	SELECT 
		customer_id,
		CONCAT(first_name, last_name) AS 'customer name'
	FROM
		customer
	WHERE
		count >= 10;

# check output
SELECT * FROM privilaged_customers;


#____OPTIONAL QUESTION 1___________________________________________________________________________________________________

/*Write a Trigger which will reduce the stock of some product whenever an order is confirmed by
the number of that product in the order. E.g. If an order with 10 Oranges is confirmed from
Nagpur branch, Stock of Oranges from Nagpur branch must be reduced by 10.*/

# substract no of units of product in order from net quantity of it in inventory to update inventory
DELIMITER //
CREATE TRIGGER update_stock_inventory AFTER INSERT
ON product_order FOR EACH ROW
BEGIN
	UPDATE product 
	SET 
		net_quantity = net_quantity - NEW.no_of_units
	WHERE
		product_id = NEW.product_id;

END; //

#insert some item for given order to product_order table
INSERT INTO product_order VALUES (405,503,20,40,1,40,NOW());

# check updates
SELECT * FROM product_order;
SELECT * FROM product;


#____OPTIONAL QUESTION 2___________________________________________________________________________________________________
/*Create a trigger which will be invoked on adding a new item in the Item entity and insert that
new item in another table with date and time when the item is added so that we can have date
and time when an item was added. */

#create table new_products_date which will store product_id and time, date to store records of 
#newly added products
CREATE TABLE new_products_date (
    product_id SMALLINT,
    FOREIGN KEY (product_id)
        REFERENCES product (product_id),
    create_time TIMESTAMP
);

# create trigger to insert record into new_products_date table when newly added to product table
DELIMITER //
CREATE TRIGGER insert_new_products_date AFTER INSERT ON product FOR EACH ROW
BEGIN
	INSERT INTO new_products_date VALUES(NEW.product_id,now());

END; //

# insert some product into product table
INSERT INTO product(product_name,branch_id,discription,product_type,net_quantity,cost_price,
					selling_price,company,manuf_date,state,last_update) 
VALUES
	('Diary2023',302,'book',null,100,100,150,null,'2022-12-30','activate',now());

#check output
SELECT * FROM product;
SELECT * FROM new_products_date;


