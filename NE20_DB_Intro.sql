/* NE20 Lab: Intro to Databases */

/* Step 1. Create a new database named Bank with collation set to Cyrillic */

CREATE DATABASE Bank /* COLLATION Cyrillic_General_100_CI_AS */
GO

/* Step 2. Set up the schema - Create the main tables in the database */

/* Create a clients table */

CREATE TABLE Clients (
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR (50) NOT NULL,
	LastName NVARCHAR (50) NOT NULL
)

/* Create a table to hold the types of accounts. At present, just checking and savings */

CREATE TABLE AccountTypes (
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL
)

/* Create a table to hold the accounts */

CREATE TABLE Accounts (
	Id INT PRIMARY KEY IDENTITY,
	AccountTypeId INT FOREIGN KEY REFERENCES AccountTypes(Id),
	Balance Decimal(15, 2) NOT NULL DEFAULT(0),
	ClientId INT FOREIGN KEY REFERENCES Clients(Id)

/* Step 3. Populate the database with test data. Populate the cliets table with some initial data for testing */

 INSERT INTO Clients (FirstName, LastName) VALUES
	('Greta', 'Anderson'),
	('Peter', 'Petterson'),
	('Mel', 'Gibson'),
	('Maria', 'Danielsson')

/* Populate the AccountTypes table with the two types of accounts, checking and savings */

INSERT INTO AccountTypes (Name) VALUES
	('Checking'),
	('Savings')
  
/* Populate the Accounts table with the newly created data from the Clients and AccountType tables and provide a starting balance */

INSERT INTO Accounts (ClientId, AccountTypeId, Balance) VALUES
	(1, 1, 175),
	(2, 1, 275.56),
	(3, 1, 138.01),
	(4, 1, 40.30),
	(4, 1, 375.50)
 
/* Step 4. Create a simple view or "found set" */

CREATE VIEW  v_ClientBalances AS SELECT (FirstName + ' ' + LastName) AS [Name],
(AccountTypes.Name) AS [Account Type], Balance FROM Clients
JOIN Accounts ON Clients.Id = Accounts.ClientId
JOIN AccountTypes ON AccountTypes.Id = Accounts.AccountTypeId

/* Test the view by calling it like this: SELECT * FROM v_ClientBalances */

/* Step 5. Create a Function to calculate total balance form checking & savings */

CREATE FUNCTION f_CalculateTotalBalance (@ClientID INT) RETURNS DECIMAL (15, 2)
BEGIN
    DECLARE @result AS DECIMAL(15,2) = (
        SELECT SUM(Balance)
        FROM Accounts WHERE ClientId = @ClientID
    )
    RETURN @result
END

/* Test the new function by calling it like this: SELECT dbo.f_CalculateTotalBalance (4) AS Balance */
/* Check the resutls by viewing the Accounts table like this: SELECT * FROM Accounts */

/* 6. Create proceedures. Create an "add account" procedure */

CREATE PROC p_AddAccount @ClientId INT, @AccountTypeId INT AS
INSERT INTO Accounts (ClientId, AccountTypeId)
VALUES (@ClientId, @AccountTypeId)


/* Call the procedure and check the Accounts table to see the new account has been added.
For example: p_AddAccount 2, 2 */

/* Create a "deposit" procedure */

CREATE PROC p_Deposit @AccountId INT, @Amount DECIMAL(15, 2) AS UPDATE Accounts
SET Balance += @Amount WHERE Id = @AccountId

/* Create a "withdrawal" procedure which will subtract the withdrawal amount only if there are sufficient funds.
    Otherwise and error will be returned. */

CREATE PROC p_Withdraw @AccountId INT, @Amount DECIMAL(15,2) AS
BEGIN
    DECLARE @OldBalance DECIMAL(15,2)
    SELECT @OldBalance = Balance FROM Accounts WHERE Id = @AccountId
    IF (@OldBalance - @Amount >= 0 )
    BEGIN
        UPDATE Accounts
        SET Balance -= @Amount
        WHERE Id = @AccountId
    END
    ELSE
    BEGIN
        RAISERROR('Insufficien funds', 10,1)
    END
END

/* Step 7. Create a Transactions table to record the transactions (proceedures) and a trigger
    which will run when the Accounts table is updated. */

CREATE TABLE Transactions (
    Id INT PRIMARY KEY IDENTITY,
    AccountId INT FOREIGN KEY REFERENCES Accounts(Id),
    OldBalance DECIMAL(15,2) NOT NULL,
    NewBalance DECIMAL(15,2) NOT NULL,
    Amount AS NewBalance - OldBalance,
    [DateTime] DATETIME2
)

CREATE TRIGGER tr_Transaction ON Accounts
AFTER UPDATE
AS
    INSERT INTO Transactions (AccountId, OldBalance, NewBalance, [DateTime])
    SELECT inserted.Id, deleted.Balance, inserted.Balance, GETDATE() FROM inserted
    JOIN deleted ON inserted.Id = deleted.Id

/* Perform some transactions to test */

/*
p_Deposit 1, 25.00
GO

p_Deposit 1, 40.00
GO

p_Withdraw 2, 200
GO

p_Deposit 4, 180
GO
*/

/* Check the Accounts to see the balance reflected */

/*
SELECT * FROM Accounts
*/

/* Check the Transactions table to see that the trigger worked */

/*
SELECT * FROM Transactions
*/












