# 🏠 Airbnb Data Analysis using SQL

## 📌 Project Overview
This project focuses on analyzing **Airbnb listing and booking data** using SQL.  
The objective is to extract meaningful insights related to **pricing, availability, customer behavior, host performance, and neighborhood trends** by writing optimized SQL queries.

The project demonstrates strong command over:
- SQL joins
- Aggregations
- Subqueries
- Filtering and grouping
- Real-world business problem solving

---

## 🗂️ Database Structure

### Tables Used
1. **listings**
   - id
   - name
   - host_id
   - host_name
   - neighbourhood
   - neighbourhood_group
   - room_type

2. **bookings**
   - listing_id
   - price
   - minimum_nights
   - availability_365
   - number_of_reviews

---

## 📊 Key SQL Analyses Performed

### 🔹 Basic Data Exploration
- Counted total listings
- Identified unique host names
- Retrieved distinct neighbourhood groups and room types
- Extracted listings from specific locations (Brooklyn, Manhattan)

---

### 🔹 Pricing & Availability Analysis
- Found maximum, minimum, and average prices
- Calculated average availability across listings
- Identified listings with high availability (>300 days)
- Filtered listings based on price ranges

---

### 🔹 Aggregations & Group Analysis
- Total price grouped by neighbourhood
- Maximum price per neighbourhood
- Maximum number of nights per neighbourhood
- Average price by room type (filtered by threshold)
- Neighbourhoods with lowest and highest total prices

---

### 🔹 Advanced SQL Queries
- Used **JOINs** to combine listings and booking data
- Implemented **subqueries** for:
  - Finding hosts with minimum and maximum total price
  - Filtering listings based on nested conditions
- Identified duplicate hosts with multiple listings
- Extracted listings containing keywords (e.g., "cozy")

---

### 🔹 Business-Oriented Insights
- Identified neighborhoods with the highest and lowest pricing trends
- Determined which hosts generate the most and least revenue
- Analyzed room types contributing to higher profitability
- Found customer behavior patterns through availability and pricing

---

## 🧠 SQL Concepts Used
- SELECT, WHERE, GROUP BY, HAVING
- INNER JOIN & SUBQUERIES
- Aggregate Functions (SUM, AVG, MAX, MIN, COUNT)
- Filtering with LIKE, IN, BETWEEN
- Sorting and grouping for analytics

---

