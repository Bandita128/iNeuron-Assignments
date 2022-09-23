
-- ASSIGNMENT 2 : TASK 1 - SHOPPING HISTORY
-- ********************************************

Create database "INEURON_ASGMT_DB";
use "INEURON_ASGMT_DB";

Create table shopping_history
(
  product varchar not null,
  quantity integer not null,
  unit_price int not null
);


Insert into shopping_history(product,quantity,unit_price) values('Milk', 2, 30);
Insert into shopping_history(product,quantity,unit_price) values('Bread', 1, 45);
Insert into shopping_history(product,quantity,unit_price) values('Yoghurt', 3, 30);
Insert into shopping_history(product,quantity,unit_price) values('Milk', 4, 30);
Insert into shopping_history(product,quantity,unit_price) values('Biscuit', 3, 25);
Insert into shopping_history(product,quantity,unit_price) values('Kellogs', 2, 100);
Insert into shopping_history(product,quantity,unit_price) values('Toothpaste', 1, 109);
Insert into shopping_history(product,quantity,unit_price) values('Milk', 2, 30);
Insert into shopping_history(product,quantity,unit_price) values('Cadbury', 5, 40);
Insert into shopping_history(product,quantity,unit_price) values('Paneer', 1, 90);
Insert into shopping_history(product,quantity,unit_price) values('Kellogs', 1, 100);
Insert into shopping_history(product,quantity,unit_price) values('Milk', 6, 30);
Insert into shopping_history(product,quantity,unit_price) values('Biscuit', 1, 25);
Insert into shopping_history(product,quantity,unit_price) values('Biscuit', 6, 30);
Insert into shopping_history(product,quantity,unit_price) values('Milk', 3, 30);
Insert into shopping_history(product,quantity,unit_price) values('Biscuit', 4, 25);
Insert into shopping_history(product,quantity,unit_price) values('Bread', 2, 45);
Insert into shopping_history(product,quantity,unit_price) values('Yoghurt', 2, 30);
Insert into shopping_history(product,quantity,unit_price) values('Toothpaste', 1, 109);
Insert into shopping_history(product,quantity,unit_price) values('Cadbury', 2, 40);


Select * from shopping_history;

-- Problem Statement : Write a SQL query that , for each 'product' returns the total amount of money spent on it. Rows should be ordered in decending alphabetical order by 'product'.

Select product as Product , sum(quantity*unit_price) as Total_Price from shopping_history
group by 1
order by 1 desc;
