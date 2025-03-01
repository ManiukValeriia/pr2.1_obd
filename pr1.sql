CREATE DATABASE IF NOT EXISTS SwineFarm;
USE SwineFarm;

-- Таблиця для зберігання інформації про тварин
CREATE TABLE Animal (
    AnimalID INT AUTO_INCREMENT PRIMARY KEY,
    Nickname VARCHAR(50) UNIQUE NOT NULL,
    Gender ENUM('male', 'female') NOT NULL,
    Age INT NOT NULL,
    Purpose ENUM('slaughter', 'sale', 'breeding') NOT NULL,
    PigletsCount INT DEFAULT NULL,
    PigletsBirthDate DATE DEFAULT NULL,
    FatherNickname VARCHAR(50) DEFAULT 'unknown',
    MotherNickname VARCHAR(50) DEFAULT 'unknown'
);

-- Таблиця зберігання інформації про вакцинацію
CREATE TABLE Vaccination (
    VaccinationID INT AUTO_INCREMENT PRIMARY KEY,
    AnimalID INT NOT NULL,
    VaccineName VARCHAR(50) NOT NULL,
    VaccinationDate DATE NOT NULL,
    FOREIGN KEY (AnimalID) REFERENCES Animal(AnimalID) ON DELETE CASCADE
);

-- Таблиця для зберігання інформації про доглядачів за свинею
CREATE TABLE Caretaker (
    CaretakerID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) UNIQUE NOT NULL,
    AssignedAnimalID INT NOT NULL,
    FOREIGN KEY (AssignedAnimalID) REFERENCES Animal(AnimalID) ON DELETE CASCADE
);

-- Таблиця для зберігання інформації про корм
CREATE TABLE Feed (
    FeedID INT AUTO_INCREMENT PRIMARY KEY,
    FeedName VARCHAR(50) NOT NULL,
    AnimalID INT NOT NULL,
    Month VARCHAR(10) NOT NULL,
    Quantity DECIMAL(5, 2) NOT NULL, -- Кількість корма
    FOREIGN KEY (AnimalID) REFERENCES Animal(AnimalID) ON DELETE CASCADE
);

-- Таблиця для зберігання інформації про вимірювання ваги
CREATE TABLE WeightMeasurement (
    MeasurementID INT AUTO_INCREMENT PRIMARY KEY,
    AnimalID INT NOT NULL,
    Date DATE NOT NULL,
    Weight DECIMAL(5, 2) NOT NULL, -- Вага тварини
    FOREIGN KEY (AnimalID) REFERENCES Animal(AnimalID) ON DELETE CASCADE
);

-- Таблиця для зберігання інформації про сімейство тварин
CREATE TABLE Family (
    FamilyID INT AUTO_INCREMENT PRIMARY KEY,
    AnimalID INT NOT NULL,
    FatherID INT DEFAULT NULL,
    MotherID INT DEFAULT NULL,
    FOREIGN KEY (AnimalID) REFERENCES Animal(AnimalID) ON DELETE CASCADE,
    FOREIGN KEY (FatherID) REFERENCES Animal(AnimalID) ON DELETE SET NULL,
    FOREIGN KEY (MotherID) REFERENCES Animal(AnimalID) ON DELETE SET NULL
);

-- Додавання тварин
INSERT INTO Animal (Nickname, Gender, Age, Purpose, PigletsCount, PigletsBirthDate, FatherNickname, MotherNickname)
VALUES 
    ('Boris', 'male', 3, 'breeding', NULL, NULL, 'unknown', 'unknown'),
    ('Luna', 'female', 2, 'breeding', 5, '2025-01-01', 'Boris', 'unknown'),
    ('Max', 'male', 4, 'sale', NULL, NULL, 'unknown', 'unknown'),
    ('Bella', 'female', 3, 'breeding', 3, '2025-02-14', 'Max', 'unknown'),
    ('Olga', 'female', 5, 'slaughter', NULL, NULL, 'unknown', 'unknown');
    
    -- Додавання записів про вакцинацію
INSERT INTO Vaccination (AnimalID, VaccineName, VaccinationDate)
VALUES 
    (1, 'Rabies', '2024-05-10'),
    (1, 'Swine Flu', '2024-06-15'),
    (2, 'Rabies', '2025-01-05'),
    (3, 'Rabies', '2024-11-11'),
    (4, 'Swine Flu', '2025-02-16'),
    (5, 'Rabies', '2023-03-20');
    
    -- Додавання доглядачів
INSERT INTO Caretaker (FullName, AssignedAnimalID)
VALUES 
    ('John Doe', 1),
    ('Alice Johnson', 2),
    ('Michael Smith', 3),
    ('Emma Davis', 4),
    ('Olivia Brown', 5);
    
    -- Додавання записів про споживання корму
INSERT INTO Feed (FeedName, AnimalID, Month, Quantity)
VALUES 
    ('Corn', 1, 'January', 50.0),
    ('Corn', 2, 'February', 40.0),
    ('Soybean', 3, 'March', 30.0),
    ('Barley', 4, 'April', 35.0),
    ('Corn', 5, 'May', 45.0);
    
    -- Додавання записів зважування
INSERT INTO WeightMeasurement (AnimalID, Date, Weight)
VALUES 
    (1, '2024-12-31', 120.5),
    (2, '2024-12-31', 110.3),
    (3, '2024-12-31', 140.2),
    (4, '2024-12-31', 135.6),
    (5, '2024-12-31', 130.7);
    
    -- Додавання даних про родини тварин
INSERT INTO Family (AnimalID, FatherID, MotherID)
VALUES 
    (2, 1, NULL), -- Луна (донька Бориса)
    (4, 3, NULL); -- Белла (донька Макса)
    
DESCRIBE Animal;
DESCRIBE Vaccination;
DESCRIBE Caretaker;
DESCRIBE Feed;
DESCRIBE WeightMeasurement;
DESCRIBE Family;

SELECT * FROM Animal;
SELECT * FROM Vaccination;
SELECT * FROM Caretaker;
SELECT * FROM Feed;
SELECT * FROM WeightMeasurement;
SELECT * FROM Family;

-- Оновлення віку тварини
UPDATE Animal
SET Age = 4
WHERE AnimalID = 1;

-- Оновлення цілі тварини
UPDATE Animal
SET Purpose = 'sale'
WHERE AnimalID = 2;

-- Оновлення кількості поросят у тварини
UPDATE Animal
SET PigletsCount = 8
WHERE AnimalID = 3;

-- Оновлення ваги тварини
UPDATE WeightMeasurement
SET Weight = 150
WHERE AnimalID = 1;

-- Оновлення кількості корму, спожитого твариною за певний місяць
UPDATE Feed
SET Quantity = 30
WHERE AnimalID = 4;

-- Вибір всіх тварин, які мають більше ніж 3 поросят
SELECT * FROM Animal
WHERE PigletsCount > 3;

-- Підрахунок кількості тварин у таблиці
SELECT COUNT(*) AS TotalAnimals FROM Animal;

-- Вибір всіх тварин жіночої статі
 SELECT * FROM Animal
WHERE Gender = 'female';

-- Виведення всіх тварин, які були вакциновані після певної дати
SELECT * FROM Vaccination
WHERE VaccinationDate > '2024-11-09';

-- Підрахунок кількості тварин з поросятами
SELECT COUNT(*) AS AnimalsWithPiglets FROM Animal
WHERE PigletsCount > 0;

-- Видалення всіх записів з таблиць
DELETE FROM Animal;
DELETE FROM Vaccination;
DELETE FROM Caretaker;
DELETE FROM Feed;
DELETE FROM WeightMeasurement;
DELETE FROM Family;

-- Видалення таблиць разом з їхньою структурою
DROP TABLE Animal;
DROP TABLE Vaccination;
DROP TABLE Caretaker;
DROP TABLE Feed;
DROP TABLE WeightMeasurement;
DROP TABLE Family;