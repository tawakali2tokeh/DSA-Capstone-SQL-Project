# DSA-Capstone-SQL-Project

# Kultra Mega Store Inventory Analysis

## Project Overview
This project aims to analyze the KMS sales data to identify the most valuable customers, the most valuable products, customer segment and evaluate the effectiveness of the company's shipping expenditure.

## Data Source
I obtained the data from the DSA LMS platform. It contains KMS transaction records from 2009 to 2012. It contains information on sales, profit, shipping costs, shipping modes, customer IDs, and order details.

## Tools Used
- Microsoft SQL Server. [Download Here](https://www.microsoft.com/en-us/sql-server/sql-server-downloads?msockid=3495a62c6de9650c173fb3da6c7764d6)

## Project Structure

### 1. Database Setup

- **Database Creation:**  
I created a database named `KMS` to serve as the foundation for all my data operations.

- **Schema Design:**  
 I created a schema named `Db` with `Database Owner` privileges to organize database objects.

- **Data Import and Table Preparation:**  
  I imported two datasets into the database, and named them `KMS_Inventory` and `Returned_Orders`, respectively.
  - **`Db.KMS_Inventory` Table:**  
    Contains columns such as `Order_Row`, `Order_ID`, `Order_Date`, `Order_Priority`, `Order_Quantity`, `Sales`, `Discount`, `Ship_Mode`, `Profit`, `Unit_Price`, `Shipping_Cost`, `Customer_Name`, `Province`, `Region`, `Customer_Segment`, `Product_Sub_Category`, `Product_Name`, `Product_Container`, `Product_Base_Margin`, `Ship_Date`. 
  - **`Db.Returned_Orders` Table:**  
    Contains `Order_ID` and `Status` columns, representing order return statuses.

- **Table Joining and View Creation:**  
I joined the `Db.KMS_Inventory` and `Db.Returned_Orders` tables on `Order_ID` to enable comprehensive analysis of order details and return statuses, and I created a view named `Db.KMS_VIEW` to facilitate this.

```sql
CREATE VIEW Db.KMS_VIEW
AS
SELECT Db.KMS_Inventory.Order_ID,
Db.KMS_Inventory.Sales,
 Db.KMS_Inventory.Customer_Name,
Db.KMS_Inventory.Customer_Segment,
Db.Returned_Order.[Status]
FROM Db.KMS_Inventory
FULL OUTER JOIN Db.Returned_Order
ON Db.Returned_Order.Order_ID = Db.KMS_Inventory.Order_ID
```

## 2. Data Analysis 

### Data Cleaning
- I Converted data types for certain columns to ensure proper data handling. For example, I transformed Customer ID from SMALLINT to INT to allow the column to accommodate larger  data.
### Data Transformation Aggregation
- I used aggregate functions such as `SUM()` to get total sales and shipping costs.
- I aggregated data to identify top customers and products based on sales amount.
### Filtering
- I used `WHERE` clauses to focus on specific customer segments, such as "Small Business," to derive targeted insights.
### SQL Commands and Clauses
- I utilized `SELECT` command to specify data retrieval.
- I used `GROUP BY` and `ORDER BY` to organize my result output.
  ### KMS Order problem and answers analysis

*1. Which product category had the highest sales?*

```SQL Query
SELECT TOP 1 Product_Category, 
SUM(Sales) AS Highest_Sales
FROM Db.KMS_Inventory
GROUP BY Product_Category
ORDER BY Highest_Sales desc
```
![nn](https://github.com/user-attachments/assets/58ef5390-27e7-4884-8ca3-e335d60a128d)

*2. What are the Top 3 and Bottom 3 regions in terms of sales?*

 ```SQL 
SELECT TOP 3  Region,
SUM(Sales) AS Highest_Region_Sales
FROM Db.KMS_Inventory
GROUP BY Region
ORDER BY Highest_Region_Sales DESC
```
```SQL
SELECT TOP 3 Region, 
SUM (Sales) AS Lowest_Region_Sales
FROM Db.KMS_Inventory
GROUP BY Region
ORDER BY Lowest_Region_Sales ASC
```
![22](https://github.com/user-attachments/assets/d3125915-b048-48f4-8290-ceded87f2e1a)

*3. What were the total sales of appliances in Ontario?*

```SQL
SELECT SUM(Sales) AS Total_Ontario_Appliances_Sales
FROM Db.KMS_Inventory
WHERE Product_Sub_Category = 'Appliances' AND Region = 'Ontario'
```
![333](https://github.com/user-attachments/assets/77d50863-e042-4b67-b3d2-397efc8f8f49)

*4. Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers*

```SQL
SELECT TOP 10 Customer_Name, 
SUM (Sales) AS Lowest_Customer_Sales, 
SUM(Profit) AS Total_PROFIT,
SUM (Shipping_Cost) AS Total_Shipping_Cost, 
SUM(Discount) AS Total_Discount, 
COUNT(Order_ID) AS Total_Order
FROM Db.KMS_Inventory
GROUP BY Customer_Name
ORDER BY Lowest_Customer_Sales ASC
```
![table4](https://github.com/user-attachments/assets/b14be765-aa31-4eac-bae7-5bc3bf3efdfb)

Answer:
- Customer Engagement and Feedback: The company should hold one-on-one sessions with customers to understand why they aren't patronizing the business as much and the company should also get product reviews and ratings from customers to identify areas for improvement.
- Order Management and Timeliness: The company should prioritize its own order processing and delivery, placing the same importance on timely orders as customers do and ensuring that orders are delivered on time for customer's satisfaction   
- Customer Service: Providing good customer service is a significant plus and can help retain customers and encourage repeat business.

*5. KMS incurred the most shipping cost using which shipping method?*

```SQL
SELECT TOP 1 Ship_Mode, 
SUM(Shipping_Cost) AS Highest_Shipping_Mode
FROM Db.KMS_Inventory
GROUP BY Ship_Mode
ORDER BY Highest_Shipping_Mode DESC
```
![table5](https://github.com/user-attachments/assets/d78b453b-5d56-4a0a-84aa-fbfd14e46397)

*6. Who are the most valuable customers, and what products or services do they typically
purchase?*

```SQL
SELECT TOP 10 Customer_Name, 
Product_Name, SUM(Sales) AS Top_Customers,
SUM (Profit) AS Total_Profit
FROM Db.KMS_Inventory
GROUP BY Customer_Name, Product_Name
ORDER BY Top_Customers DESC
```
![table6](https://github.com/user-attachments/assets/6d5e263a-13dc-4aad-aadb-2895a91ebee9)

*7. Which small business customer had the highest sales?*

```SQL
SELECT TOP 1 Customer_Name, Customer_Segment,  
SUM(SALES) AS Small_Business_Highest_Sales
FROM  Db.KMS_Inventory
WHERE Customer_Segment = 'Small Business'
GROUP BY Customer_Name, Customer_Segment
order by Small_Business_Highest_Sales DESC
```
![t7](https://github.com/user-attachments/assets/a4cfbb63-8bd4-4090-9adc-ab49b2791baf)

*8. Which Corporate Customer placed the most number of orders in 2009 – 2012*

```SQL
SELECT TOP 1 Customer_Name, Customer_Segment, 
COUNT (Order_ID) as Most_Order
FROM Db.KMS_Inventory
WHERE Customer_Segment = 'Corporate'
AND Order_Date >= '2009-01-01' and Order_date <= '2012-12-31'
GROUP by Customer_Name, Customer_Segment
ORDER BY Most_Order DESC
```
![t8](https://github.com/user-attachments/assets/de4310e1-7f74-407e-a0f6-acc17bd70aa3)

*9. Which consumer customer was the most profitable one?*

```SQL
SELECT TOP 1 Customer_Name, Customer_Segment, 
SUM(Profit) AS Consumer_Customer_Most_Profitable
FROM Db.KMS_Inventory
WHERE Customer_Segment = 'Consumer'
GROUP BY Customer_Name, Customer_Segment
ORDER BY Consumer_Customer_Most_Profitable DESC
````
![t9](https://github.com/user-attachments/assets/806f0cdb-30bf-4bce-9ca0-0c5b1896eadd)

*10. Which customer returned items, and what segment do they belong to?*

```SQL
SELECT DISTINCT Customer_Name, Customer_Segment, [Status]
FROM Db.KMS_VIEW
WHERE [Status] = 'Returned'
```
![110](https://github.com/user-attachments/assets/dd9c1889-3bf2-40ea-bb3d-14a37206ccbc)

*11. If the delivery truck is the most economical but the slowest shipping method and
express air is the fastest but the most expensive one, do you think the company
appropriately spent shipping costs based on the Order Priority? Explain your answer*

```SQL
SELECT Ship_Mode, Order_Priority,
SUM(Shipping_Cost) AS Total_Shipping_Cost,
AVG(Shipping_Cost) AS Average_Shipping_Cost
FROM Db.KMS_Inventory
WHERE Ship_Mode IN ('Express Air', 'Delivery Truck')
GROUP BY Order_Priority, Ship_Mode
ORDER BY Order_Priority, Ship_Mode
```
![t11](https://github.com/user-attachments/assets/84a8bede-755a-4eab-8550-d477ae3ea1c1)

*Answer:*
- No, Since Express air is the fastest and most expensive shipping option, it should be reserved for transporting critical and high-priority orders. Trucks, which are more affordable, should be used for transporting low, medium, and unspecified orders.

## Insights Based On Findings
- Sales Insights: This analysis highlights products with high and low sales across various regions and customer segments.
- Customer Insights: This analysis identifies the top customers, the most profitable customers, and the customers with the least activity.
- Order Insights: This analysis provides details on order patterns, including customers with the highest and lowest order volumes, as well as customers who have returned orders.
- Shipping Mode Insight: This analysis offers insights into the most effective shipping modes based on order priority and the company's shipping expenditure.

## Conclusion  
The findings from this analysis can help business owners identify key products and customer segments for targeted marketing strategies, as well as make informed decisions regarding shipping modes based on order priority and cost efficiency. This, in turn, can improve overall sales and logistics strategies to maximize profit.
