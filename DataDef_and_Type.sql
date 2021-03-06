CREATE DATABASE Minions;  -- 1. Create database

-- 2. Create tables with primaty key Id
CREATE TABLE Minions (Id INTEGER IDENTITY(1,1) PRIMARY KEY, Name NVARCHAR(50), Age INT);

CREATE TABLE Towns (Id INTEGER IDENTITY(1,1) PRIMARY KEY, Name NVARCHAR(50));

-- 3. Alter tables to add fields, CONTRAINTS and KEYs
ALTER TABLE Minions ADD TownId INTEGER;

ALTER TABLE Minions ADD FOREIGN KEY (TownID) REFERENCES Towns (Id);

-- 4. Populate tables with data using INSERT
INSERT INTO Towns (Name) VALUES 
    ('Sofia');

INSERT INTO Towns (Name) VALUES 
    ('Peter');

INSERT INTO Towns (Name) VALUES 
    ('Victoria');

INSERT INTO Minions (Name, Age, TownId)
    VALUES ('Kevin', 22, 1);

INSERT INTO Minions (Name, Age, TownId)
    VALUES ('Bob', 15, 3);

INSERT INTO Minions (Name, TownId)
    VALUES ('Steward', 2);

-- 5. Delete all data from the table 
DELETE FROM Minions;

-- DROP both tables
DROP TABLE Minions;
DROP TABLE Towns;

-- 7. Create new table with specific criteria and populate with data
CREATE TABLE People (
    Id INTEGER IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Picture VARBINARY(MAX),
    Height DECIMAL(10,2),
    Gender CHAR(1) CHECK(Gender = 'M' OR Gender = 'F') NOT NULL,
    Birthdate DATE NOT NULL,
    Biography TEXT
)

INSERT INTO People (Name, Height, Gender, Birthdate, Biography)
    VALUES ('Greta Tintin Eleonora Ernman Thunberg', 148.6, 'F', '2003-01-03', 'Greta Tintin Eleonora Ernman Thunberg (Swedish: [ˈɡrêːta ˈtʉ̂ːnbærj] (About this soundlisten); born 3 January 2003) is a Swedish environmental activist who has gained international recognition for promoting the view that humanity is facing an existential crisis arising from climate change.[3] Thunberg is known for her youth and her straightforward speaking manner,[4] both in public and to political leaders and assemblies, in which she criticises world leaders for their failure to take sufficient action to address the climate crisis.')
;

INSERT INTO People (Name, Height, Gender, Birthdate, Biography)
    VALUES ('Raymond Merlon de Groat', 170.69, 'M', '1966-06-26', 'Ray is user-friendly with a diverse background in network protocols, troubleshooting, hardware, repair, linux Bash scripting, Python, AppleScript, technical support, documentation, user training, and even product demos. He has completed thousands of repairs, resolved countless support issues, and was awarded Technician of the Year by Apple Sweden.')
;

INSERT INTO People (Name, Height, Gender, Birthdate, Biography)
    VALUES('Lynda Susan Weinman', 171.03, 'F', '1955-01-24', 'Lynda Susan Weinman (born January 24, 1955) is an American business owner, computer instructor, and author, who founded an online software training website, lynda.com, with her husband, Bruce Heavin.[1] Lynda.com was acquired by online business network LinkedIn in April 2015 for $1.5 billion. Weinman, with self-taught computer skills, worked in the film industry as a special effects animator, and became a faculty member at Art Center College of Design, UCLA, American Film Institute, and San Francisco State University multimedia studies program teaching computer graphics, animation, interactive design, and motion graphics. She has also written several books.')
;

INSERT INTO People (Name, Height, Gender, Birthdate, Biography)
    VALUES ('Todd Harry Rundgren', 176.48, 'M', '1948-06-22', 'Todd Harry Rundgren (born June 22, 1948) is an American multi-instrumentalist, singer, songwriter, and record producer who has performed a diverse range of styles as a solo artist and as a member of the band Utopia. He is known for his sophisticated and often-unorthodox music, his occasionally lavish stage shows, and his later experiments with interactive entertainment. He also produced music videos and was an early adopter and promoter of various computer technologies, such as using the Internet as a means of music distribution in the late 1990s.')
;

INSERT INTO People (Name, Gender, Birthdate, Biography)
    VALUES ('Theodor Holm Nelson', 'M', '1937-06-17','Theodor Holm Nelson is an American pioneer of information technology, philosopher and sociologist. He coined the terms hypertext and hypermedia in 1963 and published them in 1965. Nelson coined the terms transclusion, virtuality, and intertwingularity (in Literary Machines), and teledildonics. According to a 1997 Forbes profile, Nelson "sees himself as a literary romantic, like a Cyrano de Bergerac, or the Orson Welles of software.')
;

-- 8. Create table Users to specification and populate
CREATE TABLE Users (
    Id INTEGER IDENTITY(1,1),
    Username VARCHAR(30) NOT NULL,
    Password NVARCHAR(26) NOT NULL,
    LastLoginTime DATETIME,
    IsDeleted BIT
    CONSTRAINT pk_Users PRIMARY KEY (Id)
);

INSERT INTO Users (Username, [Password], IsDeleted)
    VALUES ('Greta', 'ABCDEFG', 0);
INSERT INTO Users (Username, [Password], IsDeleted)
    VALUES ('Ray', 'Password', 0);
INSERT INTO Users (Username, [Password], IsDeleted)
    VALUES ('Lynda', '12345', 0);
INSERT INTO Users (Username, [Password], IsDeleted)
    VALUES ('Todd', '12312345', 0);
INSERT INTO Users (Username, [Password], IsDeleted)
    VALUES ('Ted', 'Xanadu', 0);

-- 9. DROP the CONTRAINT or the PRIMARY KEY. ALTER TABLE to add composit key of Id & Username
ALTER TABLE Users
DROP CONSTRAINT pk_Users;

ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id,Username);

-- 10. Add a contraint check to ensure passowrd is at least 5 charachters long
ALTER TABLE Users
ADD CONSTRAINT chk_Password CHECK (LEN(Password) >= 5);

--11. Use the current date and time as the default value for a field
ALTER TABLE Users
ADD CONSTRAINT df_LastLoginTime
DEFAULT CURRENT_TIMESTAMP FOR LastLoginTime;

-- 12. Change the composit key to a single field. Contrain a field to require at least 3 characters
ALTER TABLE Users
DROP CONSTRAINT pk_Users;

ALTER TABLE Users
ADD CONSTRAINT pk_Users PRIMARY KEY (Id)

ALTER TABLE Users
ADD CONSTRAINT chck_Username CHECK (LEN(Username) >= 3);
                                                                        
