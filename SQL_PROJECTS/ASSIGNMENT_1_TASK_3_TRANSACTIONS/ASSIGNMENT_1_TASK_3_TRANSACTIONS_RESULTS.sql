
-- ASSIGNMENT 1 : TASK 3 - TRANSACTIONS
-- ********************************************

use "INEURON_ASGMT_DB";

Create table transactions(
amount integer not null,
transdate date not null
);

-- DATA SCENARIO 1

Insert into transactions(amount, transdate) values
(1000,'2020-01-06'),
(-10,'2020-01-14'),
(-75,'2020-01-20'),
(-5,'2020-01-25'),
(-4,'2020-01-29'),
(2000,'2020-03-10'),
(-75,'2020-03-12'),
(-20,'2020-03-15'),
(40,'2020-03-15'),
(-50,'2020-03-17'),
(200,'2020-10-10'),
(-200,'2020-10-10');


Select distinct SUM(total_transaction) over() - (12-total_trans_months)*5 as balance from (
Select month, num_of_credit_trans, sum_of_credit_trans, sum_of_incoming_trans,
case 
   when (num_of_credit_trans >=3 AND ABS(sum_of_credit_trans) >= 100) then (sum_of_incoming_trans - (ABS(sum_of_credit_trans) + 0))
   else (sum_of_incoming_trans - (ABS(sum_of_credit_trans) + 5))
   End as total_transaction,
count(*) over() total_trans_months    
from 
(
Select monthname(transdate) as month,
count(case when amount < 0 then 1 else NULL end) as num_of_credit_trans ,
sum(case when amount < 0 then amount else 0 end) as sum_of_credit_trans ,
sum(case when amount > 0 then amount else 0 end) as sum_of_incoming_trans 
from transactions
group by 1
));  --  2746

-- DATA SCENARIO 2

truncate table transactions;

insert into transactions(amount, transdate) values
(1,'2020-06-29'),
(35,'2020-02-20'),
(-50,'2020-02-03'),
(-1,'2020-02-26'),
(-200,'2020-08-01'),
(-44,'2020-02-07'),
(-5,'2020-02-25'),
(1,'2020-06-29'),
(1,'2020-06-29'),
(-100,'2020-12-29'),
(-100,'2020-12-30'),
(-100,'2020-12-31');

Select distinct SUM(total_transaction) over() - (12-total_trans_months)*5 as balance from (
Select month, num_of_credit_trans, sum_of_credit_trans, sum_of_incoming_trans,
case 
   when (num_of_credit_trans >=3 AND ABS(sum_of_credit_trans) >= 100) then (sum_of_incoming_trans - (ABS(sum_of_credit_trans) + 0))
   else (sum_of_incoming_trans - (ABS(sum_of_credit_trans) + 5))
   End as total_transaction,
count(*) over() total_trans_months    
from 
(
Select monthname(transdate) as month,
count(case when amount < 0 then 1 else NULL end) as num_of_credit_trans ,
sum(case when amount < 0 then amount else 0 end) as sum_of_credit_trans ,
sum(case when amount > 0 then amount else 0 end) as sum_of_incoming_trans 
from transactions
group by 1
)); -- -612


-- DATA SCENARIO 3

truncate table transactions;

Insert into transactions(amount, transdate) values
(6000,'2020-04-03'),
(5000,'2020-04-02'),
(4000,'2020-04-01'),
(3000,'2020-03-01'),
(2000,'2020-02-01'),
(1000,'2020-01-01');

Select distinct SUM(total_transaction) over() - (12-total_trans_months)*5 as balance from (
Select month, num_of_credit_trans, sum_of_credit_trans, sum_of_incoming_trans,
case 
   when (num_of_credit_trans >=3 AND ABS(sum_of_credit_trans) >= 100) then (sum_of_incoming_trans - (ABS(sum_of_credit_trans) + 0))
   else (sum_of_incoming_trans - (ABS(sum_of_credit_trans) + 5))
   End as total_transaction,
count(*) over() total_trans_months    
from 
(
Select monthname(transdate) as month,
count(case when amount < 0 then 1 else NULL end) as num_of_credit_trans ,
sum(case when amount < 0 then amount else 0 end) as sum_of_credit_trans ,
sum(case when amount > 0 then amount else 0 end) as sum_of_incoming_trans 
from transactions
group by 1
)); -- 20940





