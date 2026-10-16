--USE [LoginDB]
--GO
--INSERT [dbo].[C#Topics] ([Id], [ParentID], [TopicName], [TopicContent], [Code], [Language]) VALUES (10, 10, N'OOP', N'Object Oriented Programing', N'using System;  
--class Program  
--{     
--	static void Main()      
--	{          
--		Console.WriteLine("Hello OOP");      
--	}  
--}', N'C#')
--GO
--INSERT [dbo].[C#Topics] ([Id], [ParentID], [TopicName], [TopicContent], [Code], [Language]) VALUES (11, 10, N'What is an Object?', N'2. What is an Object?

--An object is an instance of a class.
--Objects use the class’s properties and methods.

--Example:
--Interview line:
--“An object is a real-world entity created from a class.”', N'class Program
--{
--    static void Main()
--    {
--        Student s1 = new Student();   // Object creation
--        s1.Name = "Kalpana";
--        s1.Display();
--    }
--}', N'C#')
--GO
--INSERT [dbo].[C#Topics] ([Id], [ParentID], [TopicName], [TopicContent], [Code], [Language]) VALUES (12, 10, N'What is a Class?', N'1. What is a Class?

--A class is a blueprint or template used to create objects.
--It contains:
--Fields → store data
--Methods → perform actions

--Example:
--Easy definition:
--“A class is a user-defined type that groups data and functions together.”', N'class Student
--{
--    public string Name;

--    public void Display()
--    {
--        Console.WriteLine("Student Name: " + Name);
--    }
--}', N'C#')
--GO
--INSERT [dbo].[C#Topics] ([Id], [ParentID], [TopicName], [TopicContent], [Code], [Language]) VALUES (13, 10, N'Top-Level Class', N'1. Top-Level Class

--A top-level class is a class that is not inside another class.
--Default Access Modifier: internal   internal', N'internal class Student
--{
--    public void Display()
--    {
--        Console.WriteLine("Hello");
--    }
--}', N'C#')
--GO
--INSERT [dbo].[C#Topics] ([Id], [ParentID], [TopicName], [TopicContent], [Code], [Language]) VALUES (14, 10, N' Nested Class', N'2. Nested Class

--A nested class is a class inside another class.
--Default Access Modifier:
--private
--This means it can be accessed only inside the outer class.', N'public class Outer
--{
--    private class Inner
--    {
--        public void Show()
--        {
--            Console.WriteLine("Inner Class");
--        }
--    }
--}', N'C#')
--GO
--INSERT [dbo].[C#Topics] ([Id], [ParentID], [TopicName], [TopicContent], [Code], [Language]) VALUES (15, 10, N'Abstraction', N'Abstraction is an OOP concept that hides the internal implementation details and exposes only the necessary functionality to the user.Real-Life Example  :-Example: ATM Machine

--When you withdraw money from an ATM:
--You insert the card.->Enter the PIN.->Select Withdraw.->Enter the amount.

--You get the cash.

--You don''t know how the ATM communicates with the bank, verifies your account, or processes the transaction.

--➡️ You only know what it does, not how it works.', N'abstract class Animal
--{
--    public abstract void Sound();

--    public void Eat()
--    {
--        Console.WriteLine(""Animal is eating"");
--    }
--}

--class Dog : Animal
--{
--    public override void Sound()
--    {
--        Console.WriteLine(""Dog barks"");
--    }
--}

--class Program
--{
--    static void Main()
--    {
--        Dog d = new Dog();

--        d.Sound();
--        d.Eat();
--    }
--}', N'C#')
--GO
--INSERT [dbo].[C#Topics] ([Id], [ParentID], [TopicName], [TopicContent], [Code], [Language]) VALUES (16, 10, N'Inheritance', N'Inheritance is an OOP feature that allows one class (derived class) to inherit the fields, properties, and methods of another class (base class), promoting code reuse and extensibility.Real-Life Example
--👨 Parent and Child

--A child inherits many characteristics from their parents, such as:
--Eye color->Hair color->Height->Family name

--Similarly, in C#:

--Parent Class (Base Class) contains common features.
--Child Class (Derived Class) inherits those features and can also add its own.', N'using System;

--class Animal
--{
--    public void Eat()
--    {
--        Console.WriteLine(""Animal is eating"");
--    }
--}

--class Dog : Animal
--{
--    public void Bark()
--    {
--        Console.WriteLine(""Dog is barking"");
--    }
--}

--class Program
--{
--    static void Main()
--    {
--        Dog d = new Dog();

--        d.Eat();    // Inherited method
--        d.Bark();   // Own method
--    }
--}', N'C#')
--GO
--INSERT [dbo].[C#Topics] ([Id], [ParentID], [TopicName], [TopicContent], [Code], [Language]) VALUES (20, 20, N'Class', N'Class', N'class Student
--{
--    public string Name;

--    public void Display()
--    {
--        Console.WriteLine("Student Name: " + Name);
--    }
--}', N'C#')
--GO
--INSERT [dbo].[C#Topics] ([Id], [ParentID], [TopicName], [TopicContent], [Code], [Language]) VALUES (21, 20, N'Static Class', N'1. Static Class
--A static class cannot be instantiated (you cannot create an object).
--It contains only static members.', N'class MathHelper{
--   public static int Square(int n)
--    {
--        return n * n;
--    }
--  } 
-- public class Program
-- {
--  public static void Main(string[] args)
--  {
--       Console.WriteLine(MathHelper.Square(5));
--  }
-- }', N'C#')
--GO
--INSERT [dbo].[C#Topics] ([Id], [ParentID], [TopicName], [TopicContent], [Code], [Language]) VALUES (22, 20, N'Partial class', N'1. PARTIAL CLASSMeaning
--A partial class allows you to split a single class into multiple files.
--All parts are combined into one class during compilation.
-- Key Points
--Uses partial keyword
--Same class name in multiple files
--Improves readability (large projects)
--Common in Windows Forms / ASP.NET auto-generated code', N'// File1.cs
--using System;
--using System.IO;
--public partial class Student
--{
--    public void ShowName()
--    {
--        Console.WriteLine("Name method");
--    }
--}
   
-- // File2.cs
--using System;
--using System.IO;
--public partial class Student
--{
--    public void Display()
--    {
--        Console.WriteLine("Name "+ name);
--    }
--}

--//Program.cs
--using System;
--using System.IO;
--public partial class Student
--{
--    private string name;

--    public Student(string a)
--    {
--        this.name = a;
--    }
--    public void ShowAge()
--    {
--        Console.WriteLine("Age method");
--    }
--}
--class Program
--{
--    static void Main()
--    {
--        Student s = new Student("Hrutik");

--        s.ShowName();
--        s.ShowAge();
--        s.Display();
--    }
--}', N'C#')
--GO
--INSERT [dbo].[C#Topics] ([Id], [ParentID], [TopicName], [TopicContent], [Code], [Language]) VALUES (23, 20, N'Abstract class', N'2. ABSTRACT CLASS
--Meaning

--An abstract class is a blueprint class that cannot be created directly.
--It is used to define common structure for child classes.

--Key Points
--Uses abstract keyword
--Cannot create object
--Can have abstract + normal methods
--Must be inherited
--Child class must implement abstract methods', N'using System;

--abstract class Animal
--{
--    public abstract void Sound();

--    public void Eat()
--    {
--        Console.WriteLine("Animal is eating");
--    }
--}

--class Dog : Animal
--{
--    public override void Sound()
--    {
--        Console.WriteLine("Dog Barks");
--    }
--}

--class Program
--{
--    static void Main()
--    {
--        Dog d = new Dog();

--        d.Sound();
--        d.Eat();
--    }
--}', N'C#')
--GO
--INSERT [dbo].[C#Topics] ([Id], [ParentID], [TopicName], [TopicContent], [Code], [Language]) VALUES (24, 20, N'sealed class', N'SEALED CLASS Meaning
--A sealed class is a class that cannot be inherited by another class.
--Key Points
--Uses sealed keyword
--Cannot be base class
--Used for security / restriction
--Improves performance slightly', N'using System;

--sealed class Vehicle
--{
--    public void Run()
--    {
--        Console.WriteLine("Vehicle is running");
--    }
--}

--class Program
--{
--    static void Main()
--    {
--        Vehicle v = new Vehicle();

--        v.Run();
--    }
--}', N'C#')
--GO
--INSERT [dbo].[C#Topics] ([Id], [ParentID], [TopicName], [TopicContent], [Code], [Language]) VALUES (25, 16, N'Single Inheritance', N'A class inherits from one base class.', N'class Animal { public void Eat() { } }
--class Dog : Animal { }', N'C#')
--GO
--INSERT [dbo].[C#Topics] ([Id], [ParentID], [TopicName], [TopicContent], [Code], [Language]) VALUES (26, 16, N'Multilevel Inheritance', N'A class inherits from a class that already inherits from another class.', N'class Animal { }
--class Dog : Animal { }
--class Puppy : Dog { }', N'C#')
--GO
--INSERT [dbo].[C#Topics] ([Id], [ParentID], [TopicName], [TopicContent], [Code], [Language]) VALUES (27, 16, N'Hierarchical Inheritance', N'Multiple derived classes inherit from the same base class.', N'class Animal { }
--class Dog : Animal { }
--class Cat : Animal { }', N'C#')
--GO
--INSERT [dbo].[C#Topics] ([Id], [ParentID], [TopicName], [TopicContent], [Code], [Language]) VALUES (28, 16, N'Multiple Inheritance', N'C# does not support inheriting from multiple classes, but a class can implement multiple interfaces.', N'interface IA { }
--interface IB { }
--class Demo : IA, IB { }', N'C#')
--GO
--INSERT [dbo].[C#Topics] ([Id], [ParentID], [TopicName], [TopicContent], [Code], [Language]) VALUES (29, 25, N'Single Inheritance Example', N'Example of a Dog class inheriting from Animal.', N'class Animal
--{
--    public void Eat()
--    {
--        Console.WriteLine("Animal is eating");
--    }
--}

--class Dog : Animal
--{
--    public void Bark()
--    {
--        Console.WriteLine("Dog is barking");
--    }
--}', N'C#')
--GO
--INSERT [dbo].[C#Topics] ([Id], [ParentID], [TopicName], [TopicContent], [Code], [Language]) VALUES (30, 25, N'Single Inheritance Output', N'The derived class can call the inherited public method.', N'Dog d = new Dog();
--d.Eat();
--d.Bark();', N'C#')
--GO
