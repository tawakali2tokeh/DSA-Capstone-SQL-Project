# DSA-Capstone-SQL-Project

## Project Structure

### 1. Database Setup

- **Database Creation:**  
I created a database named `KMS` to serve as the foundation for all my data operations.

- **Schema Design:**  
 I created a schema named `Db` with `Database Owner` privileges to organize database objects.

- **Data Import and Table Preparation:**  
  I imported two datasets into the database, and named them `KMS_Inventory` and `Returned_Orders`, respectively, and performed necessary data cleaning to ensure data quality and consistency.

  - **`Db.KMS_Inventory` Table:**  
    Contains columns such as `Order_Row`, `Order_Id`, `Order_Date`, `Order_Priority`, `Order_Quantity`, `Sales`, `Discount`, `Ship_Mode`, `Profit`, `Unit_Price`, `Shipping_Cost`, `Customer_Name`, `Province`, `Region`, `Customer_Segment`, `Product_Sub_Category`, `Product_Name`, `Product_Container`, `Product_Base_Margin`, `Ship_Date`. I adjusted the column data types to ensure data integrity and compatibility.
  
  - **`Db.Returned_Orders` Table:**  
    Contains `Order_Id` and `Status` columns, representing order return statuses.

- **Table Joining and View Creation:**  
I joined the `Db.KMS_Inventory` and `Db.Returned_Orders` tables on `Order_Id` to enable comprehensive analysis of order details and return statuses, and I created a view named `Db.KMS_VIEW` to facilitate this.

```SQL Query
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
`

## 2. Data Analysis & Findings
KMS Order problem and answers analysis


```SQL Query
1. Which product category had the highest sales?

SELECT TOP 1 Product_Category, 
SUM(SALES) AS Highest_Sales
FROM Db.KMS_Inventory
GROUP BY Product_Category

![image](https://github.com/user-attachments/assets/87741adb-a50d-41e9-b738-8eba47db681a)

ORDER BY Highest_Sales desc
