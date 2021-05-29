




                         --Queries based on 'NORTHWIND' database

--1- Find the number of orders sent by each shipper.
SELECT  COUNT(*)NUMBEROFORDER,ShipName
FROM Orders 
GROUP BY ShipName
SELECT *
FROM Shippers

SELECT COUNT(*)SHIP, ShipPostalCode
FROM ORDERS
GROUP BY ShipPostalCode 
ORDER BY SHIP ASC

SELECT *
FROM Orders
WHERE ShipName = 'Alfreds Futterkiste'


--2- Find the number of orders sent by each shipper, sent by each employee
SELECT  COUNT(*)NUMBEROFORDER,ShipName, E.FirstName +' '+LastName EmployeeName
FROM Orders O,Employees E
GROUP BY ShipName,E.FirstName,E.LastName


--3- Find  name  of  employees who has registered more than 100 orders.
SELECT *
FROM Employees E
SELECT *
FROM [Order Details]
SELECT E.FirstName +' '+LastName EmployeeName,OD.Quantity
FROM [Order Details] OD
JOIN Orders O ON O.OrderID = OD.OrderID
JOIN Employees E ON E.EmployeeID = O.EmployeeID
WHERE OD.Quantity > 100

--4-Find if the employees "Davolio" or "Fuller" have registered more than 25 orders.
SELECT *
FROM Employees E  

SELECT E.LastName,OD.Quantity Ordersplaced
FROM [Order Details] OD
JOIN Orders O ON O.OrderID = OD.OrderID
JOIN Employees E ON E.EmployeeID = O.EmployeeID
WHERE  Quantity > 25 AND  E.LastName in ('Davolio', 'Fuller')

--- count of order more than 25
SELECT E.LastName, count(*) order25
FROM [Order Details] OD
JOIN Orders O ON O.OrderID = OD.OrderID
JOIN Employees E ON E.EmployeeID = O.EmployeeID
WHERE  Quantity > 25 AND  E.LastName in ('Davolio', 'Fuller')
group by E.LastName
 
--




--5-Find the customer_id and name of customers who had placed orders more than one time and how many times they have placed the order

SELECT *
FROM Customers C


--6-Select all the orders where the employee’s city and order’s ship city are same.
GO
SELECT *
FROM Orders
JOIN Employees EMP ON EMP.EmployeeID = Orders.EmployeeID
WHERE EMP.City = Orders.ShipCity


--7-Create a report that shows the order ids and the associated employee names for orders that shipped after the required date.
--8-Create a report that shows the total quantity of products ordered fewer than 200.
--9-Create a report that shows the total number of orders by Customer since December 31, 1996 and the NumOfOrders is greater than 15. 
--10-Create a report that shows the company name, order id, and total price of all products of which Northwind
                                                                        -- has sold more than $10,000 worth.
--11-Create a report showing the Order ID, the name of the company that placed the order,
                          --and the first and last name of the associated employee. Only show orders placed after January 1, 1998 
                          --that shipped after they were required. Sort by Company Name.
--12-Get the phone numbers of all shippers, customers, and suppliers
GO
SELECT SH.Phone,C.Phone,S.Phone
FROM Shippers SH,Customers C,Suppliers S



--13-Create a report showing the contact name and phone numbers for all employees,customers, and suppliers.
--14-Fetch all the orders for a given customer’s phone number 030-0074321.

SELECT *
FROM orders O
JOIN Customers CT ON O.CustomerID = CT.CustomerID
WHERE CT.Phone = '030-0074321'


--15-Fetch all the products which are available under Category ‘Seafood’.
--16-Fetch all the products which are supplied by a company called ‘Pavlova, Ltd.’

GO
SELECT PR.*
FROM Orders O 
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
JOIN Products PR ON PR.ProductID = OD.PRODUCTID
WHERE PR.C





--17-All orders placed by the customers belong to London city.
GO
SELECT *
FROM Orders O
JOIN Customers C ON C.CustomerID = O.CustomerID
WHERE C.City ='London'


--18-All orders placed by the customers not belong to London city.
GO
SELECT *
FROM Orders O
JOIN Customers C ON C.CustomerID = O.CustomerID
WHERE C.City !='London'


--19-All the orders placed for the product Chai.
GO
SELECT *
FROM Orders O
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
JOIN Products PR ON PR.ProductID = OD.ProductID
WHERE PR.ProductName = 'Chai'

--20-Find the name of the company that placed order 10290.
GO
SELECT SP.CompanyName
FROM Suppliers SP
JOIN Products PR ON SP.SupplierID = PR.SupplierID
JOIN [Order Details] OD ON OD.ProductID = PR.ProductID  
WHERE OD.OrderID='10290'

--21-Find the Companies that placed orders in 1997
GO
SELECT*
FROM Customers C
JOIN Orders O ON O.CustomerID = C.CustomerID
WHERE O.OrderDate LIKE '%1997%'


--22-Get the product name , count of orders processed 

GO
SELECT PR.ProductName,  COUNT(OD.Quantity)COUNTOFORDER
FROM Orders O 
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
JOIN Products PR ON PR.ProductID = OD.PRODUCTID
GROUP BY PR.ProductName


--23-Get the top 3 products which has more orders
--https://anyonconsulting.com/business_intelligence/11-different-ways-to-select-second-nth-highest-value-in-ms-sql-server-instance/
GO
SELECT distinct TOP 3  PR.ProductName,OD.Quantity
FROM Products PR
JOIN [Order Details] OD ON OD.ProductID = PR.ProductID
JOIN Orders O ON O.OrderID = OD.OrderID
ORDER BY OD.Quantity  desc 

--24-Get the list of employees who processed the order “chai”
GO
SELECT *
FROM Employees E
JOIN Orders O ON O.EmployeeID= E.EmployeeID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
JOIN Products PR ON PR.ProductID = OD.ProductID
WHERE PR.ProductName = 'Chai'


SELECT*
FROM Products

--25-Get the shipper company who processed the order categories “Seafood” 
GO
SELECT SH.CompanyName Shippercompany
FROM Shippers SH
JOIN Orders O ON O.ShipVia = SH.ShipperID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
JOIN Products PR ON PR.ProductID = OD.PRODUCTID
JOIN Categories CT ON CT.CategoryID = PR.CategoryID
WHERE CategoryName = 'Seafood'
GROUP BY SH.CompanyName

--26-Get category name , count of orders processed by the USA employees 
GO
SELECT CT.CategoryName,  COUNT(OD.Quantity)COUNTOFORDER
FROM Orders O 
JOIN Employees EMP ON O.EmployeeID = EMP.EmployeeID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
JOIN Products PR ON PR.ProductID = OD.PRODUCTID
JOIN Categories CT ON CT.CategoryID = PR.CategoryID
WHERE EMP.Country = 'USA'
GROUP BY CT.CategoryName


--27-Select CategoryName and Description from the Categories table sorted by CategoryName.
GO
SELECT CT.CategoryName,CT.Description
FROM Categories CT
ORDER BY CT.CategoryName ASC

--28-Select ContactName, CompanyName, ContactTitle, and Phone from the Customers table sorted byPhone.
GO-- Logic of phone sorted not getting
SELECT C.ContactName,C.CompanyName,C.ContactTitle,C.Phone
FROM Customers C
ORDER BY C.Phone DESC

--29-Create a report showing employees' first and last names and hire dates sorted from newest to oldest employee
GO
SELECT E.FirstName + '  '+ E.LastName EMPName,E.HireDate
FROM Employees E
ORDER BY E.HireDate DESC


--30-Create a report showing Northwind's orders sorted by Freight from most expensive to cheapest. Show OrderID, 
                                                            --OrderDate, ShippedDate, CustomerID, and Freight
--31-Select CompanyName, Fax, Phone, HomePage and Country from the Suppliers table sorted by Country in descending 
                                                            --order and then by CompanyName in ascending order

SELECT SP.CompanyName,SP.Fax,SP.Phone,SP.HomePage,SP.Country
FROM Suppliers SP
ORDER BY 1 ASC , SP.Country ASC

--32-Create a report showing all the company names and contact names of Northwind's customers in Buenos Aires
--33-Create a report showing the product name, unit price and quantity per unit of all products that are out of stock
--34-Create a report showing the order date, shipped date, customer id, and freight of all orders placed on May 19, 1997
--35-Create a report showing the first name, last name, and country of all employees not in the United States.
--36-Create a report that shows the city, company name, and contact name of all customers who are in cities that begin with "A" or "B."
--37-Create a report that shows all orders that have a freight cost of more than $500.00.
--38-Create a report that shows the product name, units in stock, units on order, and reorder level of all
                                                                    -- products that are up for reorder
--39-Create a report that shows the company name, contact name and fax number of all customers that have a fax number.
--40-Create a report that shows the first and last name of all employees who do not report to anybody

GO
SELECT 
FROM 


--41-Create a report that shows the company name, contact name and fax number of all customers that have a fax number, 
                                                                                            --Sort by company name.
--42-Create a report that shows the city, company name, and contact name of all customers who are in cities 
                                 --that begin with "A" or "B." Sort by contact name in descending order 
--43-Create a report that shows the first and last names and birth date of all employees born in the 1950s
--44-Create a report that shows the shipping postal code, order id, and order date for all orders with a ship postal code 
                                                                                             --beginning with "02389".
--45-Create a report that shows the contact name and title and the company name for all customers whose contact title
                                                                                 -- does not contain the word "Sales".
--46-Create a report that shows the first and last names and cities of employees from cities other than Seattle
                                                                                         -- in the state of Washington.
--47-Create a report that shows the company name, contact title, city and country of all customers in Mexico 
                                                                               --or in any city in Spain except Madrid.