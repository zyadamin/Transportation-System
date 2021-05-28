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

insert into trip values (4.5,'2000/02/03',1,5,2,'metro','maadi',15,'abo el feda ','zmlek',50,null,1,1)

insert into trip values (4,'2000/04/03',2,3,8,'ansar','embaba',15,'shar3 9','maadi',90,null,2,2)
insert into trip values (4,'2000/04/03',8,3,8,'ansar','embaba',15,'shar3 9','maadi',2,2,90,60)
insert into trip values (3,'2000/04/05',3,4.5,8,'ansar','embaba',15,'teraa','shopra',60,'2545',3,3)
insert into trip values (3,'2000/04/09',4,4,8,'ansar','giza',15,'teraa','shopra',60,'2545',3,3)
insert into trip values (4,'2000/05/09',5,5,8,'ansar','giza',15,'teraa','shopra',60,'111',3,4)
insert into trip values (4,'2000/04/09',6,5,8,'ansar','giza',15,'teraa','shopra',3,4,60,'111')

/a. What was the area that had the most/least ride requests last month?
select trip.s_city as min_City
from trip
where Month(trip.Request_time)=4
group by(trip.s_city )
having COUNT(trip.s_city ) = (select min( y.num) 
FROM (select  COUNT(trip.s_city) AS num
FROM  trip
group by(trip.s_city)) y)

select trip.s_city as max_City
from trip
where Month(trip.Request_time)=4
group by(trip.s_city )
having COUNT(trip.s_city ) = (select max( y.num) 
FROM (select  COUNT(trip.s_city) AS num
FROM  trip
group by(trip.s_city)) y)



/b. Who were the drivers with the maximum number of rides last month?
select  driver.Name ,driver.driver_ID
from trip,driver
where Month(trip.Request_time)=4 and driver.driver_ID=trip.driver_ID
group by driver.Name ,driver.driver_ID
having COUNT(trip.driver_ID ) = (select max( y.num) 
FROM (select  COUNT(trip.driver_ID) AS num
FROM  trip
group by(trip.driver_ID)) y)




/c. For each driver, retrieve all his/her information and the number of rides he/she had

select *, no_trips=(select  count(driver_ID)
from trip
where driver.driver_ID=trip.driver_ID)
from driver










/d. Which driver got at least 4.5 out of 5 on every user rating he/she got?
select driver.Name,AVG(trip.Driver_rate)as avg_rate
from trip,driver
where trip.driver_ID=driver.driver_ID 
group by driver.Name
having  AVG(trip.Driver_rate) in(4.5 ,5)




/e. Who were the drivers that didn’t have any ride last month?



select *
from driver 
where  Not EXISTS(
select driver_ID 
from trip 
where driver.driver_ID=trip.driver_ID and MONTH(trip.Request_time)=4)


f. What is the most type of vehicle (car, bus, and scooter) requested last month?

select vehicle.vehicle_type
from trip,driver,vehicle
where trip.driver_ID = driver.driver_ID and driver.ID=vehicle.vehicle_ID  and Month(trip.Request_time)=4
group by(vehicle.vehicle_type)
having count(vehicle.vehicle_ID)=(select MAX(y.num)
from(
select  COUNT(vehicle.vehicle_type) as num
from trip,driver,vehicle
where trip.driver_ID = driver.driver_ID and driver.ID=vehicle.vehicle_ID and Month(trip.Request_time)=4
group by(vehicle.vehicle_type)) y)

delete 
from trip
where trip_ID>5













