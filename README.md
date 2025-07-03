# DSA-Capstone-SQL-Project

## Project Structure

### 1. Database Setup

- **Database Creation:**  
I  Created a database named `KMS` to serve as the foundation for all my data operations.

- **Schema Design:**  
 I created a schema named `Db` with `Database Owner` privileges to organize database objects.

- **Data Import and Table Preparation:**  
  I imported two datasets into the database, and named them `KMS_Inventory` and `Returned_Orders`, respectively, and performed necessary data cleaning to ensure data quality and consistency.

  - **`KMS_Inventory` Table:**  
    Contains columns such as `Order_Row`, `Order_Id`, `Order_Date`, `Order_Priority`, `Order_Quantity`, `Sales`, `Discount`, `Ship_Mode`, `Profit`, `Unit_Price`, `Shipping_Cost`, `Customer_Name`, `Province`, `Region`, `Customer_Segment`, `Product_Sub_Category`, `Product_Name`, `Product_Container`, `Product_Base_Margin`, `Ship_Date`. I adjusted the column data types to ensure data integrity and compatibility.
  
  - **`Returned_Orders` Table:**  
    Contains `Order_Id` and `Status` columns, representing order return statuses.

- **Table Joining:**  
 I  joined `KMS_Inventory` and `Returned_Orders` tables on `Order_Id` to facilitate comprehensive analysis of order details alongside return statuses.
