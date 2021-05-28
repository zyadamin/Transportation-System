insert into user1 values(1,'manar',011,'female','cash',111,null)
insert into user1 values(2,'zyad',01,'male','card',555,1234)
insert into user1 values(3,'mohamed',012,'male','cash',666,null)
insert into user1 values(4,'nour',011,'female','visa',888,456)

insert into vehicle values('car',123,1)
insert into vehicle values('bus',124,2)
insert into vehicle values('scoter',125,3)
insert into vehicle values('bus',125,4)

insert into driver values('ahmed',1,012,123,1)
insert into driver values('emaad',2,011,123,2)
insert into driver values('khaled',3,010,123,3)
insert into driver values('ibrahim',4,555,123,4)



insert into trip values (4.5,'2000/02/03',1,5,2,'metro','maadi',15,'abo el feda ','zmlek',1,1,null,50)

insert into trip values (4,'2000/04/02',2,3,8,'ansar','embaba',15,'shar3 9','maadi',2,2,null,90)

insert into trip values (3,'2000/04/03',3,4.5,8,'ansar','embaba',15,'teraa','shopra',3,3,'2545',60)

insert into trip values (3,'2000/04/05',4,4.5,8,'ansar','embaba',15,'teraa','shopra',3,3,'2545',60)

a. What was the area that had the most/least ride requests last month?

select trip.s_city 
from trip
group by(trip.s_city )
having COUNT(trip.s_city ) = (select min( y.num) 
FROM (select  COUNT(trip.s_city) AS num
FROM  trip
where MONTH(trip.Request_time)=4
group by(trip.s_city)) y) 



select trip.s_city 
from trip
where MONTH(trip.Request_time)=4
group by(trip.s_city )
having COUNT(trip.s_city ) = (select min( y.num) 
FROM (select  COUNT(trip.s_city) AS num
FROM  trip
group by(trip.s_city)) y) 

b. Who were the drivers with the maximum number of rides last month?

select driver.Name ,COUNT(trip.driver_ID) as no_trips 
from trip,driver 
where trip.driver_ID=driver.driver_ID and MONTH(trip.Request_time)=4
group by(driver.Name) 
having COUNT(trip.driver_ID) = (select max( y.num) 
FROM (select driver.Name , COUNT(trip.driver_ID) AS num
FROM  trip,driver
where trip.driver_ID =driver.driver_ID
group by(driver.Name)) y)


c. For each driver, retrieve all his/her information and the number of rides he/she had.

select *,no_of=(select count(trip.driver_ID)
from trip
where driver.driver_ID = trip.driver_ID)
from driver

d. Which driver got at least 4.5 out of 5 on every user rating he/she got?

select driver.Name ,avg(Driver_rate)
from trip,driver
where driver.driver_ID=trip.driver_ID
group by(driver.Name)
having avg(Driver_rate)>=4.5



e. Who were the drivers that didn’t have any ride last month?

select *
from driver 
where  Not EXISTS(
select driver_ID 
from trip 
where driver.driver_ID=trip.driver_ID and MONTH(trip.Request_time)=4)








f. What is the most type of vehicle (car, bus, and scooter) requested last month?




select vehicle.vehicle_type
from trip,driver,vehicle
where trip.driver_ID = driver.driver_ID and driver.ID=vehicle.vehicle_ID 
group by(vehicle.vehicle_type)
having count(vehicle.vehicle_ID)=(select MAX(y.num)
from(
select  COUNT(vehicle.vehicle_type) as num
from trip,driver,vehicle
where trip.driver_ID = driver.driver_ID and driver.ID=vehicle.vehicle_ID 
group by(vehicle.vehicle_type)) y)




select  count(trip.driver_ID)as no_trips
from trip
group by trip.driver_ID
cross join

select mycount 
from (
select trip.driver_ID ,count(trip.driver_ID) mycount
from trip
group by driver_ID)


select Name, max( y.num) as uo
FROM (select driver.Name , COUNT(trip.driver_ID) AS num
FROM  trip,driver
where trip.driver_ID =driver.driver_ID
group by(driver.Name)) y
where  y.num =uo
group by(Name)



select driver.Name ,COUNT(trip.driver_ID)  
from trip,driver 
where trip.driver_ID=driver.driver_ID
group by(driver.Name) 
having COUNT(trip.driver_ID) = (select max( y.num) 
FROM (select driver.Name , COUNT(trip.driver_ID) AS num
FROM  trip,driver
where trip.driver_ID =driver.driver_ID
group by(driver.Name)) y)



select trip.trip_ID, MONTH(trip.Request_time) as month
from trip