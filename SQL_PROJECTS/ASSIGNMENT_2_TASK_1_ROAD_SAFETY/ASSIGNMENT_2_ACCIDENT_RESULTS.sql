
-- ASSIGNMENT 1 - Analyzing Road Safety in the UK 
-- **********************************************

Create database accidents;
Use accidents;

Create table accident(
accident_index varchar(20),
accident_severity int
);

Create table vehicles(
accident_index varchar(20),
vehicle_type varchar(50)
);

Create table vehicle_types(
vehicle_code int,
vehicle_type varchar(50)
);

Show tables;
SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = true;
SET GLOBAL local_infile=1;
SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA LOCAL INFILE 'C:/load_data/Accidents_2015.csv'
INTO TABLE accident
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@col1, @dummy, @dummy, @dummy, @dummy, @dummy, @col2, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
SET accident_index=@col1, accident_severity=@col2;

Select Count(*) from accident;

LOAD DATA LOCAL INFILE 'C:/load_data/Vehicles_2015.csv'
INTO TABLE vehicles
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@col1, @dummy, @col2, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
SET accident_index=@col1, vehicle_type=@col2;

Select * from vehicles;

LOAD DATA LOCAL INFILE 'C:/load_data/vehicle_types.csv'
INTO TABLE vehicle_types
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

Select * from accident;
Select * from vehicles;
Select * from vehicle_types;

Select * from vehicle_types where vehicle_type like '%torcycle%';

-- 1. Evaluate the median severity value of accidents caused by various Motorcycles.

create table severity(id int primary key auto_increment , vehicle_type varchar(100), median_severity varchar(20));
set sql_safe_updates=0;

Delimiter $$
Create procedure evaluate_severity()
Begin
Declare finished boolean default false;
Declare median_severity int;

declare vehicle_type_var varchar(50);
declare vehicle_type_cursor cursor for Select vehicle_type from vehicle_types where vehicle_type like '%torcycle%';
Declare continue handler for not found set finished = true;

delete from severity;

open vehicle_type_cursor;
		 the_loop : loop
			 fetch vehicle_type_cursor into vehicle_type_var;  
			 
			 if finished then
			 leave the_loop;
			 end if;
             
			   set median_severity := 0;
				
                Drop table motor_severity_data;
				
				Create table motor_severity_data as 
				Select accident.* ,vehicle_types.vehicle_type,
				row_number() over(partition by vehicle_types.vehicle_type order by accident.accident_severity) as 'row_num_value',
				count(*) over() as count_of_records
				from accident
				join vehicles on vehicles.accident_index= accident.accident_index
				join vehicle_types on vehicle_types.vehicle_code= vehicles.vehicle_type
				where vehicle_types.vehicle_type =vehicle_type_var
				order by accident.accident_severity;
             
			    Select (case when max(row_num_value)%2 = 1 then 
			    (Select accident_severity from motor_severity_data where row_num_value in (round(count_of_records/2)))
			    else (Select AVG(accident_severity) from motor_severity_data where row_num_value in (round(count_of_records/2), round(count_of_records/2) + 1))
			    end ) into median_severity
			    from motor_severity_data;

				-- Insert into severity table
                insert into severity(vehicle_type,median_severity) values(vehicle_type_var,median_severity);
                
		 end loop;		 
close vehicle_type_cursor;
End $$

Delimiter ;

call evaluate_severity();
Select * from severity;

-- 2. Evaluate Accident Severity and Total Accidents per Vehicle Type

select vehicle_types.vehicle_type as Vehicle,accident.accident_severity as Severity, count(*) as Total_Accidents from accident
join vehicles on vehicles.accident_index= accident.accident_index
join vehicle_types on vehicle_types.vehicle_code= vehicles.vehicle_type
Group by 1
order by 1,2,3;

-- 3. Calculate the Average Severity by vehicle type.

select vehicle_types.vehicle_type as Vehicle, avg(accident.accident_severity) as Average_Severity, count(*) as Total_Accidents 
from accident
join vehicles on vehicles.accident_index= accident.accident_index
join vehicle_types on vehicle_types.vehicle_code= vehicles.vehicle_type
Group by 1
order by 1;

-- 4. Calculate the Average Severity and Total Accidents by Motorcycle.

select vehicle_types.vehicle_type as Vehicle,AVG(accident.accident_severity) as Average_Severity, count(*) as Total_Accidents from accident
join vehicles on vehicles.accident_index= accident.accident_index
join vehicle_types on vehicle_types.vehicle_code= vehicles.vehicle_type
where vehicle_types.vehicle_type like '%torcycle%'
Group by 1
order by 1;



