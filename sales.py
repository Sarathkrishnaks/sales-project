import sqlite3
import pandas as pd

# Create database
conn = sqlite3.connect("retail.db")
cursor = conn.cursor()

# Create tables
cursor.execute("""
CREATE TABLE IF NOT EXISTS customers (
id INTEGER PRIMARY KEY,
name TEXT NOT NULL,
email TEXT,
city TEXT,
country TEXT DEFAULT "UK",
joined_date TEXT)
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS orders (
id INTEGER PRIMARY KEY,
customer_id INTEGER,
product TEXT NOT NULL,
category TEXT,
quantity INTEGER DEFAULT 1,
price REAL NOT NULL,
order_date TEXT,
FOREIGN KEY(customer_id) REFERENCES customers(id)
)
""")

# Load from cSV or insert sample data
df_customers = pd.read_csv("customers.csv")
df_customers.to_sql("customers", conn, if_exists = "append",index=False)

df_orders = pd.read_csv("orders.csv")
df_orders.to_sql("orders", conn, if_exists = "append", index = False)

conn.commit()


def run_query(sql, description=""):
    if description:
        print(f"\n--- {description} ---")
    result = pd.read_sql_query(sql, conn)
    print(result.to_string(index=False))
    return result

run_query("SELECT city, COUNT(*) as count FROM customers GROUP BY city ORDER BY count DESC LIMIT 5",
          "Top 5 cities by customer count")
