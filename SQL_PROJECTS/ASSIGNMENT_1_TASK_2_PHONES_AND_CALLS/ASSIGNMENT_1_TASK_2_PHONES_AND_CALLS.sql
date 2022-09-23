
-- ASSIGNMENT 2 : TASK 2 - PHONES AND CALLS
-- ********************************************

use "INEURON_ASGMT_DB";

Create table phones(
name varchar(20) not null unique,
phone_number int not null unique
);

Create table calls(
id integer not null,
caller integer not null,
callee integer not null,
duration integer not null,
unique (id)
);

Insert into phones(name,phone_number ) values
('Jack', 1234),
('Lena', 3333),
('Mark', 9999),
('Anna', 7582);

Insert into calls(id,caller, callee, duration ) values
(25,1234,7582,8),
(7,9999,7582,1),
(18,9999,3333,4),
(2,7582,3333,3),
(3,3333,1234,1),
(21,3333,1234,1);

Select * from phones;
Select * from calls;

-- Problem Statement : Write a SQL query that finds all the clients who talked for atleast 10 mins in total The table of results should contain 1 column : the name of the client(name). Rows should be sorted alphabetically.

Select phones.name from phones
join (
Select distinct caller , sum (filter1) as call_duration from (
Select distinct caller, sum(duration) over(partition by caller) filter1 from c                                                             
Union 
Select distinct callee, sum(duration) over(partition by callee) filter2 from calls)
group by caller) as call_records on phones.phone_number=call_records.caller
having call_records.call_duration >=10
order by phones.name;


