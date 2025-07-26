
-- Dim_Product
CREATE TABLE Dim_Product (
    ProductID NUMBER PRIMARY KEY,
    ProductName VARCHAR2(100),
    Category VARCHAR2(50),
    Color VARCHAR2(50),
    ProductSize VARCHAR2(50), 
    UnitOfMeasure VARCHAR2(20),
    ProductImage VARCHAR2(200),
    Rating NUMBER(3,1),
    Pricing NUMBER(10,2)
);

-- Dim_Customer
CREATE TABLE Dim_Customer (
    CustomerID NUMBER PRIMARY KEY,
    CustomerName VARCHAR2(100),
    Email VARCHAR2(100),
    Phoneno VARCHAR2(20),
    CustomerAddress VARCHAR2(200)
);

-- Dim_Sales
CREATE TABLE Dim_Sales (
    SalesID NUMBER PRIMARY KEY,
    units_sold NUMBER,
    title VARCHAR2(100),
    tags VARCHAR2(200),
    price NUMBER(10,2),
    balance NUMBER(10,2),
    salesindex NUMBER
);

-- Dim_Promotions
CREATE TABLE Dim_Promotions (
    PromoID NUMBER PRIMARY KEY,
    PromoName VARCHAR2(100),
    DiscountRate NUMBER(5,2),
    StartDate DATE,
    EndDate DATE
);

-- Dim_Return
CREATE TABLE Dim_Return (
    ReturnID NUMBER PRIMARY KEY,
    Reason VARCHAR2(200),
    ReturnDateKey NUMBER,
    EmployeeIDKey NUMBER
);

-- Dim_Date
CREATE TABLE Dim_Date (
    DateID NUMBER PRIMARY KEY,
    Month VARCHAR2(20),
    Quarter VARCHAR2(10),
    Year NUMBER
);

-- Dim_Supplier
CREATE TABLE Dim_Supplier (
    SupplierID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Region VARCHAR2(50)
);

-- Dim_StoredLocation
CREATE TABLE Dim_StoredLocation (
    StoreID NUMBER PRIMARY KEY,
    Location VARCHAR2(100),
    Region VARCHAR2(50)
);

-- Dim_PerformanceMatrix
CREATE TABLE Dim_PerformanceMatrix (
    PerformanceID NUMBER PRIMARY KEY,
    PerformanceRating NUMBER(3,1),
    ReviewDate DATE,
    ReviewCycle VARCHAR2(50),
    TargetCovered NUMBER,
    EmployeeID NUMBER
);

-- Dim_Attendance
CREATE TABLE Dim_Attendance (
    AttendanceID NUMBER PRIMARY KEY,
    Employee_ID NUMBER,  
    AttendanceDate DATE,  
    Scheduled_Start_Time VARCHAR2(10), 
    Actual_Start_Time VARCHAR2(10), 
    Late_Minutes NUMBER,  
    Attendance_Status VARCHAR2(50), 
    Absence_Reason VARCHAR2(200)  
);

-- Dim_EmployeeInfo
CREATE TABLE Dim_EmployeeInfo (
    EmployeeID NUMBER PRIMARY KEY,
    First_Name VARCHAR2(50),
    Last_Name VARCHAR2(50),
    Department VARCHAR2(50),
    Job_Title VARCHAR2(50),
    Hire_Date DATE,
    Salary_Grade VARCHAR2(20),
    Start_Date DATE,
    End_Date DATE,
    Is_Current CHAR(1)
);

-- Dim_FeedBack
CREATE TABLE Dim_FeedBack (
    FeedBackKey NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    ProductID NUMBER,
    Rating NUMBER(3,1),
    FeedbackComment VARCHAR2(500),
    FeedbackDate DATE,
    Sentiment VARCHAR2(50)
);

-- Dim_SupplierType
CREATE TABLE Dim_SupplierType (
    SupplierTypeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100)
);

-- Fact_OrderSummary
CREATE TABLE Fact_OrderSummary (
    ProductKey NUMBER,
    CustomerKey NUMBER,
    SalesKey NUMBER,
    DateKey NUMBER,
    PromotionsKey NUMBER,
    ReturnKey NUMBER,
    CONSTRAINT fk_os_product FOREIGN KEY (ProductKey) REFERENCES Dim_Product(ProductID),
    CONSTRAINT fk_os_customer FOREIGN KEY (CustomerKey) REFERENCES Dim_Customer(CustomerID),
    CONSTRAINT fk_os_sales FOREIGN KEY (SalesKey) REFERENCES Dim_Sales(SalesID),
    CONSTRAINT fk_os_date FOREIGN KEY (DateKey) REFERENCES Dim_Date(DateID),
    CONSTRAINT fk_os_promo FOREIGN KEY (PromotionsKey) REFERENCES Dim_Promotions(PromoID),
    CONSTRAINT fk_os_return FOREIGN KEY (ReturnKey) REFERENCES Dim_Return(ReturnID)
);

-- Fact_InventorySummary
CREATE TABLE Fact_InventorySummary (
    InventoryKey NUMBER,
    ProductKey NUMBER,
    StoreKey NUMBER,
    DateKey NUMBER,
    StockLevel NUMBER,
    RestockAmount NUMBER,
    CONSTRAINT fk_is_product FOREIGN KEY (ProductKey) REFERENCES Dim_Product(ProductID),
    CONSTRAINT fk_is_store FOREIGN KEY (StoreKey) REFERENCES Dim_StoredLocation(StoreID),
    CONSTRAINT fk_is_date FOREIGN KEY (DateKey) REFERENCES Dim_Date(DateID)
);

-- Fact_EmployeePerformance
CREATE TABLE Fact_EmployeePerformance (
    PerformanceMatrixKey NUMBER,
    AttendanceKey NUMBER,
    EmployeeInfoKey NUMBER,
    DateKey NUMBER,
    KPI_Score NUMBER,
    CONSTRAINT fk_ep_perf FOREIGN KEY (PerformanceMatrixKey) REFERENCES Dim_PerformanceMatrix(PerformanceID),
    CONSTRAINT fk_ep_attend FOREIGN KEY (AttendanceKey) REFERENCES Dim_Attendance(AttendanceID),
    CONSTRAINT fk_ep_emp FOREIGN KEY (EmployeeInfoKey) REFERENCES Dim_EmployeeInfo(EmployeeID),
    CONSTRAINT fk_ep_date FOREIGN KEY (DateKey) REFERENCES Dim_Date(DateID)
);

-- Fact_SupplierPerformance
CREATE TABLE Fact_SupplierPerformance (
    DateKey NUMBER,
    SupplierKey NUMBER,
    ProductKey NUMBER,
    OrderedQuantity NUMBER,
    ReceivedQuantity NUMBER,
    QualityDefectsUnits NUMBER,
    SupplierTypeKey NUMBER,
    CONSTRAINT fk_sp_date FOREIGN KEY (DateKey) REFERENCES Dim_Date(DateID),
    CONSTRAINT fk_sp_supplier FOREIGN KEY (SupplierKey) REFERENCES Dim_Supplier(SupplierID),
    CONSTRAINT fk_sp_product FOREIGN KEY (ProductKey) REFERENCES Dim_Product(ProductID),
    CONSTRAINT fk_sp_type FOREIGN KEY (SupplierTypeKey) REFERENCES Dim_SupplierType(SupplierTypeID)
);

-- Fact_CusFeedBack
CREATE TABLE Fact_CusFeedBack (
    FeedBackKey NUMBER,
    ProductKey NUMBER,
    DateKey NUMBER,
    AverageRate NUMBER(3,1),
    CONSTRAINT fk_cf_feedback FOREIGN KEY (FeedBackKey) REFERENCES Dim_FeedBack(FeedBackKey),
    CONSTRAINT fk_cf_product FOREIGN KEY (ProductKey) REFERENCES Dim_Product(ProductID),
    CONSTRAINT fk_cf_date FOREIGN KEY (DateKey) REFERENCES Dim_Date(DateID)
);
COMMIT;
SELECT *FROM DIM_RETURN;
--sample test data
-- =====================
-- Sample Inserts
-- =====================

INSERT INTO Dim_Product VALUES (1, 'Laptop X1', 'Electronics', 'Silver', '15 inch', 'Piece', 'laptopx1.png', 4.5, 1200.00);
INSERT INTO Dim_Product VALUES (2, 'Smartphone S9', 'Electronics', 'Black', '6 inch', 'Piece', 'smartphones9.png', 4.2, 699.99);

INSERT INTO Dim_Customer VALUES (1, 'John Doe', 'john.doe@example.com', '+1234567890', '123 Main Street');
INSERT INTO Dim_Customer VALUES (2, 'Jane Smith', 'jane.smith@example.com', '+0987654321', '456 Elm Street');

INSERT INTO Dim_Sales VALUES (1, 10, 'Laptop X1 Bulk', 'electronics,laptop', 12000.00, 0.00, 101);
INSERT INTO Dim_Sales VALUES (2, 1, 'Smartphone S9 Single', 'electronics,smartphone', 699.99, 0.00, 102);

INSERT INTO Dim_Promotions VALUES (1, 'Holiday Sale', 10.00, TO_DATE('2025-12-01','YYYY-MM-DD'), TO_DATE('2025-12-31','YYYY-MM-DD'));

INSERT INTO Dim_Return VALUES (1, 'Defective screen', 20250701, 1);

INSERT INTO Dim_Date VALUES (20250701, 'July', 'Q3', 2025);
INSERT INTO Dim_Date VALUES (20250702, 'July', 'Q3', 2025);

INSERT INTO Dim_Supplier VALUES (1, 'ABC Electronics', 'East');
INSERT INTO Dim_Supplier VALUES (2, 'XYZ Components', 'West');

INSERT INTO Dim_StoredLocation VALUES (1, 'Warehouse A', 'East');
INSERT INTO Dim_StoredLocation VALUES (2, 'Warehouse B', 'West');

INSERT INTO Dim_PerformanceMatrix VALUES (1, 4.3, TO_DATE('2025-06-30','YYYY-MM-DD'), 'H1 2025', 95, 1);

INSERT INTO Dim_Attendance VALUES (1, 1, TO_DATE('2025-07-01','YYYY-MM-DD'), '09:00', '09:05', 5, 'Present', NULL);

INSERT INTO Dim_EmployeeInfo VALUES (1, 'Alice', 'Brown', 'Sales', 'Sales Associate', TO_DATE('2020-01-15','YYYY-MM-DD'), 'B', TO_DATE('2020-01-15','YYYY-MM-DD'), NULL, 'Y');

INSERT INTO Dim_FeedBack VALUES (1, 1, 1, 4.0, 'Good product, but shipping was slow.', TO_DATE('2025-07-02','YYYY-MM-DD'), 'Positive');

INSERT INTO Dim_SupplierType VALUES (1, 'Primary Supplier');
INSERT INTO Dim_SupplierType VALUES (2, 'Backup Supplier');

-- =====================
-- Fact Tables
-- =====================

INSERT INTO Fact_OrderSummary VALUES (1, 1, 1, 20250701, 1, 1);

INSERT INTO Fact_InventorySummary VALUES (1, 1, 1, 20250701, 50, 20);

INSERT INTO Fact_EmployeePerformance VALUES (1, 1, 1, 20250701, 92);

INSERT INTO Fact_SupplierPerformance VALUES (20250701, 1, 1, 100, 98, 2, 1);

INSERT INTO Fact_CusFeedBack VALUES (1, 1, 20250702, 4.0);

-- =====================
-- End of Inserts
-- =====================
SELECT *FROM Fact_CusFeedBack;

-- Drop fact tables first to avoid foreign key constraint issues
DROP TABLE Fact_CusFeedBack;
DROP TABLE Fact_SupplierPerformance;
DROP TABLE Fact_EmployeePerformance;
DROP TABLE Fact_InventorySummary;
DROP TABLE Fact_OrderSummary;

-- Drop dimension tables
DROP TABLE Dim_FeedBack;
DROP TABLE Dim_EmployeeInfo;
DROP TABLE Dim_Attendance;
DROP TABLE Dim_PerformanceMatrix;
DROP TABLE Dim_StoredLocation;
DROP TABLE Dim_Supplier;
DROP TABLE Dim_SupplierType;
DROP TABLE Dim_Date;
DROP TABLE Dim_Return;
DROP TABLE Dim_Promotions;
DROP TABLE Dim_Sales;
DROP TABLE Dim_Customer;
DROP TABLE Dim_Product;

COMMIT;


-- Dim_Date
INSERT ALL
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250101, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250102, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250103, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250104, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250105, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250106, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250107, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250108, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250109, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250110, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250111, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250112, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250113, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250114, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250115, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250116, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250117, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250118, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250119, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250120, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250121, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250122, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250123, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250124, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250125, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250126, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250127, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250128, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250129, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250130, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250131, 'January', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250201, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250202, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250203, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250204, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250205, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250206, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250207, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250208, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250209, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250210, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250211, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250212, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250213, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250214, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250215, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250216, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250217, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250218, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250219, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250220, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250221, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250222, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250223, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250224, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250225, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250226, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250227, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250228, 'February', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250301, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250302, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250303, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250304, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250305, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250306, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250307, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250308, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250309, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250310, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250311, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250312, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250313, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250314, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250315, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250316, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250317, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250318, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250319, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250320, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250321, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250322, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250323, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250324, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250325, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250326, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250327, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250328, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250329, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250330, 'March', 'Q1', 2025)
    INTO Dim_Date (DateID, Month, Quarter, Year) VALUES (20250331, 'March', 'Q1', 2025)
SELECT 1 FROM DUAL;

-- Dim_Product
INSERT ALL
    INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (101, 'Classic T-Shirt', 'Tops', 'Black', 'M', 'Piece', 'tshirt_black_m.jpg', 4.5, 19.99)
    INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (102, 'Slim Fit Jeans', 'Bottoms', 'Blue', '32x32', 'Piece', 'jeans_slim_blue.jpg', 4.2, 49.99)
    INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (103, 'Summer Dress', 'Dresses', 'Floral', 'S', 'Piece', 'dress_floral_s.jpg', 4.8, 35.50)
    INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (104, 'Hooded Sweatshirt', 'Outerwear', 'Grey', 'L', 'Piece', 'hoodie_grey_l.jpg', 4.0, 59.00)
    INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (105, 'Running Shorts', 'Activewear', 'Navy', 'M', 'Piece', 'shorts_navy_m.jpg', 4.3, 24.99)
    INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (106, 'Polo Shirt', 'Tops', 'White', 'L', 'Piece', 'polo_white_l.jpg', 4.1, 29.99)
    INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (107, 'Denim Jacket', 'Outerwear', 'Light Blue', 'M', 'Piece', 'jacket_denim_m.jpg', 4.6, 75.00)
    INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (108, 'Maxi Skirt', 'Bottoms', 'Red', 'S', 'Piece', 'skirt_maxi_red.jpg', 4.4, 39.99)
    INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (109, 'Casual Blouse', 'Tops', 'Green', 'M', 'Piece', 'blouse_green_m.jpg', 3.9, 27.00)
    INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (110, 'Winter Coat', 'Outerwear', 'Black', 'XL', 'Piece', 'coat_winter_xl.jpg', 4.9, 120.00)
    INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (111, 'Sport Leggings', 'Activewear', 'Black', 'S', 'Piece', 'leggings_sport_s.jpg', 4.7, 32.50)
    INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (112, 'Button-Up Shirt', 'Tops', 'Blue Stripe', 'L', 'Piece', 'shirt_buttonup_l.jpg', 4.2, 45.00)
    INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (113, 'Cargo Pants', 'Bottoms', 'Khaki', '34x30', 'Piece', 'pants_cargo_khaki.jpg', 4.0, 55.00)
    INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (114, 'Cocktail Dress', 'Dresses', 'Navy', 'M', 'Piece', 'dress_cocktail_m.jpg', 4.8, 89.99)
    INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (115, 'Lightweight Jacket', 'Outerwear', 'Olive', 'L', 'Piece', 'jacket_light_l.jpg', 4.3, 65.00)
    INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (116, 'Yoga Pants', 'Activewear', 'Grey', 'M', 'Piece', 'yoga_pants_m.jpg', 4.5, 30.00)
    INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (117, 'Graphic Tee', 'Tops', 'White', 'M', 'Piece', 'graphic_tee_m.jpg', 4.1, 22.00)
    INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (118, 'Skinny Jeans', 'Bottoms', 'Black', '28x30', 'Piece', 'skinny_jeans_b.jpg', 4.6, 52.00)
    INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (119, 'Sweater Dress', 'Dresses', 'Burgundy', 'S', 'Piece', 'sweater_dress_s.jpg', 4.7, 48.00)
    INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (120, 'Rain Jacket', 'Outerwear', 'Yellow', 'L', 'Piece', 'rain_jacket_y.jpg', 4.0, 70.00)
SELECT 1 FROM DUAL;

-- Dim_Customer
INSERT ALL
    INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (1, 'Alice Smith', 'alice.smith@example.com', '555-123-4567', '123 Oak Ave, Cityville')
    INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (2, 'Bob Johnson', 'bob.j@example.com', '555-987-6543', '456 Pine St, Townsville')
    INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (3, 'Charlie Brown', 'charlie.b@example.com', '555-555-1212', '789 Maple Rd, Villageton')
    INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (4, 'Diana Prince', 'diana.p@example.com', '555-111-2222', '101 Elm Blvd, Metropolis')
    INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (5, 'Eve Adams', 'eve.a@example.com', '555-333-4444', '202 Birch Ln, Gotham')
    INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (6, 'Frank White', 'frank.w@example.com', '555-666-7777', '303 Cedar Dr, Star City')
    INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (7, 'Grace Lee', 'grace.l@example.com', '555-888-9999', '404 Willow Way, Central City')
    INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (8, 'Henry King', 'henry.k@example.com', '555-000-1111', '505 Poplar Ct, Opal City')
    INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (9, 'Ivy Green', 'ivy.g@example.com', '555-222-3333', '606 Spruce St, Coast City')
    INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (10, 'Jack Black', 'jack.b@example.com', '555-444-5555', '707 Redwood Ave, Keystone')
    INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (11, 'Karen Blue', 'karen.b@example.com', '555-666-8888', '808 Fir Rd, National City')
    INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (12, 'Liam Red', 'liam.r@example.com', '555-999-0000', '909 Palm Blvd, Jump City')
    INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (13, 'Mia Purple', 'mia.p@example.com', '555-123-7890', '111 Sycamore Ln, Sunnyvale')
    INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (14, 'Noah Yellow', 'noah.y@example.com', '555-456-1234', '222 Cypress Dr, Pleasantville')
    INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (15, 'Olivia Orange', 'olivia.o@example.com', '555-789-0123', '333 Magnolia Way, Fair City')
    INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (16, 'Peter Pink', 'peter.p@example.com', '555-012-3456', '444 Aspen Ct, Harmony')
    INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (17, 'Quinn Grey', 'quinn.g@example.com', '555-345-6789', '555 Juniper St, Serenity')
    INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (18, 'Rachel White', 'rachel.w@example.com', '555-678-9012', '666 Dogwood Ave, Tranquility')
    INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (19, 'Sam Brown', 'sam.b@example.com', '555-901-2345', '777 Elder Rd, Utopia')
    INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (20, 'Tina Green', 'tina.g@example.com', '555-234-5678', '888 Fir Blvd, Paradise')
SELECT 1 FROM DUAL;

-- Dim_Sales
INSERT ALL
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (1, 1, 'T-Shirt Sale', 'Apparel, Casual', 19.99, 0.00, 1)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (2, 2, 'Jeans Promo', 'Denim, Bottoms', 99.98, 0.00, 2)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (3, 1, 'Dress Offer', 'Summer, Fashion', 35.50, 0.00, 3)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (4, 1, 'Hoodie Discount', 'Warm, Outerwear', 59.00, 0.00, 4)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (5, 3, 'Shorts Bundle', 'Sport, Active', 74.97, 0.00, 5)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (6, 1, 'Polo Deal', 'Casual, Top', 29.99, 0.00, 6)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (7, 1, 'Jacket Special', 'Denim, Outerwear', 75.00, 0.00, 7)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (8, 2, 'Skirt Combo', 'Fashion, Bottom', 79.98, 0.00, 8)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (9, 1, 'Blouse Sale', 'Casual, Top', 27.00, 0.00, 9)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (10, 1, 'Coat Clearance', 'Winter, Outerwear', 120.00, 0.00, 10)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (11, 2, 'Leggings Offer', 'Sport, Active', 65.00, 0.00, 11)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (12, 1, 'Shirt Promo', 'Formal, Top', 45.00, 0.00, 12)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (13, 1, 'Pants Discount', 'Cargo, Bottom', 55.00, 0.00, 13)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (14, 1, 'Dress Special', 'Party, Fashion', 89.99, 0.00, 14)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (15, 1, 'Jacket Deal', 'Light, Outerwear', 65.00, 0.00, 15)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (16, 2, 'Yoga Pants Combo', 'Active, Bottom', 60.00, 0.00, 16)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (17, 1, 'Graphic Tee Offer', 'Casual, Top', 22.00, 0.00, 17)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (18, 1, 'Skinny Jeans Sale', 'Denim, Bottom', 52.00, 0.00, 18)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (19, 1, 'Sweater Dress Promo', 'Winter, Fashion', 48.00, 0.00, 19)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (20, 1, 'Rain Jacket Discount', 'Outdoor, Outerwear', 70.00, 0.00, 20)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (21, 1, 'Summer Scarf', 'Accessory, Light', 15.00, 0.00, 21)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (22, 1, 'Winter Gloves', 'Accessory, Warm', 25.00, 0.00, 22)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (23, 1, 'Leather Belt', 'Accessory, Formal', 30.00, 0.00, 23)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (24, 1, 'Sports Socks', 'Activewear, Accessory', 10.00, 0.00, 24)
    INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance, salesindex) VALUES (25, 1, 'Baseball Cap', 'Accessory, Casual', 18.00, 0.00, 25)
SELECT 1 FROM DUAL;

-- Dim_Promotions
INSERT ALL
    INTO Dim_Promotions (PromoID, PromoName, DiscountRate, StartDate, EndDate) VALUES (1, 'New Year Sale', 15.00, TO_DATE('2025-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-15', 'YYYY-MM-DD'))
    INTO Dim_Promotions (PromoID, PromoName, DiscountRate, StartDate, EndDate) VALUES (2, 'Winter Clearance', 25.00, TO_DATE('2025-01-20', 'YYYY-MM-DD'), TO_DATE('2025-02-10', 'YYYY-MM-DD'))
    INTO Dim_Promotions (PromoID, PromoName, DiscountRate, StartDate, EndDate) VALUES (3, 'Valentine''s Day Special', 10.00, TO_DATE('2025-02-05', 'YYYY-MM-DD'), TO_DATE('2025-02-14', 'YYYY-MM-DD'))
    INTO Dim_Promotions (PromoID, PromoName, DiscountRate, StartDate, EndDate) VALUES (4, 'Spring Collection Launch', 5.00, TO_DATE('2025-03-01', 'YYYY-MM-DD'), TO_DATE('2025-03-31', 'YYYY-MM-DD'))
    INTO Dim_Promotions (PromoID, PromoName, DiscountRate, StartDate, EndDate) VALUES (5, 'Flash Sale Friday', 20.00, TO_DATE('2025-01-24', 'YYYY-MM-DD'), TO_DATE('2025-01-24', 'YYYY-MM-DD'))
    INTO Dim_Promotions (PromoID, PromoName, DiscountRate, StartDate, EndDate) VALUES (6, 'Mid-Month Madness', 12.00, TO_DATE('2025-02-15', 'YYYY-MM-DD'), TO_DATE('2025-02-20', 'YYYY-MM-DD'))
    INTO Dim_Promotions (PromoID, PromoName, DiscountRate, StartDate, EndDate) VALUES (7, 'Early Bird Discount', 8.00, TO_DATE('2025-03-05', 'YYYY-MM-DD'), TO_DATE('2025-03-10', 'YYYY-MM-DD'))
    INTO Dim_Promotions (PromoID, PromoName, DiscountRate, StartDate, EndDate) VALUES (8, 'Weekend Bonanza', 18.00, TO_DATE('2025-03-22', 'YYYY-MM-DD'), TO_DATE('2025-03-23', 'YYYY-MM-DD'))
SELECT 1 FROM DUAL;

-- Dim_EmployeeInfo (Assuming some employees for returns and performance)
INSERT ALL
    INTO Dim_EmployeeInfo (EmployeeID, First_Name, Last_Name, Department, Job_Title, Hire_Date, Salary_Grade, Start_Date, End_Date, Is_Current) VALUES (1001, 'John', 'Doe', 'Sales', 'Sales Associate', TO_DATE('2023-05-10', 'YYYY-MM-DD'), 'Grade 3', TO_DATE('2023-05-10', 'YYYY-MM-DD'), NULL, 'Y')
    INTO Dim_EmployeeInfo (EmployeeID, First_Name, Last_Name, Department, Job_Title, Hire_Date, Salary_Grade, Start_Date, End_Date, Is_Current) VALUES (1002, 'Jane', 'Smith', 'Customer Service', 'Customer Rep', TO_DATE('2022-11-15', 'YYYY-MM-DD'), 'Grade 2', TO_DATE('2022-11-15', 'YYYY-MM-DD'), NULL, 'Y')
    INTO Dim_EmployeeInfo (EmployeeID, First_Name, Last_Name, Department, Job_Title, Hire_Date, Salary_Grade, Start_Date, End_Date, Is_Current) VALUES (1003, 'Peter', 'Jones', 'Inventory', 'Stock Clerk', TO_DATE('2024-01-20', 'YYYY-MM-DD'), 'Grade 1', TO_DATE('2024-01-20', 'YYYY-MM-DD'), NULL, 'Y')
    INTO Dim_EmployeeInfo (EmployeeID, First_Name, Last_Name, Department, Job_Title, Hire_Date, Salary_Grade, Start_Date, End_Date, Is_Current) VALUES (1004, 'Sarah', 'Davis', 'Management', 'Store Manager', TO_DATE('2021-08-01', 'YYYY-MM-DD'), 'Grade 5', TO_DATE('2021-08-01', 'YYYY-MM-DD'), NULL, 'Y')
    INTO Dim_EmployeeInfo (EmployeeID, First_Name, Last_Name, Department, Job_Title, Hire_Date, Salary_Grade, Start_Date, End_Date, Is_Current) VALUES (1005, 'Michael', 'Brown', 'Sales', 'Sales Associate', TO_DATE('2024-02-01', 'YYYY-MM-DD'), 'Grade 3', TO_DATE('2024-02-01', 'YYYY-MM-DD'), NULL, 'Y')
SELECT 1 FROM DUAL;

-- Dim_Return
INSERT ALL
    INTO Dim_Return (ReturnID, Reason, ReturnDateKey, EmployeeIDKey) VALUES (1, 'Wrong size', 20250105, 1002)
    INTO Dim_Return (ReturnID, Reason, ReturnDateKey, EmployeeIDKey) VALUES (2, 'Changed mind', 20250110, 1002)
    INTO Dim_Return (ReturnID, Reason, ReturnDateKey, EmployeeIDKey) VALUES (3, 'Defective item', 20250120, 1001)
    INTO Dim_Return (ReturnID, Reason, ReturnDateKey, EmployeeIDKey) VALUES (4, 'Color not as expected', 20250201, 1002)
    INTO Dim_Return (ReturnID, Reason, ReturnDateKey, EmployeeIDKey) VALUES (5, 'Too small', 20250215, 1001)
    INTO Dim_Return (ReturnID, Reason, ReturnDateKey, EmployeeIDKey) VALUES (6, 'Duplicate order', 20250301, 1002)
    INTO Dim_Return (ReturnID, Reason, ReturnDateKey, EmployeeIDKey) VALUES (7, 'Damaged in transit', 20250310, 1001)
    INTO Dim_Return (ReturnID, Reason, ReturnDateKey, EmployeeIDKey) VALUES (8, 'Unsatisfied with quality', 20250325, 1002)
SELECT 1 FROM DUAL;

-- Dim_Supplier
INSERT ALL
    INTO Dim_Supplier (SupplierID, Name, Region) VALUES (1, 'Textile Innovations Inc.', 'Asia')
    INTO Dim_Supplier (SupplierID, Name, Region) VALUES (2, 'Fabric World Ltd.', 'Europe')
    INTO Dim_Supplier (SupplierID, Name, Region) VALUES (3, 'Apparel Solutions Co.', 'North America')
    INTO Dim_Supplier (SupplierID, Name, Region) VALUES (4, 'Global Threads', 'Asia')
    INTO Dim_Supplier (SupplierID, Name, Region) VALUES (5, 'European Textiles', 'Europe')
SELECT 1 FROM DUAL;

-- Dim_StoredLocation
INSERT ALL
    INTO Dim_StoredLocation (StoreID, Location, Region) VALUES (1, 'Downtown Flagship', 'Central')
    INTO Dim_StoredLocation (StoreID, Location, Region) VALUES (2, 'Suburban Mall', 'East')
    INTO Dim_StoredLocation (StoreID, Location, Region) VALUES (3, 'Outlet Village', 'West')
    INTO Dim_StoredLocation (StoreID, Location, Region) VALUES (4, 'Online Warehouse A', 'Virtual')
SELECT 1 FROM DUAL;

-- Dim_PerformanceMatrix
INSERT ALL
    INTO Dim_PerformanceMatrix (PerformanceID, PerformanceRating, ReviewDate, ReviewCycle, TargetCovered, EmployeeID) VALUES (1, 4.2, TO_DATE('2025-01-15', 'YYYY-MM-DD'), 'Monthly', 95, 1001)
    INTO Dim_PerformanceMatrix (PerformanceID, PerformanceRating, ReviewDate, ReviewCycle, TargetCovered, EmployeeID) VALUES (2, 3.8, TO_DATE('2025-01-15', 'YYYY-MM-DD'), 'Monthly', 88, 1002)
    INTO Dim_PerformanceMatrix (PerformanceID, PerformanceRating, ReviewDate, ReviewCycle, TargetCovered, EmployeeID) VALUES (3, 4.5, TO_DATE('2025-01-15', 'YYYY-MM-DD'), 'Monthly', 102, 1003)
    INTO Dim_PerformanceMatrix (PerformanceID, PerformanceRating, ReviewDate, ReviewCycle, TargetCovered, EmployeeID) VALUES (4, 4.0, TO_DATE('2025-02-15', 'YYYY-MM-DD'), 'Monthly', 92, 1001)
    INTO Dim_PerformanceMatrix (PerformanceID, PerformanceRating, ReviewDate, ReviewCycle, TargetCovered, EmployeeID) VALUES (5, 4.1, TO_DATE('2025-02-15', 'YYYY-MM-DD'), 'Monthly', 90, 1002)
    INTO Dim_PerformanceMatrix (PerformanceID, PerformanceRating, ReviewDate, ReviewCycle, TargetCovered, EmployeeID) VALUES (6, 4.7, TO_DATE('2025-02-15', 'YYYY-MM-DD'), 'Monthly', 105, 1003)
    INTO Dim_PerformanceMatrix (PerformanceID, PerformanceRating, ReviewDate, ReviewCycle, TargetCovered, EmployeeID) VALUES (7, 4.3, TO_DATE('2025-03-15', 'YYYY-MM-DD'), 'Monthly', 98, 1001)
    INTO Dim_PerformanceMatrix (PerformanceID, PerformanceRating, ReviewDate, ReviewCycle, TargetCovered, EmployeeID) VALUES (8, 3.9, TO_DATE('2025-03-15', 'YYYY-MM-DD'), 'Monthly', 87, 1002)
    INTO Dim_PerformanceMatrix (PerformanceID, PerformanceRating, ReviewDate, ReviewCycle, TargetCovered, EmployeeID) VALUES (9, 4.6, TO_DATE('2025-03-15', 'YYYY-MM-DD'), 'Monthly', 100, 1003)
    INTO Dim_PerformanceMatrix (PerformanceID, PerformanceRating, ReviewDate, ReviewCycle, TargetCovered, EmployeeID) VALUES (10, 4.8, TO_DATE('2025-03-15', 'YYYY-MM-DD'), 'Quarterly', 110, 1004)
SELECT 1 FROM DUAL;

-- Dim_Attendance
INSERT ALL
    INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (1, 1001, TO_DATE('2025-01-02', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Present', NULL)
    INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (2, 1002, TO_DATE('2025-01-02', 'YYYY-MM-DD'), '09:00', '09:05', 5, 'Late', NULL)
    INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (3, 1003, TO_DATE('2025-01-02', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Present', NULL)
    INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (4, 1001, TO_DATE('2025-01-03', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Present', NULL)
    INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (5, 1002, TO_DATE('2025-01-03', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Present', NULL)
    INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (6, 1003, TO_DATE('2025-01-03', 'YYYY-MM-DD'), '09:00', '09:10', 10, 'Late', NULL)
    INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (7, 1001, TO_DATE('2025-01-04', 'YYYY-MM-DD'), '09:00', NULL, NULL, 'Absent', 'Sick Leave')
    INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (8, 1002, TO_DATE('2025-01-04', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Present', NULL)
    INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (9, 1003, TO_DATE('2025-01-04', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Present', NULL)
    INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (10, 1001, TO_DATE('2025-02-01', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Present', NULL)
    INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (11, 1002, TO_DATE('2025-02-01', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Present', NULL)
    INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (12, 1003, TO_DATE('2025-02-01', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Present', NULL)
    INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (13, 1001, TO_DATE('2025-03-05', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Present', NULL)
    INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (14, 1002, TO_DATE('2025-03-05', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Present', NULL)
    INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (15, 1003, TO_DATE('2025-03-05', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Present', NULL)
    INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (16, 1005, TO_DATE('2025-03-05', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Present', NULL)
    INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (17, 1005, TO_DATE('2025-03-06', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Present', NULL)
    INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (18, 1005, TO_DATE('2025-03-07', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Present', NULL)
SELECT 1 FROM DUAL;

-- Dim_FeedBack
INSERT ALL
    INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (1, 1, 101, 5.0, 'Great t-shirt, very comfortable!', TO_DATE('2025-01-05', 'YYYY-MM-DD'), 'Positive')
    INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (2, 2, 102, 4.0, 'Jeans fit well, good quality for the price.', TO_DATE('2025-01-07', 'YYYY-MM-DD'), 'Positive')
    INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (3, 3, 103, 3.0, 'Dress was okay, but the color was a bit off.', TO_DATE('2025-01-10', 'YYYY-MM-DD'), 'Neutral')
    INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (4, 4, 104, 5.0, 'Love this hoodie, super warm and soft.', TO_DATE('2025-01-12', 'YYYY-MM-DD'), 'Positive')
    INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (5, 5, 105, 2.0, 'Shorts ripped after first wash, poor quality.', TO_DATE('2025-01-15', 'YYYY-MM-DD'), 'Negative')
    INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (6, 1, 106, 4.5, 'Nice polo shirt for casual wear.', TO_DATE('2025-01-20', 'YYYY-MM-DD'), 'Positive')
    INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (7, 6, 107, 5.0, 'Perfect denim jacket, exactly what I wanted.', TO_DATE('2025-01-25', 'YYYY-MM-DD'), 'Positive')
    INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (8, 7, 108, 3.5, 'Maxi skirt is a bit long, but fabric is nice.', TO_DATE('2025-02-01', 'YYYY-MM-DD'), 'Neutral')
    INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (9, 8, 109, 4.0, 'Blouse is comfortable, good for office.', TO_DATE('2025-02-05', 'YYYY-MM-DD'), 'Positive')
    INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (10, 9, 110, 5.0, 'Best winter coat ever! Very warm.', TO_DATE('2025-02-10', 'YYYY-MM-DD'), 'Positive')
    INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (11, 10, 111, 4.5, 'Leggings are great for workouts.', TO_DATE('2025-02-15', 'YYYY-MM-DD'), 'Positive')
    INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (12, 11, 112, 4.0, 'Button-up shirt looks smart.', TO_DATE('2025-02-20', 'YYYY-MM-DD'), 'Positive')
    INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (13, 12, 113, 3.0, 'Pants are a bit baggy.', TO_DATE('2025-02-25', 'YYYY-MM-DD'), 'Negative')
    INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (14, 13, 114, 5.0, 'Stunning dress for special occasions.', TO_DATE('2025-03-01', 'YYYY-MM-DD'), 'Positive')
    INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (15, 14, 115, 4.0, 'Lightweight jacket is perfect for spring.', TO_DATE('2025-03-05', 'YYYY-MM-DD'), 'Positive')
    INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (16, 15, 116, 4.5, 'Yoga pants are very flexible.', TO_DATE('2025-03-10', 'YYYY-MM-DD'), 'Positive')
    INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (17, 16, 117, 3.0, 'Graphic tee design faded quickly.', TO_DATE('2025-03-15', 'YYYY-MM-DD'), 'Negative')
    INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (18, 17, 118, 4.0, 'Skinny jeans are comfortable.', TO_DATE('2025-03-20', 'YYYY-MM-DD'), 'Positive')
    INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (19, 18, 119, 5.0, 'Sweater dress is cozy and stylish.', TO_DATE('2025-03-25', 'YYYY-MM-DD'), 'Positive')
    INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (20, 19, 120, 4.0, 'Rain jacket works well, good for light rain.', TO_DATE('2025-03-30', 'YYYY-MM-DD'), 'Positive')
SELECT 1 FROM DUAL;

-- Dim_SupplierType
INSERT ALL
    INTO Dim_SupplierType (SupplierTypeID, Name) VALUES (1, 'Raw Material')
    INTO Dim_SupplierType (SupplierTypeID, Name) VALUES (2, 'Finished Goods')
    INTO Dim_SupplierType (SupplierTypeID, Name) VALUES (3, 'Accessories')
SELECT 1 FROM DUAL;

-- Fact_OrderSummary (200 records)
INSERT ALL
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (101, 1, 1, 20250101, 1, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (102, 2, 2, 20250101, 1, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (103, 3, 3, 20250102, 1, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (104, 4, 4, 20250102, 1, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (105, 5, 5, 20250103, 1, 5) -- Returned
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (106, 6, 6, 20250103, 1, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (107, 7, 7, 20250104, 1, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (108, 8, 8, 20250104, 1, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (109, 9, 9, 20250105, 1, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (110, 10, 10, 20250105, 1, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (111, 11, 11, 20250106, 1, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (112, 12, 12, 20250106, 1, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (113, 13, 13, 20250107, 1, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (114, 14, 14, 20250107, 1, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (115, 15, 15, 20250108, 1, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (116, 16, 16, 20250108, 1, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (117, 17, 17, 20250109, 1, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (118, 18, 18, 20250109, 1, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (119, 19, 19, 20250110, 1, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (120, 20, 20, 20250110, 1, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (101, 1, 1, 20250115, 1, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (102, 2, 2, 20250116, 2, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (103, 3, 3, 20250117, 2, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (104, 4, 4, 20250118, 2, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (105, 5, 5, 20250119, 2, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (106, 6, 6, 20250120, 2, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (107, 7, 7, 20250121, 2, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (108, 8, 8, 20250122, 2, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (109, 9, 9, 20250123, 2, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (110, 10, 10, 20250124, 5, NULL) -- Flash Sale
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (111, 11, 11, 20250125, 2, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (112, 12, 12, 20250126, 2, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (113, 13, 13, 20250127, 2, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (114, 14, 14, 20250128, 2, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (115, 15, 15, 20250129, 2, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (116, 16, 16, 20250130, 2, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (117, 17, 17, 20250131, 2, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (118, 18, 18, 20250201, 3, NULL) -- Valentine's
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (119, 19, 19, 20250202, 3, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (120, 20, 20, 20250203, 3, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (101, 1, 1, 20250204, 3, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (102, 2, 2, 20250205, 3, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (103, 3, 3, 20250206, 3, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (104, 4, 4, 20250207, 3, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (105, 5, 5, 20250208, 3, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (106, 6, 6, 20250209, 3, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (107, 7, 7, 20250210, 2, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (108, 8, 8, 20250211, 6, NULL) -- Mid-Month
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (109, 9, 9, 20250212, 6, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (110, 10, 10, 20250213, 6, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (111, 11, 11, 20250214, 3, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (112, 12, 12, 20250215, 6, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (113, 13, 13, 20250216, 6, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (114, 14, 14, 20250217, 6, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (115, 15, 15, 20250218, 6, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (116, 16, 16, 20250219, 6, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (117, 17, 17, 20250220, 6, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (118, 18, 18, 20250221, NULL, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (119, 19, 19, 20250222, NULL, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (120, 20, 20, 20250223, NULL, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (101, 1, 1, 20250224, NULL, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (102, 2, 2, 20250225, NULL, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (103, 3, 3, 20250226, NULL, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (104, 4, 4, 20250227, NULL, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (105, 5, 5, 20250228, NULL, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (106, 6, 6, 20250301, 4, NULL) -- Spring Launch
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (107, 7, 7, 20250302, 4, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (108, 8, 8, 20250303, 4, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (109, 9, 9, 20250304, 4, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (110, 10, 10, 20250305, 7, NULL) -- Early Bird
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (111, 11, 11, 20250306, 7, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (112, 12, 12, 20250307, 7, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (113, 13, 13, 20250308, 7, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (114, 14, 14, 20250309, 7, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (115, 15, 15, 20250310, 7, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (116, 16, 16, 20250311, 4, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (117, 17, 17, 20250312, 4, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (118, 18, 18, 20250313, 4, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (119, 19, 19, 20250314, 4, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (120, 20, 20, 20250315, 4, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (101, 1, 21, 20250316, 4, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (102, 2, 22, 20250317, 4, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (103, 3, 23, 20250318, 4, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (104, 4, 24, 20250319, 4, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (105, 5, 25, 20250320, 4, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (106, 6, 6, 20250321, 4, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (107, 7, 7, 20250322, 8, NULL) -- Weekend Bonanza
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (108, 8, 8, 20250323, 8, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (109, 9, 9, 20250324, 4, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (110, 10, 10, 20250325, 4, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (111, 11, 11, 20250326, 4, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (112, 12, 12, 20250327, 4, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (113, 13, 13, 20250328, 4, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (114, 14, 14, 20250329, 4, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (115, 15, 15, 20250330, 4, NULL)
    INTO Fact_OrderSummary (ProductKey, CustomerKey, SalesKey, DateKey, PromotionsKey, ReturnKey) VALUES (116, 16, 16, 20250331, 4, NULL)
SELECT 1 FROM DUAL;

-- Fact_InventorySummary (300 records)
INSERT ALL
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (1, 101, 1, 20250101, 100, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (2, 102, 1, 20250101, 50, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (3, 103, 2, 20250101, 75, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (4, 104, 3, 20250101, 30, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (5, 101, 1, 20250105, 95, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (6, 102, 1, 20250105, 48, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (7, 103, 2, 20250105, 70, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (8, 104, 3, 20250105, 28, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (9, 101, 1, 20250110, 90, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (10, 102, 1, 20250110, 45, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (11, 103, 2, 20250110, 65, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (12, 104, 3, 20250110, 25, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (13, 101, 1, 20250115, 85, 50)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (14, 102, 1, 20250115, 40, 20)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (15, 103, 2, 20250115, 60, 30)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (16, 104, 3, 20250115, 20, 15)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (17, 105, 1, 20250101, 80, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (18, 106, 2, 20250101, 60, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (19, 107, 3, 20250101, 40, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (20, 108, 1, 20250101, 70, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (21, 109, 2, 20250101, 55, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (22, 110, 3, 20250101, 25, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (23, 111, 1, 20250101, 90, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (24, 112, 2, 20250101, 65, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (25, 113, 3, 20250101, 45, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (26, 114, 1, 20250101, 35, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (27, 115, 2, 20250101, 50, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (28, 116, 3, 20250101, 70, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (29, 117, 1, 20250101, 85, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (30, 118, 2, 20250101, 40, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (31, 119, 3, 20250101, 30, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (32, 120, 1, 20250101, 20, 0)
    -- More data for Jan 2025
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (33, 101, 1, 20250120, 130, 50)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (34, 102, 1, 20250120, 60, 20)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (35, 103, 2, 20250120, 80, 30)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (36, 104, 3, 20250120, 35, 15)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (37, 105, 1, 20250120, 70, 20)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (38, 106, 2, 20250120, 50, 20)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (39, 107, 3, 20250120, 30, 10)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (40, 108, 1, 20250120, 60, 20)
    -- Data for Feb 2025
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (41, 101, 1, 20250201, 120, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (42, 102, 1, 20250201, 55, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (43, 103, 2, 20250201, 75, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (44, 104, 3, 20250201, 32, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (45, 105, 1, 20250205, 65, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (46, 106, 2, 20250205, 48, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (47, 107, 3, 20250205, 28, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (48, 108, 1, 20250205, 58, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (49, 101, 1, 20250215, 110, 40)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (50, 102, 1, 20250215, 50, 20)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (51, 103, 2, 20250215, 70, 30)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (52, 104, 3, 20250215, 30, 15)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (53, 105, 1, 20250220, 60, 20)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (54, 106, 2, 20250220, 45, 20)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (55, 107, 3, 20250220, 25, 10)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (56, 108, 1, 20250220, 55, 20)
    -- Data for March 2025
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (57, 101, 1, 20250301, 100, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (58, 102, 1, 20250301, 45, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (59, 103, 2, 20250301, 65, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (60, 104, 3, 20250301, 28, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (61, 105, 1, 20250305, 55, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (62, 106, 2, 20250305, 40, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (63, 107, 3, 20250305, 20, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (64, 108, 1, 20250305, 50, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (65, 101, 1, 20250315, 90, 30)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (66, 102, 1, 20250315, 40, 15)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (67, 103, 2, 20250315, 60, 25)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (68, 104, 3, 20250315, 25, 10)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (69, 105, 1, 20250320, 50, 15)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (70, 106, 2, 20250320, 35, 15)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (71, 107, 3, 20250320, 18, 8)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (72, 108, 1, 20250320, 45, 15)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (73, 101, 4, 20250101, 500, 0) -- Online warehouse
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (74, 102, 4, 20250101, 300, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (75, 103, 4, 20250101, 400, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (76, 104, 4, 20250101, 200, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (77, 101, 4, 20250115, 480, 100)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (78, 102, 4, 20250115, 290, 50)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (79, 103, 4, 20250115, 380, 70)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (80, 104, 4, 20250115, 190, 40)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (81, 101, 4, 20250201, 450, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (82, 102, 4, 20250201, 270, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (83, 103, 4, 20250201, 350, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (84, 104, 4, 20250201, 180, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (85, 101, 4, 20250215, 430, 80)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (86, 102, 4, 20250215, 250, 40)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (87, 103, 4, 20250215, 330, 60)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (88, 104, 4, 20250215, 170, 30)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (89, 101, 4, 20250301, 400, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (90, 102, 4, 20250301, 230, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (91, 103, 4, 20250301, 300, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (92, 104, 4, 20250301, 160, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (93, 101, 4, 20250315, 380, 70)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (94, 102, 4, 20250315, 210, 35)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (95, 103, 4, 20250315, 280, 50)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (96, 104, 4, 20250315, 150, 25)
    -- Add more inventory for other products and dates
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (97, 105, 2, 20250101, 90, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (98, 106, 3, 20250101, 70, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (99, 107, 1, 20250101, 50, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (100, 108, 2, 20250101, 80, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (101, 105, 2, 20250115, 85, 20)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (102, 106, 3, 20250115, 65, 15)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (103, 107, 1, 20250115, 45, 10)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (104, 108, 2, 20250115, 75, 20)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (105, 109, 3, 20250101, 60, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (106, 110, 1, 20250101, 30, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (107, 111, 2, 20250101, 100, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (108, 112, 3, 20250101, 80, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (109, 109, 3, 20250115, 55, 15)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (110, 110, 1, 20250115, 28, 10)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (111, 111, 2, 20250115, 95, 25)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (112, 112, 3, 20250115, 75, 20)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (113, 113, 1, 20250101, 55, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (114, 114, 2, 20250101, 40, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (115, 115, 3, 20250101, 60, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (116, 116, 1, 20250101, 85, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (117, 113, 1, 20250115, 50, 15)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (118, 114, 2, 20250115, 38, 10)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (119, 115, 3, 20250115, 55, 15)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (120, 116, 1, 20250115, 80, 20)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (121, 117, 2, 20250101, 95, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (122, 118, 3, 20250101, 50, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (123, 119, 1, 20250101, 40, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (124, 120, 2, 20250101, 25, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (125, 117, 2, 20250115, 90, 25)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (126, 118, 3, 20250115, 48, 15)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (127, 119, 1, 20250115, 38, 10)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (128, 120, 2, 20250115, 23, 8)
    -- More data for Feb and March for all products across all stores
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (129, 101, 2, 20250201, 80, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (130, 102, 2, 20250201, 40, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (131, 103, 3, 20250201, 60, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (132, 104, 1, 20250201, 25, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (133, 105, 3, 20250201, 70, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (134, 106, 1, 20250201, 50, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (135, 107, 2, 20250201, 30, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (136, 108, 3, 20250201, 65, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (137, 109, 1, 20250201, 55, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (138, 110, 2, 20250201, 28, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (139, 111, 3, 20250201, 90, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (140, 112, 1, 20250201, 75, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (141, 113, 2, 20250201, 50, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (142, 114, 3, 20250201, 35, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (143, 115, 1, 20250201, 55, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (144, 116, 2, 20250201, 80, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (145, 117, 3, 20250201, 90, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (146, 118, 1, 20250201, 45, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (147, 119, 2, 20250201, 35, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (148, 120, 3, 20250201, 20, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (149, 101, 2, 20250301, 70, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (150, 102, 2, 20250301, 35, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (151, 103, 3, 20250301, 55, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (152, 104, 1, 20250301, 22, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (153, 105, 3, 20250301, 60, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (154, 106, 1, 20250301, 45, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (155, 107, 2, 20250301, 25, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (156, 108, 3, 20250301, 55, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (157, 109, 1, 20250301, 50, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (158, 110, 2, 20250301, 25, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (159, 111, 3, 20250301, 80, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (160, 112, 1, 20250301, 65, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (161, 113, 2, 20250301, 45, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (162, 114, 3, 20250301, 30, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (163, 115, 1, 20250301, 50, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (164, 116, 2, 20250301, 70, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (165, 117, 3, 20250301, 80, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (166, 118, 1, 20250301, 40, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (167, 119, 2, 20250301, 30, 0)
    INTO Fact_InventorySummary (InventoryKey, ProductKey, StoreKey, DateKey, StockLevel, RestockAmount) VALUES (168, 120, 3, 20250301, 18, 0)
SELECT 1 FROM DUAL;

-- Fact_EmployeePerformance (100 records)
INSERT ALL
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (1, 1, 1001, 20250102, 85)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (2, 2, 1002, 20250102, 78)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (3, 3, 1003, 20250102, 90)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (1, 4, 1001, 20250103, 87)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (2, 5, 1002, 20250103, 80)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (3, 6, 1003, 20250103, 88)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (1, 7, 1001, 20250104, 70) -- Absent, lower score
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (2, 8, 1002, 20250104, 82)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (3, 9, 1003, 20250104, 92)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (4, 10, 1001, 20250201, 88)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (5, 11, 1002, 20250201, 81)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (6, 12, 1003, 20250201, 95)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (7, 13, 1001, 20250305, 90)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (8, 14, 1002, 20250305, 79)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (9, 15, 1003, 20250305, 93)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (10, 16, 1004, 20250305, 98) -- Manager
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (10, 17, 1004, 20250306, 97)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (10, 18, 1004, 20250307, 99)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (1, 1, 1001, 20250105, 86)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (2, 2, 1002, 20250105, 79)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (3, 3, 1003, 20250105, 91)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (4, 10, 1001, 20250205, 89)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (5, 11, 1002, 20250205, 82)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (6, 12, 1003, 20250205, 96)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (7, 13, 1001, 20250310, 91)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (8, 14, 1002, 20250310, 80)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (9, 15, 1003, 20250310, 94)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (10, 16, 1004, 20250310, 99)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (1, 1, 1001, 20250110, 87)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (2, 2, 1002, 20250110, 80)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (3, 3, 1003, 20250110, 92)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (4, 10, 1001, 20250210, 90)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (5, 11, 1002, 20250210, 83)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (6, 12, 1003, 20250210, 97)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (7, 13, 1001, 20250315, 92)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (8, 14, 1002, 20250315, 81)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (9, 15, 1003, 20250315, 95)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (10, 16, 1004, 20250315, 99)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (1, 1, 1001, 20250115, 88)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (2, 2, 1002, 20250115, 81)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (3, 3, 1003, 20250115, 93)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (4, 10, 1001, 20250215, 91)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (5, 11, 1002, 20250215, 84)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (6, 12, 1003, 20250215, 98)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (7, 13, 1001, 20250320, 93)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (8, 14, 1002, 20250320, 82)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (9, 15, 1003, 20250320, 96)
    INTO Fact_EmployeePerformance (PerformanceMatrixKey, AttendanceKey, EmployeeInfoKey, DateKey, KPI_Score) VALUES (10, 16, 1004, 20250320, 100)
SELECT 1 FROM DUAL;

-- Fact_SupplierPerformance (150 records)
INSERT ALL
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250105, 1, 101, 200, 200, 5, 1)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250105, 2, 102, 100, 98, 2, 1)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250105, 3, 103, 150, 150, 0, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250110, 1, 104, 80, 80, 0, 1)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250110, 2, 105, 120, 115, 5, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250110, 3, 106, 90, 90, 0, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250115, 4, 107, 70, 70, 0, 1)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250115, 5, 108, 110, 108, 2, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250115, 1, 109, 130, 130, 3, 1)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250120, 2, 110, 60, 58, 2, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250120, 3, 111, 180, 180, 0, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250125, 4, 112, 100, 100, 0, 1)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250125, 5, 113, 90, 88, 2, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250125, 1, 114, 70, 70, 0, 1)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250130, 2, 115, 140, 135, 5, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250130, 3, 116, 160, 160, 0, 2)
    -- Feb 2025 data
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250205, 1, 101, 180, 180, 3, 1)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250205, 2, 102, 90, 89, 1, 1)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250205, 3, 103, 140, 140, 0, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250210, 1, 104, 75, 75, 0, 1)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250210, 2, 105, 110, 105, 5, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250210, 3, 106, 85, 85, 0, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250215, 4, 107, 65, 65, 0, 1)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250215, 5, 108, 100, 98, 2, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250215, 1, 109, 120, 120, 2, 1)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250220, 2, 110, 55, 53, 2, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250220, 3, 111, 170, 170, 0, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250225, 4, 112, 95, 95, 0, 1)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250225, 5, 113, 85, 83, 2, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250225, 1, 114, 65, 65, 0, 1)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250228, 2, 115, 130, 125, 5, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250228, 3, 116, 150, 150, 0, 2)
    -- March 2025 data
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250305, 1, 101, 170, 170, 2, 1)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250305, 2, 102, 80, 79, 1, 1)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250305, 3, 103, 130, 130, 0, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250310, 1, 104, 70, 70, 0, 1)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250310, 2, 105, 100, 95, 5, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250310, 3, 106, 80, 80, 0, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250315, 4, 107, 60, 60, 0, 1)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250315, 5, 108, 90, 88, 2, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250315, 1, 109, 110, 110, 1, 1)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250320, 2, 110, 50, 48, 2, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250320, 3, 111, 160, 160, 0, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250325, 4, 112, 90, 90, 0, 1)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250325, 5, 113, 80, 78, 2, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250325, 1, 114, 60, 60, 0, 1)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250330, 2, 115, 120, 115, 5, 2)
    INTO Fact_SupplierPerformance (DateKey, SupplierKey, ProductKey, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits, SupplierTypeKey) VALUES (20250330, 3, 116, 140, 140, 0, 2)
SELECT 1 FROM DUAL;

-- Fact_CusFeedBack (100 records)
INSERT ALL
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (1, 101, 20250105, 5.0)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (2, 102, 20250107, 4.0)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (3, 103, 20250110, 3.0)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (4, 104, 20250112, 5.0)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (5, 105, 20250115, 2.0)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (6, 106, 20250120, 4.5)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (7, 107, 20250125, 5.0)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (8, 108, 20250201, 3.5)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (9, 109, 20250205, 4.0)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (10, 110, 20250210, 5.0)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (11, 111, 20250215, 4.5)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (12, 112, 20250220, 4.0)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (13, 113, 20250225, 3.0)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (14, 114, 20250301, 5.0)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (15, 115, 20250305, 4.0)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (16, 116, 20250310, 4.5)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (17, 117, 20250315, 3.0)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (18, 118, 20250320, 4.0)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (19, 119, 20250325, 5.0)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (20, 120, 20250330, 4.0)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (1, 101, 20250106, 4.8)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (2, 102, 20250108, 4.2)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (3, 103, 20250111, 3.2)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (4, 104, 20250113, 4.9)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (5, 105, 20250116, 2.5)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (6, 106, 20250121, 4.3)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (7, 107, 20250126, 4.7)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (8, 108, 20250202, 3.8)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (9, 109, 20250206, 4.1)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (10, 110, 20250211, 4.9)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (11, 111, 20250216, 4.6)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (12, 112, 20250221, 4.2)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (13, 113, 20250226, 3.3)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (14, 114, 20250302, 4.8)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (15, 115, 20250306, 4.1)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (16, 116, 20250311, 4.6)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (17, 117, 20250316, 3.1)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (18, 118, 20250321, 4.1)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (19, 119, 20250326, 4.9)
    INTO Fact_CusFeedBack (FeedBackKey, ProductKey, DateKey, AverageRate) VALUES (20, 120, 20250331, 4.1)
SELECT 1 FROM DUAL;

COMMIT;

-- Create user
CREATE USER dw_user IDENTIFIED BY sachidwuser;

-- Grant permissions
GRANT CONNECT, RESOURCE, CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE PROCEDURE TO dw_user;
ALTER USER dw_user QUOTA UNLIMITED ON USERS;
-- Dimension Tables (should be created first as they are referenced by Fact tables)

-- Dim_Product
CREATE TABLE Dim_Product (
    ProductID_sk NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ProductID NUMBER,
    ProductName VARCHAR2(100),
    Category VARCHAR2(50),
    Color VARCHAR2(50),
    ProductSize VARCHAR2(50),
    UnitOfMeasure VARCHAR2(20),
    ProductImage VARCHAR2(200),
    Rating NUMBER(3,1),
    Pricing NUMBER(10,2)
);

-- Dim_Customer
CREATE TABLE Dim_Customer (
    CustomerID_sk NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    CustomerID NUMBER,
    CustomerName VARCHAR2(100),
    Email VARCHAR2(100),
    Phoneno VARCHAR2(20),
    CustomerAddress VARCHAR2(200)
);

-- Dim_Sales
CREATE TABLE Dim_Sales (
    SalesID_sk NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    SalesID NUMBER,
    units_sold NUMBER,
    title VARCHAR2(100),
    tags VARCHAR2(200),
    price NUMBER(10,2),
    balance NUMBER(10,2)
);

-- Dim_Promotions
CREATE TABLE Dim_Promotions (
    PromoID_sk NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    PromoID NUMBER,
    PromoName VARCHAR2(100),
    DiscountRate NUMBER(5,2),
    StartDate DATE,
    EndDate DATE
);

-- Dim_Return
CREATE TABLE Dim_Return (
    ReturnID_sk NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ReturnID NUMBER,
    ReturnDate DATE,
    CustomerID NUMBER
);

-- Dim_Date
CREATE TABLE Dim_Date (
    DateID_sk NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    DateID NUMBER,
    Day NUMBER,
    Month NUMBER,
    Year NUMBER
);

-- Dim_Supplier
CREATE TABLE Dim_Supplier (
    SupplierID_sk NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    SupplierID NUMBER,
    Name VARCHAR2(100),
    Region VARCHAR2(50)
);

-- Dim_PerformanceMatrix
CREATE TABLE Dim_PerformanceMatrix (
    PerformanceID_sk NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    PerformanceID NUMBER,
    PerformanceRating NUMBER(3,1),
    ReviewDate DATE,
    ReviewCycle VARCHAR2(50),
    TargetCovered NUMBER,
    EmployeeID NUMBER
);

-- Dim_Attendance
CREATE TABLE Dim_Attendance (
    AttendanceID_sk NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    AttendanceID NUMBER,
    Employee_ID NUMBER,
    AttendanceDate Date,
    Scheduled_Start_Time VARCHAR2(10),
    Actual_Start_Time VARCHAR2(10),
    Late_Minutes NUMBER,
    Attendance_Status VARCHAR2(50),
    Absence_Reason VARCHAR2(200)
);

-- Dim_EmployeeInfo
CREATE TABLE Dim_EmployeeInfo (
    EmployeeID_sk NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    EmployeeID NUMBER,
    First_Name VARCHAR2(50),
    Last_Name VARCHAR2(50),
    Department VARCHAR2(50),
    Job_Title VARCHAR2(50),
    Hire_Date DATE,
    Salary_Grade VARCHAR2(20),
    Start_Date DATE,
    End_Date DATE,
    Is_Current CHAR(1)
);

-- Dim_FeedBack
CREATE TABLE Dim_FeedBack (
    FeedBackKey_sk NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    FeedBackKey NUMBER,
    CustomerID NUMBER,
    ProductID NUMBER,
    Rating NUMBER(3,1),
    FeedbackComment VARCHAR2(500),
    FeedbackDate DATE,
    Sentiment VARCHAR2(50)
);

-- Dim_SupplierType
CREATE TABLE Dim_SupplierType (
    SupplierTypeID_sk NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    SupplierTypeID NUMBER,
    Name VARCHAR2(100)
);


-- Fact Tables (should be created after all referenced Dimension tables)

-- Fact_OrderSummary
CREATE TABLE Fact_OrderSummary (
    OrderSummaryKey NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ProductID_sk  NUMBER,
    CustomerID_sk  NUMBER,
    SalesID_sk  NUMBER,
    DateID_sk NUMBER,
    PromoID_sk NUMBER,
    ReturnID_sk  NUMBER,
    CONSTRAINT fk_os_product FOREIGN KEY (ProductID_sk) REFERENCES Dim_Product(ProductID_sk),
    CONSTRAINT fk_os_customer FOREIGN KEY (CustomerID_sk) REFERENCES Dim_Customer(CustomerID_sk),
    CONSTRAINT fk_os_sales FOREIGN KEY (SalesID_sk) REFERENCES Dim_Sales(SalesID_sk),
    CONSTRAINT fk_os_date FOREIGN KEY (DateID_sk) REFERENCES Dim_Date(DateID_sk),
    CONSTRAINT fk_os_promo FOREIGN KEY (PromoID_sk) REFERENCES Dim_Promotions(PromoID_sk),
    CONSTRAINT fk_os_return FOREIGN KEY (ReturnID_sk) REFERENCES Dim_Return(ReturnID_sk)
);

-- Fact_InventorySummary
CREATE TABLE Fact_InventorySummary (
    InventoryKey NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ProductID_sk NUMBER,
    DateID_sk NUMBER,
    StockLevel NUMBER,
    RestockAmount NUMBER,
    CONSTRAINT fk_is_product FOREIGN KEY (ProductID_sk) REFERENCES Dim_Product(ProductID_sk),
    CONSTRAINT fk_is_date FOREIGN KEY (DateID_sk) REFERENCES Dim_Date(DateID_sk)
);

-- Fact_EmployeePerformance
CREATE TABLE Fact_EmployeePerformance (
    EmployeePerformanceKey NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    PerformanceID_sk NUMBER,
    AttendanceID_sk NUMBER,
    EmployeeID_sk NUMBER,
    DateID_sk NUMBER,
    KPI_Score NUMBER,
    CONSTRAINT fk_ep_perf FOREIGN KEY (PerformanceID_sk) REFERENCES Dim_PerformanceMatrix(PerformanceID_sk),
    CONSTRAINT fk_ep_attend FOREIGN KEY (AttendanceID_sk) REFERENCES Dim_Attendance(AttendanceID_sk),
    CONSTRAINT fk_ep_emp FOREIGN KEY (EmployeeID_sk) REFERENCES Dim_EmployeeInfo(EmployeeID_sk),
    CONSTRAINT fk_ep_date FOREIGN KEY (DateID_sk) REFERENCES Dim_Date(DateID_sk)
);

-- Fact_SupplierPerformance
CREATE TABLE Fact_SupplierPerformance (
    SupplierPerformanceKey NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    DateID_sk NUMBER,
    SupplierID_sk NUMBER,
    ProductID_sk NUMBER,
    SupplierTypeID_sk NUMBER,
    OrderedQuantity NUMBER,
    ReceivedQuantity NUMBER,
    QualityDefectsUnits NUMBER,
    CONSTRAINT fk_sp_date FOREIGN KEY (DateID_sk) REFERENCES Dim_Date(DateID_sk),
    CONSTRAINT fk_sp_supplier FOREIGN KEY (SupplierID_sk) REFERENCES Dim_Supplier(SupplierID_sk),
    CONSTRAINT fk_sp_product FOREIGN KEY (ProductID_sk) REFERENCES Dim_Product(ProductID_sk),
    CONSTRAINT fk_sp_type FOREIGN KEY (SupplierTypeID_sk) REFERENCES Dim_SupplierType(SupplierTypeID_sk)
);

-- Fact_CusFeedBack
CREATE TABLE Fact_CusFeedBack (
    CusFeedBackKey NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    FeedBackKey_sk NUMBER,
    ProductID_sk NUMBER,
    DateID_sk NUMBER,
    AverageRate NUMBER(3,1),
    CONSTRAINT fk_cf_feedback FOREIGN KEY (FeedBackKey_sk) REFERENCES Dim_FeedBack(FeedBackKey_sk),
    CONSTRAINT fk_cf_product FOREIGN KEY (ProductID_sk) REFERENCES Dim_Product(ProductID_sk),
    CONSTRAINT fk_cf_date FOREIGN KEY (DateID_sk) REFERENCES Dim_Date(DateID_sk)
);
COMMIT;

-- INSERT Statements for Dimension Tables

-- Dim_Product
INSERT INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (101, 'Laptop Pro X', 'Electronics', 'Silver', '15-inch', 'Unit', 'laptop_pro_x.jpg', 4.5, 1200.00);
INSERT INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (102, 'Wireless Mouse', 'Accessories', 'Black', 'Standard', 'Unit', 'mouse.jpg', 4.2, 25.00);
INSERT INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (103, 'Mechanical Keyboard', 'Accessories', 'RGB', 'Full-size', 'Unit', 'keyboard.jpg', 4.8, 80.00);
INSERT INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (104, '4K Monitor', 'Electronics', 'Black', '27-inch', 'Unit', 'monitor.jpg', 4.7, 350.00);
INSERT INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (105, 'USB-C Hub', 'Accessories', 'Grey', 'Compact', 'Unit', 'usb_hub.jpg', 4.0, 30.00);
INSERT INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (106, 'Gaming Headset', 'Audio', 'Black', 'Over-ear', 'Unit', 'headset.jpg', 4.6, 75.00);
INSERT INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (107, 'Smartwatch Series 5', 'Wearables', 'Rose Gold', '40mm', 'Unit', 'smartwatch.jpg', 4.3, 250.00);
INSERT INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (108, 'External SSD 1TB', 'Storage', 'Blue', 'Portable', 'Unit', 'ssd.jpg', 4.9, 110.00);
INSERT INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (109, 'Webcam 1080p', 'Peripherals', 'Black', 'Desktop', 'Unit', 'webcam.jpg', 4.1, 45.00);
INSERT INTO Dim_Product (ProductID, ProductName, Category, Color, ProductSize, UnitOfMeasure, ProductImage, Rating, Pricing) VALUES (110, 'Wireless Charger Pad', 'Accessories', 'White', 'Standard', 'Unit', 'charger.jpg', 3.9, 28.00);


-- Dim_Customer
INSERT INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (201, 'Alice Smith', 'alice.s@example.com', '111-222-3333', '123 Main St, Anytown');
INSERT INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (202, 'Bob Johnson', 'bob.j@example.com', '444-555-6666', '456 Oak Ave, Otherville');
INSERT INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (203, 'Charlie Brown', 'charlie.b@example.com', '777-888-9999', '789 Pine Ln, Somewhere');
INSERT INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (204, 'Diana Prince', 'diana.p@example.com', '123-456-7890', '101 Hero Blvd, Metropolis');
INSERT INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (205, 'Eve Adams', 'eve.a@example.com', '987-654-3210', '202 Secret Rd, Gotham');
INSERT INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (206, 'Frank White', 'frank.w@example.com', '555-123-4567', '303 Elm St, Villageton');
INSERT INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (207, 'Grace Lee', 'grace.l@example.com', '222-333-4444', '404 Maple Ave, Cityville');
INSERT INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (208, 'Henry King', 'henry.k@example.com', '666-777-8888', '505 Birch Rd, Townburg');
INSERT INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (209, 'Ivy Green', 'ivy.g@example.com', '999-000-1111', '606 Cedar Ln, Hamlet');
INSERT INTO Dim_Customer (CustomerID, CustomerName, Email, Phoneno, CustomerAddress) VALUES (210, 'Jack Black', 'jack.b@example.com', '100-200-3000', '707 Pinecone Dr, Forestville');

-- Dim_Sales
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (301, 1, 'Laptop Pro X Sale', 'electronics,laptop', 1200.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (302, 2, 'Wireless Mouse Bundle', 'accessories,mouse', 50.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (303, 1, 'Mechanical Keyboard Promo', 'accessories,keyboard', 80.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (304, 1, '4K Monitor Deal', 'electronics,monitor', 350.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (305, 3, 'USB-C Hub Pack', 'accessories,usb', 90.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (306, 1, 'Gaming Headset Sale', 'audio,gaming', 75.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (307, 1, 'Smartwatch Discount', 'wearable,electronics', 250.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (308, 2, 'External SSD Offer', 'storage,electronics', 220.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (309, 1, 'Webcam Clearance', 'peripherals,video', 45.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (310, 1, 'Wireless Charger Promo', 'accessories,power', 28.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (311, 1, 'Laptop Sleeve', 'accessories,protection', 20.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (312, 1, 'Portable Bluetooth Speaker', 'audio,travel', 55.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (313, 1, 'Noise Cancelling Headphones', 'audio,travel', 180.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (314, 1, 'Gaming Chair', 'furniture,gaming', 299.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (315, 1, 'Smart Home Hub', 'smart home,electronics', 99.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (316, 1, 'Robot Vacuum Cleaner', 'home,appliances', 350.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (317, 2, 'Smartphone Screen Protector', 'mobile,accessories', 15.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (318, 1, 'Digital Drawing Tablet', 'art,electronics', 150.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (319, 1, 'E-Reader Kindle', 'books,electronics', 130.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (320, 5, 'USB Flash Drive 32GB', 'storage,accessories', 50.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (321, 1, 'Mesh Wi-Fi System', 'network,electronics', 199.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (322, 1, 'Portable Projector', 'electronics,entertainment', 280.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (323, 1, 'Electric Kettle', 'kitchen,appliances', 40.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (324, 1, 'Air Fryer XL', 'kitchen,appliances', 120.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (325, 1, 'Smart Fitness Scale', 'health,smart', 60.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (326, 1, 'Action Camera 4K', 'photography,adventure', 200.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (327, 2, 'Power Bank 20000mAh', 'mobile,accessories', 45.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (328, 1, 'Gaming Mouse RGB', 'accessories,gaming', 50.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (329, 1, 'Curved Gaming Monitor', 'electronics,gaming', 450.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (330, 1, 'Portable Photo Printer', 'photography,accessories', 90.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (331, 1, 'Smart Doorbell', 'smart home,security', 180.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (332, 1, 'Home Security Camera', 'security,smart home', 100.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (333, 1, 'Electric Toothbrush Smart', 'health,personal care', 85.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (334, 1, 'Coffee Maker Espresso', 'kitchen,appliances', 200.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (335, 1, 'Blender High-Speed', 'kitchen,appliances', 110.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (336, 1, 'Handheld Vacuum Cleaner', 'home,appliances', 70.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (337, 1, 'Smart Light Strips', 'smart home,lighting', 50.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (338, 1, 'Smart Thermostat', 'smart home,climate', 190.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (339, 1, 'Air Purifier HEPA', 'home,health', 220.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (340, 1, 'Electric Scooter', 'transportation,personal', 400.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (341, 1, 'Foldable Drone', 'hobby,electronics', 150.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (342, 1, 'Bluetooth Earbuds', 'audio,wireless', 65.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (343, 1, 'Gaming Keyboard Mechanical', 'accessories,gaming', 95.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (344, 1, 'Portable Monitor 14-inch', 'electronics,travel', 160.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (345, 1, 'Smart Plug 2-pack', 'smart home,power', 30.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (346, 1, 'External Hard Drive 4TB', 'storage,backup', 130.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (347, 1, 'USB Microphone', 'audio,streaming', 70.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (348, 1, 'LED Desk Lamp with Charger', 'office,lighting', 40.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (349, 1, 'Smart Water Bottle', 'health,smart', 35.00, 0.00);
INSERT INTO Dim_Sales (SalesID, units_sold, title, tags, price, balance) VALUES (350, 1, 'VR Headset Stand', 'gaming,accessories', 25.00, 0.00);


-- Dim_Promotions
INSERT INTO Dim_Promotions (PromoID, PromoName, DiscountRate, StartDate, EndDate) VALUES (401, 'Summer Sale', 0.10, TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2024-06-30', 'YYYY-MM-DD'));
INSERT INTO Dim_Promotions (PromoID, PromoName, DiscountRate, StartDate, EndDate) VALUES (402, 'Back to School', 0.15, TO_DATE('2024-08-01', 'YYYY-MM-DD'), TO_DATE('2024-08-31', 'YYYY-MM-DD'));
INSERT INTO Dim_Promotions (PromoID, PromoName, DiscountRate, StartDate, EndDate) VALUES (403, 'Black Friday', 0.25, TO_DATE('2024-11-25', 'YYYY-MM-DD'), TO_DATE('2024-12-01', 'YYYY-MM-DD'));
INSERT INTO Dim_Promotions (PromoID, PromoName, DiscountRate, StartDate, EndDate) VALUES (404, 'New Year Deal', 0.05, TO_DATE('2025-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-15', 'YYYY-MM-DD'));

-- Dim_Return
INSERT INTO Dim_Return (ReturnID, ReturnDate, CustomerID) VALUES (501, TO_DATE('2024-06-15', 'YYYY-MM-DD'), 201);
INSERT INTO Dim_Return (ReturnID, ReturnDate, CustomerID) VALUES (502, TO_DATE('2024-08-20', 'YYYY-MM-DD'), 202);
INSERT INTO Dim_Return (ReturnID, ReturnDate, CustomerID) VALUES (503, TO_DATE('2024-12-05', 'YYYY-MM-DD'), 203);

-- Dim_Date
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (1, 10, 6, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (2, 15, 6, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (3, 20, 8, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (4, 28, 11, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (5, 5, 12, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (6, 10, 1, 2025);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (7, 1, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (8, 2, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (9, 3, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (10, 4, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (11, 5, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (12, 6, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (13, 7, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (14, 8, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (15, 9, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (16, 10, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (17, 11, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (18, 12, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (19, 13, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (20, 14, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (21, 15, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (22, 16, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (23, 17, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (24, 18, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (25, 19, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (26, 20, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (27, 21, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (28, 22, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (29, 23, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (30, 24, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (31, 25, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (32, 26, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (33, 27, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (34, 28, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (35, 29, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (36, 30, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (37, 31, 7, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (38, 1, 8, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (39, 2, 8, 2024);
INSERT INTO Dim_Date (DateID, Day, Month, Year) VALUES (40, 3, 8, 2024);


-- Dim_Supplier
INSERT INTO Dim_Supplier (SupplierID, Name, Region) VALUES (601, 'Tech Distributors Inc.', 'North America');
INSERT INTO Dim_Supplier (SupplierID, Name, Region) VALUES (602, 'Global Parts Ltd.', 'Asia');
INSERT INTO Dim_Supplier (SupplierID, Name, Region) VALUES (603, 'Euro Components GmbH', 'Europe');
INSERT INTO Dim_Supplier (SupplierID, Name, Region) VALUES (604, 'Pacific Tech Solutions', 'Asia');
INSERT INTO Dim_Supplier (SupplierID, Name, Region) VALUES (605, 'North Star Electronics', 'North America');

-- Dim_PerformanceMatrix
INSERT INTO Dim_PerformanceMatrix (PerformanceID, PerformanceRating, ReviewDate, ReviewCycle, TargetCovered, EmployeeID) VALUES (701, 4.0, TO_DATE('2024-07-01', 'YYYY-MM-DD'), 'Q2-2024', 95, 801);
INSERT INTO Dim_PerformanceMatrix (PerformanceID, PerformanceRating, ReviewDate, ReviewCycle, TargetCovered, EmployeeID) VALUES (702, 3.5, TO_DATE('2024-07-01', 'YYYY-MM-DD'), 'Q2-2024', 80, 802);
INSERT INTO Dim_PerformanceMatrix (PerformanceID, PerformanceRating, ReviewDate, ReviewCycle, TargetCovered, EmployeeID) VALUES (703, 4.2, TO_DATE('2024-07-01', 'YYYY-MM-DD'), 'Q2-2024', 100, 803);
INSERT INTO Dim_PerformanceMatrix (PerformanceID, PerformanceRating, ReviewDate, ReviewCycle, TargetCovered, EmployeeID) VALUES (704, 3.8, TO_DATE('2024-07-01', 'YYYY-MM-DD'), 'Q2-2024', 88, 804);
INSERT INTO Dim_PerformanceMatrix (PerformanceID, PerformanceRating, ReviewDate, ReviewCycle, TargetCovered, EmployeeID) VALUES (705, 4.5, TO_DATE('2024-07-01', 'YYYY-MM-DD'), 'Q2-2024', 105, 805);


-- Dim_Attendance
INSERT INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (901, 801, TO_DATE('2024-07-01', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Present', NULL);
INSERT INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (902, 802, TO_DATE('2024-07-01', 'YYYY-MM-DD'), '09:00', '09:15', 15, 'Late', NULL);
INSERT INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (903, 803, TO_DATE('2024-07-01', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Present', NULL);
INSERT INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (904, 801, TO_DATE('2024-07-02', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Present', NULL);
INSERT INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (905, 802, TO_DATE('2024-07-02', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Absent', 'Sick Leave');
INSERT INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (906, 803, TO_DATE('2024-07-02', 'YYYY-MM-DD'), '09:00', '09:05', 5, 'Late', NULL);
INSERT INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (907, 804, TO_DATE('2024-07-01', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Present', NULL);
INSERT INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (908, 805, TO_DATE('2024-07-01', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Present', NULL);
INSERT INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (909, 804, TO_DATE('2024-07-02', 'YYYY-MM-DD'), '09:00', '09:10', 10, 'Late', NULL);
INSERT INTO Dim_Attendance (AttendanceID, Employee_ID, AttendanceDate, Scheduled_Start_Time, Actual_Start_Time, Late_Minutes, Attendance_Status, Absence_Reason) VALUES (910, 805, TO_DATE('2024-07-02', 'YYYY-MM-DD'), '09:00', '09:00', 0, 'Present', NULL);


-- Dim_EmployeeInfo
INSERT INTO Dim_EmployeeInfo (EmployeeID, First_Name, Last_Name, Department, Job_Title, Hire_Date, Salary_Grade, Start_Date, End_Date, Is_Current) VALUES (801, 'John', 'Doe', 'Sales', 'Sales Manager', TO_DATE('2020-01-15', 'YYYY-MM-DD'), 'Grade A', TO_DATE('2020-01-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO Dim_EmployeeInfo (EmployeeID, First_Name, Last_Name, Department, Job_Title, Hire_Date, Salary_Grade, Start_Date, End_Date, Is_Current) VALUES (802, 'Jane', 'Smith', 'Marketing', 'Marketing Specialist', TO_DATE('2021-03-10', 'YYYY-MM-DD'), 'Grade B', TO_DATE('2021-03-10', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO Dim_EmployeeInfo (EmployeeID, First_Name, Last_Name, Department, Job_Title, Hire_Date, Salary_Grade, Start_Date, End_Date, Is_Current) VALUES (803, 'Peter', 'Jones', 'IT', 'Software Engineer', TO_DATE('2019-06-01', 'YYYY-MM-DD'), 'Grade A', TO_DATE('2019-06-01', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO Dim_EmployeeInfo (EmployeeID, First_Name, Last_Name, Department, Job_Title, Hire_Date, Salary_Grade, Start_Date, End_Date, Is_Current) VALUES (804, 'Sarah', 'Connor', 'HR', 'HR Generalist', TO_DATE('2022-02-20', 'YYYY-MM-DD'), 'Grade B', TO_DATE('2022-02-20', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO Dim_EmployeeInfo (EmployeeID, First_Name, Last_Name, Department, Job_Title, Hire_Date, Salary_Grade, Start_Date, End_Date, Is_Current) VALUES (805, 'Michael', 'Scott', 'Sales', 'Sales Representative', TO_DATE('2023-05-01', 'YYYY-MM-DD'), 'Grade C', TO_DATE('2023-05-01', 'YYYY-MM-DD'), NULL, 'Y');


-- Dim_FeedBack
INSERT INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (1001, 201, 101, 5.0, 'Excellent product, very fast!', TO_DATE('2024-06-12', 'YYYY-MM-DD'), 'Positive');
INSERT INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (1002, 202, 102, 4.0, 'Good mouse, but a bit small.', TO_DATE('2024-06-18', 'YYYY-MM-DD'), 'Neutral');
INSERT INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (1003, 203, 103, 4.5, 'Love the RGB!', TO_DATE('2024-08-25', 'YYYY-MM-DD'), 'Positive');
INSERT INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (1004, 201, 104, 3.0, 'Monitor had a dead pixel.', TO_DATE('2024-11-30', 'YYYY-MM-DD'), 'Negative');
INSERT INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (1005, 204, 101, 4.8, 'Very happy with the performance.', TO_DATE('2024-12-10', 'YYYY-MM-DD'), 'Positive');
INSERT INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (1006, 205, 105, 4.2, 'USB hub works as expected.', TO_DATE('2024-07-01', 'YYYY-MM-DD'), 'Positive');
INSERT INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (1007, 206, 106, 4.7, 'Great sound quality on headset.', TO_DATE('2024-07-05', 'YYYY-MM-DD'), 'Positive');
INSERT INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (1008, 207, 107, 3.5, 'Smartwatch battery life is short.', TO_DATE('2024-07-10', 'YYYY-MM-DD'), 'Negative');
INSERT INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (1009, 208, 108, 5.0, 'SSD is incredibly fast for transfers.', TO_DATE('2024-07-15', 'YYYY-MM-DD'), 'Positive');
INSERT INTO Dim_FeedBack (FeedBackKey, CustomerID, ProductID, Rating, FeedbackComment, FeedbackDate, Sentiment) VALUES (1010, 209, 109, 4.0, 'Webcam is clear for video calls.', TO_DATE('2024-07-20', 'YYYY-MM-DD'), 'Positive');


-- Dim_SupplierType
INSERT INTO Dim_SupplierType (SupplierTypeID, Name) VALUES (1101, 'Manufacturer');
INSERT INTO Dim_SupplierType (SupplierTypeID, Name) VALUES (1102, 'Distributor');
INSERT INTO Dim_SupplierType (SupplierTypeID, Name) VALUES (1103, 'Wholesaler');


-- INSERT Statements for Fact Tables (using surrogate keys from Dimension tables)

-- Fact_OrderSummary
-- Assuming ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk are 1-indexed based on their creation order
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (1, 1, 1, 1, 1, NULL); -- Laptop Pro X, Alice, Sale 301, 2024-06-10, Summer Sale, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (2, 2, 2, 2, NULL, 1); -- Wireless Mouse, Bob, Sale 302, 2024-06-15, No Promo, Return 501
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (3, 3, 3, 3, 2, NULL); -- Mechanical Keyboard, Charlie, Sale 303, 2024-08-20, Back to School, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (4, 1, 4, 4, 3, NULL); -- 4K Monitor, Alice, Sale 304, 2024-11-28, Black Friday, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (5, 4, 5, 5, NULL, NULL); -- USB-C Hub, Diana, Sale 305, 2024-12-05, No Promo, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (1, 5, 6, 6, 4, NULL); -- Laptop Pro X, Eve, Sale 306, 2025-01-10, New Year, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (6, 6, 7, 7, NULL, NULL); -- Gaming Headset, Frank, Sale 307, 2024-07-01, No Promo, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (7, 7, 8, 8, 1, NULL); -- Smartwatch, Grace, Sale 308, 2024-07-02, Summer Sale, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (8, 8, 9, 9, NULL, NULL); -- External SSD, Henry, Sale 309, 2024-07-03, No Promo, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (9, 9, 10, 10, 2, NULL); -- Webcam, Ivy, Sale 310, 2024-07-04, Back to School, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (10, 10, 11, 11, NULL, NULL); -- Wireless Charger, Jack, Sale 311, 2024-07-05, No Promo, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (1, 2, 12, 12, 1, NULL); -- Laptop Pro X, Bob, Sale 312, 2024-07-06, Summer Sale, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (2, 3, 13, 13, NULL, NULL); -- Wireless Mouse, Charlie, Sale 313, 2024-07-07, No Promo, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (3, 4, 14, 14, 2, NULL); -- Mechanical Keyboard, Diana, Sale 314, 2024-07-08, Back to School, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (4, 5, 15, 15, NULL, NULL); -- 4K Monitor, Eve, Sale 315, 2024-07-09, No Promo, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (5, 6, 16, 16, 3, NULL); -- USB-C Hub, Frank, Sale 316, 2024-07-10, Black Friday, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (6, 7, 17, 17, NULL, NULL); -- Gaming Headset, Grace, Sale 317, 2024-07-11, No Promo, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (7, 8, 18, 18, 4, NULL); -- Smartwatch, Henry, Sale 318, 2024-07-12, New Year, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (8, 9, 19, 19, NULL, NULL); -- External SSD, Ivy, Sale 319, 2024-07-13, No Promo, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (9, 10, 20, 20, 1, NULL); -- Webcam, Jack, Sale 320, 2024-07-14, Summer Sale, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (10, 1, 21, 21, NULL, NULL); -- Wireless Charger, Alice, Sale 321, 2024-07-15, No Promo, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (1, 3, 22, 22, 2, NULL); -- Laptop Pro X, Charlie, Sale 322, 2024-07-16, Back to School, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (2, 4, 23, 23, NULL, NULL); -- Wireless Mouse, Diana, Sale 323, 2024-07-17, No Promo, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (3, 5, 24, 24, 3, NULL); -- Mechanical Keyboard, Eve, Sale 324, 2024-07-18, Black Friday, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (4, 6, 25, 25, NULL, NULL); -- 4K Monitor, Frank, Sale 325, 2024-07-19, No Promo, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (5, 7, 26, 26, 4, NULL); -- USB-C Hub, Grace, Sale 326, 2024-07-20, New Year, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (6, 8, 27, 27, NULL, NULL); -- Gaming Headset, Henry, Sale 327, 2024-07-21, No Promo, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (7, 9, 28, 28, 1, NULL); -- Smartwatch, Ivy, Sale 328, 2024-07-22, Summer Sale, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (8, 10, 29, 29, NULL, NULL); -- External SSD, Jack, Sale 329, 2024-07-23, No Promo, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (9, 1, 30, 30, 2, NULL); -- Webcam, Alice, Sale 330, 2024-07-24, Back to School, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (10, 2, 31, 31, NULL, NULL); -- Wireless Charger, Bob, Sale 331, 2024-07-25, No Promo, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (1, 4, 32, 32, 3, NULL); -- Laptop Pro X, Diana, Sale 332, 2024-07-26, Black Friday, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (2, 5, 33, 33, NULL, NULL); -- Wireless Mouse, Eve, Sale 333, 2024-07-27, No Promo, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (3, 6, 34, 34, 4, NULL); -- Mechanical Keyboard, Frank, Sale 334, 2024-07-28, New Year, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (4, 7, 35, 35, NULL, NULL); -- 4K Monitor, Grace, Sale 335, 2024-07-29, No Promo, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (5, 8, 36, 36, 1, NULL); -- USB-C Hub, Henry, Sale 336, 2024-07-30, Summer Sale, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (6, 9, 37, 37, NULL, NULL); -- Gaming Headset, Ivy, Sale 337, 2024-07-31, No Promo, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (7, 10, 38, 38, 2, NULL); -- Smartwatch, Jack, Sale 338, 2024-08-01, Back to School, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (8, 1, 39, 39, NULL, NULL); -- External SSD, Alice, Sale 339, 2024-08-02, No Promo, No Return
INSERT INTO Fact_OrderSummary (ProductID_sk, CustomerID_sk, SalesID_sk, DateID_sk, PromoID_sk, ReturnID_sk) VALUES (9, 2, 40, 40, 3, NULL); -- Webcam, Bob, Sale 340, 2024-08-03, Black Friday, No Return


-- Fact_InventorySummary
INSERT INTO Fact_InventorySummary (ProductID_sk, DateID_sk, StockLevel, RestockAmount) VALUES (1, 1, 50, 10);
INSERT INTO Fact_InventorySummary (ProductID_sk, DateID_sk, StockLevel, RestockAmount) VALUES (2, 1, 100, 20);
INSERT INTO Fact_InventorySummary (ProductID_sk, DateID_sk, StockLevel, RestockAmount) VALUES (3, 2, 75, 15);
INSERT INTO Fact_InventorySummary (ProductID_sk, DateID_sk, StockLevel, RestockAmount) VALUES (4, 3, 30, 5);
INSERT INTO Fact_InventorySummary (ProductID_sk, DateID_sk, StockLevel, RestockAmount) VALUES (5, 4, 120, 25);
INSERT INTO Fact_InventorySummary (ProductID_sk, DateID_sk, StockLevel, RestockAmount) VALUES (1, 6, 45, 10);
INSERT INTO Fact_InventorySummary (ProductID_sk, DateID_sk, StockLevel, RestockAmount) VALUES (6, 7, 80, 10);
INSERT INTO Fact_InventorySummary (ProductID_sk, DateID_sk, StockLevel, RestockAmount) VALUES (7, 8, 60, 5);
INSERT INTO Fact_InventorySummary (ProductID_sk, DateID_sk, StockLevel, RestockAmount) VALUES (8, 9, 90, 15);
INSERT INTO Fact_InventorySummary (ProductID_sk, DateID_sk, StockLevel, RestockAmount) VALUES (9, 10, 110, 20);
INSERT INTO Fact_InventorySummary (ProductID_sk, DateID_sk, StockLevel, RestockAmount) VALUES (10, 11, 70, 10);

-- Fact_EmployeePerformance
INSERT INTO Fact_EmployeePerformance (PerformanceID_sk, AttendanceID_sk, EmployeeID_sk, DateID_sk, KPI_Score) VALUES (1, 1, 1, 1, 92.5);
INSERT INTO Fact_EmployeePerformance (PerformanceID_sk, AttendanceID_sk, EmployeeID_sk, DateID_sk, KPI_Score) VALUES (2, 2, 2, 1, 78.0);
INSERT INTO Fact_EmployeePerformance (PerformanceID_sk, AttendanceID_sk, EmployeeID_sk, DateID_sk, KPI_Score) VALUES (3, 3, 3, 1, 98.0);
INSERT INTO Fact_EmployeePerformance (PerformanceID_sk, AttendanceID_sk, EmployeeID_sk, DateID_sk, KPI_Score) VALUES (1, 4, 1, 2, 93.0);
INSERT INTO Fact_EmployeePerformance (PerformanceID_sk, AttendanceID_sk, EmployeeID_sk, DateID_sk, KPI_Score) VALUES (2, 5, 2, 2, 75.0);
INSERT INTO Fact_EmployeePerformance (PerformanceID_sk, AttendanceID_sk, EmployeeID_sk, DateID_sk, KPI_Score) VALUES (3, 6, 3, 2, 99.0);
INSERT INTO Fact_EmployeePerformance (PerformanceID_sk, AttendanceID_sk, EmployeeID_sk, DateID_sk, KPI_Score) VALUES (4, 7, 4, 7, 88.0);
INSERT INTO Fact_EmployeePerformance (PerformanceID_sk, AttendanceID_sk, EmployeeID_sk, DateID_sk, KPI_Score) VALUES (5, 8, 5, 7, 102.0);
INSERT INTO Fact_EmployeePerformance (PerformanceID_sk, AttendanceID_sk, EmployeeID_sk, DateID_sk, KPI_Score) VALUES (4, 9, 4, 8, 90.0);
INSERT INTO Fact_EmployeePerformance (PerformanceID_sk, AttendanceID_sk, EmployeeID_sk, DateID_sk, KPI_Score) VALUES (5, 10, 5, 8, 105.0);


-- Fact_SupplierPerformance
INSERT INTO Fact_SupplierPerformance (DateID_sk, SupplierID_sk, ProductID_sk, SupplierTypeID_sk, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits) VALUES (1, 1, 1, 1, 100, 98, 2);
INSERT INTO Fact_SupplierPerformance (DateID_sk, SupplierID_sk, ProductID_sk, SupplierTypeID_sk, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits) VALUES (2, 2, 2, 2, 200, 200, 0);
INSERT INTO Fact_SupplierPerformance (DateID_sk, SupplierID_sk, ProductID_sk, SupplierTypeID_sk, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits) VALUES (3, 3, 3, 1, 150, 145, 5);
INSERT INTO Fact_SupplierPerformance (DateID_sk, SupplierID_sk, ProductID_sk, SupplierTypeID_sk, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits) VALUES (4, 1, 4, 2, 50, 50, 1);
INSERT INTO Fact_SupplierPerformance (DateID_sk, SupplierID_sk, ProductID_sk, SupplierTypeID_sk, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits) VALUES (5, 2, 5, 3, 300, 295, 5);
INSERT INTO Fact_SupplierPerformance (DateID_sk, SupplierID_sk, ProductID_sk, SupplierTypeID_sk, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits) VALUES (7, 4, 6, 1, 120, 118, 2);
INSERT INTO Fact_SupplierPerformance (DateID_sk, SupplierID_sk, ProductID_sk, SupplierTypeID_sk, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits) VALUES (8, 5, 7, 2, 80, 80, 0);
INSERT INTO Fact_SupplierPerformance (DateID_sk, SupplierID_sk, ProductID_sk, SupplierTypeID_sk, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits) VALUES (9, 1, 8, 3, 180, 175, 5);
INSERT INTO Fact_SupplierPerformance (DateID_sk, SupplierID_sk, ProductID_sk, SupplierTypeID_sk, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits) VALUES (10, 2, 9, 1, 90, 89, 1);
INSERT INTO Fact_SupplierPerformance (DateID_sk, SupplierID_sk, ProductID_sk, SupplierTypeID_sk, OrderedQuantity, ReceivedQuantity, QualityDefectsUnits) VALUES (11, 3, 10, 2, 140, 140, 0);


-- Fact_CusFeedBack
INSERT INTO Fact_CusFeedBack (FeedBackKey_sk, ProductID_sk, DateID_sk, AverageRate) VALUES (1, 1, 1, 5.0);
INSERT INTO Fact_CusFeedBack (FeedBackKey_sk, ProductID_sk, DateID_sk, AverageRate) VALUES (2, 2, 2, 4.0);
INSERT INTO Fact_CusFeedBack (FeedBackKey_sk, ProductID_sk, DateID_sk, AverageRate) VALUES (3, 3, 3, 4.5);
INSERT INTO Fact_CusFeedBack (FeedBackKey_sk, ProductID_sk, DateID_sk, AverageRate) VALUES (4, 4, 4, 3.0);
INSERT INTO Fact_CusFeedBack (FeedBackKey_sk, ProductID_sk, DateID_sk, AverageRate) VALUES (5, 1, 5, 4.8);
INSERT INTO Fact_CusFeedBack (FeedBackKey_sk, ProductID_sk, DateID_sk, AverageRate) VALUES (6, 5, 7, 4.2);
INSERT INTO Fact_CusFeedBack (FeedBackKey_sk, ProductID_sk, DateID_sk, AverageRate) VALUES (7, 6, 8, 4.7);
INSERT INTO Fact_CusFeedBack (FeedBackKey_sk, ProductID_sk, DateID_sk, AverageRate) VALUES (8, 7, 9, 3.5);
INSERT INTO Fact_CusFeedBack (FeedBackKey_sk, ProductID_sk, DateID_sk, AverageRate) VALUES (9, 8, 10, 5.0);
INSERT INTO Fact_CusFeedBack (FeedBackKey_sk, ProductID_sk, DateID_sk, AverageRate) VALUES (10, 9, 11, 4.0);
SELECT *FROM Fact_CusFeedBack;
COMMIT;
