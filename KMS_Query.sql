CREATE DATABASE KMS

CREATE SCHEMA Db

SELECT * FROM Db.KMS_Inventory
SELECT * FROM Db.Returned_Order

--- Q1 Which product category had the highest sales?

SELECT TOP 1 Product_Category, 
SUM(Sales) AS Highest_Sales
FROM Db.KMS_Inventory
GROUP BY Product_Category
ORDER BY Highest_Sales desc


--- Q2 What are the Top 3 and Bottom 3 regions in terms of sales?
---TOP 3 REGIONS IN TERMS OF SALES

SELECT TOP 3  Region,
SUM(Sales) AS Highest_Region_Sales
FROM Db.KMS_Inventory
GROUP BY Region
ORDER BY Highest_Region_Sales DESC


SELECT TOP 3 Region, 
SUM (Sales) AS Lowest_Region_Sales
FROM Db.KMS_Inventory
GROUP BY Region
ORDER BY Lowest_Region_Sales ASC

---Q3 What were the total sales of appliances in Ontario?


SELECT SUM(Sales) AS Total_Ontario_Appliances_Sales
FROM Db.KMS_Inventory
WHERE Product_Sub_Category = 'Appliances' AND Region = 'Ontario'


---Q4 Advise the management of KMS on what to do to increase the revenue from the bottom
---10 customers

SELECT TOP 10 Customer_Name, 
SUM (Sales) AS Lowest_Customer_Sales, 
SUM(Profit) AS Total_PROFIT,
SUM (Shipping_Cost) AS Total_Shipping_Cost, 
SUM(Discount) AS Total_Discount, 
COUNT(Order_ID) AS Total_Order
FROM Db.KMS_Inventory
GROUP BY Customer_Name
ORDER BY Lowest_Customer_Sales ASC


---Q5 KMS incurred the most shipping cost using which shipping method?

SELECT TOP 1 Ship_Mode, 
SUM(Shipping_Cost) AS Highest_Shipping_Mode
FROM Db.KMS_Inventory
GROUP BY Ship_Mode
ORDER BY Highest_Shipping_Mode DESC


---Q6 Who are the most valuable customers, and what products or services do they typically
---purchase?

SELECT TOP 10 Customer_Name, 
Product_Name, SUM(Sales) AS Top_Customers,
SUM (Profit) AS Total_Profit
FROM Db.KMS_Inventory
GROUP BY Customer_Name, Product_Name
ORDER BY Top_Customers DESC

---Q7 Which small business customer had the highest sales?

SELECT TOP 1 Customer_Name, Customer_Segment,  
SUM(SALES) AS Small_Business_Highest_Sales
FROM  Db.KMS_Inventory
WHERE Customer_Segment = 'Small Business'
GROUP BY Customer_Name, Customer_Segment
order by Small_Business_Highest_Sales DESC

---Q8 Which Corporate Customer placed the most number of orders in 2009 – 2012

SELECT TOP 1 Customer_Name, Customer_Segment, 
count (Order_ID) as Most_Order
FROM Db.KMS_Inventory
WHERE Customer_Segment = 'Corporate' and Order_Date >= '2009-01-01' and Order_date <= '2012-12-31'
GROUP by Customer_Name, Customer_Segment
ORDER BY Most_Order DESC

---Q9 Which consumer customer was the most profitable one?

SELECT TOP 1 Customer_Name, Customer_Segment, 
SUM(Profit) AS Consumer_Customer_Most_Profitable
FROM Db.KMS_Inventory
WHERE Customer_Segment = 'Consumer'
GROUP BY Customer_Name, Customer_Segment
ORDER BY Consumer_Customer_Most_Profitable DESC


---Q10 Which customer returned items, and what segment do they belong to?

CREATE VIEW Db.KMS_VIEW
AS
SELECT Db.KMS_Inventory.ORDER_ID, 
Db.KMS_Inventory.Sales, 
Db.KMS_Inventory.Customer_Name, 
Db.KMS_Inventory.Customer_Segment, 
Db.Returned_Order.[Status]
FROM Db.KMS_Inventory
FULL OUTER JOIN Db.Returned_Order
ON Db.Returned_Order.Order_ID = Db.KMS_Inventory.Order_ID

select * from Db.KMS_VIEW

SELECT DISTINCT Customer_Name, Customer_Segment, [Status]
FROM Db.KMS_VIEW
WHERE [Status] = 'Returned'

---Q11 If the delivery truck is the most economical but the slowest shipping method and
---Express Air is the fastest but the most expensive one, do you think the company
---appropriately spent shipping costs based on the Order Priority? Explain your answer


SELECT Ship_Mode, Order_Priority,
SUM(Shipping_Cost) AS Total_Shipping_Cost,
AVG(Shipping_Cost) AS Average_Shipping_Cost
FROM Db.KMS_Inventory
WHERE Ship_Mode IN ('Express Air', 'Delivery Truck')
GROUP BY Order_Priority, Ship_Mode
ORDER BY Order_Priority, Ship_Mode



