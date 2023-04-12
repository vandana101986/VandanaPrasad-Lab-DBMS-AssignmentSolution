create schema eCommerce;
use eCommerce;

create table supplier(SUPP_NAME varchar(20) NOT NULL,SUPP_CITY varchar(20) NOT NULL,SUPP_PHONE varchar(10) NOT NULL);
alter table supplier ADD SUPP_ID int PRIMARY KEY;
create table customer(CUS_ID int PRIMARY KEY,CUS_NAME varchar(20) NOT NULL, CUS_PHONE varchar(10) NOT NULL,CUS_CITY varchar(20) NOT NULL,CUS_GENDER char);
create table category(CAT_ID int PRIMARY KEY,CAT_NAME varchar(20) NOT NULL);
create table product(PROD_ID int PRIMARY KEY,PROD_NAME varchar(20) NOT NULL DEFAULT "DUMMY",PROD_DESC varchar(60), CAT_ID int, FOREIGN KEY (CAT_ID) REFERENCES category(CAT_ID));
create table supplier_pricing(PRICING_ID int PRIMARY KEY,PROD_ID int, SUPP_ID int,SUPP_PRICE int DEFAULT 0, FOREIGN KEY(SUPP_ID) REFERENCES supplier(SUPP_ID),FOREIGN KEY(PROD_ID) REFERENCES product(PROD_ID));
create table order_details(ORD_ID int PRIMARY KEY, ORD_AMOUNT int NOT NULL, ORD_DATE date NOT NULL, CUS_ID int, PRICING_ID int, FOREIGN KEY(CUS_ID) references customer(CUS_ID),FOREIGN KEY(PRICING_ID) references supplier_pricing(PRICING_ID));
create table rating(RAT_ID int PRIMARY KEY, ORD_ID int, RAT_RATSTARS int NOT NULL, FOREIGN KEY(ORD_ID) references order_details(ORD_ID));

insert into supplier values("Rajesh Retails", "Delhi", "1234567890",1);
insert into supplier values("Appario Ltd.", "Mumbai", "2589631470",2);
insert into supplier values("Knome products", "Banglore", "9785462315",3);
insert into supplier values("Bansal Retails", "Kochi", "8975463285",4);
insert into supplier values("Mittal Ltd.", "Lucknow", "7898456532",5);

insert into customer values(1, "AAKASH", "9999999999", "DELHI", "M");
insert into customer values(2, "AMAN", "9785463215", "NOIDA", "M");
insert into customer values(3, "NEHA","9999999999", "MUMBAI", "F");
insert into customer values(4, "MEGHA", "9994562399", "KOLKATA", "F");
insert into customer values(5, "PULKIT", "7895999999", "LUCKNOW", "M");

insert into category values(1, "BOOKS");
insert into category values(2, "GAMES");
insert into category values(3, "GROCERIES");
insert into category values(4, "ELECTRONICS");
insert into category values(5, "CLOTHES");

insert into product values(1, "GTA V", "Windows 7 and above with i5 processor and 8GB RAM", 2);
insert into product values(2, "TSHIRT", "SIZE-L with Black, Blue and White variations", 5);
insert into product values(3, "ROG LAPTOP", "Windows 10 with 15inch screen, i7 processor, 1TB SSD", 4);
insert into product values(4, "OATS", "Highly Nutritious from Nestle", 3);
insert into product values(5, "HARRY POTTER", "Best Collection of all time by J.K Rowling", 1);
insert into product values(6, "MILK", "1L Toned MIlk", 3);
insert into product values(7, "Boat Earphones", "1.5Meter long Dolby Atmos", 4);
insert into product values(8, "Jeans", "Stretchable Denim Jeans with various sizes and color", 5);
insert into product values(9, "Project IGI", "compatible with windows 7 and above", 2);
insert into product values(10, "Hoodie", "Black GUCCI for 13 yrs and above", 5);
insert into product values(11, "Rich Dad Poor Dad", "Written by RObert Kiyosaki", 1);
insert into product values(12, "Train Your Brain", "By Shireen Stephen", 1);

insert into supplier_pricing values(1, 1, 2, 1500);
insert into supplier_pricing values(2, 3, 5, 30000);
insert into supplier_pricing values(3, 5, 1, 3000);
insert into supplier_pricing values(4, 2, 3, 2500);
insert into supplier_pricing values(5, 4, 1, 1000);

insert into order_details values(101, 1500, '2021-10-06', 2, 1);
insert into order_details values(102, 1000, '2021-10-12', 3, 5);
insert into order_details values(103, 30000, '2021-09-16', 5, 2);
insert into order_details values(104, 1500, '2021-10-05', 1, 1);
insert into order_details values(105, 3000, '2021-08-16', 4, 3);
insert into order_details values(106, 1450, '2021-08-18', 1, 9);
insert into order_details values(107, 789, '2021-09-01', 3, 7);
insert into order_details values(108, 780, '2021-09-07', 5, 6);
insert into order_details values(109, 3000, '2021-00-10', 5, 3);
insert into order_details values(110, 2500, '2021-09-10', 2, 4);
insert into order_details values(111, 1000, '2021-09-15', 4, 5);
insert into order_details values(112, 789, '2021-09-16', 4, 7);
insert into order_details values(113, 31000, '2021-09-16', 1, 8);
insert into order_details values(114, 1000, '2021-09-16', 3, 5);
insert into order_details values(115, 3000, '2021-09-16', 5, 3);
insert into order_details values(116, 99, '2021-09-17', 2, 14);

insert into rating values(1, 101, 4);
insert into rating values(2, 102, 3);
insert into rating values(3, 103, 1);
insert into rating values(4, 104, 2);
insert into rating values(5, 105, 4);
insert into rating values(6, 106, 3);
insert into rating values(7, 107, 4);
insert into rating values(8, 108, 4);
insert into rating values(9, 109, 3);
insert into rating values(10, 110, 5);
insert into rating values(11, 111, 3);
insert into rating values(12, 112, 4);
insert into rating values(13, 113, 2);
insert into rating values(14, 114, 1);
insert into rating values(15, 115, 1);
insert into rating values(16, 116, 0);

/* Question 3 */
select CUS_GENDER as GENDER, count(CUS_GENDER) as COUNT from customer where CUS_ID IN(select CUS_ID from order_details where ORD_AMOUNT >=3000) group by CUS_GENDER;

/* Question 4 */
select product.PROD_NAME, order_details.* from order_details, supplier_pricing, product
where order_details.CUS_ID=2 and
order_details.PRICING_ID=supplier_pricing.PRICING_ID and supplier_pricing.PROD_ID=product.PROD_ID;

/* Question 5 */
select * from supplier where supplier.SUPP_ID in
(select SUPP_ID from supplier_pricing group by SUPP_ID having
count(SUPP_ID)>1)
group by supplier.SUPP_ID;

/* Question 6 */
select category.CAT_ID,category.CAT_NAME, min(t2.min_price) as Min_Price from category inner join
(select product.CAT_ID, product.PROD_NAME, t1.* from product inner join
(select PROD_ID, min(SUPP_PRICE) as Min_Price from supplier_pricing group by PROD_ID)
as t1 where t1.PROD_ID = product.PROD_ID)
as t2 where t2.CAT_ID = category.CAT_ID group by t2.CAT_ID;

/* Question 7 */
select PROD_ID from supplier_pricing where PRICING_ID in(select PRICING_ID from order_details where ORD_DATE > '2021-10-05');

/* Question 8 */
select CUS_NAME, CUS_GENDER from customer where CUS_NAME LIKE 'A%' OR CUS_NAME LIKE '%A';

/*Question 9 */
DELIMITER &&
CREATE PROCEDURE proc()
BEGIN select report.SUPP_ID,report.SUPP_NAME,report.Average,
CASE
 WHEN report.Average =5 THEN 'Excellent Service'
 WHEN report.Average >4 THEN 'Good Service'
 WHEN report.Average >2 THEN 'Average Service'
 ELSE 'Poor Service'
END AS Type_of_Service from
(select final.SUPP_ID, supplier.SUPP_NAME, final.Average from
(select test2.SUPP_ID, sum(test2.RAT_RATSTARS)/count(test2.RAT_RATSTARS) as Average from
(select supplier_pricing.SUPP_ID, test.ORD_ID, test.RAT_RATSTARS from supplier_pricing inner join
(select order_details.PRICING_ID, rating.ORD_ID, rating.RAT_RATSTARS from order_details inner join rating on rating.ORD_ID = order_details.ORD_ID ) as test
on test.PRICING_ID = supplier_pricing.PRICING_ID)
as test2 group by supplier_pricing.SUPP_ID)
as final inner join supplier where final.SUPP_ID = supplier.SUPP_ID) as report;
END &&
DELIMITER ;
call proc();

/* Explaination of Delimiter 

By default mysql considers ; as end of a statement.
When we create procedures or triggers, they can contain multiple statements ending with ; . Mysql terminates the execution when it sees ;. To continue with the execution of all statements of the procedure or the trigger, we need to use a temporary delimiter. 

We can use the 'Create Procedure' option under 'Stored Procedure'. We need not mention the delimiter here. Mysql will automatically apply the delimiter when creating the procedure. */

