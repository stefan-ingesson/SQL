IF NOT EXISTS (select name from master.sys.databases where name = N'BibliotekDatabas')
CREATE DATABASE BibliotekDatabas;
GO
USE BibliotekDatabas;
GO

if not exists (select object_id, type from sys.objects where object_id = object_id(N'dbo.AuthorList') and type in(N'U'))
 begin

create table AuthorList
(
		AuthorId int not null identity(1,1) primary key
	,	FirstName nvarchar(50) not null
	,	LastName nvarchar(50) not null
	,	YearOfBirth date not null
	,	YearOfDeath date null
	,	CountryOfOrigin varchar(100) null
	,	constraint CK_Author_BirthDeathControl
			check (YearOfDeath is null or YearOfDeath > YearOfBirth)
	,	 unique(FirstName, LastName,YearOfBirth,YearOfDeath)
);
end
go

if not exists (select object_id, type from sys.objects where object_id = object_id(N'dbo.BookList') and type in(N'U'))
begin
create table BookList
(
		BookId int not null identity(1, 1) primary key
	,	AuthorId int not null
	,	Title varchar(100) not null
	,	ReleaseYear date not null
	,	Genre varchar(100) not null
	,	[Language] varchar(50) not null
	,	constraint FK_BookList_AuthorId foreign key (AuthorId) 
			references AuthorList (AuthorId)			
);
end
go

if not exists (select object_id, type from sys.objects where object_id = object_id(N'dbo.UniqueBookCopy') and type in(N'U'))
begin
create table UniqueBookCopy
(
		CopyId int not null identity(1, 1) primary key
	,	PurchasePrice money not null
	,	PurchaseDate date null
	,	BookId int not null
	,	[Status] int not null constraint DF_UniqueBookCopy_Status default 1 
	,	constraint FK_UniqueBookCopy_BookId foreign key (BookId) 
			references [BookList] (BookId)		
);
end
go

if not exists (select object_id, type from sys.objects where object_id = object_id(N'dbo.Customer') and type in(N'U'))
begin
create table Customer
(
		CustomerId int not null identity(1, 1) primary key
	,	FirstName varchar(50) not null
	,	LastName varchar(50) not null
	,	Adress varchar(50) not null 
	,	PhoneNumber varchar(50) not null
	,	Email varchar(50) not null
	,	Gender varchar(10) not null
	,	constraint CK_Customer_Email
			check (Email like '%_@%_._%')
	,	constraint CK_Customer_Gender
			check (Gender is null or Gender in ('Male', 'Female'))
	,	unique (Email)
);
end
go

if not exists (select object_id, type from sys.objects where object_id = object_id(N'dbo.CurrentLoans') and type in(N'U'))
begin
create table CurrentLoans
(
		LoanId int not null identity(1, 1) primary key
	,	CustomerId int not null
	,	CopyId int not null
	,	[Date] date not null
	,	IsReturned bit not null constraint DF_IsReturned_False default 0
	,	DueDate as dateadd(dd, 14, [Date])
	,	constraint FK_Loan_CustomerId foreign key (CustomerId) 
			references Customer (CustomerId)
	,	constraint FK_Loan_UniqueBookCopy_CopyId foreign key (CopyId) 
			references UniqueBookCopy (CopyId)
	,	unique (CustomerId, CopyId, [Date], DueDate)	
);
end
go


if not exists (select * from dbo.AuthorList) 
begin

declare @AuthorId integer;
insert into AuthorList
				(FirstName,LastName,YearOfBirth, YearOfDeath, CountryOfOrigin)
values			('John', 'Tolkien', '1892', '1973', 'England')
set @AuthorId = scope_identity()
insert into		dbo.BookList 
				(AuthorId,Title, ReleaseYear, Genre, [Language])
values			(@AuthorId,'The Hobbit',  '1937', 'Fantasy', 'English')
declare @BookId integer
set @BookId = scope_identity()
insert into UniqueBookCopy
			(PurchasePrice, PurchaseDate, BookId)
values		(15.00, '2001-02-03', @BookId)
		,	(15.00, '2001-02-03', @BookId)
		,	(15.00, '2001-02-03', @BookId)
		,	(15.00, '2001-02-03', @BookId)


insert into AuthorList
			(FirstName, LastName, YearOfBirth, YearOfDeath, CountryOfOrigin)
values		('Astrid', 'Lindgren', '1907' ,'2002', 'Sweden')
set @AuthorId = scope_identity()
insert into dbo.BookList
			(Title, ReleaseYear, Genre ,[Language], AuthorId)
values		('Bröderna Lejonhjärta', '1973','Fantasy', 'Swedish', @AuthorId)
set @BookId = scope_identity()
insert into UniqueBookCopy
			(PurchasePrice, PurchaseDate, BookId)
values		(25.00, '1995-07-23', @BookId)
		,	(25.00, '1995-07-23', @BookId)
		,	(25.00, '1995-07-23', @BookId)
		,	(25.00, '1995-07-23', @BookId)
		,	(25.00, '1995-07-23', @BookId)


insert into AuthorList
				(FirstName, LastName, YearOfBirth, CountryOfOrigin)		
values			('Stephen', 'King', '1947', 'USA')	
set @AuthorId = scope_identity()
insert into dbo.BookList
				(Title, ReleaseYear, Genre, [Language],AuthorId)
values			('It', '1986', 'Horror' ,'English', @AuthorId)
set @BookId = scope_identity()
insert into UniqueBookCopy
			(PurchasePrice, PurchaseDate, BookId)
values		(20.00, '1992-04-21', @BookId)
		,	(20.00, '1992-04-21', @BookId)
		,	(20.00, '1992-04-21', @BookId)
		,	(20.00, '1992-04-21', @BookId)
		,	(20.00, '1992-04-21', @BookId)


insert into AuthorList
				(FirstName, LastName, YearOfBirth, CountryOfOrigin)		
values			('Paolo', 'Coelho', '1947', 'Brazil')	
set @AuthorId = scope_identity()
insert into dbo.BookList
				(Title, ReleaseYear, Genre, [Language],AuthorId)
values			('The Alchemist', '1988', 'Adventure' ,'Swedish', @AuthorId)
set @BookId = scope_identity()
insert into UniqueBookCopy
			(PurchasePrice, PurchaseDate, BookId)
values		(17.00, '1995-04-21', @BookId)
		,	(17.00, '1995-04-21', @BookId)
		,	(17.00, '1995-04-21', @BookId)
		,	(17.00, '1995-04-21', @BookId)
		,	(17.00, '1995-04-21', @BookId)	


insert into dbo.Customer
			(FirstName,LastName,Adress, PhoneNumber, Email, Gender)
values		('Kent', 'Andersson', 'Hittepåvägen 56', '0480-112233', 'thisismyemail@email.com', 'Male')
		,	('Harriet', 'Mellerud', 'Tjoflöjtvägen 2', '332211', 'email@email.com', 'Female')
		,	('Sven', 'Karlsson', 'Wienerbrödsgatan 27', '221133', 'email@hotmail.com', 'Male')
		,	('Bengt', 'Koskenkorva', 'Tjofräsgatan 1', '0485-33164', 'BengtKoskenkorva@gmail.com', 'Male')		


insert into dbo.CurrentLoans(CustomerId, CopyId, [Date])
values		(2, 3, '2015-01-13')
		,	(3, 7, '2015-01-17')
		,	(1, 13, getdate())
		,	(4, 18, '2015-03-17')
		

insert into dbo.CurrentLoans(CustomerId, CopyId, [Date])
values	(1, 1, getdate())
end
go

--Uppdatera unika boken
begin
update dbo.UniqueBookCopy
		set Status = 2
		from dbo.UniqueBookCopy as C
			 inner join dbo.CurrentLoans as L
			 on C.CopyID = L.CopyId
		where L.[Date] is not null
end

if not exists (select name, type from sys.objects where name = N'vBookCustomer' and type in(N'V'))
begin
	execute dbo.sp_executesql @statement = 
	N'create view vBookCustomer
	as
	select b.Title as Title
		,	Cust.FirstName + '' '' + Cust.LastName as Customer
		,	L.DueDate
		,	a.FirstName
		,	a.LastName
		,	b.BookId
	from dbo.BookList b	
	inner join dbo.UniqueBookCopy as C
		on b.BookId = c.BookId
	inner join	dbo.CurrentLoans as L
		on c.CopyId = l.CopyId
	inner join dbo.Customer AS Cust
		on L.CustomerId = Cust.CustomerId
	inner join dbo.AuthorList a on a.AuthorId = b.AuthorId'
end;


if not exists (select name, type from sys.objects where name = N'vBooksAvailable' and type in(N'V'))
begin
	execute dbo.sp_executesql @statement = 
		N'create view vBooksAvailable
		as
		select B.Title, count(C.CopyId) AS CopiesAvailable
		from dbo.UniqueBookCopy AS C
		inner join dbo.BookList AS B
		on C.BookId = B.BookId
		where [Status] = 1
		group by B.Title'
end;


go
if object_id(N'dbo.usp_Add_Loan') is not null
drop procedure dbo.usp_Add_Loan;
go
create procedure dbo.usp_Add_Loan
(
	@CopyId int,
	@CustomerId int
)
	as
	begin try
	begin transaction
		insert into dbo.CurrentLoans (CustomerId, CopyId, Date)
		values (@CustomerId, @CopyId, getdate())
		update UniqueBookCopy 
		set [Status] = 2
		where CopyId = @CopyId
	commit transaction
	end try
	begin catch
	rollback transaction
	select 'Loan Successful'
	end catch;


go
if object_id(N'dbo.usp_Return_Book') is not null
drop procedure dbo.usp_Return_Book;
go
create procedure dbo.usp_Return_Book
	(
	@CopyId int,
	@CustomerId int
	)
as 
begin try
	begin transaction
		update dbo.CurrentLoans
		set	IsReturned = 1
		from dbo.CurrentLoans
		where CopyID = @CopyID
		update dbo.UniqueBookCopy
		set [Status] = 1
		from dbo.UniqueBookCopy as UBC
			inner join CurrentLoans AS L ON UBC.CopyId = L.CopyID
		where UBC.CopyID = @CopyID
		commit transaction
end try
begin catch
rollback transaction
select 'Transaction failure - Book return failed'
end catch


execute dbo.usp_Add_Loan @CopyId=9 ,@CustomerID=4;

execute dbo.usp_Return_Book @CopyId=9, @CustomerId=4;



select * 
from dbo.vBookCustomer

select *
from dbo.vBooksAvailable

select * from UniqueBookCopy
select * from Customer
select * from CurrentLoans
select * from AuthorList
select * from BookList
 







