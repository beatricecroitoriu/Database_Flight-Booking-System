USE [master]
GO
/****** Object:  Database [proiect]    Script Date: 5/31/2023 3:03:30 PM ******/
CREATE DATABASE [proiect]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'proiect', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\proiect.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'proiect_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\proiect_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [proiect] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [proiect].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [proiect] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [proiect] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [proiect] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [proiect] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [proiect] SET ARITHABORT OFF 
GO
ALTER DATABASE [proiect] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [proiect] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [proiect] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [proiect] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [proiect] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [proiect] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [proiect] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [proiect] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [proiect] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [proiect] SET  ENABLE_BROKER 
GO
ALTER DATABASE [proiect] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [proiect] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [proiect] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [proiect] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [proiect] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [proiect] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [proiect] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [proiect] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [proiect] SET  MULTI_USER 
GO
ALTER DATABASE [proiect] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [proiect] SET DB_CHAINING OFF 
GO
ALTER DATABASE [proiect] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [proiect] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [proiect] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [proiect] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [proiect] SET QUERY_STORE = ON
GO
ALTER DATABASE [proiect] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [proiect]
GO
/****** Object:  Table [dbo].[Flight]    Script Date: 5/31/2023 3:03:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Flight](
	[id_f] [int] NOT NULL,
	[flight_number] [varchar](10) NOT NULL,
	[company] [varchar](50) NOT NULL,
	[departure_airport_id] [int] NULL,
	[arrival_airport_id] [int] NULL,
	[departure_time] [datetime] NULL,
	[arrival_time] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_f] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Passenger]    Script Date: 5/31/2023 3:03:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Passenger](
	[id_p] [int] NOT NULL,
	[first_name] [varchar](50) NOT NULL,
	[last_name] [varchar](50) NOT NULL,
	[CNP] [bigint] NULL,
	[phone] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_p] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 5/31/2023 3:03:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[id_b] [int] NOT NULL,
	[passenger_id] [int] NULL,
	[flight_id] [int] NULL,
	[class] [varchar](20) NULL,
	[seat_number] [varchar](10) NOT NULL,
	[booking_date] [date] NOT NULL,
	[payment] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_b] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PassengerView]    Script Date: 5/31/2023 3:03:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PassengerView] AS
SELECT P.id_p, P.first_name AS "First Name", P.last_name AS "Last Name", 
	   F.flight_number, B.class AS "Class", B.seat_number AS "Seat Number"
FROM Flight AS F
INNER JOIN Booking AS B ON F.id_f = B.flight_id
INNER JOIN Passenger AS P ON B.passenger_id = P.id_p;
GO
/****** Object:  Table [dbo].[Airport]    Script Date: 5/31/2023 3:03:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Airport](
	[id_a] [int] NOT NULL,
	[name] [varchar](50) NOT NULL,
	[city] [varchar](50) NOT NULL,
	[country] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_a] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Flight_class]    Script Date: 5/31/2023 3:03:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Flight_class](
	[class] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[class] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Airport] ([id_a], [name], [city], [country]) VALUES (1, N'John F. Kennedy International Airport', N'New York', N'United States')
INSERT [dbo].[Airport] ([id_a], [name], [city], [country]) VALUES (2, N'Heathrow Airport', N'London', N'United Kingdom')
INSERT [dbo].[Airport] ([id_a], [name], [city], [country]) VALUES (3, N'Charles de Gaulle Airport', N'Paris', N'France')
INSERT [dbo].[Airport] ([id_a], [name], [city], [country]) VALUES (4, N'Los Angeles International Airport', N'Los Angeles', N'United States')
INSERT [dbo].[Airport] ([id_a], [name], [city], [country]) VALUES (5, N'Sydney Airport', N'Sydney', N'Australia')
INSERT [dbo].[Airport] ([id_a], [name], [city], [country]) VALUES (6, N'Tokyo Haneda Airport', N'Tokyo', N'Japan')
INSERT [dbo].[Airport] ([id_a], [name], [city], [country]) VALUES (7, N'Beijing Capital International Airport', N'Beijing', N'China')
INSERT [dbo].[Airport] ([id_a], [name], [city], [country]) VALUES (8, N'Dubai International Airport', N'Dubai', N'United Arab Emirates')
INSERT [dbo].[Airport] ([id_a], [name], [city], [country]) VALUES (9, N'Sao Paulo-Guarulhos International Airport', N'Sao Paulo', N'Brazil')
GO
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (1, 1, 1, N'Economy Class', N'A1', CAST(N'2023-05-20' AS Date), 40.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (2, 2, 2, N'Business Class', N'B3', CAST(N'2023-05-21' AS Date), 90.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (3, 3, 1, N'First Class', N'C2', CAST(N'2023-05-18' AS Date), 150.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (4, 4, 3, N'Business Class', N'D4', CAST(N'2023-05-23' AS Date), 100.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (5, 6, 1, N'Economy Class', N'F5', CAST(N'2023-05-15' AS Date), 29.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (6, 5, 4, N'Business Class', N'G7', CAST(N'2023-05-23' AS Date), 85.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (7, 1, 3, N'Economy Class', N'A1', CAST(N'2023-05-21' AS Date), 36.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (8, 5, 4, N'First Class', N'D3', CAST(N'2023-05-24' AS Date), 200.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (9, 2, 2, N'Business Class', N'C1', CAST(N'2023-05-17' AS Date), 76.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (10, 4, 3, N'Business Class', N'G2', CAST(N'2023-05-22' AS Date), 95.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (11, 6, 3, N'Economy Class', N'A1', CAST(N'2023-05-17' AS Date), 40.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (12, 5, 2, N'Business Class', N'C1', CAST(N'2023-05-20' AS Date), 80.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (13, 5, 2, N'Business Class', N'C1', CAST(N'2023-05-20' AS Date), 80.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (14, 5, 2, N'Business Class', N'C1', CAST(N'2023-05-20' AS Date), 60.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (15, 5, 2, N'Business Class', N'C1', CAST(N'2023-05-20' AS Date), 80.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (16, 6, 1, N'First Class', N'C3', CAST(N'2023-05-15' AS Date), 120.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (17, 6, 1, N'First Class', N'C3', CAST(N'2023-05-15' AS Date), 120.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (18, 6, 1, N'First Class', N'C3', CAST(N'2023-05-15' AS Date), 120.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (19, 6, 1, N'First Class', N'C3', CAST(N'2023-05-15' AS Date), 120.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (20, 6, 1, N'First Class', N'C3', CAST(N'2023-05-15' AS Date), 130.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (21, 3, 3, N'Economy Class', N'G1', CAST(N'2023-05-19' AS Date), 50.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (22, 3, 3, N'Economy Class', N'G1', CAST(N'2023-05-19' AS Date), 50.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (23, 3, 3, N'Economy Class', N'G1', CAST(N'2023-05-19' AS Date), 40.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (24, 3, 3, N'Economy Class', N'G1', CAST(N'2023-05-19' AS Date), 40.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (25, 3, 3, N'Economy Class', N'G1', CAST(N'2023-05-19' AS Date), 40.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (26, 3, 3, N'Economy Class', N'G1', CAST(N'2023-05-19' AS Date), 40.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (27, 3, 3, N'Economy Class', N'G1', CAST(N'2023-05-19' AS Date), 40.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (28, 3, 3, N'Economy Class', N'G1', CAST(N'2023-05-19' AS Date), 60.0000)
INSERT [dbo].[Booking] ([id_b], [passenger_id], [flight_id], [class], [seat_number], [booking_date], [payment]) VALUES (29, 5, 2, N'Business Class', N'H3', CAST(N'2023-05-12' AS Date), 90.0000)
GO
INSERT [dbo].[Flight] ([id_f], [flight_number], [company], [departure_airport_id], [arrival_airport_id], [departure_time], [arrival_time]) VALUES (1, N'ABC123', N'TAROM', 1, 2, CAST(N'2023-05-22T10:00:00.000' AS DateTime), CAST(N'2023-05-22T14:30:00.000' AS DateTime))
INSERT [dbo].[Flight] ([id_f], [flight_number], [company], [departure_airport_id], [arrival_airport_id], [departure_time], [arrival_time]) VALUES (2, N'DEF456', N'WizzAir', 2, 3, CAST(N'2023-05-23T12:30:00.000' AS DateTime), CAST(N'2023-05-23T16:45:00.000' AS DateTime))
INSERT [dbo].[Flight] ([id_f], [flight_number], [company], [departure_airport_id], [arrival_airport_id], [departure_time], [arrival_time]) VALUES (3, N'GHI789', N'Qatar Airways', 4, 5, CAST(N'2023-05-24T08:15:00.000' AS DateTime), CAST(N'2023-05-24T12:30:00.000' AS DateTime))
INSERT [dbo].[Flight] ([id_f], [flight_number], [company], [departure_airport_id], [arrival_airport_id], [departure_time], [arrival_time]) VALUES (4, N'JKL012', N'Blue Air', 5, 6, CAST(N'2023-05-25T16:45:00.000' AS DateTime), CAST(N'2023-05-25T19:30:00.000' AS DateTime))
GO
INSERT [dbo].[Flight_class] ([class]) VALUES (N'Business Class')
INSERT [dbo].[Flight_class] ([class]) VALUES (N'Economy Class')
INSERT [dbo].[Flight_class] ([class]) VALUES (N'First Class')
GO
INSERT [dbo].[Passenger] ([id_p], [first_name], [last_name], [CNP], [phone], [email]) VALUES (1, N'Ioan', N'Popescu', 1890425541278, N'+40754268776', N'popescu.ioan@yahoo.com')
INSERT [dbo].[Passenger] ([id_p], [first_name], [last_name], [CNP], [phone], [email]) VALUES (2, N'Elena', N'Stangu', 2920611671879, N'+40725639267', N'e.stangu@gmail.com')
INSERT [dbo].[Passenger] ([id_p], [first_name], [last_name], [CNP], [phone], [email]) VALUES (3, N'Beatrice', N'Croitoriu', 6020311279028, N'+40768364772', N'croitoriu.andreea@gmail.com')
INSERT [dbo].[Passenger] ([id_p], [first_name], [last_name], [CNP], [phone], [email]) VALUES (4, N'Emilia', N'Popa', 6011123509722, N'+40728364829', N'popa.emilia@student.utcluj.ro')
INSERT [dbo].[Passenger] ([id_p], [first_name], [last_name], [CNP], [phone], [email]) VALUES (5, N'David', N'Popovici', 5030516780054, N'+40724367290', N'david.p@yahoo.ro')
INSERT [dbo].[Passenger] ([id_p], [first_name], [last_name], [CNP], [phone], [email]) VALUES (6, N'Sophia', N'Craciun', 6020617460089, N'+40728763892', N'sophiacr@gmail.com')
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD FOREIGN KEY([class])
REFERENCES [dbo].[Flight_class] ([class])
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD FOREIGN KEY([flight_id])
REFERENCES [dbo].[Flight] ([id_f])
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD FOREIGN KEY([passenger_id])
REFERENCES [dbo].[Passenger] ([id_p])
GO
ALTER TABLE [dbo].[Flight]  WITH CHECK ADD FOREIGN KEY([arrival_airport_id])
REFERENCES [dbo].[Airport] ([id_a])
GO
ALTER TABLE [dbo].[Flight]  WITH CHECK ADD FOREIGN KEY([departure_airport_id])
REFERENCES [dbo].[Airport] ([id_a])
GO
/****** Object:  StoredProcedure [dbo].[ColocviuEx1]    Script Date: 5/31/2023 3:03:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ColocviuEx1]
@date DATE, @class VARCHAR(20)
AS
BEGIN
    SELECT P.first_name AS "First Name", P.last_name AS "Last Name"
    FROM Booking AS B INNER JOIN Passenger AS P ON B.passenger_id = P.id_p
    WHERE B.booking_date < @date AND B.class = @class
    GROUP BY P.first_name, P.last_name
    HAVING P.first_name like 'E%' and COUNT(B.id_b) > 1
END


GO
/****** Object:  StoredProcedure [dbo].[GetPassengersByFlightID]    Script Date: 5/31/2023 3:03:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPassengersByFlightID]
    @flightID INT
AS
BEGIN
    SELECT P.id_p, P.first_name, P.last_name, P.CNP, P.phone, P.email
    FROM Passenger AS P
    INNER JOIN Booking AS B ON P.id_p = B.passenger_id
    WHERE B.flight_id = @flightID;

END
GO
/****** Object:  Trigger [dbo].[CalculatePayment]    Script Date: 5/31/2023 3:03:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[CalculatePayment]
ON [dbo].[Booking]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE B
    SET B.payment = 120
    FROM Booking AS B
    INNER JOIN inserted AS I ON B.id_b = I.id_b
    WHERE B.class = 'First Class';

  
    UPDATE B
    SET B.payment = 80
    FROM Booking AS B
    INNER JOIN inserted AS I ON B.id_b = I.id_b
    WHERE B.class = 'Business Class';

  
    UPDATE B
    SET B.payment = 40
    FROM Booking AS B
    INNER JOIN inserted AS I ON B.id_b = I.id_b
    WHERE B.class = 'Economy Class';

 
    UPDATE B
    SET B.payment = B.payment + 20
    FROM Booking AS B
    INNER JOIN inserted AS I ON B.id_b = I.id_b
    WHERE B.seat_number IN ('A1', 'B1', 'C1', 'D1', 'E1', 'F1', 'G1', 'H1');

 
    UPDATE B
    SET B.payment = B.payment + 10
    FROM Booking AS B
    INNER JOIN inserted AS I ON B.id_b = I.id_b
    WHERE B.seat_number NOT IN ('A1', 'B1', 'C1', 'D1', 'E1', 'F1', 'G1', 'H1');
END

GO
ALTER TABLE [dbo].[Booking] ENABLE TRIGGER [CalculatePayment]
GO
/****** Object:  Trigger [dbo].[CheckBookingDate]    Script Date: 5/31/2023 3:03:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[CheckBookingDate]
ON [dbo].[Booking]
AFTER INSERT
AS
BEGIN
    DECLARE @bookingDate DATE;
    DECLARE @departureDate DATE;

    SELECT @bookingDate = booking_date
    FROM inserted;

    SELECT @departureDate = F.departure_time
    FROM Flight AS F
    INNER JOIN inserted AS I ON F.id_f = I.flight_id;

    IF DATEDIFF(DAY, @bookingDate, @departureDate) < 1
    BEGIN
        RAISERROR('Booking date must be at least one day before the departure date.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END
GO
ALTER TABLE [dbo].[Booking] ENABLE TRIGGER [CheckBookingDate]
GO
/****** Object:  Trigger [dbo].[ColocviuEx2]    Script Date: 5/31/2023 3:03:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[ColocviuEx2]
ON [dbo].[PassengerView]
INSTEAD OF DELETE
AS
BEGIN
   
    IF EXISTS (
        SELECT *
        FROM Passenger p
        INNER JOIN Booking b ON p.id_p = b.passenger_id
		INNER JOIN deleted d ON d.id_p = b.passenger_id
        WHERE b.class = 'First Class'
    )
    BEGIN
        RAISERROR('Passenger in first class cannot be deleted.', 16, 1);
        ROLLBACK TRANSACTION; 
        RETURN; 
    END

 
    DELETE FROM Booking
    WHERE EXISTS (
        SELECT *
        FROM deleted d
        WHERE Booking.id_b = d.id_p
    );

END
GO
USE [master]
GO
ALTER DATABASE [proiect] SET  READ_WRITE 
GO
