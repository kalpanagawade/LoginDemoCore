CREATE TABLE C#Topics (
    Id INT PRIMARY KEY,
	ParentID INT,
    TopicName VARCHAR(50),
    TopicContent NVARCHAR(MAX),
	Code NVARCHAR(MAX),
	Language Varchar(50)
);


INSERT INTO C#Topics (Id,ParentID,TopicName, TopicContent,Code,Language)
VALUES ('10','10','OOP','Object Oriented Programing','Code','C#'),
('11','10','Abstraction','Abstraction','Code','C#'),
('12','10','Inheritance','Inheritance','Code','C#'),
('13','10','Polymorphism','Polymorphism','Code','C#'),
('14','10','Encapsulation','Encapsulation','Code','C#')



