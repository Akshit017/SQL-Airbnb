-- Project: Airbnb Data Analysis using SQL
-- Author: Akshit Chauhan
-- Description:
-- This project analyzes Airbnb listings and booking data
-- to uncover pricing trends, availability patterns, and
-- neighborhood-level insights.

-- 1. DATABASE SETUP

CREATE DATABASE airbnb;
USE airbnb;

-- Tables:
-- listings (listing details)
-- bookings (pricing, availability, reviews)

-- 2. DATA EXPLORATION

-- Total Listings
SELECT COUNT(DISTINCT id) AS total_listings FROM listings;

-- Total Bookings
SELECT COUNT(DISTINCT listing_id) AS total_bookings FROM bookings;

-- Unique Hosts
SELECT COUNT(DISTINCT host_name) AS unique_hosts FROM listings;

-- Unique Neighborhood Groups
SELECT DISTINCT neighbourhood_group FROM listings;

-- Unique Room Types
SELECT DISTINCT room_type FROM listings;


-- 3. DATA ANALYSIS

-- Price Statistics
SELECT 
    MAX(price) AS max_price,
    MIN(price) AS min_price,
    AVG(price) AS avg_price
FROM bookings;

-- Average Availability
SELECT AVG(availability_365) AS avg_availability FROM bookings;

-- High Availability Listings (>300 days)
SELECT listing_id, availability_365
FROM bookings
WHERE availability_365 > 300;

-- Price Range Analysis (300–400)
SELECT COUNT(listing_id) AS listings_in_range
FROM bookings
WHERE price BETWEEN 300 AND 400;

-- Short Stay Listings (<5 nights)
SELECT COUNT(listing_id) AS short_stay_listings
FROM bookings
WHERE minimum_nights < 5;

-- 4. DATA JOINING & TRANSFORMATION

-- Combine Listings & Bookings
SELECT *
FROM listings l
LEFT JOIN bookings b
ON l.id = b.listing_id;

-- Host Name & Price Mapping
SELECT l.host_name, b.price
FROM listings l
JOIN bookings b
ON l.id = b.listing_id;

-- Room Type vs Price
SELECT l.room_type, b.price
FROM listings l
JOIN bookings b
ON l.id = b.listing_id;

-- 5. BUSINESS INSIGHTS

-- Total Revenue by Neighborhood
SELECT 
    l.neighbourhood_group,
    SUM(b.price) AS total_revenue
FROM listings l
JOIN bookings b
ON l.id = b.listing_id
GROUP BY l.neighbourhood_group;

-- Maximum Price by Neighborhood
SELECT 
    l.neighbourhood_group,
    MAX(b.price) AS max_price
FROM listings l
JOIN bookings b
ON l.id = b.listing_id
GROUP BY l.neighbourhood_group;

-- Average Price by Room Type (<100 filter)
SELECT 
    l.room_type,
    AVG(b.price) AS avg_price
FROM listings l
JOIN bookings b
ON l.id = b.listing_id
GROUP BY l.room_type
HAVING AVG(b.price) < 100;

-- 6. ADVANCED QUERIES

-- Listings with Price > 200 (Subquery)
SELECT *
FROM listings
WHERE id IN (
    SELECT listing_id FROM bookings WHERE price > 200
);

-- Hosts with Same Host ID (Self Join)
SELECT a.id AS listing1, b.id AS listing2
FROM listings a
JOIN listings b
ON a.host_id = b.host_id
AND a.id < b.id;

-- Search Listings with 'Cozy'
SELECT *
FROM listings
WHERE LOWER(name) LIKE '%cozy%';

-- 7. KEY INSIGHTS

-- Top Neighborhood by Reviews
SELECT 
    l.neighbourhood_group,
    SUM(b.number_of_reviews) AS total_reviews
FROM listings l
JOIN bookings b
ON l.id = b.listing_id
GROUP BY l.neighbourhood_group
ORDER BY total_reviews DESC
LIMIT 1;

-- Most Expensive Hosts
SELECT 
    l.host_name,
    SUM(b.price) AS total_price
FROM listings l
JOIN bookings b
ON l.id = b.listing_id
GROUP BY l.host_name
ORDER BY total_price DESC
LIMIT 5;

-- Price vs Availability by Room Type
SELECT 
    l.room_type,
    MAX(b.price) AS max_price,
    AVG(b.availability_365) AS avg_availability
FROM listings l
JOIN bookings b
ON l.id = b.listing_id
GROUP BY l.room_type
ORDER BY max_price;

-- 8. ADVANCED ANALYSIS (HIGH IMPACT QUERIES)

-- Rank Listings by Price within Each Neighborhood (Window Function)
SELECT 
    l.neighbourhood_group,
    l.id AS listing_id,
    b.price,
    RANK() OVER (PARTITION BY l.neighbourhood_group ORDER BY b.price DESC) AS price_rank
FROM listings l
JOIN bookings b
ON l.id = b.listing_id;

-- Top 3 Most Expensive Listings in Each Neighborhood
SELECT *
FROM (
    SELECT 
        l.neighbourhood_group,
        l.id AS listing_id,
        b.price,
        ROW_NUMBER() OVER (PARTITION BY l.neighbourhood_group ORDER BY b.price DESC) AS rn
    FROM listings l
    JOIN bookings b
    ON l.id = b.listing_id
) ranked
WHERE rn <= 3;

-- Running Total of Prices by Neighborhood
SELECT 
    l.neighbourhood_group,
    b.price,
    SUM(b.price) OVER (PARTITION BY l.neighbourhood_group ORDER BY b.price) AS running_total
FROM listings l
JOIN bookings b
ON l.id = b.listing_id;

-- Identify Listings Priced Above Neighborhood Average
SELECT 
    l.id AS listing_id,
    l.neighbourhood_group,
    b.price
FROM listings l
JOIN bookings b
ON l.id = b.listing_id
WHERE b.price > (
    SELECT AVG(b2.price)
    FROM listings l2
    JOIN bookings b2
    ON l2.id = b2.listing_id
    WHERE l2.neighbourhood_group = l.neighbourhood_group
);

-- Detect Highly Available Listings (Top 10%)
SELECT *
FROM (
    SELECT 
        listing_id,
        availability_365,
        NTILE(10) OVER (ORDER BY availability_365 DESC) AS percentile_rank
    FROM bookings
) ranked
WHERE percentile_rank = 1;
