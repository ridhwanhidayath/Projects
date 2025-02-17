#Project 1

CREATE TABLE project_1(Product_ID INT,Product_name VARCHAR(100),Selling_price DECIMAL );
INSERT INTO project_1 (Product_ID,Product_name,Selling_price)VALUES ('1','Product A','100.00'),('2','Product B','150.00'),('1','Product A','120.00'),('3','Product C','200.00'),('2','Product B','180.00'),('1','Product A','90.00'),('3','Product C','210.00');
SELECT * FROM project_1
SELECT product_name,avg(selling_price)FROM project_1 GROUP BY product_name

#Project 2

CREATE TABLE PROJECT__2 (AccountNumber INT,AccountholderName VARCHAR(100),TransactionDate DATE,TransactionType VARCHAR(100),TransactionAmount INT);
INSERT INTO PROJECT__2(AccountNumber,AccountholderName,TransactionDate,TransactionType,TransactionAmount)VALUES('1001','Ravi Sharma','2023-07-01','Deposit','5000'),('1001','Ravi Sharma','2023-07-05','Withdrawal','1000'),('1001','Ravi Sharma','2023-07-10','Deposit','2000'),('1002','Priya Gupta','2023-07-02','Deposit','3000'),('1002','Priya Gupta','2023-07-08','Withdrawal','500'),('1003','Vikram Patel','2023-07-04','Deposit','10000'),('1003','Vikram Patel','2023-07-09','Withdrawal','2000');
 SELECT * FROM PROJECT__2
 CREATE TABLE C1 AS
SELECT AccountNumber,AccountholderName,sum(TransactionAmount)AS SUM FROM PROJECT__2 WHERE TransactionType='Deposit' GROUP BY AccountNumber,AccountholderName;
SELECT * FROM C1
CREATE TABLE C2 AS
 SELECT AccountNumber,AccountholderName,sum(TransactionAmount)AS Total FROM PROJECT__2 WHERE TransactionType='Withdrawal' GROUP BY AccountNumber,AccountholderName
 CREATE TABLE D1 AS
SELECT *FROM C1
NATURAL JOIN C2
SELECT * FROM D1
CREATE TABLE D2 AS
SELECT AccountNumber,AccountholderName,D1.sum - D1.total AS TotalBalance FROM D1
SELECT * FROM D2

#Project 3

CREATE TABLE Customers(ID INT,NAME VARCHAR(100));
INSERT INTO Customers (ID,NAME) VALUES('1','Joe'),('2','Henry'),('3','Sam'),('4','Max');
SELECT*FROM Customers

CREATE TABLE Orders(ID INT,Customer_ID INT);
INSERT INTO Orders(ID,Customer_ID)VALUES('2','1'),('1','3');

 
SELECT NAME FROM customers
LEFT JOIN Orders
ON Customers.ID=Orders.Customer_ID WHERE Orders.Customer_ID IS NULL

#Project 4

CREATE TABLE Project_4(Customer_ID INT,Product_ID VARCHAR(100),Purchase_date DATE,Quantity INT,Revenue DECIMAL);
INSERT INTO Project_4(Customer_ID,Product_ID,Purchase_date,Quantity,Revenue)VALUES ('1','A','2023-01-01','5','100.00'),('2','B','2023-01-02','3','50.00'),('3','A','2023-01-03','2','30.00'),('4','C','2023-01-03','1','20.00'),('1','B','2023-01-04','4','80.00');
SELECT *FROM Project_4

SELECT sum(revenue) AS Total_Revenue FROM Project_4
SELECT Product_ID ,sum(Quantity)AS TotalQuantity,sum(Revenue)AS TotalRvenue FROM Project_4 GROUP BY Product_ID ORDER BY Product_ID


#Project 5

CREATE TABLE Productsss(Product_ID INT,Product_name VARCHAR(100),Price DECIMAL);
INSERT INTO Productsss(Product_ID,Product_name,Price)VALUES('1','Apple','2.50'),('2','Banana','1.50'),('3','Orange','3.00'),('4','Mango','2.00')

CREATE TABLE Orderss(Order_ID INT,Product_ID INT,Quantity INT,Sales DECIMAL);
INSERT INTO Orderss(Order_ID,Product_ID,Quantity,Sales)VALUES('1','1','10','25.00'),('2','1','5','12.50'),('3','2','8','12.00'),('4','3','12','36.00'),('5','4','6','12.00');

SELECT Product_name,sum(sales)AS Totalrevenue FROM(SELECT*FROM Productsss INNER JOIN Orderss ON Productsss.Product_ID=Orderss.Product_ID)GROUP BY Product_name ORDER BY Product_name