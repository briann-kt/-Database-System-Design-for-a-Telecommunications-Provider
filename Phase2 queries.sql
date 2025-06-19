DROP TABLE IF EXISTS SupportTicket, Billing, UsageRecord, Subscription, ServicePlan, NetworkElement, Customer;
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Gender VARCHAR(10),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20),
    Address VARCHAR(255)
);
CREATE TABLE ServicePlan (
    PlanID INT PRIMARY KEY AUTO_INCREMENT,
    PlanName VARCHAR(100),
    PlanType VARCHAR(20),
    Price DECIMAL(10,2),
    DataLimit INT,
    SMSLimit INT,
    CallMinutes INT
);
CREATE TABLE Subscription (
    SubscriptionID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    PlanID INT,
    StartDate DATE,
    EndDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (PlanID) REFERENCES ServicePlan(PlanID)
);
CREATE TABLE UsageRecord (
    UsageID INT PRIMARY KEY AUTO_INCREMENT,
    SubscriptionID INT,
    CallMinutesUsed INT,
    SMSUsed INT,
    DataUsed INT,
    UsageDate DATE,
    FOREIGN KEY (SubscriptionID) REFERENCES Subscription(SubscriptionID)
);
CREATE TABLE Billing (
    BillID INT PRIMARY KEY AUTO_INCREMENT,
    SubscriptionID INT,
    BillingPeriodStart DATE,
    BillingPeriodEnd DATE,
    TotalAmount DECIMAL(10,2),
    AmountPaid DECIMAL(10,2),
    PaymentDate DATE,
    FOREIGN KEY (SubscriptionID) REFERENCES Subscription(SubscriptionID)
);
CREATE TABLE NetworkElement (
    ElementID INT PRIMARY KEY AUTO_INCREMENT,
    Type VARCHAR(50),
    Location VARCHAR(100),
    Status VARCHAR(20)
);
CREATE TABLE SupportTicket (
    TicketID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    IssueType VARCHAR(100),
    Description TEXT,
    CreatedAt DATETIME,
    ResolvedAt DATETIME,
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
INSERT INTO Customer (Name, Gender, Email, PhoneNumber, Address) VALUES
('Alice Mwangi', 'Female', 'alice@example.com', '0712345678', 'Nairobi'),
('John Otieno', 'Male', 'john@example.com', '0722333444', 'Kisumu');
INSERT INTO ServicePlan (PlanName, PlanType, Price, DataLimit, SMSLimit, CallMinutes) VALUES
('Prepaid Lite', 'Prepaid', 10.00, 500, 50, 100),
('Postpaid Pro', 'Postpaid', 40.00, 5000, 500, 2000);
INSERT INTO Subscription (CustomerID, PlanID, StartDate, EndDate, Status) VALUES
(1, 1, '2024-01-01', NULL, 'Active'),
(2, 2, '2024-01-01', NULL, 'Active');
INSERT INTO UsageRecord (SubscriptionID, CallMinutesUsed, SMSUsed, DataUsed, UsageDate) VALUES
(1, 20, 10, 300, '2024-01-10'),
(2, 180, 200, 4500, '2024-01-15');
INSERT INTO Billing (SubscriptionID, BillingPeriodStart, BillingPeriodEnd, TotalAmount, AmountPaid, PaymentDate) VALUES
(1, '2024-01-01', '2024-01-31', 10.00, 10.00, '2024-02-01'),
(2, '2024-01-01', '2024-01-31', 40.00, 40.00, '2024-02-01');
INSERT INTO NetworkElement (Type, Location, Status) VALUES
('Cell Tower', 'Nairobi CBD', 'Active'),
('Router', 'Eldoret Hub', 'Maintenance');
INSERT INTO SupportTicket (CustomerID, IssueType, Description, CreatedAt, ResolvedAt, Status) VALUES
(1, 'Network Issue', 'No signal for 2 hours.', '2024-02-10 09:00:00', '2024-02-10 11:30:00', 'Resolved'),
(2, 'Billing Inquiry', 'Disputed postpaid charges.', '2024-02-12 14:00:00', NULL, 'Open');
SELECT * FROM Customer;