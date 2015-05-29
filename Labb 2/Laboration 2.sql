use AdventureWorks2012;

-- Uppgift 4.0 --
--BACKUP DATABASE AdventureWorks
--TO DISK = 'C:\SQLDATA\AW_BU.bak'

-- Uppgift 4.1 --
begin transaction

select @@trancount as ActiveTransactions

select LastName
from Person.Person

update Person.Person
set LastName = 'Hult'

rollback transaction

-- Uppgift 4.2 --
create table dbo.TempCustomers
(
	ContactID int NULL,
	FirstName nvarchar(50) NULL,
	LastName nvarchar(50) NULL,
	City nvarchar(30) NULL,
	StateProvince nvarchar(50) NULL
)
GO

insert into dbo.TempCustomers values
(1,'Kalen','Delaney'),
(2,'Herman','Karlsson','Vislanda','Kronoberg')

insert into dbo.TempCustomers values
(3,'Tora','Eriksson','Guldsmedshyttan'),
(4,'Charlie','Carpenter','Tappström')

insert into dbo.TempCustomers(ContactID,FirstName,LastName,City) values
(3,'Tora','Eriksson','Guldsmedshyttan'),
(4,'Charlie','Carpenter','Tappström')

select ContactID
	,	FirstName
	,	LastName
	,	City
	,	StateProvince
from dbo.TempCustomers

-- Uppgift 4.3 --

insert into Production.Product(Name, ProductNumber, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, DaysToManufacture, SellStartDate) values 
('Racing Gizmo', '', 1, 2, 50, 75, 1, GETDATE())

-- Uppgift 4.4 --
insert into dbo.TempCustomers(ContactID,FirstName,LastName,City,StateProvince) 
(
select P.BusinessEntityID, P.FirstName
, P.LastName, PA.City , SP.Name
from Person.Person as P
		join Person.BusinessEntity as BE
on P.BusinessEntityID=BE.BusinessEntityID
		join Person.BusinessEntityAddress as BEA
on BE.BusinessEntityID = BEA.BusinessEntityID
		join Person.Address PA
on BEA.AddressID=PA.AddressID
		join Person.StateProvince AS SP
on PA.StateProvinceID = SP.StateProvinceID
)

-- Uppgift 4.5 --

truncate table dbo.TempCustomers
go
dbcc DROPCLEANBUFFERS
dbcc FREEPROCCACHE
go

declare @Start datetime2, @Stop datetime2
select @Start = SYSDATETIME()
insert into dbo.TempCustomers
(ContactID, FirstName, LastName)
select BusinessEntityID, FirstName, LastName
from Person.Person
select @Stop = SYSDATETIME()
select DATEDIFF(ms,@Start,@Stop) as MilliSeconds


-- 220ms, 42ms, 38ms, 33ms, 90ms, 93ms, 37ms, 29ms

CREATE UNIQUE CLUSTERED INDEX [Unique_Clustered]
ON [dbo].[TempCustomers]
( [ContactID] ASC )
GO
CREATE NONCLUSTERED INDEX [NonClustered_LName]
ON [dbo].[TempCustomers]
( [LastName] ASC )
GO
CREATE NONCLUSTERED INDEX [NonClustered_FName]
ON [dbo].[TempCustomers]
( [FirstName] ASC )

-- 1650ms 

-- Uppgift 4.6 --

select 
		BusinessEntityID as ContactID,
		PersonType, 
		FirstName,
		LastName,
		Title,
		EmailPromotion
into
		#TempTab
from Person.Person
where LastName IN ('Achong', 'Acevedo')

select * from #TempTab

insert into Person.Person(BusinessEntityID,PersonType,FirstName,LastName,Title,EmailPromotion)
select 
		MAX(ContactID+1),
		PersonType,
		FirstName,
		LastName,
		Title,
		EmailPromotion
from #TempTab
group by PersonType,
		 FirstName,
		 LastName,
		 Title,
		 EmailPromotion

select P.FirstName + ' ' + P.LastName as 'Name'
	,	P.BusinessEntityID as 'ContactID'
	,	P.ModifiedDate
from Person.Person as P
where P.ModifiedDate > '2015-03-11'

drop table #TempTab

-- Uppgift 4.7
update Person.Person
set FirstName = 'Gurra', Lastname = 'Tjong'
where BusinessEntityID = 292

-- Upgift 4.8
select * from Production.ProductSubcategory

update Production.Product	
set ListPrice = ListPrice * 1.1
	, ModifiedDate = GETDATE()
from Production.Product as P
	inner join Production.ProductSubcategory as PS
	on P.ProductSubcategoryID = PS.ProductSubcategoryID
	where PS.ProductSubcategoryID = 20; -- 20 == Kategorin Gloves

select Name
	, ModifiedDate
	, ListPrice	
from Production.Product
order by ModifiedDate desc


-- Uppgift 4.9
select * from dbo.TempCustomers
where LastName = 'Smith'


delete from dbo.TempCustomers
where LastName = 'Smith'