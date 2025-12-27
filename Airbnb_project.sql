create database airbnb;
use airbnb;

#1. Import Data from both the .CSV files to create tables, Listings and Booking Details.

#2. Q2 Write a query to show names from Listings table
select count(name) from listings;
select distinct count(name) from listings;
 
#3. Write a query to fetch total listings from the listings table
select distinct count(id) from listings;

#4. Write a query to fetch total listing_id from the booking_details table
select distinct count(listing_id) from bookings;

#6. Write a query to fetch all unique host name from listings table
select distinct host_name from listings;

#7. Write a query to show all unique neighbourhood_group from listings table
select distinct neighbourhood_group from listings;
 
#9. Write a query to fetch unique room_type from listings tables
select distinct room_type from listings;

#10. Write a query to show all values of Brooklyn & Manhattan from listings tables
select * from listings
where neighbourhood_group in ('Brooklyn', 'Manhattan');

#11. Write a query to show maximum price from booking_details table
select max(price) from bookings;
select min(price) from bookings;
select avg(price) from bookings;
 
#16. Write a query to show average availability_365
select avg(availability_365) from bookings;

#17. Write a query to show id , availability_365 and all availability_365 values greater than 300
select listing_id, availability_365 from bookings
where availability_365 > 300;

#18. Write a query to show count of id where price is in between 300 to 400
select count(listing_id) from bookings
where price between 300 and 400;
 
#19. Write a query to show count of id where minimum_nights spend is less than 5
select count(listing_id) from bookings
where minimum_nights < 5;
 
select count(listing_id) from bookings
where minimum_nights > 100;

#21. Write a query to show all data of listings & booking_details
select * from listings l left join bookings b
on l.id = b.listing_id
union
select * from listings l right join bookings b
on l.id = b.listing_id;

#22. Write a query to show host name and price
select l.host_name, b.price from listings l join bookings b
on l.id = b.listing_id;

select l.room_type, b.price from listings l join bookings b
on l.id = b.listing_id;

#26. Write a query to show total price by neighbourhood_group
select l.neighbourhood_group, sum(b.price) total_price from listings l join bookings b
on l.id = b.listing_id
group by l.neighbourhood_group; 

#27. Write a query to show maximum price by neighbourhood_group
select l.neighbourhood_group, max(b.price) maximum_price from listings l join bookings b
on l.id = b.listing_id
group by l.neighbourhood_group; 

#28. Write a query to show maximum night spend by neighbourhood_group
select l.neighbourhood_group, max(b.minimum_nights) maximum_nights from listings l join bookings b
on l.id = b.listing_id
group by l.neighbourhood_group; 

#34. Write a query to show average price by room type but average price is less than 100
select l.room_type, avg(b.price) average_price from listings l join bookings b
on l.id = b.listing_id
group by l.room_type
having avg(b.price) < 100; 

#36. Write a query to show all data from listings where price is greater than 200 using sub-query.
select * from listings
where id in (select listing_id from bookings where price > 200);

#37. Write a query to show all values from booking_details table where host id is 314941 using sub-query.
select * from bookings
where listing_id in (select distinct id from listings where host_id = 314941);

#38. Find all pairs of id having the same host id, each pair coming once only.
select a.id listing1, b.id listing2
from listings a
join listings b 
on a.host_id = b.host_id
and a.id < b.id;

#39. Write an sql query to show fetch all records that have the term cozy in name
select * from listings
where lower(name) like "%cozy%";
 
#40. Write an sql query to show price, host id, neighbourhood_group of manhattan neighbourhood_group
select l.host_id, l.neighbourhood_group, b.price from listings l join bookings b
on l.id = b.listing_id
where l.neighbourhood_group = 'manhattan';

#41. Write a query to show id , host name, neighbourhood and price but only for Upper West Side & Williamsburg neighbourhood, also make sure price is greater than 100
select l.id, l.host_name, l.neighbourhood, b.price from listings l join bookings b
on l.id = b.listing_id
where l.neighbourhood in ('Upper West Side', 'Williamsburg') and b.price > 100;

#43. Write a query to show host_name, availability_365,minimum_nights only for 100+ availability_365 and minimum_nights
select l.host_name, b.availability_365, b.minimum_nights from listings l join bookings b
on l.id = b.listing_id
where b.availability_365 and b.minimum_nights > 100;

#45. Write a query to show neighbourhood_group which have most total number of review
select l.neighbourhood_group, sum(b.number_of_reviews) total_reviews from listings l join bookings b
on l.id = b.listing_id
group by l.neighbourhood_group
ORDER BY total_reviews DESC
LIMIT 1;

#46. Write a query to show host name which have most cheaper total price
select l.host_name, sum(b.price) total_price from listings l join bookings b
on l.id = b.listing_id
group by l.host_name 
having sum(b.price) = (select min(total_price) from (select sum(b.price) total_price 
from listings l join bookings b
on l.id = b.listing_id
group by l.host_name ) sub);

#47. Write a query to show host name which have most costly total price
select l.host_name, sum(b.price) total_price from listings l join bookings b
on l.id = b.listing_id
group by l.host_name 
having sum(b.price) = (select max(total_price) from (select sum(b.price) total_price 
from listings l join bookings b
on l.id = b.listing_id
group by l.host_name ) sub);

#49. Write a query to show neighbourhood_group where price is less than 100
select distinct l.neighbourhood_group from listings l join bookings b
on l.id = b.listing_id
where b.price < 100;

#50. Write a query to find max price, average availability_365 for each room type and order in ascending by maximum price.
select l.room_type, max(b.price) maximum_price, avg(b.availability_365) average_availability from listings l join bookings b
on l.id = b.listing_id
group by l.room_type
order by max(b.price);




