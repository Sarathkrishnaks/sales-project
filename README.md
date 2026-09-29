# sales-project

A Python and SQLite-based data pipeline for ingesting retail transaction data and performing customer and sales analytics. This project loads raw customer and order CSV files into a relational SQLite database (retail.db) and executes key analytical SQL queries to evaluate revenue, customer lifetime value (LTV), city-level spend, and sales trends.
** Features **
Automated Data Ingestion: Reads customers.csv and orders.csv directly into a relational SQLite database using pandas.
Relational Schema: Enforces foreign key constraints linking customer demographics to order transaction histories.
SQL Analytics Engine: Uses a Python wrapper function (run_query) to format SQL query outputs cleanly in the terminal.
Key Business Metrics:
Geographic markets by customer volume and average customer spend.
High-value customer identification against overall spend benchmarks.
Category-specific customer targeting (e.g., Electronics purchasers).
Customer Lifetime Value (LTV) summaries with purchase date windows.
Monthly revenue, order volume, and Average Order Value (AOV) time-series trends.

** Schema Design **

1. customers Table
   Column            Type                  Constraints              Description
   id                INTEGER               PRIMARY KEY              Unique customer identifier
   name              TEXT                  NOT NULL                 Full customer name
   email             TEXT                                           Contact email address
   city              TEXT                                           Customer city
   country           TEXT                  DEFAULT "UK"             Customer country
   joined_date       TEXT                                           Registration date(DD/MM/YYYY or YYYY-MM-DD)

2. orders Table
   Column            Type                  Constraints              Description
   id                INTEGER               PRIMARY KEY              Unique order identifier
   customer_id       INTEGER               FOREIGN KEY              References customers(id)
   product           TEXT                  NOT NULL                 Name of product purchased
   category          TEXT                                           Product category
   quantity          INTEGER               DEFAULT 1                Units purchased
   price             REAL                  NOT NULL                 Unit price
   order_date        TEXT                                           Date of order(DD/MM/YYYY)

** Prerequisites & Setup **
  Dependencies
  Python 3.8+
  SQLite3 (included in the Python standard library)
  pandas library
  
** Installation **
  Install required Python dependencies:
  pip install pandas

** File Structure **
 ---customers.csv
 ---orders.csv
 ---retail.db
 ---sales.py
 ---README.md

** Usage **
1. Prepare Source Files
   Ensure customers.csv and orders.csv are in the project root directory and formatted as follows:
   customers.csv: id, name, email, city, country, joined_date
   orders.csv:    id, customer_id, product, category, quantity, price, order_date
2. Run the Script
   Execute the main script to initialize the database, load data, and run analytical queries:
   python sales.py

** Analytical SQL query explanation for analysis **

1. Top Cities by Customer Count: Identifies top 5 geographic markets with the highest customer concentration.

2. High-Value Customer Identification: Filters customer whose cumulative spend exceeds the overall average spend per order.

3. Average Spend per City:  Subqueries customer-level totals before aggregating the average spend per city.

4. Electronics Category Buyers: Uses Exists to find all customers with at least one order in the Electronics category.

5. Customer Lifetime Value(LTV) Summary: Displays total orders, lifetime value, average order value and activity timeframe for top customers.

6. Monthly Revenue Trend Analysis: Extracts year and month from order_date (in DD/MM/YYYY format) to track monthly orders, revenue and AOd 


   
