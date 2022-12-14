create database final_assgn;

use final_assgn;

CREATE TABLE events(
event_time VARCHAR(150),
event_type VARCHAR(150),
product_id VARCHAR(150),
category_id VARCHAR(150),
category_code VARCHAR(150),
brand VARCHAR(150),
price VARCHAR(150),
user_id VARCHAR(150),
user_session VARCHAR(150));

select * from events;
-- disabling safe update mode
SET SQL_SAFE_UPDATES =0;



-- removing UTC from event_time
UPDATE events
SET event_time = trim('UTC' from event_time);



-- updating UTC to IST
UPDATE events
SET event_time = convert_tz(event_time,'+00:00','+05:30');

----updating price datatype into float

alter table events 
 modify price float(10,2);

/*
--1
Here students are required to find months in decreasing order of sales and 
also highest sales in which month and year and lowest sales in which 
month and year with the help of SQL query.
*/

select year(event_time) as year,month(event_time) as month,
sum(price) as sales 
from events group by year(event_time),month(event_time)
order by sales desc;

desc events

select year(event_time) as year,month(event_time) as month,
(price) as sales 
from events group by year(event_time),month(event_time)
order by sales asc;

/*
2)Top Time of Visit: 
Here Students are required to calculate the time for viewing, adding 
to cart and Purchase time with help of SQL query and need to
 confirm if mostly viewed  and added to cart time is similar to Purchase time or not.
 select * from events
 */
 
 with CTE as
 (select *,case
 WHEN TIME (event_time) between '00:00:00' and '04:00:00' then 'late_night'
 WHEN TIME (event_time) between '04:00:00' and '08:00:00' then 'early_morning'
 WHEN TIME (event_time) between '08:00:00' and '12:00:00' then 'morning'
 WHEN TIME (event_time) between '12:00:00' and '16:00:00' then 'afternoon'
 WHEN TIME (event_time) between '16:00:00' and '20:00:00' then 'evening'
 WHEN TIME (event_time) between '20:00:00' and '24:00:00' then 'night'
 end as event_time_catagory
      from events)
select * FROM CTE;      


 with CTE as
 (select *,case
 WHEN TIME (event_time) between '00:00:00' and '04:00:00' then 'late_night'
 WHEN TIME (event_time) between '04:00:00' and '08:00:00' then 'early_morning'
 WHEN TIME (event_time) between '08:00:00' and '12:00:00' then 'morning'
 WHEN TIME (event_time) between '12:00:00' and '16:00:00' then 'afternoon'
 WHEN TIME (event_time) between '16:00:00' and '20:00:00' then 'evening'
 WHEN TIME (event_time) between '20:00:00' and '24:00:00' then 'night'
 end as event_time_catagory
      from events)
select event_type,event_time_catagory ,count(*) as total_event_type 
from CTE
group by event_time_catagory,event_type 
order by total_event_type desc; 


with CTE as
 (select *,case
 WHEN TIME (event_time) between '00:00:00' and '04:00:00' then 'late_night'
 WHEN TIME (event_time) between '04:00:00' and '08:00:00' then 'early_morning'
 WHEN TIME (event_time) between '08:00:00' and '12:00:00' then 'morning'
 WHEN TIME (event_time) between '12:00:00' and '16:00:00' then 'afternoon'
 WHEN TIME (event_time) between '16:00:00' and '20:00:00' then 'evening'
 WHEN TIME (event_time) between '20:00:00' and '24:00:00' then 'night'
 end as event_time_catagory
      from events),
      CTEM as
      (select event_type,event_time_catagory ,count(*) as total_event_type from CTE
	  group by event_time_catagory,event_type 
      order by total_event_type desc)select event_type,event_time_catagory , total_event_type
      from CTEM
      where total_event_type in(select max(total_event_type) from CTEM group by event_type)





3) Top brands by Sale:
 Here Students are required to find Top 6 brand w.r.t 
Sales which is the Top Brand followed by other brand with the help of SQL query.

select brand,sum(price) as total_price
from events
where event_type='purchase'
group by brand order by total_price desc
limit 6


4)  Demand for Items: Here Students are required to find Top 6 Category which was
    sold most number of times and should also show the count as well.
 select * from events
 
select category_code,count(category_id) as sold_time
from events where event_type='purchase'
group by category_code order by sold_time desc
limit 6


5)Frequency of Purchase- Here Students are required to find count of Users who has purchase at each time i.e. 
number of users purchasing once,twice,thrice etc once in a given time span of 5 months 
and also Maximum number of Times one person has purchased in a given time span of 5 months
select * from events

select year(event_time)year,month(event_time)month, count(*) as users_purchase
from events where event_type ='purchase'
group by  year,month
order by users_purchase Desc

6)Actual Time purchased – Here Students have to find the number of times that the item has actually been purchased 
after the users have viewed the items i.e. the query should give result for actual number of times purchased.
Also query should be written to find the number of times the item has been viewed.

select event_type,count(*)
from events 
group by event_type;









