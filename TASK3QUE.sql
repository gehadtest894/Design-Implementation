
CREATE DATABASE AirportT;

USE AirportT;
GO


CREATE TABLE Manager (
    Manager_ID INT PRIMARY KEY,
    SSN INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Phone INT,
    Address VARCHAR(70)
);



CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50) NOT NULL,
    Manager_ID INT,
    CONSTRAINT FK_Dept_Manager FOREIGN KEY (Manager_ID) REFERENCES Manager(Manager_ID)
);



CREATE TABLE Pilot (
    Pilot_ID INT PRIMARY KEY,
    SSN INT NOT NULL,
    License_Num INT,
    Name VARCHAR(50) NOT NULL,
    Phone INT,
    Address VARCHAR(70),
    Dept_ID INT,
    CONSTRAINT FK_Pilot_Dept FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);



CREATE TABLE Plane (
    Regestiration_Num INT PRIMARY KEY,
    Model_Num INT NOT NULL,
    Capacity INT,
    Weight INT,
    Dept_ID INT,
    CONSTRAINT FK_Plane_Dept FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);



CREATE TABLE Passengers (
    Passenger_ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Phone INT,
    Address VARCHAR(70)
);



CREATE TABLE Flight (
    Flight_Num INT PRIMARY KEY,
    Destination VARCHAR(50) NOT NULL,
    Date_Of_Flying DATE,
    Departure_Time TIME,
    Arrival_Time TIME,
    Houres_Flying INT,
    Pilot_ID INT,
    Dept_ID INT,
    Regestiration_Num INT,
    CONSTRAINT FK_Flight_Pilot FOREIGN KEY (Pilot_ID) REFERENCES Pilot(Pilot_ID),
    CONSTRAINT FK_Flight_Dept FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID),
    CONSTRAINT FK_Flight_Plane FOREIGN KEY (Regestiration_Num) REFERENCES Plane(Regestiration_Num)
);


CREATE TABLE Reservation (
    Reservation_ID INT PRIMARY KEY,
    Seats_Reserve INT,
    Passenger_ID INT,
    Flight_Num INT,
    CONSTRAINT FK_Reservation_Passenger FOREIGN KEY (Passenger_ID) REFERENCES Passengers(Passenger_ID),
    CONSTRAINT FK_Reservation_Flight FOREIGN KEY (Flight_Num) REFERENCES Flight(Flight_Num)
);

USE AirportDB;
GO


INSERT INTO Manager (Manager_ID, SSN, Name, Phone, Address) VALUES 
(1, 100123456, 'Ahmed Ali', 1012345678, 'Cairo, Egypt'),
(2, 100987654, 'Mona Samir', 1198765432, 'Alexandria, Egypt'),
(3, 100456789, 'Hassan Mahmoud', 1234509876, 'Giza, Egypt'),
(4, 100654321, 'Rania Kaled', 1555667788, 'Mansoura, Egypt');
SELECT *
FROM Manager

INSERT INTO Department (Dept_ID, Dept_Name, Manager_ID) VALUES 
(10, 'Operations', 1),
(20, 'Logistics', 2),
(30, 'Maintenance', 3),
(40, 'Customer Service', 4);
SELECT *
FROM Department


INSERT INTO Pilot (Pilot_ID, SSN, License_Num, Name, Phone, Address, Dept_ID) VALUES 
(101, 200111222, 55441, 'Tarek Omar', 1234567890, 'Giza, Egypt', 10),
(102, 200333444, 55442, 'Sarah Khaled', 1245678901, 'Cairo, Egypt', 10),
(103, 200555666, 55443, 'Karim Nabil', 1098765432, 'Alexandria, Egypt', 10),
(104, 200777888, 55444, 'Yasmine Adel', 1122334455, 'Cairo, Egypt', 10);
SELECT *
FROM Pilot


INSERT INTO Plane (Regestiration_Num, Model_Num, Capacity, Weight, Dept_ID) VALUES 
(701, 737, 180, 41000, 10),
(702, 320, 150, 42000, 10),
(703, 777, 300, 75000, 10),
(704, 350, 280, 70000, 10);
SELECT *
FROM Plane


INSERT INTO Passengers (Passenger_ID, Name, Phone, Address) VALUES 
(1001, 'Mohamed Hassan', 1511223344, 'Nasr City, Cairo'),
(1002, 'Nour El-Din', 1599887766, 'Maadi, Cairo'),
(1003, 'Mariam Mostafa', 1022446688, 'Zamalek, Cairo'),
(1004, 'Omar Fathy', 1133557799, 'Sidi Gaber, Alexandria');
SELECT *
FROM Passengers


INSERT INTO Flight (Flight_Num, Destination, Date_Of_Flying, Departure_Time, Arrival_Time, Houres_Flying, Pilot_ID, Dept_ID, Regestiration_Num) VALUES 
(501, 'Dubai', '2026-10-15', '08:00:00', '12:30:00', 4, 101, 10, 701),
(502, 'London', '2026-10-16', '14:00:00', '19:00:00', 5, 102, 10, 702),
(503, 'Paris', '2026-10-17', '06:00:00', '11:00:00', 5, 103, 10, 703),
(504, 'Riyadh', '2026-10-18', '21:00:00', '23:30:00', 2, 104, 10, 704);
SELECT *
FROM Flight


INSERT INTO Reservation (Reservation_ID, Seats_Reserve, Passenger_ID, Flight_Num) VALUES 
(9001, 12, 1001, 501),
(9002, 14, 1002, 502),
(9003, 22, 1003, 503),
(9004, 5, 1004, 504);
SELECT *
FROM Reservation


-------------REQUIREMENTS-----------
--1- display the name of each pilot and the name of his manager. 
SELECT P.Name,M.Name
FROM Pilot AS P
INNER JOIN Department AS D
ON P.Dept_ID=D.Dept_ID
INNER JOIN Manager AS M 
ON D.Manager_ID=M.Manager_ID;

--display the model number of each plane that will be used in a flight to
--USA last week.
SELECT P.Model_Num
FROM Plane AS P
INNER JOIN Flight AS F
ON P.Regestiration_Num=F.Regestiration_Num
WHERE Destination='USA ';

--3- display the maximum capacity of the flight number 1200
SELECT P.Capacity AS MAXC
FROM Flight AS F
INNER JOIN Plane AS P
ON  F.Regestiration_Num=P.Regestiration_Num
WHERE F.Flight_Num=1200;

--4- Performa report that display the flight number of first flight to Paris 

SELECT TOP 1 Flight_Num,Date_Of_Flying,Departure_Time
FROM Flight 
WHERE Destination='Paris'
ORDER BY Date_Of_Flying ,Departure_Time

--5- Perform
--a report that display a details of pilot information and flight
SELECT P.Address,P.Dept_ID,P.License_Num,P.Name,P.Phone,P.Pilot_ID,P.SSN ,F.Flight_Num,F.Date_Of_Flying,F.Departure_Time,
F.Arrival_Time,F.Destination,F.Houres_Flying
FROM Pilot AS P 
INNER JOIN Flight AS F
ON P.Pilot_ID=F.Pilot_ID

--6- display the flights information that will be arrived after 1
--Hours
SELECT *
FROM Flight
WHERE Date_Of_Flying = CAST(GETDATE() AS DATE)
  AND Arrival_Time >= CAST(DATEADD(HOUR, 1, GETDATE()) AS TIME);
 -- 7- display the number of pilots in each department
SELECT D.Dept_ID,D.Dept_Name,COUNT(P.[Pilot_ID])AS TOTAL 
FROM Department AS D
LEFT JOIN  Pilot AS P
ON D.Dept_ID=P.Dept_ID
GROUP BY D.Dept_ID,D.Dept_Name;

--8- display the number of the planes in each department that arrived in last 3days
SELECT D.Dept_ID,D.Dept_Name,COUNT(P.Regestiration_Num) AS COUNTREG
FROM Department AS D 
INNER JOIN Plane AS P
ON D.Dept_ID =P.Dept_ID
INNER JOIN Flight AS F
ON P.Regestiration_Num=F.Regestiration_Num
WHERE DATEDIFF(DAY, f.Date_Of_Flying, GETDATE()) BETWEEN 0 AND 3
GROUP BY D.Dept_ID,D.Dept_Name;
--9- Display the number of passengers in each flight and information abouttheir pilot.
SELECT 
    f.Flight_Num,
    COUNT(r.Passenger_ID) AS Passenger_Count,
    p.Pilot_ID,
    p.Name AS Pilot_Name,
    p.License_Num
FROM Flight f
LEFT JOIN Reservation r ON f.Flight_Num = r.Flight_Num
LEFT JOIN Pilot p ON f.Pilot_ID = p.Pilot_ID
GROUP BY f.Flight_Num, p.Pilot_ID, p.Name, p.License_Num;

--10- display the manager ‘s name of the department that contains maximumplanes of number
CREATE PROCEDURE  PRO 
AS
BEGIN
    SELECT TOP 1
        m.Name AS Manager_Name,
        d.Dept_Name,
        COUNT(pl.Regestiration_Num) AS Total_Planes
    FROM Manager m
    JOIN Department d ON m.Manager_ID = d.Manager_ID
    JOIN Plane pl ON d.Dept_ID = pl.Dept_ID
    GROUP BY m.Name, d.Dept_Name
    ORDER BY COUNT(pl.Regestiration_Num) DESC;
END;

