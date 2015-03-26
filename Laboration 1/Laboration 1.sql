use AdventureWorks2012

-- Upggift 1.1

--select	ProductID
--	,	Name
--	,	Color
--	,	ListPrice
--from Production.Product;


--Uppgift 1.2

--select	ProductID
--	,	Name
--	,	Color
--	,	ListPrice
--from Production.Product
--where ListPrice > 0;


--Uppgift 1.3

--select	ProductID
--	,	Name
--	,	Color
--	,	ListPrice
--from	Production.Product
--where	Color is null;
	 



-- Uppgift 1.4
--select	ProductID
--	,	Name
--	,	Color
--	,	ListPrice
--from	Production.Product
--where Color is not null;



--Uppgift 1.5	

--select	ProductID
--	,	Name
--	,	Color
--	,	ListPrice
--from	Production.Product
--where	ListPrice > 0 
--		and Color is not null;


--Uppgift 1.6

--select Name + ' ' + Color as [Name and color]	
--from	Production.Product
--where	Color is not null;




--Uppgift 1.7

--select 'NAME: ' + (Name) + ' -- ' + 'COLOR:' + ' '+ (Color) as [Name and color]	
--from	Production.Product
--where	Color is not null;


--Uppgift 1.8

--select	ProductID
--	,	Name
--from	Production.Product
--where	ProductID between 400 and 500;


--Uppgift 1.9

--select	ProductID
--	,	Name
--	,	Color
--from	Production.Product
--where	Color in ('Black' , 'Blue');


--Uppgift 1.10

--select	Name
--	,		ListPrice
--from	Production.Product
--where	Name like 'S%';


--Uppgift 1.11

--select	Name
--	,		ListPrice
--from	Production.Product
--where	Name like 'S%'
--		or Name like 'A%';


--Uppgift 1.12

--select	Name
--	,		ListPrice
--from	Production.Product
--where	Name like 'SPO%' and Name not like 'SPOK%'



--Uppgift 1.13

--select distinct	Color
--from Production.Product;



--Uppgift 1.14

--select distinct ProductSubcategoryID
--	, 	Color
--from	Production.Product
--where	ProductSubcategoryID is not null
--		and Color is not null
--order by ProductSubcategoryID asc,
--		 Color desc


--Uppgift 1.15

--select	ProductSubCategoryID 
--	,	left([Name],35) AS [Name] 
--	,	Color
--	,	ListPrice  
--from Production.Product 
--where Color in ('Red','Black')  
--and ProductSubCategoryID = 1    
--or ListPrice between 1000 and 2000        
--order by ProductID;


--Uppgift 1.16

--select	Name
--	, isnull(Color, 'Unknown') as Color
--	,	ListPrice
--from Production.Product;



--Uppgift 2.1

--select	count(Name)
--from	Production.Product;



--Uppgift 2.2

--select	count(Name)
--from	Production.Product
--where ProductSubcategoryID is not null;


--Uppgift 2.3

--select	ProductSubcategoryID
--	,	count(Name) as CountedProducts
--from	Production.Product
--group by ProductSubcategoryID; 


-- Uppgift 2.4

--select	count(Name) as NoSub
--from	Production.Product
--where	ProductSubcategoryID is null

--select count(*) - count(ProductSubcategoryID) as NoSub
--from Production.Product



--Uppgift 2.5

--select	ProductID
--	,	sum(Quantity) as InStock					
--from	Production.ProductInventory
--group by	ProductID;



--Uppgift 2.6

--select	ProductID
--	,	sum(Quantity) as InStock				
--from	Production.ProductInventory
--where	LocationId = 40
--group by ProductID, Quantity, LocationID
--having	Quantity < 100;



--Uppgift 2.7

--select	ProductID
--	,	sum(Quantity) as InStock	
--	,	Shelf		
--from	Production.ProductInventory
--where	LocationId = 40
--group by ProductID, Quantity, Shelf
--having	Quantity < 100;



--Uppgift 2.8 

--select	avg(Quantity) as AvgQuantity
--from	Production.ProductInventory
--where	LocationID = 10;


--Uppgift 2.9

--select	row_number() over(order by Name asc) as Row
--	,	Name
--from	Production.ProductCategory;


--Uppgift 3.1

--select	CountryReg.[Name] as Country
--	,	StateProv.[Name] as State
--from	Person.CountryRegion as CountryReg
--			join Person.StateProvince as StateProv
--				on CountryReg.CountryRegionCode = StateProv.CountryRegionCode;



--Uppgift 3.2

--select	CountryReg.[Name] as Country
--	,	StateProv.[Name] as Province
--from	Person.CountryRegion as CountryReg
--			join Person.StateProvince as StateProv
--				on CountryReg.CountryRegionCode = StateProv.CountryRegionCode
--where CountryReg.Name = 'Germany' or CountryReg.Name = 'Canada'
--order by Country asc, Province asc;


--Uppgift 3.3

--select	SOH.SalesOrderID
--	,	SOH.OrderDate
--	,	SOH.SalesPersonID
--	,	SP.BusinessEntityID
--	,	SP.Bonus
--	,	SP.SalesYTD
--from Sales.SalesOrderHeader as SOH
--		join Sales.SalesPerson	as SP
--			on SOH.SalesPersonID = SP.BusinessEntityID;


--Uppgift 3.4
 
--Bygg på föregående fråga och lägg till JobTitle och ta bort SalesPersonID och BusinessEntity. 
--Du måste joina med HumanResources.Emplyee.

--select	SOH.SalesOrderID
--	,	SOH.OrderDate
--	,	SP.Bonus
--	,	SP.SalesYTD
--	,	EMP.JobTitle
--from Sales.SalesOrderHeader as SOH
--		join Sales.SalesPerson	as SP
--			on SOH.SalesPersonID = SP.BusinessEntityID
--				join HumanResources.Employee as EMP
--					on SP.BusinessEntityID = EMP.BusinessEntityID;


--Uppgift 3.5

--select	SOH.SalesOrderID
--	,	SOH.OrderDate
--	,	SP.Bonus
--	,	P.FirstName
--	,	P.LastName
--from Sales.SalesOrderHeader as SOH
--		join Sales.SalesPerson	as SP
--			on SOH.SalesPersonID = SP.BusinessEntityID
--				join HumanResources.Employee as EMP
--					on SP.BusinessEntityID = EMP.BusinessEntityID
--						join Person.Person as P
--							on EMP.BusinessEntityID = P.BusinessEntityID;



--Uppgift 3.6
 

--select	SOH.SalesOrderID
--	,	SOH.OrderDate
--	,	SP.Bonus
--	,	P.FirstName
--	,	P.LastName
--from Sales.SalesOrderHeader as SOH
--		join Sales.SalesPerson	as SP
--			on SOH.SalesPersonID = SP.BusinessEntityID
--						join Person.Person as P
--							on SP.BusinessEntityID = P.BusinessEntityID;


--Uppgift 3.7

--select	SOH.SalesOrderID
--	,	SOH.OrderDate
--	,	P.FirstName
--	,	P.LastName
--from Sales.SalesOrderHeader as SOH
--		join Person.Person as P
--			on SOH.SalesPersonID = P.BusinessEntityID;


--Uppgift 3.8
 
--Nu vill vi även se orderdetaljer. Använd ovanstående fråga och joina med Sales.SalesOrderDetail 
--där du hämtar ProductID och OrderQty. Slå även ihop FirstName och LastName till en kolumn 
--som du kallar SalesPerson. Sortera raderna på OrderDate och SalesOrderID 


--select	SOH.SalesOrderID
--	,	SOH.OrderDate
--	,	P.FirstName + ' ' + P.LastName as SalesPerson
--	,	SOD.ProductID
--	,	SOD.OrderQty
--from Sales.SalesOrderHeader as SOH
--		join Person.Person as P
--			on SOH.SalesPersonID = P.BusinessEntityID
--				join Sales.SalesOrderDetail as SOD
--					on SOH.SalesOrderID = SOD.SalesOrderID
--order by SOH.OrderDate, SOH.SalesOrderID;


--Uppgift 3.9

--Nu vill vi ha namnet på produkten istället för ProductID. 
--Du kan få tag I det genom att joina med Production.Product 

--select	SOH.SalesOrderID
--	,	SOH.OrderDate
--	,	P.FirstName + ' ' + P.LastName as SalesPerson
--	,	Product.Name as ProductName
--	,	SOD.OrderQty	
--from Sales.SalesOrderHeader as SOH
--		join Person.Person as P
--			on SOH.SalesPersonID = P.BusinessEntityID
--				join Sales.SalesOrderDetail as SOD
--					on SOH.SalesOrderID = SOD.SalesOrderID
--						join Production.Product as Product
--							on SOD.ProductID = Product.ProductID
--order by SOH.OrderDate, SOH.SalesOrderID;



--Uppgift 3.10 

--select	soh.SalesOrderID
--	,	soh.OrderDate
--	,	prs.FirstName + ' ' + prs.LastName AS SalesPerson
--	,	p.Name AS ProductName
--	,	sod.OrderQty
--from Sales.SalesOrderHeader AS soh
--inner join Person.Person AS prs
--    on soh.SalesPersonID = prs.BusinessEntityID
--inner join Sales.SalesOrderDetail AS sod
--    on soh.SalesOrderID = sod.SalesOrderID
--inner join Production.Product AS p
--    on p.ProductID = sod.ProductID
--where soh.SubTotal > 100000
--  and soh.OrderDate >= '20040101'
--  and soh.OrderDate < '20050101'
--order by OrderDate, SalesOrderID





 --Uppgift 3.11

--select	PCR.Name
--	,	PSP.Name
--from	Person.CountryRegion as PCR
--		left outer join Person.StateProvince as PSP
--				on PCR.CountryRegionCode = PSP.CountryRegionCode
--order by PCR.Name, PSP.Name


--Uppgift 3.12

--Skriv en fråga som returnerar kunder som ännu inte lagt en order. 
--Detta kan göras med en outer join eftersom kunden finns i Sales.Customer men inte i Sales.SalesOrderHeader. 

--select	Customer.CustomerID
--	,	SOH.SalesOrderID
--from	Sales.Customer as Customer
--			left outer join Sales.SalesOrderHeader SOH
--				on Customer.CustomerID = SOH.CustomerID
--where SOH.SalesOrderID is null


--Uppgift 3.13

--Använd en FULL JOIN och returnera en lista med produkter som inte har något modellnamn och modeller 
--som inte är kopplade till någon produkt. Du skall returnera ProductName och ProductModelName. 

--select	P.Name as ProductName
--	,	PModel.Name as ProductModelName
--from	Production.Product as P
--			full join Production.ProductModel as PModel
--				on P.ProductModelID = PModel.ProductModelID
--where	PModel.Name is null
--		or P.Name is null


--Uppgift 3.14

--select	P.BusinessEntityID as SalesPersonId
--	,	P.FirstName + ' ' + P.LastName as FullName
--from	Sales.SalesPerson as SP
--			join HumanResources.Employee as EMP
--				on EMP.BusinessEntityID = SP.BusinessEntityID
--					join Person.Person as P
--						on EMP.BusinessEntityID = P.BusinessEntityID
				

--Steg 2

--select	SP.BusinessEntityID
--	,	P.FirstName + ' ' + P.LastName as FullName
--	,	sum(SOH.SubTotal) as TotalSum
--	,	count(SOH.SalesPersonID) as [No. Orders]
--from	Sales.SalesPerson as SP
--			join HumanResources.Employee as EMP
--				on EMP.BusinessEntityID = SP.BusinessEntityID
--					join Person.Person as P
--						on P.BusinessEntityID = EMP.BusinessEntityID 
--							join Sales.SalesOrderHeader as SOH
--								on  SP.BusinessEntityID = SOH.SalesPersonID

--group by	SP.BusinessEntityID
--		,	P.FirstName + ' ' + P.LastName
		

--Uppgift 3.15

--select	datepart(year,OrderDate) as [Year]
--	,	Name as Region
--	,	sum(SubTotal) as SumTotal
--from	Sales.SalesOrderHeader as SOH
--			join Sales.SalesTerritory as ST 
--				on SOH.TerritoryID = ST.TerritoryID
--group by datepart(year, SOH.OrderDate)
--	,	 [Name] 
--ORDER BY [Name] desc
--	,	 datepart(year,OrderDate) asc



--Uppgift 3.16
--Vi vill veta vilka anställda som har jobbat på mer än en avdelning.  
--Använd Person.Person, HumaResources.Employee och Humanresources.EmployeeDepartmentHistory  
--Använd COUNT I kombination med GROUP BY och HAVING för att få svaret. 

--select	EMP.BusinessEntityID
--	,	P.LastName
--	,	count(DH.DepartmentID) as [D Count]
--from	Person.Person as P
--			join HumanResources.Employee as EMP
--				on	P.BusinessEntityID = EMP.BusinessEntityID
--					join HumanResources.EmployeeDepartmentHistory as DH
--						on EMP.BusinessEntityID = DH.BusinessEntityID
--group by	P.LastName
--	,		EMP.BusinessEntityID
--having count(DH.DepartmentID) > 1



--Uppgift 3.17

--select	min(SOH.SubTotal) as Value
--from	Sales.SalesOrderHeader as SOH

--union

--select	max(SOH.Subtotal) as MaxValue
--from	Sales.SalesOrderHeader as SOH

--union

--select	avg(SOH.SubTotal) as Average
--from Sales.SalesOrderHeader as SOH



--Uppgift 3.18
--Skriv en fråga som visa de 10 dyraste produkterna. 
--Använd TOP och returnera ListPrice och Name. 

--select	top(10)P.ListPrice
--	,	P.Name
--from	 Production.Product as P
--order by P.ListPrice desc



--Uppgift 3.19

--Skriv en fråga som visar namnet och priset på den  1% av produkterna som har längst tillverkningstid. 
--Du hittar datan du behöver i Production.Product. 

--select	top(1)percent P.DaysToManufacture
--	,	P.Name
--	,	P.ListPrice
--from	Production.Product as P
--order by P.DaysToManufacture desc