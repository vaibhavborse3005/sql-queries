--1-Display all data from DimCustomer

Select* 
from DimCustomer;

--2-Display customers first name, birthdate,marrital status and gender from dimcutomer

Select DC.FirstName,DC.BirthDate,DC.MaritalStatus,DC.Gender
FROM DimCustomer DC

--3-Get customer whose yearly income is more than 60000

Select *
From DimCustomer 
where YearlyIncome > 60000

--4-Get all customers who have totalchilderen <=3

Select *
FROM DimCustomer 
WHERE TotalChildren <=3

--5-List of customers who are married and have yearly income>one lakh

SELECT *
FROM DimCustomer 
WHERE MaritalStatus = 'M'
AND YearlyIncome > 100000


--6- List all male customers whose birthdate is greater than 1st jan 1970

SELECT *
FROM DimCustomer 
WHERE Gender='M' 
AND BirthDate > '1.01.1970' 

--7 get customer whose occupation is either professional and managemnt

SELECT *
FROM DimCustomer 
WHERE EnglishOccupation = 'Professional' 
OR EnglishOccupation ='Management'

--8 Display accounkey,paretcountry and account discrtiption from 
--dimaccount whose account type is liabilities and prentaccounkey is not null

Select AccountKey,ParentAccountKey,AccountDescription
FROM DimAccount 
WHERE AccountType ='Liabilities'
AND ParentAccountKey IS NOT NULL

--9HA- Display product key and product name from DimProduct whose reorder point > 300 and color is black

SELECT DP.ProductKey,DP.EnglishProductName
FROM DimProduct AS DP
WHERE ReorderPoint > 300 
AND Color ='BLACK'

--10HA- Display all products who are silver in colour

SELECT *
FROM DimProduct 
WHERE Color='SILVER'


--11HA- Employees working in departments HumanResources And Sales.

SELECT *
FROM DimEmployee
WHERE DepartmentName =

--12-- All departments from DimEmployee

SELECT DISTINCT DepartmentName
FROM DimEmployee


--13-Display salesordernumber, productkey and freight from factresellersales whose freighny > and <100

select SalesOrderNumber,ProductKey,Freight
from FactResellerSales
WHERE FREIGHT >= 15.6249
AND FREIGHT <= 65.6096

-----OR-------------
select SalesOrderNumber,ProductKey,Freight
from FactResellerSales
WHERE FREIGHT BETWEEN 15 AND 100

--14- All employees working IN HR sales purchasing and marketing

SELECT *
FROM DimEmployee
WHERE DepartmentName ='Human Resources' 
OR DepartmentName='Sales'
OR DepartmentName='PURCHASING'
OR DepartmentName='MARKETING'

-----OR-------------

SELECT * 
FROM DimEmployee
WHERE DepartmentName IN ('Human Resources','Sales','PURCHASING','MARKETING')

--15--Display employeekey,parentemployeekey and departmenname of employee key is 1,19,276,105,73

SELECT EmployeeKey,ParentEmployeeKey,DepartmentName
FROM DimEmployee
WHERE EmployeeKey IN (1,19,276,105,73)


--16--ALL employee who are married and whose base rate is >10 and <25

select *
from DimEmployee
WHERE MaritalStatus ='M'
AND BASERATE BETWEEN 10 
AND 25

select *
from DimEmployee
WHERE MaritalStatus ='M'
AND BASERATE > 10
AND BASERATE < 25 

select *
from DimEmployee
WHERE MaritalStatus ='M'
AND BASERATE IN (10,25) 

--ALL MArried employee whose base rate is between 10 and 25
select *
from DimEmployee
WHERE MaritalStatus ='M'
AND Gender ='M'
AND BASERATE BETWEEN 10 
AND 25

---18--DISPLAY ALL customer whose firstnamr starts with j

select *
from DimCustomer
where FirstName LIKE 'J%'

--19-- DISPLAY all customer whose firstname with J,E,C
SELECT *
FROM DimCustomer
WHERE FirstName LIKE '[JEC]%'

--20--Display customername,birthdatename,gender from dimcustomer

select FirstName + ' '+ LastName ,BirthDate,Gender
from DimCustomer

select FirstName + LastName ,BirthDate,Gender
from DimCustomer


--21-Display all product with their 'subcategoryname'


SELECT * 
FROM DimProduct DP
INNER JOIN DimProductSubcategory DPS ON  DP.ProductSubcategoryKey=DPS.ProductSubcategoryKey



use join
inner join can be used only for matching record any one column should be same
if the 

---full outer joins---all the matching record aswell as non matching records
--left outer --- matching from all non matchin record left  all the matching records of left table
--cross join--
-----right join all matching records and right side ke nonmatching from right side

select * 
from DimProductSubcategory


select DP.*,DPS.EnglishProductSubcategoryName Subcategory
from DimProduct DP
left join DimProductSubcategory DPS on DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey

--- matching records from left and right side and non matching records from left side


--- 22 -- display all products along with their categoryname and subcategoryname


select DP.*,DPC.EnglishProductCategoryName CATEGORYNAME,DPS.EnglishProductSubcategoryName SUBCATEGORYNAME
from DimProduct DP
LEFT JOIN DimProductSubcategory DPS ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
LEFT JOIN DimProductCategory DPC ON DPS.ProductCategoryKey=DPC.ProductCategoryKey




--SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate
--FROM Orders
--INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID;


select *
from  DimProductCategory
SELECT*
FROM DimProductSubcategory


--23 DISPLAY departmentwise employess count

select COUNT(*) totalemplyee, DepartmentName
from DimEmployee,DimCustomer
GROUP BY DepartmentName

--24-- PRODUCTSUBCATEGORYWISE NUMBER of products FROM TABLE DIMPRODUCT

select COUNT(*)totalproducts,DPS.EnglishProductSubcategoryName
from DimProduct DP
left join DimProductSubcategory DPS ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
ORDER BY DPS.EnglishProductSubcategoryName



-- 25 -- Productsubcategorywise number of products from table dimproduct whose subcategory is not null

select COUNT(*)totalproducts,DPS.EnglishProductSubcategoryName subcategory
from DimProduct DP
left join DimProductSubcategory DPS ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
where dp.ProductSubcategoryKey is not null
ORDER BY DPS.EnglishProductSubcategoryName



--26-DISPLAY COUNT of married female emplyess
SeLECT count(*) marriedfemale,DepartmentName
from DimEmployee
where MaritalStatus='m'
and gender = 'f'
group by DepartmentName
--27--Departmenwise female 
SeLECT count(*) marriedfemale,DepartmentName
from DimEmployee
where MaritalStatus='m'
and gender = 'f'
group by DepartmentName

GO
--- 28--customernamewise totalsale and totalfrieght from factinternetsale

all fact tables are dependat
chain he toh dependant he to always write depedant table first in from

select DC.FirstName + ''+DC.LastName CUSTOMERNAME, SUM(FIS.SalesAmount)Totalsales,Sum(FIS.Freight)TOTALFREIGHT
from FactInternetSales FIS
JOIN DimCustomer DC ON FIS.CustomerKey=DC.CustomerKey
GROUP BY DC.FirstName + ''+DC.LastName

--29--Productwise totalsales from factinternetsales
select SUM(FIS.SalesAmount)Totalsales,DP.EnglishProductName PRODUCT
from FactInternetSales FIS
JOIN DimProduct DP ON FIS.ProductKey=DP.ProductKey
GROUP BY DP.EnglishProductName

--30-- Productsubcategorywise average sale from factinternetsale

SELECT AVG(FIS.SalesAmount)AVGsales,DPS.EnglishProductSubcategoryName PRODUCTSUBNAME
FROM FactInternetSales FIS, DimProductSubcategory DPS
GROUP BY DPS.EnglishProductSubcategoryName

--NO DIRECT CONNECTION BETWEEN THIS TABLES SO WE NEED TO JOIN TWO TABLES
SELECT AVG(FIS.SalesAmount)AVGsales,DPS.EnglishProductSubcategoryName PRODUCTSUBNAME
FROM FactInternetSales FIS 
JOIN DimProduct DP ON DP.ProductKey=FIS.ProductKey
JOIN DimProductSubcategory DPS ON DPS.ProductSubcategoryKey=DP.ProductSubcategoryKey
GROUP BY DPS.EnglishProductSubcategoryName

SELECT *
FROM DimProductSubcategory

--31 COUNTRYWISE totalsale in descending from factRESELLERS

SELECT SUM(FRS.SalesAmount)TOTALsales, DG.EnglishCountryRegionName
FROM FactResellerSales FRS
JOIN DimReseller DR ON FRS.ResellerKey= DR.ResellerKey
JOIN DimGeography DG ON DR.GeographyKey= DG.GeographyKey
GROUP BY  DG.EnglishCountryRegionName
order by 1 DESC  ---- POSITION OF SUM IN SLELECT CLAUSE


--32--countrywise statewise totalsale from factreseller(HINT -ORDER BY Clause)

SELECT DG.EnglishCountryRegionName COUNTRY,DG.StateProvinceName STATEONLY, SUM(FRS.SalesAmount)TOTALsales
FROM FactResellerSales FRS
JOIN DimReseller DR ON FRS.ResellerKey= DR.ResellerKey
JOIN DimGeography DG ON DR.GeographyKey= DG.GeographyKey
GROUP BY  DG.EnglishCountryRegionName,DG.StateProvinceName
order by 1,3 DESC 


SELECT SUM(FIS.SalesAmount)TOTALsales, DST.SalesTerritoryCountry,DG.StateProvinceName
FROM FactInternetSales FIS
JOIN DimSalesTerritory DST  ON FIS.SalesTerritoryKey=DST.SalesTerritoryKey
JOIN DimGeography DG ON DG.SalesTerritoryKey=DST.SalesTerritoryKey
GROUP BY DST.SalesTerritoryCountry,FIS.SalesAmount,DG.StateProvinceName
order by FIS.SalesAmount DESC


---33--COUNTRYWISE RESELLERWISE totalsale from factrellers(HINT -ORDER BY Clause)

SELECT DG.EnglishCountryRegionName COUNTRY, DR.ResellerName Rname, SUM(FRS.SalesAmount)TOTALsales
FROM FactResellerSales FRS
JOIN DimReseller DR ON FRS.ResellerKey= DR.ResellerKey
JOIN DimGeography DG ON DR.GeographyKey= DG.GeographyKey
GROUP BY  DG.EnglishCountryRegionName,DR.ResellerName
order by 1 DESC,3 DESC 

---34--Fiscalyearwise employeenamewise  avgsales from factrellersales
SELECT AVG(FIS.SalesAmount)AVGsales,DPS.EnglishProductSubcategoryName PRODUCTSUBNAME
FROM FactResellerSales FRS
JOIN DimEmployee DE ON DE.EmployeeKey = FRS.EmployeeKey
JOIN 
GROUP BY DPS.EnglishProductSubcategoryName


--34HA-FiscalYearWise EmployeesNameWise AverageSale From FactResellerSales
--35HA-SalesTerritoryGroupWise EmployeeWise CategoryWise Minimum And Maximum Sale From FactInternetSales
--36HA-SubcategoryWise TotalSale From FIS


--37- Display salesordernumber, salesorderlinenumber, Amountdue from FIS


select SalesOrderNumber,SalesOrderLineNumber,SalesAmount + TaxAmt + Freight Amountdue
from FactInternetSales FIS


--38-- display employeekey,employee's fullname, departmentname and managername from dimemployee


select DE.EmployeeKey,DE.FirstName +''+DE.LastName EMPLOYEENAME,DE.DepartmentName,
DEMP.FirstName +''+DEMP.LastName MANAGERNAME
from  DimEmployee DE
LEFT JOIN  DimEmployee DEMP ON DE.ParentEmployeeKey = DEMP.EmployeeKey
ORDER BY 1

SELECT*
FROM DimEmployee


---DISPLAY  MANAGERNAME AND TOTALEMPLOYEES REPORTING TO THAT MANAGER
SELECT DEMP.FirstName +''+DEMP.LastName MANAGERNAME,COUNT(*)Totalemployees
from  DimEmployee DE
LEFT JOIN  DimEmployee DEMP ON DE.ParentEmployeeKey = DEMP.EmployeeKey
group by DEMP.FirstName +''+DEMP.LastName
ORDER BY 2 desc
 