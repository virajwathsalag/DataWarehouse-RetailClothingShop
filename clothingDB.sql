create database clothing_storeDB;
USE clothing_storeDB;

drop database clothing_storeDB;

-- Sachitha 

CREATE TABLE IF NOT EXISTS Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT, 
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    ContactNo VARCHAR(15) NOT NULL,
    Address VARCHAR(500) NOT NULL,
    City VARCHAR(50) NOT NULL
);

-- Table: PaymentType
CREATE TABLE IF NOT EXISTS PaymentType (
    PaymentTypeID INT PRIMARY KEY AUTO_INCREMENT, 
    PaymentMethod VARCHAR(50) NOT NULL
);

-- Table: TransportProvider
CREATE TABLE IF NOT EXISTS TransportProvider (                               
    ProviderID INT PRIMARY KEY AUTO_INCREMENT, 
    ProviderName VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    ContactNo VARCHAR(15) NOT NULL,
    FaxNumber VARCHAR(15) NOT NULL,
    BranchLocation VARCHAR(200) NOT NULL,
    Country VARCHAR(100) NOT NULL
);


-- Table: Sales 
CREATE TABLE IF NOT EXISTS Sales (
    SalesID INT PRIMARY KEY AUTO_INCREMENT,  
    CustomerID INT NOT NULL,
    PaymentTypeID INT NOT NULL,
    Type VARCHAR(50) NOT NULL, -- e.g., Online, In-Store
    ItemsCountPurchased INT NOT NULL,
    CashierID INT NOT NULL,
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    TotalAmount DOUBLE,
    NetTotal DOUBLE,
    GivenAmount DOUBLE,
    DiscountedAmount DOUBLE,
    Balance DOUBLE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (PaymentTypeID) REFERENCES PaymentType(PaymentTypeID)
);

ALTER TABLE Sales
MODIFY COLUMN TotalAmount DOUBLE;
ALTER TABLE Sales
MODIFY COLUMN NetTotal DOUBLE;
ALTER TABLE Sales
MODIFY COLUMN GivenAmount DOUBLE;
ALTER TABLE Sales
MODIFY COLUMN DiscountedAmount DOUBLE;
ALTER TABLE Sales
MODIFY COLUMN Balance DOUBLE;

-- Table: Shipments
CREATE TABLE IF NOT EXISTS Shipments (                                     	                
    ShipmentID INT PRIMARY KEY AUTO_INCREMENT, 
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    DestinationAddress VARCHAR(500) NOT NULL,
    ServiceCharge DOUBLE,
    Tax DOUBLE,
    EstimatedDeliverDate DATE,
    TotalShipmentCharge DOUBLE,
    ProviderID INT,
    SalesID INT,
    FOREIGN KEY (ProviderID) REFERENCES TransportProvider(ProviderID),
	FOREIGN KEY (SalesID) REFERENCES Sales(SalesID)
    
);

ALTER TABLE Shipments
MODIFY COLUMN ServiceCharge DOUBLE;
ALTER TABLE Shipments
MODIFY COLUMN Tax DOUBLE;
ALTER TABLE Shipments
MODIFY COLUMN TotalShipmentCharge DOUBLE;



-- Table: Wishlist
CREATE TABLE IF NOT EXISTS Wishlist (                                                         
    WishlistID INT PRIMARY KEY AUTO_INCREMENT, 
    CustomerID INT NOT NULL,
    ItemCount INT DEFAULT 0,
    LastUpdatedDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Table: WishListItems
CREATE TABLE IF NOT EXISTS WishListItems (
    ListItemID INT PRIMARY KEY AUTO_INCREMENT, 
    WishlistID INT NOT NULL, 
    ProductID INT NOT NULL,
    Count INT NOT NULL,
    ItemDate DATE,
    FOREIGN KEY (WishlistID) REFERENCES Wishlist(WishlistID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Sanuja

CREATE TABLE IF NOT EXISTS Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    SellingPrice DECIMAL(10,2) NOT NULL,
    Rating DECIMAL(3,1),
    Amount_allocated INT,
    InventoryID INT
);

CREATE TABLE IF NOT EXISTS ProductCategory (
    CatID INT PRIMARY KEY,
    Category VARCHAR(50) NOT NULL,
    Description VARCHAR(200)
);

CREATE TABLE IF NOT EXISTS Product_Sub_Category (
    Sub_CatID INT PRIMARY KEY,
    Category VARCHAR(50) NOT NULL,
    Description VARCHAR(100) NOT NULL,
    CatID INT NOT NULL,
    FOREIGN KEY (CatID) REFERENCES ProductCategory(CatID)
);


CREATE TABLE IF NOT EXISTS ProductImages (
    ImageID INT PRIMARY KEY,
    URL VARCHAR(255) NOT NULL,
    ProductID INT NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE IF NOT EXISTS Promotions (
    PromoID INT PRIMARY KEY,
    StartTime DATETIME NOT NULL,
    EndTime DATETIME NOT NULL,
    Percentage DECIMAL(5,2) NOT NULL CHECK (Percentage BETWEEN 5 AND 60),
    PromotionName VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Returnes (
    ReturnID INT PRIMARY KEY,
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    CustomerID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
    
);

CREATE TABLE IF NOT EXISTS ReturnItems (
    ReturnItemsID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    ReturnID INT NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (ReturnID) REFERENCES Returnes(ReturnID)
);




-- Raveen
-- Table: Inventory
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    Description TEXT,
    Brand VARCHAR(255),
    Specifications TEXT,
    Material VARCHAR(255),
    InventoryAmount INT,
    BuyingPrice DECIMAL(10, 2),
    ProfitAmount DECIMAL(10, 2),
    Status ENUM('active', 'removed'),
    SupplierID INT,
    ColorID INT,
    SizeID INT,
    CatID INT,
    FOREIGN KEY (ColorID) REFERENCES Color(ColorID),
    FOREIGN KEY (SizeID) REFERENCES Size(SizeID),
    FOREIGN KEY (CatID) REFERENCES ProductCategory(CatID)
);

-- Table: DamagedInventory
CREATE TABLE DamagedInventory (
    DamagedInventoryID INT PRIMARY KEY,
    DamageDescription VARCHAR(255),
    ReturningAmount DECIMAL(10, 2),
    DamagedAmount DECIMAL(10, 2),
    InventoryID INT,
    FOREIGN KEY (InventoryID) REFERENCES Inventory(InventoryID)
);

-- Table: Color
CREATE TABLE Color (
    ColorID INT PRIMARY KEY,
    Name VARCHAR(50),
    HexCode VARCHAR(7)
);

-- Table: Size
CREATE TABLE Size (
    SizeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Measurements VARCHAR(255)
);

-- Table: ProductCategory
-- CREATE TABLE ProductCategory (
--     CatID INT PRIMARY KEY,
--     Category VARCHAR(255),
--     Description TEXT,
--     SubCatID INT,
--     FOREIGN KEY (SubCatID) REFERENCES SubCategories(SubCatID)
-- );

-- Table: SubCategories
-- CREATE TABLE SubCategories (
--     SubCatID INT PRIMARY KEY,
--     SubCategories VARCHAR(255),
--     Description TEXT
-- );

-- Table: InventoryUpdatedHistory
CREATE TABLE InventoryUpdatedHistory (
    ModifyID INT PRIMARY KEY,
    Date DATE,
    Time TIME,
    InventoryID INT,
    SupplierID INT,
    EmployeeID INT,
    FOREIGN KEY (InventoryID) REFERENCES Inventory(InventoryID)
);

CREATE TABLE IF NOT EXISTS Contains (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    PromoID INT NOT NULL,
    ProductID INT NOT NULL,
    FOREIGN KEY (PromoID) REFERENCES Promotions(PromoID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);





-- DataInserting part 

INSERT INTO Customer (FirstName, LastName, Email, ContactNo, Address, City) VALUES
('Nimal', 'Perera', 'nimal.perera1@gmail.lk', '+94711000001', 'No. 1, Galle Road, Colombo 5', 'Colombo 5'),
('Priya', 'Rajan', 'priya.rajan2@yahoo.lk', '+94761000002', 'No. 2, Temple Road, Jaffna Town', 'Jaffna Town'),
('Chathura', 'Silva', 'chathura.silva3@slnet.lk', '+94771000003', 'No. 3, Kandy Lane, Kandy Central', 'Kandy Central'),
('Ayesha', 'Mohamed', 'ayesha.mohamed4@gmail.lk', '+94781000004', 'No. 4, Lotus Avenue, Negombo Beach', 'Negombo Beach'),
('Sivakumar', 'Nadarajah', 'sivakumar.nadarajah5@yahoo.lk', '+94751000005', 'No. 5, Coconut Grove, Galle Fort', 'Galle Fort'),
('Kumari', 'Fernando', 'kumari.fernando6@slnet.lk', '+94711000006', 'No. 6, Peradeniya Road, Kurunegala City', 'Kurunegala City'),
('Rizwan', 'Ismail', 'rizwan.ismail7@gmail.lk', '+94761000007', 'No. 7, Sea View Road, Trincomalee Coast', 'Trincomalee Coast'),
('Sanduni', 'Weerasinghe', 'sanduni.weerasinghe8@yahoo.lk', '+94771000008', 'No. 8, Hill Street, Nuwara Eliya Town', 'Nuwara Eliya Town'),
('Arjun', 'Selvan', 'arjun.selvan9@slnet.lk', '+94781000009', 'No. 9, Main Street, Batticaloa Lagoon', 'Batticaloa Lagoon'),
('Fathima', 'Fazil', 'fathima.fazil10@gmail.lk', '+94751000010', 'No. 10, Lake Road, Ratnapura Gem', 'Ratnapura Gem'),
('Tharani', 'Gunawardena', 'tharani.gunawardena11@yahoo.lk', '+94711000011', 'No. 11, Marine Drive, Matara Beach', 'Matara Beach'),
('Dinesh', 'Karunaratne', 'dinesh.karunaratne12@slnet.lk', '+94761000012', 'No. 12, Park Road, Anuradhapura Ruins', 'Anuradhapura Ruins'),
('Fazil', 'Rahman', 'fazil.rahman13@gmail.lk', '+94771000013', 'No. 13, Temple Lane, Badulla Hills', 'Badulla Hills'),
('Anusha', 'Jayasinghe', 'anusha.jayasinghe14@yahoo.lk', '+94781000014', 'No. 14, Beach Road, Colombo Dehiwala', 'Colombo Dehiwala'),
('Suresh', 'Vigneshwaran', 'suresh.vigneshwaran15@slnet.lk', '+94751000015', 'No. 15, Hill View, Kandy Peradeniya', 'Kandy Peradeniya'),
('Malini', 'Wickramasinghe', 'malini.wickramasinghe16@gmail.lk', '+94711000016', 'No. 16, Ocean Drive, Galle Hikkaduwa', 'Galle Hikkaduwa'),
('Hassan', 'Nazeer', 'hassan.nazeer17@yahoo.lk', '+94761000017', 'No. 17, Station Road, Negombo Fish Market', 'Negombo Fish Market'),
('Dilshan', 'Mendis', 'dilshan.mendis18@slnet.lk', '+94771000018', 'No. 18, Lake View, Kurunegala Lake', 'Kurunegala Lake'),
('Shalini', 'Thiruchelvam', 'shalini.thiruchelvam19@gmail.lk', '+94781000019', 'No. 19, Coastal Road, Trincomalee Uppuveli', 'Trincomalee Uppuveli'),
('Imran', 'Siddique', 'imran.siddique20@yahoo.lk', '+94751000020', 'No. 20, Gem Street, Ratnapura Mines', 'Ratnapura Mines'),
('Nuwan', 'Abeywardena', 'nuwan.abeywardena21@slnet.lk', '+94711000021', 'No. 21, Fort Road, Colombo Fort', 'Colombo Fort'),
('Sampath', 'De Silva', 'sampath.desilva22@gmail.lk', '+94761000022', 'No. 22, Church Road, Jaffna Nallur', 'Jaffna Nallur'),
('Lakmal', 'Bandara', 'lakmal.bandara23@yahoo.lk', '+94771000023', 'No. 23, Hill Crest, Kandy Hill', 'Kandy Hill'),
('Nadeesha', 'Amarasinghe', 'nadeesha.amarasinghe24@slnet.lk', '+94781000024', 'No. 24, Beach Lane, Negombo Lagoon', 'Negombo Lagoon'),
('Vimal', 'Ratnayake', 'vimal.ratnayake25@gmail.lk', '+94751000025', 'No. 25, Surf Road, Galle Unawatuna', 'Galle Unawatuna'),
('Ranjith', 'Hettiarachchi', 'ranjith.hettiarachchi26@yahoo.lk', '+94711000026', 'No. 26, City Road, Kurunegala Central', 'Kurunegala Central'),
('Asanka', 'Senanayake', 'asanka.senanayake27@slnet.lk', '+94761000027', 'No. 27, Bay Road, Trincomalee Harbor', 'Trincomalee Harbor'),
('Nirosha', 'Dissanayake', 'nirosha.dissanayake28@gmail.lk', '+94771000028', 'No. 28, Mountain View, Nuwara Eliya Hills', 'Nuwara Eliya Hills'),
('Upul', 'Ekanayake', 'upul.ekanayake29@yahoo.lk', '+94781000029', 'No. 29, Lagoon Road, Batticaloa East', 'Batticaloa East'),
('Saman', 'Kulathunga', 'saman.kulathunga30@slnet.lk', '+94751000030', 'No. 30, River Road, Ratnapura City', 'Ratnapura City'),
('Chamara', 'Liyanage', 'chamara.liyanage31@gmail.lk', '+94711000031', 'No. 31, Ocean View, Matara Coast', 'Matara Coast'),
('Nishanthi', 'Pathirana', 'nishanthi.pathirana32@yahoo.lk', '+94761000032', 'No. 32, Temple Street, Anuradhapura Old Town', 'Anuradhapura Old Town'),
('Ruwan', 'Samarasinghe', 'ruwan.samarasinghe33@slnet.lk', '+94771000033', 'No. 33, Hill Road, Badulla Town', 'Badulla Town'),
('Madhuri', 'Wijesinghe', 'madhuri.wijesinghe34@gmail.lk', '+94781000034', 'No. 34, Park Lane, Colombo 7', 'Colombo 7'),
('Janaka', 'Gunaratne', 'janaka.gunaratne35@yahoo.lk', '+94751000035', 'No. 35, Garden Road, Kandy Bogambara', 'Kandy Bogambara'),
('Sewwandi', 'Alwis', 'sewwandi.alwis36@slnet.lk', '+94711000036', 'No. 36, Coral Road, Galle Mirissa', 'Galle Mirissa'),
('Amila', 'Ranasinghe', 'amila.ranasinghe37@gmail.lk', '+94761000037', 'No. 37, Market Road, Negombo Market', 'Negombo Market'),
('Thilini', 'Kodikara', 'thilini.kodikara38@yahoo.lk', '+94771000038', 'No. 38, Lake Side, Kurunegala North', 'Kurunegala North'),
('Kusal', 'Edirisinghe', 'kusal.edirisinghe39@slnet.lk', '+94781000039', 'No. 39, Beachfront Road, Trincomalee Nilaveli', 'Trincomalee Nilaveli'),
('Dinusha', 'Herath', 'dinusha.herath40@gmail.lk', '+94751000040', 'No. 40, Gem Lane, Ratnapura Central', 'Ratnapura Central'),
('Sanjaya', 'Peiris', 'sanjaya.peiris41@yahoo.lk', '+94711000041', 'No. 41, Surf Lane, Matara Polhena', 'Matara Polhena'),
('Kavindya', 'Wimalasuriya', 'kavindya.wimalasuriya42@slnet.lk', '+94761000042', 'No. 42, Sacred Road, Anuradhapura Sacred City', 'Anuradhapura Sacred City'),
('Isuru', 'Attanayake', 'isuru.attanayake43@gmail.lk', '+94771000043', 'No. 43, Valley Road, Badulla Valley', 'Badulla Valley'),
('Shanika', 'Rajapaksa', 'shanika.rajapaksa44@yahoo.lk', '+94781000044', 'No. 44, Cinnamon Road, Colombo Cinnamon Gardens', 'Colombo Cinnamon Gardens'),
('Pradeep', 'Seneviratne', 'pradeep.seneviratne45@slnet.lk', '+94751000045', 'No. 45, Temple View, Kandy Temple', 'Kandy Temple'),
('Nimesha', 'Gamage', 'nimesha.gamage46@gmail.lk', '+94711000046', 'No. 46, Beach View, Galle Weligama', 'Galle Weligama'),
('Roshan', 'De Zoysa', 'roshan.dezoysa47@yahoo.lk', '+94761000047', 'No. 47, Fish Market Road, Negombo Central', 'Negombo Central'),
('Dilrukshi', 'Wickremasinghe', 'dilrukshi.wickremasinghe48@slnet.lk', '+94771000048', 'No. 48, Lake Road, Kurunegala South', 'Kurunegala South'),
('Chaminda', 'Abeysinghe', 'chaminda.abeysinghe49@gmail.lk', '+94781000049', 'No. 49, Oceanfront Road, Trincomalee Fort', 'Trincomalee Fort'),
('Hiruni', 'Senaratne', 'hiruni.senaratne50@yahoo.lk', '+94751000050', 'No. 50, Gem Road, Ratnapura North', 'Ratnapura North'),
('Naveen', 'Balasuriya', 'naveen.balasuriya51@slnet.lk', '+94711000051', 'No. 51, Coastal Lane, Matara Town', 'Matara Town'),
('Shamila', 'Dahanayake', 'shamila.dahanayake52@gmail.lk', '+94761000052', 'No. 52, Ruins Road, Anuradhapura North', 'Anuradhapura North'),
('Thushara', 'Lokuge', 'thushara.lokuge53@yahoo.lk', '+94771000053', 'No. 53, Hilltop Road, Badulla Central', 'Badulla Central'),
('Kasun', 'Samarakoon', 'kasun.samarakoon54@slnet.lk', '+94781000054', 'No. 54, Park View, Colombo 3', 'Colombo 3'),
('Pavithra', 'Wanigasekara', 'pavithra.wanigasekara55@gmail.lk', '+94751000055', 'No. 55, Lake Lane, Kandy Lake', 'Kandy Lake'),
('Malith', 'Ariyaratne', 'malith.ariyaratne56@yahoo.lk', '+94711000056', 'No. 56, Surf View, Galle Tangalle', 'Galle Tangalle'),
('Nayana', 'Kumara', 'nayana.kumara57@slnet.lk', '+94761000057', 'No. 57, Market Lane, Negombo North', 'Negombo North'),
('Sasanka', 'Jayaweera', 'sasanka.jayaweera58@gmail.lk', '+94771000058', 'No. 58, City Lane, Kurunegala West', 'Kurunegala West'),
('Tharindu', 'Madushanka', 'tharindu.madushanka59@yahoo.lk', '+94781000059', 'No. 59, Beach Road, Trincomalee Town', 'Trincomalee Town'),
('Nethmi', 'Siriwardena', 'nethmi.siriwardena60@slnet.lk', '+94751000060', 'No. 60, Gem View, Ratnapura South', 'Ratnapura South'),
('Lahiru', 'Fonseka', 'lahiru.fonseka61@gmail.lk', '+94711000061', 'No. 61, Ocean Lane, Matara South', 'Matara South'),
('Sanjani', 'Hewage', 'sanjani.hewage62@yahoo.lk', '+94761000062', 'No. 62, Sacred Lane, Anuradhapura Central', 'Anuradhapura Central'),
('Ravindu', 'Wimalaweera', 'ravindu.wimalaweera63@slnet.lk', '+94771000063', 'No. 63, Valley View, Badulla South', 'Badulla South'),
('Ashani', 'Nanayakkara', 'ashani.nanayakkara64@gmail.lk', '+94781000064', 'No. 64, Cinnamon Lane, Colombo 4', 'Colombo 4'),
('Kavisha', 'Dushyantha', 'kavisha.dushyantha65@yahoo.lk', '+94751000065', 'No. 65, Temple Road, Kandy Town', 'Kandy Town'),
('Sahan', 'Rathnayake', 'sahan.rathnayake66@slnet.lk', '+94711000066', 'No. 66, Beachfront Lane, Galle South', 'Galle South'),
('Nimasha', 'Peris', 'nimasha.peris67@gmail.lk', '+94761000067', 'No. 67, Fish Market Lane, Negombo South', 'Negombo South'),
('Thilina', 'Wijewardena', 'thilina.wijewardena68@yahoo.lk', '+94771000068', 'No. 68, Lakefront Road, Kurunegala East', 'Kurunegala East'),
('Yasodara', 'Senadheera', 'yasodara.senadheera69@slnet.lk', '+94781000069', 'No. 69, Coastal Lane, Trincomalee East', 'Trincomalee East'),
('Chandana', 'Amarasekera', 'chandana.amarasekera70@gmail.lk', '+94751000070', 'No. 70, Gem City Road, Ratnapura East', 'Ratnapura East'),
('Sithara', 'Weerasekara', 'sithara.weerasekara71@yahoo.lk', '+94711000071', 'No. 71, Surf Road, Matara Central', 'Matara Central'),
('Nadeeka', 'Gunasekera', 'nadeeka.gunasekera72@slnet.lk', '+94761000072', 'No. 72, Ruins Lane, Anuradhapura South', 'Anuradhapura South'),
('Ruwanthi', 'Salgado', 'ruwanthi.salgado73@gmail.lk', '+94771000073', 'No. 73, Hill Lane, Badulla North', 'Badulla North'),
('Amal', 'Palihawadana', 'amal.palihawadana74@yahoo.lk', '+94781000074', 'No. 74, Park Road, Colombo 6', 'Colombo 6'),
('Shashika', 'Adhikari', 'shashika.adhikari75@slnet.lk', '+94751000075', 'No. 75, Lake View Road, Kandy South', 'Kandy South'),
('Tharaka', 'Wijesekara', 'tharaka.wijesekara76@gmail.lk', '+94711000076', 'No. 76, Ocean Road, Galle Central', 'Galle Central'),
('Nisansala', 'Hewavitharana', 'nisansala.hewavitharana77@yahoo.lk', '+94761000077', 'No. 77, Market Road, Negombo East', 'Negombo East'),
('Sankalpa', 'Munasinghe', 'sankalpa.munasinghe78@slnet.lk', '+94771000078', 'No. 78, City View, Kurunegala Town', 'Kurunegala Town'),
('Yasith', 'Kariyawasam', 'yasith.kariyawasam79@gmail.lk', '+94781000079', 'No. 79, Beach Lane, Trincomalee South', 'Trincomalee South'),
('Anuradha', 'Rathnayaka', 'anuradha.rathnayaka80@yahoo.lk', '+94751000080', 'No. 80, Gem Market Road, Ratnapura West', 'Ratnapura West'),
('Chamari', 'Lakshan', 'chamari.lakshan81@slnet.lk', '+94711000081', 'No. 81, Coastal Road, Matara North', 'Matara North'),
('Nipun', 'Wickramaratne', 'nipun.wickramaratne82@gmail.lk', '+94761000082', 'No. 82, Sacred City Road, Anuradhapura West', 'Anuradhapura West'),
('Sashika', 'Abeyratne', 'sashika.abeyratne83@yahoo.lk', '+94771000083', 'No. 83, Valley Lane, Badulla East', 'Badulla East'),
('Thushari', 'Dissanayaka', 'thushari.dissanayaka84@slnet.lk', '+94781000084', 'No. 84, Cinnamon View, Colombo 8', 'Colombo 8'),
('Rangana', 'Kulasekara', 'rangana.kulasekara85@gmail.lk', '+94751000085', 'No. 85, Temple Lane, Kandy North', 'Kandy North'),
('Sewmini', 'Jayaratne', 'sewmini.jayaratne86@yahoo.lk', '+94711000086', 'No. 86, Beach Road, Galle North', 'Galle North'),
('Kanchana', 'Wijerathna', 'kanchana.wijerathna87@slnet.lk', '+94761000087', 'No. 87, Fish Market Road, Negombo West', 'Negombo West'),
('Sanjula', 'Hewapathirana', 'sanjula.hewapathirana88@gmail.lk', '+94771000088', 'No. 88, Lake Lane, Kurunegala Central', 'Kurunegala Central'),
('Nimali', 'Senanayaka', 'nimali.senanayaka89@yahoo.lk', '+94781000089', 'No. 89, Coastal View, Trincomalee Central', 'Trincomalee Central'),
('Chathuri', 'Ekanayaka', 'chathuri.ekanayaka90@slnet.lk', '+94751000090', 'No. 90, Gem Lane, Ratnapura Town', 'Ratnapura Town'),
('Sasindu', 'Gunathilaka', 'sasindu.gunathilaka91@gmail.lk', '+94711000091', 'No. 91, Surf Lane, Matara West', 'Matara West'),
('Niranjala', 'Weerakoon', 'niranjala.weerakoon92@yahoo.lk', '+94761000092', 'No. 92, Ruins View, Anuradhapura East', 'Anuradhapura East'),
('Tharusha', 'Samarawickrama', 'tharusha.samarawickrama93@slnet.lk', '+94771000093', 'No. 93, Hill View, Badulla West', 'Badulla West'),
('Ashen', 'Ranathunga', 'ashen.ranathunga94@gmail.lk', '+94781000094', 'No. 94, Park Lane, Colombo 9', 'Colombo 9'),
('Sampath', 'Wijethunga', 'sampath.wijethunga95@yahoo.lk', '+94751000095', 'No. 95, Lake Road, Kandy West', 'Kandy West'),
('Nadeeshani', 'Amarasuriya', 'nadeeshani.amarasuriya96@slnet.lk', '+94711000096', 'No. 96, Ocean Lane, Galle West', 'Galle West'),
('Ruwantha', 'Kotalawala', 'ruwantha.kotalawala97@gmail.lk', '+94761000097', 'No. 97, Market View, Negombo Town', 'Negombo Town'),
('Tharindi', 'Liyanarachchi', 'tharindi.liyanarachchi98@yahoo.lk', '+94771000098', 'No. 98, City Road, Kurunegala North', 'Kurunegala North'),
('Nisal', 'Abeykoon', 'nisal.abeykoon99@slnet.lk', '+94781000099', 'No. 99, Beach Lane, Trincomalee West', 'Trincomalee West'),
('Sanjani', 'Wickramasingha', 'sanjani.wickramasingha100@gmail.lk', '+94751000100', 'No. 100, Gem Road, Ratnapura Central', 'Ratnapura Central'),
('Tharaka', 'Senevirathna', 'tharaka.senevirathna101@yahoo.lk', '+94711000101', 'No. 101, Coastal Road, Matara East', 'Matara East'),
('Nethmi', 'Dahanayaka', 'nethmi.dahanayaka102@slnet.lk', '+94761000102', 'No. 102, Sacred Road, Anuradhapura Town', 'Anuradhapura Town'),
('Sahan', 'Lokuge', 'sahan.lokuge103@gmail.lk', '+94771000103', 'No. 103, Valley Road, Badulla Town', 'Badulla Town'),
('Kavisha', 'Samarakoon', 'kavisha.samarakoon104@yahoo.lk', '+94781000104', 'No. 104, Cinnamon Road, Colombo 10', 'Colombo 10'),
('Ashani', 'Wanigasekara', 'ashani.wanigasekara105@slnet.lk', '+94751000105', 'No. 105, Temple Lane, Kandy East', 'Kandy East'),
('Rangana', 'Ariyaratne', 'rangana.ariyaratne106@gmail.lk', '+94711000106', 'No. 106, Beach Road, Galle East', 'Galle East'),
('Nayana', 'Kumara', 'nayana.kumara107@yahoo.lk', '+94761000107', 'No. 107, Fish Market Lane, Negombo Central', 'Negombo Central'),
('Sasanka', 'Jayaweera', 'sasanka.jayaweera108@slnet.lk', '+94771000108', 'No. 108, Lake View, Kurunegala West', 'Kurunegala West'),
('Tharindu', 'Madushanka', 'tharindu.madushanka109@gmail.lk', '+94781000109', 'No. 109, Coastal Road, Trincomalee Town', 'Trincomalee Town'),
('Nethmi', 'Siriwardena', 'nethmi.siriwardena110@yahoo.lk', '+94751000110', 'No. 110, Gem Lane, Ratnapura North', 'Ratnapura North'),
('Lahiru', 'Fonseka', 'lahiru.fonseka111@slnet.lk', '+94711000111', 'No. 111, Surf Lane, Matara South', 'Matara South'),
('Sanjani', 'Hewage', 'sanjani.hewage112@gmail.lk', '+94761000112', 'No. 112, Sacred Lane, Anuradhapura East', 'Anuradhapura East'),
('Ravindu', 'Wimalaweera', 'ravindu.wimalaweera113@yahoo.lk', '+94771000113', 'No. 113, Valley View, Badulla South', 'Badulla South'),
('Ashani', 'Nanayakkara', 'ashani.nanayakkara114@slnet.lk', '+94781000114', 'No. 114, Cinnamon Lane, Colombo 11', 'Colombo 11'),
('Kavisha', 'Dushyantha', 'kavisha.dushyantha115@gmail.lk', '+94751000115', 'No. 115, Temple Road, Kandy Central', 'Kandy Central'),
('Sahan', 'Rathnayake', 'sahan.rathnayake116@yahoo.lk', '+94711000116', 'No. 116, Beachfront Lane, Galle North', 'Galle North'),
('Nimasha', 'Peris', 'nimasha.peris117@slnet.lk', '+94761000117', 'No. 117, Fish Market Road, Negombo East', 'Negombo East'),
('Thilina', 'Wijewardena', 'thilina.wijewardena118@gmail.lk', '+94771000118', 'No. 118, Lakefront Road, Kurunegala South', 'Kurunegala South'),
('Yasodara', 'Senadheera', 'yasodara.senadheera119@yahoo.lk', '+94781000119', 'No. 119, Coastal Lane, Trincomalee East', 'Trincomalee East'),
('Chandana', 'Amarasekera', 'chandana.amarasekera120@slnet.lk', '+94751000120', 'No. 120, Gem City Road, Ratnapura West', 'Ratnapura West'),
('Sithara', 'Weerasekara', 'sithara.weerasekara121@gmail.lk', '+94711000121', 'No. 121, Surf Road, Matara North', 'Matara North'),
('Nadeeka', 'Gunasekera', 'nadeeka.gunasekera122@yahoo.lk', '+94761000122', 'No. 122, Ruins Lane, Anuradhapura Town', 'Anuradhapura Town'),
('Ruwanthi', 'Salgado', 'ruwanthi.salgado123@slnet.lk', '+94771000123', 'No. 123, Hill Lane, Badulla North', 'Badulla North'),
('Amal', 'Palihawadana', 'amal.palihawadana124@gmail.lk', '+94781000124', 'No. 124, Park Road, Colombo 12', 'Colombo 12'),
('Shashika', 'Adhikari', 'shashika.adhikari125@yahoo.lk', '+94751000125', 'No. 125, Lake View Road, Kandy West', 'Kandy West'),
('Tharaka', 'Wijesekara', 'tharaka.wijesekara126@slnet.lk', '+94711000126', 'No. 126, Ocean Road, Galle Central', 'Galle Central'),
('Nisansala', 'Hewavitharana', 'nisansala.hewavitharana127@gmail.lk', '+94761000127', 'No. 127, Market Road, Negombo Town', 'Negombo Town'),
('Sankalpa', 'Munasinghe', 'sankalpa.munasinghe128@yahoo.lk', '+94771000128', 'No. 128, City View, Kurunegala North', 'Kurunegala North'),
('Yasith', 'Kariyawasam', 'yasith.kariyawasam129@slnet.lk', '+94781000129', 'No. 129, Beach Lane, Trincomalee West', 'Trincomalee West'),
('Anuradha', 'Rathnayaka', 'anuradha.rathnayaka130@gmail.lk', '+94751000130', 'No. 130, Gem Market Road, Ratnapura Central', 'Ratnapura Central'),
('Chamari', 'Lakshan', 'chamari.lakshan131@yahoo.lk', '+94711000131', 'No. 131, Coastal Road, Matara East', 'Matara East'),
('Nipun', 'Wickramaratne', 'nipun.wickramaratne132@slnet.lk', '+94761000132', 'No. 132, Sacred City Road, Anuradhapura West', 'Anuradhapura West'),
('Sashika', 'Abeyratne', 'sashika.abeyratne133@gmail.lk', '+94771000133', 'No. 133, Valley Lane, Badulla East', 'Badulla East'),
('Thushari', 'Dissanayaka', 'thushari.dissanayaka134@yahoo.lk', '+94781000134', 'No. 134, Cinnamon View, Colombo 13', 'Colombo 13'),
('Rangana', 'Kulasekara', 'rangana.kulasekara135@slnet.lk', '+94751000135', 'No. 135, Temple Lane, Kandy Central', 'Kandy Central'),
('Sewmini', 'Jayaratne', 'sewmini.jayaratne136@gmail.lk', '+94711000136', 'No. 136, Beach Road, Galle North', 'Galle North'),
('Kanchana', 'Wijerathna', 'kanchana.wijerathna137@yahoo.lk', '+94761000137', 'No. 137, Fish Market Road, Negombo East', 'Negombo East'),
('Sanjula', 'Hewapathirana', 'sanjula.hewapathirana138@slnet.lk', '+94771000138', 'No. 138, Lakefront Road, Kurunegala South', 'Kurunegala South'),
('Nimali', 'Senanayaka', 'nimali.senanayaka139@gmail.lk', '+94781000139', 'No. 139, Coastal Lane, Trincomalee East', 'Trincomalee East'),
('Chathuri', 'Ekanayaka', 'chathuri.ekanayaka140@yahoo.lk', '+94751000140', 'No. 140, Gem City Road, Ratnapura West', 'Ratnapura West'),
('Sasindu', 'Gunathilaka', 'sasindu.gunathilaka141@slnet.lk', '+94711000141', 'No. 141, Surf Lane, Matara North', 'Matara North'),
('Niranjala', 'Weerakoon', 'niranjala.weerakoon142@gmail.lk', '+94761000142', 'No. 142, Ruins View, Anuradhapura Town', 'Anuradhapura Town'),
('Tharusha', 'Samarawickrama', 'tharusha.samarawickrama143@yahoo.lk', '+94771000143', 'No. 143, Hill View, Badulla North', 'Badulla North'),
('Ashen', 'Ranathunga', 'ashen.ranathunga144@slnet.lk', '+94781000144', 'No. 144, Park Lane, Colombo 14', 'Colombo 14'),
('Sampath', 'Wijethunga', 'sampath.wijethunga145@gmail.lk', '+94751000145', 'No. 145, Lake Road, Kandy West', 'Kandy West'),
('Nadeeshani', 'Amarasuriya', 'nadeeshani.amarasuriya146@yahoo.lk', '+94711000146', 'No. 146, Ocean Lane, Galle Central', 'Galle Central'),
('Ruwantha', 'Kotalawala', 'ruwantha.kotalawala147@slnet.lk', '+94761000147', 'No. 147, Market View, Negombo Town', 'Negombo Town'),
('Tharindi', 'Liyanarachchi', 'tharindi.liyanarachchi148@gmail.lk', '+94771000148', 'No. 148, City Road, Kurunegala North', 'Kurunegala North'),
('Nisal', 'Abeykoon', 'nisal.abeykoon149@yahoo.lk', '+94781000149', 'No. 149, Beach Lane, Trincomalee West', 'Trincomalee West'),
('Sanjani', 'Wickramasingha', 'sanjani.wickramasingha150@slnet.lk', '+94751000150', 'No. 150, Gem Road, Ratnapura Central', 'Ratnapura Central'),
('Tharaka', 'Senevirathna', 'tharaka.senevirathna151@gmail.lk', '+94711000151', 'No. 151, Coastal Road, Matara East', 'Matara East'),
('Nethmi', 'Dahanayaka', 'nethmi.dahanayaka152@yahoo.lk', '+94761000152', 'No. 152, Sacred Road, Anuradhapura Town', 'Anuradhapura Town'),
('Sahan', 'Lokuge', 'sahan.lokuge153@slnet.lk', '+94771000153', 'No. 153, Valley Road, Badulla Town', 'Badulla Town'),
('Kavisha', 'Samarakoon', 'kavisha.samarakoon154@gmail.lk', '+94781000154', 'No. 154, Cinnamon Road, Colombo 15', 'Colombo 15'),
('Ashani', 'Wanigasekara', 'ashani.wanigasekara155@yahoo.lk', '+94751000155', 'No. 155, Temple Lane, Kandy Central', 'Kandy Central'),
('Rangana', 'Ariyaratne', 'rangana.ariyaratne156@slnet.lk', '+94711000156', 'No. 156, Beach Road, Galle North', 'Galle North'),
('Nayana', 'Kumara', 'nayana.kumara157@gmail.lk', '+94761000157', 'No. 157, Fish Market Lane, Negombo East', 'Negombo East'),
('Sasanka', 'Jayaweera', 'sasanka.jayaweera158@yahoo.lk', '+94771000158', 'No. 158, Lake View, Kurunegala South', 'Kurunegala South'),
('Tharindu', 'Madushanka', 'tharindu.madushanka159@slnet.lk', '+94781000159', 'No. 159, Coastal Road, Trincomalee Town', 'Trincomalee Town'),
('Nethmi', 'Siriwardena', 'nethmi.siriwardena160@gmail.lk', '+94751000160', 'No. 160, Gem Lane, Ratnapura North', 'Ratnapura North'),
('Lahiru', 'Fonseka', 'lahiru.fonseka161@yahoo.lk', '+94711000161', 'No. 161, Surf Lane, Matara South', 'Matara South'),
('Sanjani', 'Hewage', 'sanjani.hewage162@slnet.lk', '+94761000162', 'No. 162, Sacred Lane, Anuradhapura East', 'Anuradhapura East'),
('Ravindu', 'Wimalaweera', 'ravindu.wimalaweera163@gmail.lk', '+94771000163', 'No. 163, Valley View, Badulla South', 'Badulla South'),
('Ashani', 'Nanayakkara', 'ashani.nanayakkara164@yahoo.lk', '+94781000164', 'No. 164, Cinnamon Lane, Colombo 1', 'Colombo 1'),
('Kavisha', 'Dushyantha', 'kavisha.dushyantha165@slnet.lk', '+94751000165', 'No. 165, Temple Road, Kandy Central', 'Kandy Central'),
('Sahan', 'Rathnayake', 'sahan.rathnayake166@gmail.lk', '+94711000166', 'No. 166, Beachfront Lane, Galle North', 'Galle North'),
('Nimasha', 'Peris', 'nimasha.peris167@yahoo.lk', '+94761000167', 'No. 167, Fish Market Road, Negombo East', 'Negombo East'),
('Thilina', 'Wijewardena', 'thilina.wijewardena168@slnet.lk', '+94771000168', 'No. 168, Lakefront Road, Kurunegala South', 'Kurunegala South'),
('Yasodara', 'Senadheera', 'yasodara.senadheera169@gmail.lk', '+94781000169', 'No. 169, Coastal Lane, Trincomalee East', 'Trincomalee East'),
('Chandana', 'Amarasekera', 'chandana.amarasekera170@yahoo.lk', '+94751000170', 'No. 170, Gem City Road, Ratnapura West', 'Ratnapura West'),
('Sithara', 'Weerasekara', 'sithara.weerasekara171@slnet.lk', '+94711000171', 'No. 171, Surf Road, Matara North', 'Matara North'),
('Nadeeka', 'Gunasekera', 'nadeeka.gunasekera172@gmail.lk', '+94761000172', 'No. 172, Ruins Lane, Anuradhapura Town', 'Anuradhapura Town'),
('Ruwanthi', 'Salgado', 'ruwanthi.salgado173@yahoo.lk', '+94771000173', 'No. 173, Hill Lane, Badulla North', 'Badulla North'),
('Amal', 'Palihawadana', 'amal.palihawadana174@slnet.lk', '+94781000174', 'No. 174, Park Road, Colombo 2', 'Colombo 2'),
('Shashika', 'Adhikari', 'shashika.adhikari175@gmail.lk', '+94751000175', 'No. 175, Lake View Road, Kandy West', 'Kandy West'),
('Tharaka', 'Wijesekara', 'tharaka.wijesekara176@yahoo.lk', '+94711000176', 'No. 176, Ocean Road, Galle Central', 'Galle Central'),
('Nisansala', 'Hewavitharana', 'nisansala.hewavitharana177@slnet.lk', '+94761000177', 'No. 177, Market Road, Negombo Town', 'Negombo Town'),
('Sankalpa', 'Munasinghe', 'sankalpa.munasinghe178@gmail.lk', '+94771000178', 'No. 178, City View, Kurunegala North', 'Kurunegala North'),
('Yasith', 'Kariyawasam', 'yasith.kariyawasam179@yahoo.lk', '+94781000179', 'No. 179, Beach Lane, Trincomalee West', 'Trincomalee West'),
('Anuradha', 'Rathnayaka', 'anuradha.rathnayaka180@slnet.lk', '+94751000180', 'No. 180, Gem Market Road, Ratnapura Central', 'Ratnapura Central'),
('Chamari', 'Lakshan', 'chamari.lakshan181@gmail.lk', '+94711000181', 'No. 181, Coastal Road, Matara East', 'Matara East'),
('Nipun', 'Wickramaratne', 'nipun.wickramaratne182@yahoo.lk', '+94761000182', 'No. 182, Sacred City Road, Anuradhapura West', 'Anuradhapura West'),
('Sashika', 'Abeyratne', 'sashika.abeyratne183@slnet.lk', '+94771000183', 'No. 183, Valley Lane, Badulla East', 'Badulla East'),
('Thushari', 'Dissanayaka', 'thushari.dissanayaka184@gmail.lk', '+94781000184', 'No. 184, Cinnamon View, Colombo 3', 'Colombo 3'),
('Rangana', 'Kulasekara', 'rangana.kulasekara185@yahoo.lk', '+94751000185', 'No. 185, Temple Lane, Kandy Central', 'Kandy Central'),
('Sewmini', 'Jayaratne', 'sewmini.jayaratne186@slnet.lk', '+94711000186', 'No. 186, Beach Road, Galle North', 'Galle North'),
('Kanchana', 'Wijerathna', 'kanchana.wijerathna187@gmail.lk', '+94761000187', 'No. 187, Fish Market Road, Negombo East', 'Negombo East'),
('Sanjula', 'Hewapathirana', 'sanjula.hewapathirana188@yahoo.lk', '+94771000188', 'No. 188, Lakefront Road, Kurunegala South', 'Kurunegala South'),
('Nimali', 'Senanayaka', 'nimali.senanayaka189@slnet.lk', '+94781000189', 'No. 189, Coastal Lane, Trincomalee East', 'Trincomalee East'),
('Chathuri', 'Ekanayaka', 'chathuri.ekanayaka190@gmail.lk', '+94751000190', 'No. 190, Gem City Road, Ratnapura West', 'Ratnapura West'),
('Sasindu', 'Gunathilaka', 'sasindu.gunathilaka191@yahoo.lk', '+94711000191', 'No. 191, Surf Lane, Matara North', 'Matara North'),
('Niranjala', 'Weerakoon', 'niranjala.weerakoon192@slnet.lk', '+94761000192', 'No. 192, Ruins View, Anuradhapura Town', 'Anuradhapura Town'),
('Tharusha', 'Samarawickrama', 'tharusha.samarawickrama193@gmail.lk', '+94771000193', 'No. 193, Hill View, Badulla North', 'Badulla North'),
('Ashen', 'Ranathunga', 'ashen.ranathunga194@yahoo.lk', '+94781000194', 'No. 194, Park Lane, Colombo 4', 'Colombo 4'),
('Sampath', 'Wijethunga', 'sampath.wijethunga195@slnet.lk', '+94751000195', 'No. 195, Lake Road, Kandy West', 'Kandy West'),
('Nadeeshani', 'Amarasuriya', 'nadeeshani.amarasuriya196@gmail.lk', '+94711000196', 'No. 196, Ocean Lane, Galle Central', 'Galle Central'),
('Ruwantha', 'Kotalawala', 'ruwantha.kotalawala197@yahoo.lk', '+94761000197', 'No. 197, Market View, Negombo Town', 'Negombo Town'),
('Tharindi', 'Liyanarachchi', 'tharindi.liyanarachchi198@slnet.lk', '+94771000198', 'No. 198, City Road, Kurunegala North', 'Kurunegala North'),
('Nisal', 'Abeykoon', 'nisal.abeykoon199@gmail.lk', '+94781000199', 'No. 199, Beach Lane, Trincomalee West', 'Trincomalee West'),
('Sanjani', 'Wickramasingha', 'sanjani.wickramasingha200@yahoo.lk', '+94751000200', 'No. 200, Gem Road, Ratnapura Central', 'Ratnapura Central'),
('Lasantha', 'Kodagoda', 'lasantha.kodagoda201@gmail.lk', '+94711000201', 'No. 201, Nawala Road, Colombo Wellawatte', 'Colombo Wellawatte'),
('Sharmila', 'Sivanesan', 'sharmila.sivanesan202@yahoo.lk', '+94761000202', 'No. 202, Point Pedro Road, Jaffna Chunnakam', 'Jaffna Chunnakam'),
('Duminda', 'Athukorala', 'duminda.athukorala203@slnet.lk', '+94771000203', 'No. 203, Digana Road, Kandy Digana', 'Kandy Digana'),
('Zainab', 'Hameed', 'zainab.hameed204@gmail.lk', '+94781000204', 'No. 204, Lewis Place, Negombo Katunayake', 'Negombo Katunayake'),
('Vijay', 'Thirugnanasambanthar', 'vijay.thirugnanasambanthar205@yahoo.lk', '+94751000205', 'No. 205, Beach Road, Galle Ahangama', 'Galle Ahangama'),
('Sriyani', 'Walgama', 'sriyani.walgama206@slnet.lk', '+94711000206', 'No. 206, Dambulla Road, Kurunegala Mallawapitiya', 'Kurunegala Mallawapitiya'),
('Faheem', 'Rauff', 'faheem.rauff207@gmail.lk', '+94761000207', 'No. 207, Pigeon Island Road, Trincomalee Kinniya', 'Trincomalee Kinniya'),
('Keshani', 'Godamunne', 'keshani.godamunne208@yahoo.lk', '+94771000208', 'No. 208, Pedro Estate, Nuwara Eliya Kandapola', 'Nuwara Eliya Kandapola'),
('Senthuran', 'Yogarajah', 'senthuran.yogarajah209@slnet.lk', '+94781000209', 'No. 209, Kallady Road, Batticaloa Kallady', 'Batticaloa Kallady'),
('Nishad', 'Shafeek', 'nishad.shafeek210@gmail.lk', '+94751000210', 'No. 210, Samanala Road, Ratnapura Eheliyagoda', 'Ratnapura Eheliyagoda'),
('Samanthi', 'Udawatte', 'samanthi.udawatte211@yahoo.lk', '+94711000211', 'No. 211, Star Fort Road, Matara Weligambay', 'Matara Weligambay'),
('Nishantha', 'Kulatunga', 'nishantha.kulatunga212@slnet.lk', '+94761000212', 'No. 212, Mihintale Road, Anuradhapura Mihintale', 'Anuradhapura Mihintale'),
('Aqeela', 'Niyas', 'aqeela.niyas213@gmail.lk', '+94771000213', 'No. 213, Uva Road, Badulla Demodara', 'Badulla Demodara'),
('Sajith', 'Madanayake', 'sajith.madanayake214@yahoo.lk', '+94781000214', 'No. 214, Kirulapone Road, Colombo Havelock', 'Colombo Havelock'),
('Raveena', 'Sivakumaran', 'raveena.sivakumaran215@slnet.lk', '+94751000215', 'No. 215, Katheeswaran Road, Jaffna Kopay', 'Jaffna Kopay'),
('Rohana', 'Piyadasa', 'rohana.piyadasa216@gmail.lk', '+94711000216', 'No. 216, Menikdiwela Road, Kandy Menikdiwela', 'Kandy Menikdiwela'),
('Nusrath', 'Jaleel', 'nusrath.jaleel217@yahoo.lk', '+94761000217', 'No. 217, Porutota Road, Negombo Kochchikade', 'Negombo Kochchikade'),
('Kavitharan', 'Nadesan', 'kavitharan.nadesan218@slnet.lk', '+94771000218', 'No. 218, Talpe Road, Galle Habaraduwa', 'Galle Habaraduwa'),
('Indrani', 'Senevirathne', 'indrani.senevirathne219@gmail.lk', '+94781000219', 'No 219, Polgahawela Road, Kurunegala Polgaha', 'Kurunegala Polgaha'),
('Shihan', 'Zacky', 'shihan.zacky220@yahoo.lk', '+94751000220', 'No. 220, Pulmoddai Road, Trincomalee Pulmoddai', 'Trincomalee Pulmoddai'),
('Sachithra', 'Wimalarathna', 'sachithra.wimalarathna221@slnet.lk', '+94711000221', 'No. 221, Hatton Road, Nuwara Eliya Hatton', 'Nuwara Eliya Hatton'),
('Vithuran', 'Sivagnanam', 'vithuran.sivagnanam222@gmail.lk', '+94761000222', 'No. 222, Eravur Road, Batticaloa Eravur', 'Batticaloa Eravur'),
('Fazna', 'Hussain', 'fazna.hussain223@yahoo.lk', '+94771000223', 'No. 223, Pelmadulla Road, Ratnapura Pelmadulla', 'Ratnapura Pelmadulla'),
('Danushka', 'Wickramarachchi', 'danushka.wickramarachchi224@slnet.lk', '+94781000224', 'No. 224, Dikwella Road, Matara Dikwella', 'Matara Dikwella'),
('Padmini', 'Wickramapala', 'padmini.wickramapala225@gmail.lk', '+94751000225', 'No. 225, Jaya Road, Anuradhapura Jaya', 'Anuradhapura Jaya'),
('Shameer', 'Rizvi', 'shameer.rizvi226@yahoo.lk', '+94711000226', 'No. 226, Passara Road, Badulla Passara', 'Badulla Passara'),
('Thilak', 'Wimalasena', 'thilak.wimalasena227@slnet.lk', '+94761000227', 'No. 227, Baseline Road, Colombo Borella', 'Colombo Borella'),
('Nirojan', 'Kandiah', 'nirojan.kandiah228@gmail.lk', '+94771000228', 'No. 228, Vaddukodai Road, Jaffna Vaddukodai', 'Jaffna Vaddukodai'),
('Chamila', 'Hapuarachchi', 'chamila.hapuarachchi229@yahoo.lk', '+94781000229', 'No. 229, Katugastota Road, Kandy Katugastota', 'Kandy Katugastota'),
('Rifka', 'Nazeem', 'rifka.nazeem230@slnet.lk', '+94751000230', 'No. 230, Eththukala Road, Negombo Eththukala', 'Negombo Eththukala'),
('Sujeevan', 'Sivalingam', 'sujeevan.sivalingam231@gmail.lk', '+94711000231', 'No. 231, Koggala Road, Galle Koggala', 'Galle Koggala'),
('Kusum', 'Ranaweera', 'kusum.ranaweera232@yahoo.lk', '+94761000232', 'No. 232, Wariyapola Road, Kurunegala Wariyapola', 'Kurunegala Wariyapola'),
('Imthiyas', 'Saleem', 'imthiyas.saleem233@slnet.lk', '+94771000233', 'No. 233, Kuchchaveli Road, Trincomalee Kuchchaveli', 'Trincomalee Kuchchaveli'),
('Nadeera', 'Jayawardena', 'nadeera.jayawardena234@gmail.lk', '+94781000234', 'No. 234, Ambagahawatte Road, Nuwara Eliya Ambagaha', 'Nuwara Eliya Ambagaha'),
('Kajan', 'Nagaratnam', 'kajan.nagaratnam235@yahoo.lk', '+94751000235', 'No. 235, Valachchenai Road, Batticaloa Valachchenai', 'Batticaloa Valachchenai'),
('Rifath', 'Iqbal', 'rifath.iqbal236@slnet.lk', '+94711000236', 'No. 236, Balangoda Road, Ratnapura Balangoda', 'Ratnapura Balangoda'),
('Sunil', 'Wijesundara', 'sunil.wijesundara237@gmail.lk', '+94761000237', 'No. 237, Gandara Road, Matara Gandara', 'Matara Gandara'),
('Anoma', 'Kalansooriya', 'anoma.kalansooriya238@yahoo.lk', '+94771000238', 'No. 238, Thissa Road, Anuradhapura Thissa', 'Anuradhapura Thissa'),
('Nizam', 'Hafeel', 'nizam.hafeel239@slnet.lk', '+94781000239', 'No. 239, Ella Road, Badulla Ella', 'Badulla Ella'),
('Sampath', 'Hewawasam', 'sampath.hewawasam240@gmail.lk', '+94751000240', 'No. 240, Maradana Road, Colombo Maradana', 'Colombo Maradana'),
('Thivya', 'Sivapalan', 'thivya.sivapalan241@yahoo.lk', '+94711000241', 'No. 241, Karainagar Road, Jaffna Karainagar', 'Jaffna Karainagar'),
('Gamini', 'Wijegunawardena', 'gamini.wijegunawardena242@slnet.lk', '+94761000242', 'No. 242, Ampitiya Road, Kandy Ampitiya', 'Kandy Ampitiya'),
('Shazna', 'Faleel', 'shazna.faleel243@gmail.lk', '+94771000243', 'No. 243, Daluwakotuwa Road, Negombo Daluwakotuwa', 'Negombo Daluwakotuwa'),
('Nirmalan', 'Pathmanathan', 'nirmalan.pathmanathan244@yahoo.lk', '+94781000244', 'No. 244, Boossa Road, Galle Boossa', 'Galle Boossa'),
('Chandrika', 'Wimaladharma', 'chandrika.wimaladharma245@slnet.lk', '+94751000245', 'No. 245, Alawwa Road, Kurunegala Alawwa', 'Kurunegala Alawwa'),
('Azhar', 'Nawfer', 'azhar.nawfer246@gmail.lk', '+94711000246', 'No. 246, Sampur Road, Trincomalee Sampur', 'Trincomalee Sampur'),
('Sanjaya', 'Lakmal', 'sanjaya.lakmal247@yahoo.lk', '+94761000247', 'No. 247, Nanuoya Road, Nuwara Eliya Nanuoya', 'Nuwara Eliya Nanuoya'),
('Sivanesan', 'Thavarajah', 'sivanesan.thavarajah248@slnet.lk', '+94771000248', 'No. 248, Kattankudy Road, Batticaloa Kattankudy', 'Batticaloa Kattankudy'),
('Fazil', 'Jameel', 'fazil.jameel249@gmail.lk', '+94781000249', 'No. 249, Kalawana Road, Ratnapura Kalawana', 'Ratnapura Kalawana'),
('Nayanajith', 'Wickramathilaka', 'nayanajith.wickramathilaka250@yahoo.lk', '+94751000250', 'No. 250, Kapuwatte Road, Matara Kapuwatte', 'Matara Kapuwatte'),
('Ranjani', 'Subasinghe', 'ranjani.subasinghe251@slnet.lk', '+94711000251', 'No. 251, Saliya Road, Anuradhapura Saliya', 'Anuradhapura Saliya'),
('Rameez', 'Rahim', 'rameez.rahim252@gmail.lk', '+94761000252', 'No. 252, Haputale Road, Badulla Haputale', 'Badulla Haputale'),
('Suresh', 'Wanasinghe', 'suresh.wanasinghe253@yahoo.lk', '+94771000253', 'No. 253, Kollupitiya Road, Colombo Kollupitiya', 'Colombo Kollupitiya'),
('Kavitha', 'Sivathasan', 'kavitha.sivathasan254@slnet.lk', '+94781000254', 'No. 254, Manipay Road, Jaffna Manipay', 'Jaffna Manipay'),
('Asela', 'Gunawardhana', 'asela.gunawardhana255@gmail.lk', '+94751000255', 'No. 255, Kundasale Road, Kandy Kundasale', 'Kandy Kundasale'),
('Nafiya', 'Rasheed', 'nafiya.rasheed256@yahoo.lk', '+94711000256', 'No. 256, Kandawala Road, Negombo Kandawala', 'Negombo Kandawala'),
('Sutharsan', 'Sinniah', 'sutharsan.sinniah257@slnet.lk', '+94761000257', 'No. 257, Bentota Road, Galle Bentota', 'Galle Bentota'),
('Nalini', 'Kumari', 'nalini.kumari258@gmail.lk', '+94771000258', 'No. 258, Mawathagama Road, Kurunegala Mawathagama', 'Kurunegala Mawathagama'),
('Imran', 'Fawaz', 'imran.fawaz259@yahoo.lk', '+94781000259', 'No. 259, Mutur Road, Trincomalee Mutur', 'Trincomalee Mutur'),
('Tharanga', 'Weerathunga', 'tharanga.weerathunga260@slnet.lk', '+94751000260', 'No. 260, Dickoya Road, Nuwara Eliya Dickoya', 'Nuwara Eliya Dickoya'),
('Vijitharan', 'Raveendran', 'vijitharan.raveendran261@gmail.lk', '+94711000261', 'No. 261, Arugam Bay Road, Batticaloa Arugam', 'Batticaloa Arugam'),
('Shamila', 'Faizer', 'shamila.faizer262@yahoo.lk', '+94761000262', 'No. 262, Embilipitiya Road, Ratnapura Embilipitiya', 'Ratnapura Embilipitiya'),
('Ruwan', 'Jayasundara', 'ruwan.jayasundara263@slnet.lk', '+94771000263', 'No. 263, Walahanduwa Road, Matara Walahanduwa', 'Matara Walahanduwa'),
('Suneetha', 'Galappaththi', 'suneetha.galappaththi264@gmail.lk', '+94781000264', 'No. 264, Nuwara Road, Anuradhapura Nuwara', 'Anuradhapura Nuwara'),
('Nazeer', 'Hameem', 'nazeer.hameem265@yahoo.lk', '+94751000265', 'No. 265, Bandarawela Road, Badulla Bandarawela', 'Badulla Bandarawela'),
('Nandana', 'Amarathunga', 'nandana.amarathunga266@slnet.lk', '+94711000266', 'No. 266, Dematagoda Road, Colombo Dematagoda', 'Colombo Dematagoda'),
('Thayalini', 'Vijayakumar', 'thayalini.vijayakumar267@gmail.lk', '+94761000267', 'No. 267, Tellippalai Road, Jaffna Tellippalai', 'Jaffna Tellippalai'),
('Sumith', 'Dissanayake', 'sumith.dissanayake268@yahoo.lk', '+94771000268', 'No. 268, Gampola Road, Kandy Gampola', 'Kandy Gampola'),
('Fathima', 'Shukri', 'fathima.shukri269@slnet.lk', '+94781000269', 'No. 269, Palali Road, Negombo Palali', 'Negombo Palali'),
('Sivashankar', 'Tharmalingam', 'sivashankar.tharmalingam270@gmail.lk', '+94751000270', 'No. 270, Ambalangoda Road, Galle Ambalangoda', 'Galle Ambalangoda'),
('Kanthi', 'Jayasekara', 'kanthi.jayasekara271@yahoo.lk', '+94711000271', 'No. 271, Kuliyapitiya Road, Kurunegala Kuliyapitiya', 'Kurunegala Kuliyapitiya'),
('Rizwan', 'Mansoor', 'rizwan.mansoor272@slnet.lk', '+94761000272', 'No. 272, Seruvila Road, Trincomalee Seruvila', 'Trincomalee Seruvila'),
('Sadeepa', 'Wijesuriya', 'sadeepa.wijesuriya273@gmail.lk', '+94771000273', 'No. 273, Talawakelle Road, Nuwara Eliya Talawakelle', 'Nuwara Eliya Talawakelle'),
('Niroshan', 'Sivapragasam', 'niroshan.sivapragasam274@yahoo.lk', '+94781000274', 'No. 274, Pottuvil Road, Batticaloa Pottuvil', 'Batticaloa Pottuvil'),
('Nihara', 'Jalaldeen', 'nihara.jalaldeen275@slnet.lk', '+94751000275', 'No. 275, Kuruwita Road, Ratnapura Kuruwita', 'Ratnapura Kuruwita'),
('Ranjith', 'Somasiri', 'ranjith.somasiri276@gmail.lk', '+94711000276', 'No. 276, Akuressa Road, Matara Akuressa', 'Matara Akuressa'),
('Wasantha', 'Kumuduni', 'wasantha.kumuduni277@yahoo.lk', '+94761000277', 'No. 277, Kekirawa Road, Anuradhapura Kekirawa', 'Anuradhapura Kekirawa'),
('Ameen', 'Shafeer', 'ameen.shafeer278@slnet.lk', '+94771000278', 'No. 278, Mahiyangana Road, Badulla Mahiyangana', 'Badulla Mahiyangana'),
('Chandana', 'Perera', 'chandana.perera279@gmail.lk', '+94781000279', 'No. 279, Rajagiriya Road, Colombo Rajagiriya', 'Colombo Rajagiriya'),
('Sangeetha', 'Sivarajah', 'sangeetha.sivarajah280@yahoo.lk', '+94751000280', 'No. 280, Chavakachcheri Road, Jaffna Chavakachcheri', 'Jaffna Chavakachcheri'),
('Sarath', 'Weerakoon', 'sarath.weerakoon281@slnet.lk', '+94711000281', 'No. 281, Nawalapitiya Road, Kandy Nawalapitiya', 'Kandy Nawalapitiya'),
('Nuzha', 'Hameed', 'nuzha.hameed282@gmail.lk', '+94761000282', 'No. 282, Katunayake Road, Negombo Seeduwa', 'Negombo Seeduwa'),
('Sivakumaran', 'Nadaraja', 'sivakumaran.nadaraja283@yahoo.lk', '+94771000283', 'No. 283, Beruwala Road, Galle Beruwala', 'Galle Beruwala'),
('Nirmala', 'Gunathilake', 'nirmala.gunathilake284@slnet.lk', '+94781000284', 'No. 284, Pannala Road, Kurunegala Pannala', 'Kurunegala Pannala'),
('Ramees', 'Niyas', 'ramees.niyas285@gmail.lk', '+94751000285', 'No. 285, Kantale Road, Trincomalee Kantale', 'Trincomalee Kantale'),
('Dilruk', 'Weerasingha', 'dilruk.weerasingha286@yahoo.lk', '+94711000286', 'No. 286, Ragala Road, Nuwara Eliya Ragala', 'Nuwara Eliya Ragala'),
('Sivathas', 'Sivaneswaran', 'sivathas.sivaneswaran287@slnet.lk', '+94761000287', 'No. 287, Kalmunai Road, Batticaloa Kalmunai', 'Batticaloa Kalmunai'),
('Shameem', 'Rifai', 'shameem.rifai288@gmail.lk', '+94771000288', 'No. 288, Rakwana Road, Ratnapura Rakwana', 'Ratnapura Rakwana'),
('Nimal', 'Jayakody', 'nimal.jayakody289@yahoo.lk', '+94781000289', 'No. 289, Deniyaya Road, Matara Deniyaya', 'Matara Deniyaya'),
('Sujatha', 'Abeysekara', 'sujatha.abeysekara290@slnet.lk', '+94751000290', 'No. 290, Medawachchiya Road, Anuradhapura Medawachchiya', 'Anuradhapura Medawachchiya'),
('Fawzul', 'Azeez', 'fawzul.azeez291@gmail.lk', '+94711000291', 'No. 291, Welimada Road, Badulla Welimada', 'Badulla Welimada'),
('Lalith', 'Edirisinghe', 'lalith.edirisinghe292@yahoo.lk', '+94761200292', 'No. 292, Pettah Road, Colombo Pettah', 'Colombo Pettah'),
('Nirusha', 'Sivapatham', 'nirusha.sivapatham293@slnet.lk', '+94771000293', 'No. 293, Uduvil Road, Jaffna Uduvil', 'Jaffna Uduvil'),
('Upul', 'Samarasekara', 'upul.samarasekara294@gmail.lk', '+94781000294', 'No. 294, Gelioya Road, Kandy Gelioya', 'Kandy Gelioya'),
('Zahra', 'Fazal', 'zahra.fazal295@yahoo.lk', '+94751000295', 'No. 295, Minuwangoda Road, Negombo Minuwangoda', 'Negombo Minuwangoda'),
('Sivajothy', 'Sivakumaran', 'sivajothy.sivakumaran296@slnet.lk', '+94711000296', 'No. 296, Hikkaduwa Road, Galle Hikkaduwa', 'Galle Hikkaduwa'),
('Ranjani', 'Wickramasuriya', 'ranjani.wickramasuriya297@gmail.lk', '+94761000297', 'No. 297, Ibbagamuwa Road, Kurunegala Ibbagamuwa', 'Kurunegala Ibbagamuwa'),
('Nawaz', 'Ismail', 'nawaz.ismail298@yahoo.lk', '+94771000298', 'No. 298, Nilaveli Road, Trincomalee Nilaveli', 'Trincomalee Nilaveli'),
('Sampath', 'Gunasekera', 'sampath.gunasekera299@slnet.lk', '+94781000299', 'No. 299, Pundaluoya Road, Nuwara Eliya Pundaluoya', 'Nuwara Eliya Pundaluoya'),
('Sivaneswaran', 'Sivapalan', 'sivaneswaran.sivapalan300@gmail.lk', '+94751000300', 'No. 300, Akkaraipattu Road, Batticaloa Akkaraipattu', 'Batticaloa Akkaraipattu'),
('Rifka', 'Nazeer', 'rifka.nazeer301@yahoo.lk', '+94711000301', 'No. 301, Godakawela Road, Ratnapura Godakawela', 'Ratnapura Godakawela'),
('Nishantha', 'Rathnapala', 'nishantha.rathnapala302@slnet.lk', '+94761000302', 'No. 302, Hakmana Road, Matara Hakmana', 'Matara Hakmana'),
('Kumuduni', 'Abeywickrama', 'kumuduni.abeywickrama303@gmail.lk', '+94771000303', 'No. 303, Galaha Road, Kandy Galaha', 'Peradeniya'),
('Azeem', 'Rahuman', 'azeem.rahuman304@yahoo.lk', '+94781000304', 'No. 304, Thalawathugoda Road, Colombo Thalawatta', 'Colombo Thalawatta'),
('Tharani', 'Sivapragash', 'tharani.sivapragash305@slnet.lk', '+94751000305', 'No. 305, Valvettithurai Road, Jaffna Valvettithurai', 'Jaffna Valvettithurai'),
('Wasantha', 'Hewage', 'wasantha.hewage306@gmail.lk', '+94711000306', 'No. 306 , No 306, Badulla Road, Badulla', 'Badulla'),
('Shamila', 'Jiffry', 'shamila.jiffry307@yahoo.lk', '+94761000307', 'No. 307, Dondra Road, Matara Dondra', 'Matara Dondra'),
('Sivakumaran', 'Nadesan', 'sivakumaran.nadesan308@slnet.lk', '+94771000308', 'No. 308, Wennappuwa Road, Negombo Wennappuwa', 'Negombo Wennappuwa'),
('Nayana', 'Sumanadasa', 'nayana.sumanadasa309@gmail.lk', '+94781000309', 'No. 309, Induruwa Road, Galle Induruwa', 'Galle Induruwa'),
('Saman', 'Jayalath', 'saman.jayalath310@yahoo.lk', '+94751000310', 'No. 310, Mawanella Road, Kandy Mawanella', 'Kandy Mawanella'),
('Fathima', 'Nizar', 'fathima.nizar311@slnet.lk', '+94711000311', 'No. 311, No 311, Kirindiwela', 'Colombo Kirindi'),
('Nishadi', 'Wickramapala', 'nishadi.wickramapala312@yahoo.lk', '+94761000312', 'No. 312, Ginigathhena Road, Nuwara Eliya Ginigathhena', 'Nuwara Eliya Ginigathhena'),
('Sivaneswar', 'Sivapalan', 'sivaneswar.sivapalan313@slnet.lk', '+94771000313', 'No. 313, Sainthamaruthu Road, Batticaloa Sainthamaruthu', 'Batticaloa Sainthamaruthu'),
('Rifaz', 'Niyas', 'rifaz.niyas314@gmail.lk', '+94781000314', 'No. 314, Opanayake Road, Ratnapura Opanayake', 'Ratnapura Opanayake'),
('Ruwan', 'Samarajeewa', 'ruwan.samarajeewa315@yahoo.lk', '+94751000315', 'No. 315, Kamburupitiya Road, Matara Kamburupitiya', 'Matara Kamburupitiya'),
('Suneetha', 'Galappatti', 'suneetha.galappatti316@slnet.lk', '+94711000316', 'No. 316, Horana', 'Colombo Horana'),
('Nazeem', 'Hameem', 'nazeem.hameem317@gmail.lk', '+94762000317', 'No. 317, Habarana Road, Anuradhapura Habarana', 'Anuradhapura Habarana'),
('Nandana', 'Amarathunga', 'nandana.amarathunga318@yahoo.lk', '+94761100318', 'No. 318, Soratha Mawatha Road, Badulla', 'Badulla Soratha'),
('Thayalini', 'Vijayakumaran', 'thayalini.vijayakumaran319@slnet.lk', '+94781000319', 'No. 319, Velanai Road, Jaffna Velanai', 'Jaffna Velanai'),
('Sarath', 'Weerasekera', 'sarath.weerasekera320@gmail.lk', '+94751000320', 'No. 320, Kadugannawa Road, Kandy Kadugannawa', 'Kandy Kadugannawa'),
('Nuzha', 'Hamid', 'nuzha.hamid321@yahoo.lk', '+94711000321', 'No. 321, Jaela Road, Negombo Jaela', 'Negombo Jaela'),
('Sivakumaran', 'Nadarajah', 'sivakumaran.nadarajah322@slnet.lk', '+94761000322', 'No. 322, Balapitiya', 'Galle Balapitiya'),
('Nirmala', 'Gunathilaka', 'nirmala.gunathilaka323@gmail.lk', '+94771000323', 'No. 323, Nikaweratiya Road, Kurunegala Nikaweratiya', 'Kurunegala Nikaweratiya'),
('Ramees', 'Niyaz', 'ramees.niyaz324@yahoo.lk', '+94781000324', 'No. 324, Uppuveli Road, Trincomalee Uppuveli', 'Trincomalee Uppuveli'),
('Dilruk', 'Weerasinghe', 'dilruk.weerasinghe325@slnet.lk', '+94751000325', 'No. 325, Dayagama Road, Nuwara Eliya Dayagama', 'Nuwara Eliya Dayagama'),
('Sivathasan', 'Sivaneswaran', 'sivathasan.sivaneswaran326@gmail.lk', '+94711000326', 'No. 326, Ampara Road, Batticaloa Ampara', 'Batticaloa Ampara'),
('Shameem', 'Rifai', 'shameem.rifai327@yahoo.lk', '+94761000327', 'No. 327, Madampe Road', 'Ratnapura Madam'),
('Nimal', 'Jayakodi', 'nimal.jayakodi328@slnet.lk', '+94771000328', 'No. 328, Tissamaharama Road, Matara Tissamaharama', 'Matara Tissamaharama'),
('Sujatha', 'Abeysekera', 'sujatha.abeysekera329@slnet.lk', '+94781000329', 'No. 329, Gampaha', 'Colombo Gampaha'),
('Fawaz', 'Azeez', 'fawaz.azeez330@yahoo.lk', '+94791000330', 'No. 330, Diyatalawa Road, Badulla Diyatalawa', 'Badulla Diyatalawa'),
('Lalith', 'Edirisingha', 'lalith.edirisingha331@slnet.lk', '+94751000331', 'No. 331, Maligawatta Road, Colombo Maligawatta', 'Colombo Maligawatta'),
('Nirusha', 'Sivapathan', 'nirusha.sivapathan332@gmail.lk', '+94711000332', 'No. 332, Anaicoddai Road, Jaffna Anaicoddai', 'Jaffna Anaicoddai'),
('Upul', 'Samarasinghe', 'upul.samarasinghe333@slnet.lk', '+94761000333', 'No. 333, Peradeniya Road', 'Kandy Peradeniya'),
('Zahira', 'Anver', 'zahira.anver334@yahoo.lk', '+94771000334', 'No. 334, Chilaw Road', 'Negombo Chilaw'),
('Sivajothi', 'Sivakumara', 'sivajothi.sivakumara335@slnet.lk', '+94781000335', 'No. 335, Elpitiya Road', 'Galle Elpitiya'),
('Ranjaya', 'Wickramasinghe', 'ranjaya.wickramasinghe336@gmail.lk', '+94751000336','No 336, Town', 'Kurunegala Town'),
('Nawas', 'Ismael', 'nawas.ismael337@yahoo.lk', '+94711000337','No 337, Town', 'Trincomalee Town'),
('Sampatha', 'Gunasekara', 'sampatha.gunasekara338@slnet.lk', '+94761000338', 'No. 338, Lindula Road, Nuwara Eliya Lindula', 'Nuwara Eliya Lindula'),
('Sivaneswara', 'Sivapala', 'sivaneswara.sivapala339@slnet.lk', '+94771000339', 'No. 339, Oddamavadi Road, Batticaloa Oddamavadi', 'Batticaloa Oddamavadi'),
('Rifka', 'Nazeer', 'rifka.nazeer@340@gmail.lk', '+94781000340', 'No 340, Town', 'Ratnapura Town'),
('Nishantha', 'Rathnayaka', 'nishantha.rathnayaka341@slnet.lk', '+94751000341', 'No. 341, Walasmulla Road, Matara Walasmulla', 'Matara Walasmulla'),
('Kumuduni', 'Abeywickrama', 'kumuduni.abeywickrama342@slnet.lk', '+94711000342','No 342, Town', 'Anuradhapura Town'),
('Azeem', 'Rahuman', 'azeem.rahuman343@slnet.lk', '+94761000343','No 343, Town', 'Badulla Town'),
('Tharani', 'Sivapragasam', 'tharani.sivapragasam344@yahoo.lk', '+94771000344','No 344, Town', 'Colombo Town'),
('Wasantha', 'Hewa', 'wasantha.h@345@gmail.lk', '+94781000345','No 345, Town', 'Jaffna Town'),
('Shamila', 'Jiffrey', 'shamila.jiffrey346@slnet.lk', '+94751000346','No 346, Town', 'Kandy Town'),
('Sivakumaran', 'Nadeesan', 'sivakumaran.nadeesan347@slnet.lk', '+94711000347','No 347, Town', 'Negombo Town'),
('Nayana', 'Sumanadas', 'nayana.sumanadas348@slnet.lk', '+94761000348','No 348, Town', 'Galle Town'),
('Saman', 'Jayalatha', 'saman.jayalatha349@slnet.lk', '+94771000349','No 349, Town', 'Kurunegala'),
('Fathima', 'Nizwar', 'fathima.nizwar@350@slnet.lk', '+94781000350','No 350, Town', 'Trincomalee'),
('Nishadi', 'Wikala', 'nishadi.wikala351@slnet.lk', '+94751000351','No 351, Town', 'Nuwara Eliya'),
('Sivaneswar', 'Sivapalan', 'sivaneswar.sivapalan352@slnet.lk', '+94761000352','No 352, Town', 'Batticaloa'),
('Rifaz', 'Niaz', 'rifaz.niaz353@slnet.lk', '+94771000353','No 353, Town', 'Ratnapura'),
('Ruwan', 'Samarajeewa', 'ruwan.samarajeewa354@slnet.lk', '+94781000354','No 354, Town', 'Matara'),
('Suneeta', 'Galapappatti', 'suneeta.galapappatti355@slnet.lk', '+94751000355','No 355, Town', 'Anuradhapura'),
('Nazeem', 'Hameem', 'nazeem.hameem356@slnet.lk', '+94711000356','No 356, Town', 'Badulla'),
('Nandana', 'Amarathu', 'nandana.amarathu357@slnet.lk', '+94761000357','No 357, Town', 'Colombo'),
('Thayalini', 'Vijayakumaran', 'thayalini.vijayakumaran358@slnet.lk', '+94771000358','No 358, Town', 'Jaffna'),
('Sampatha', 'Gunasekara', 'sampatha.gunasikekara338@slnet.lk', '+94761000338', 'No. 338, Lindula Road, Nuwara Eliya Lindula', 'Nuwara Eliya Lindula'),
('Nuzha', 'Nair', 'nuzha.nair360@slnet.lk', '+94751000360','No 360, Town', 'Negombo'),
('Sivakumaran', 'Nadarajah', 'sivakumaran.nadarajah361@slnet.lk', '+94761000361','No 361, Town', 'Galle'),
('Nirmala', 'Gunathilaka', 'nirmala.gunathilaka362@slnet.lk', '+9476100362','No 362, Town', 'Kurunegala'),
('Ramees', 'Niyaz', 'ramees.niyaz363@slnet.lk', '+947610363785','No 363, Town', 'Trincomalee'),
('Dilruk', 'Weerasinghe', 'dilruk.w@364@slnet.lk', '+947364452147','No 364, Town', 'Nuwara Eliya'),
('Sivathasan', 'Sivaneswaran', 'sivathasan.sivaneswaran365@slnet.lk', '+947365745896','No 365, Town', 'Batticaloa'),
('Shameem', 'Rifai', 'shameem.rifai366@slnet.lk', '+9473664578','No 366, Town', 'Ratnapura'),
('Nimal', 'Jayakodi', 'nimal.jayakodi367@slnet.lk', '+94711000401', 'No 367, Town', 'Matara'),
('Sujatha', 'Abeysekera', 'sujatha.abeysekera368@slnet.lk', '+94771000401','No 368, Town', 'Anuradhapura'),
('Fawaz', 'Azeez', 'fawaz.azeez369@slnet.lk', '+94710000401','No 369, Town', 'Badulla'),
('Lalith', 'Edirisingha', 'lalith.edirisingha370@slnet.lk', '+947378785570','No 370, Town', 'Colombo'),
('Nirusha', 'Sivapatan', 'nirusha.sivapatan371@slnet.lk', '+947377854121','No 371, Town', 'Jaffna'),
('Upul', 'Samarasinghe', 'upul.samarasinghe372@slnet.lk', '+947374589622','No 372, Town', 'Kandy'),
('Zahira', 'Anver', 'zahira.anver373@slnet.lk', '+947785478373','No 373, Town', 'Negombo'),
('Sivajothi', 'Sivakumara', 'sivajothi.sivakumara374@slnet.lk', '+947345213674','No 374, Town', 'Galle'),
('Ranjaya', 'Wickramasinghe', 'ranjaya.wickramasinghe375@slnet.lk', '+947347854775','No 375, Town', 'Kurunegala'),
('Nawas', 'Ismael', 'nawas.ismael376@slnet.lk', '+947345782376', 'No 376, Town', 'Trincomala'),
('Sampatha', 'Gunasekara', 'sampatha.gunasekara377@slnet.lk', '+947378452177','No 377, Town', 'Nuwara Elia'),
('Sivaneswara', 'Sivapala', 'sivaneswara.sivapala378@slnet.lk', '+947378457978','No 378, Town', 'Batticala'),
('Rifka', 'Nazeer', 'rifka.nazeer379@slnet.lk', '+947345789679','No 379, Town', 'Ratnapura'),
('Nishantha', 'Rathnayaka', 'nishantha.rathnayaka380@slnet.lk', '+947457896380','No 380, Town', 'Matara'),
('Kumuduni', 'Abeywickrama', 'kumuduni.abeywickrama381@slnet.lk', '+947345258681','No 381, Town', 'Anuradhap'),
('Azeem', 'Rahuman', 'azeem.rahuman382@slnet.lk', '+947457896382','No 382, Town', 'Badulla'),
('Tharani', 'Sivapragasam', 'tharani.sivapragasam383@slnet.lk', '+94256387383','No 383, Town', 'Colombo'),
('Wasantha', 'Hewa', 'wasantha.h384@wa', '+947457823384','No 384, Town', 'Jaffna'),
('Shamila', 'Jiffry', 'shamila.jiffry385@slnet.lk', '+94258963385','No 385, Town', 'Kandy'),
('Sivakumaran', 'Nadeesan', 'sivakumaran.nadeesan386@slnet.lk', '+947378547886','No 386, Town', 'Negombo'),
('Nayana', 'Sumanadas', 'nayana.sumanadas387@slnet.lk', '+947378458587','No 387, Town', 'Galle'),
('Saman', 'Jayalatha', 'saman.jayalatha388@slnet.lk', '+947478512388','No 388, Town', 'Kurunegala'),
('Fathima', 'Nizwar', 'fathima.nizwar389@slnet.lk', '+947345789989', 'No 389, Town', 'Trincomale'),
('Nishadi', 'Wikala', 'nishadi.wikala390@slnet.lk', '+947345789690','No 390, Town', 'Nuwara Eli'),
('Sivaneswar', 'Sivapalan', 'sivaneswar.sivapalan391@slnet.lk', '+947457891394','No 391, Town', 'Batticalo'),
('Rifaz', 'Niaz', 'rifaz.niaz392@slnet.lk', '+947457898394', 'No 392, Town', 'Ratnapura'),
('Ruwan', 'Samarajeewa', 'ruwan.samarajeewa393@slnet.lk', '+947457894394','No 393, Town', 'Matara'),
('Suneeta', 'Galapappatti', 'suneeta.galapappatti394@slnet.lk', '+947457894394','No 394, Town', 'Anuradhapu'),
('Nazeem', 'Hameem', 'nazeem.hameem395@slnet.lk', '+947312354795', 'No 395, Town', 'Badulla'),
('Nandana', 'Amarathu', 'nandana.amarathu396@slnet.lk', '+944789658396','No 396, Town', 'Colombo'),
('Thayalini', 'Vijayakumaran', 'thayalini.vijayakumaran397@slnet.lk', '+94771000405', 'No 397, Town', 'Jaffna'),
('Sarath', 'Weeraseasinghe', 'sarath.weeraseasinghe398@slnet.lk', '+947570004075','No 398, Town', 'Kandy'),
('Nuzha', 'Nair', 'nuzha.nair399@slnet.lk', '+94751000401','No 399, Town', 'Negombo'),
('Sivakumaran', 'Nadarajah', 'sivakumaran.nadarajah400@slnet.lk', '+94741234500','No 400, Town', 'Galle'),
('Nimal', 'Thushara', 'nimal.thushara401@gmail.lk', '+94711000401', 'No. 401, High Level Road, Colombo Nugegoda', 'Colombo Nugegoda'),
('Shanika', 'Sivapalan', 'shanika.sivapalan402@yahoo.lk', '+94761000402', 'No. 402, Ariyalai Road, Jaffna Ariyalai', 'Jaffna Ariyalai'),
('Ruwan', 'Liyanage', 'ruwan.liyanage403@slnet.lk', '+94771000403', 'No. 403, Wattegama Road, Kandy Wattegama', 'Kandy Wattegama'),
('Fathima', 'Azlam', 'fathima.azlam404@gmail.lk', '+94781000404', 'No. 404, Chilaw Road, Negombo Chilaw', 'Negombo Chilaw'),
('Sivanesan', 'Nagarajah', 'sivanesan.nagarajah405@yahoo.lk', '+94751000405', 'No. 405, Talpe Road, Galle Talpe', 'Galle Talpe'),
('Kusuma', 'Wimalaratne', 'kusuma.wimalaratne406@slnet.lk', '+94711000406', 'No. 406, Girandurukotte Road, Kurunegala Girandurukotte', 'Kurunegala Girandurukotte'),
('Rizwan', 'Nazeer', 'rizwan.nazeer407@gmail.lk', '+94761000407', 'No. 407, Thirukkovil Road, Trincomalee Thirukkovil', 'Trincomalee Thirukkovil'),
('Sajani', 'Hewavitharana', 'sajani.hewavitharana408@yahoo.lk', '+94771000408', 'No. 408, Nuwara Eliya Road, Nuwara Eliya Central', 'Nuwara Eliya Central'),
('Tharshan', 'Sivashankar', 'tharshan.sivashankar409@slnet.lk', '+94781000409', 'No. 409, Navatkuli Road, Batticaloa Navatkuli', 'Batticaloa Navatkuli'),
('Nihara', 'Faleel', 'nihara.faleel410@gmail.lk', '+94751000410', 'No. 410, Kahawatta Road, Ratnapura Kahawatta', 'Ratnapura Kahawatta'),
('Sampath', 'Wickramasinghe', 'sampath.wickramasinghe411@yahoo.lk', '+94711000411', 'No. 411, Tangalle Road, Matara Tangalle', 'Matara Tangalle'),
('Nirmala', 'Gunawardena', 'nirmala.gunawardena412@slnet.lk', '+94761000412', 'No. 412, Polonnaruwa Road, Anuradhapura Polonnaruwa', 'Anuradhapura Polonnaruwa'),
('Ameen', 'Rahim', 'ameen.rahim413@gmail.lk', '+94771000413', 'No. 413, Hali Ela Road, Badulla Hali Ela', 'Badulla Hali Ela'),
('Chandrika', 'Jayasundara', 'chandrika.jayasundara414@yahoo.lk', '+94781000414', 'No. 414, Kohuwala Road, Colombo Kohuwala', 'Colombo Kohuwala'),
('Sivathasan', 'Thirunavukkarasu', 'sivathasan.thirunavukkarasu415@slnet.lk', '+94751000415', 'No. 415, Velanai Road, Jaffna Velanai', 'Jaffna Velanai'),
('Ranjith', 'Abeyratne', 'ranjith.abeyratne416@gmail.lk', '+94711000416', 'No. 416, Akurana Road, Kandy Akurana', 'Kandy Akurana'),
('Zahra', 'Jalaldeen', 'zahra.jalaldeen417@yahoo.lk', '+94761000417', 'No. 417, Katana Road, Negombo Katana', 'Negombo Katana'),
('Sujith', 'Sivanesan', 'sujith.sivanesan418@slnet.lk', '+94771000418', 'No. 418, Ambalangoda Road, Galle Ambalangoda', 'Galle Ambalangoda'),
('Kanthi', 'Seneviratne', 'kanthi.seneviratne419@gmail.lk', '+94781000419', 'No. 419, Hingurakgoda Road, Kurunegala Hingurakgoda', 'Kurunegala Hingurakgoda'),
('Shameer', 'Iqbal', 'shameer.iqbal420@yahoo.lk', '+94751000420', 'No. 420, Veraval Road, Trincomalee Veraval', 'Trincomalee Veraval'),
('Nayana', 'Wickramarachchi', 'nayana.wickramarachchi421@slnet.lk', '+94711000421', 'No. 421, Maskeliya Road, Nuwara Eliya Maskeliya', 'Nuwara Eliya Maskeliya'),
('Sivaneswaran', 'Nadarajah', 'sivaneswaran.nadarajah422@gmail.lk', '+94761000422', 'No. 422, Pasikudah Road, Batticaloa Pasikudah', 'Batticaloa Pasikudah'),
('Fazna', 'Hussain', 'fazna.hussain423@yahoo.lk', '+94771000423', 'No. 423, Godakawela Road, Ratnapura Godakawela', 'Ratnapura Godakawela'),
('Sunil', 'Perera', 'sunil.perera424@slnet.lk', '+94781000424', 'No. 424, Mirissa Road, Matara Mirissa', 'Matara Mirissa'),
('Anoma', 'Hewawasam', 'anoma.hewawasam425@gmail.lk', '+94751000425', 'No. 425, Tambuttegama Road, Anuradhapura Tambuttegama', 'Anuradhapura Tambuttegama'),
('Nizam', 'Shafeek', 'nizam.shafeek426@yahoo.lk', '+94711000426', 'No. 426, Uva Wellassa Road, Badulla Wellassa', 'Badulla Wellassa'),
('Sampath', 'Wijesundara', 'sampath.wijesundara427@slnet.lk', '+94761000427', 'No. 427, Narahenpita Road, Colombo Narahenpita', 'Colombo Narahenpita'),
('Thivya', 'Sivapalan', 'thivya.sivapalan428@gmail.lk', '+94771000428', 'No. 428, Sandilipay Road, Jaffna Sandilipay', 'Jaffna Sandilipay'),
('Gamini', 'Dissanayake', 'gamini.dissanayake429@yahoo.lk', '+94781000429', 'No. 429, Kaduwela Road, Kandy Kaduwela', 'Kandy Kaduwela'),
('Shazna', 'Nazeem', 'shazna.nazeem430@slnet.lk', '+94751000430', 'No. 430, Dalugama Road, Negombo Dalugama', 'Negombo Dalugama'),
('Nirmalan', 'Sivagnanam', 'nirmalan.sivagnanam431@gmail.lk', '+94711000431', 'No. 431, Weligama Road, Galle Weligama', 'Galle Weligama'),
('Chandrika', 'Jayasekara', 'chandrika.jayasekara432@yahoo.lk', '+94761000432', 'No. 432, Narammala Road, Kurunegala Narammala', 'Kurunegala Narammala'),
('Azhar', 'Fawaz', 'azhar.fawaz433@slnet.lk', '+94771000433', 'No. 433, Kantalai Road, Trincomalee Kantalai', 'Trincomalee Kantalai'),
('Sanjaya', 'Ranaweera', 'sanjaya.ranaweera434@gmail.lk', '+94781000434', 'No. 434, Bogawantalawa Road, Nuwara Eliya Bogawantalawa', 'Nuwara Eliya Bogawantalawa'),
('Sivanesan', 'Thavarajah', 'sivanesan.thavarajah435@yahoo.lk', '+94751000435', 'No. 435, Kaluwanchikudy Road, Batticaloa Kaluwanchikudy', 'Batticaloa Kaluwanchikudy'),
('Fazil', 'Jameel', 'fazil.jameel436@slnet.lk', '+94711000436', 'No. 436, Kuruwita Road, Ratnapura Kuruwita', 'Ratnapura Kuruwita'),
('Nayanajith', 'Wickramathilaka', 'nayanajith.wickramathilaka437@gmail.lk', '+94761000437', 'No. 437, Devinuwara Road, Matara Devinuwara', 'Matara Devinuwara'),
('Ranjani', 'Subasinghe', 'ranjani.subasinghe438@yahoo.lk', '+94771000438', 'No. 438, Horowpathana Road, Anuradhapura Horowpathana', 'Anuradhapura Horowpathana'),
('Rameez', 'Rahim', 'rameez.rahim439@slnet.lk', '+94781000439', 'No. 439, Meegoda Road, Badulla Meegoda', 'Badulla Meegoda'),
('Suresh', 'Wanasinghe', 'suresh.wanasinghe440@gmail.lk', '+94751000440', 'No. 440, Battaramulla Road, Colombo Battaramulla', 'Colombo Battaramulla'),
('Kavitha', 'Sivathasan', 'kavitha.sivathasan441@yahoo.lk', '+94711000441', 'No. 441, Nelliady Road, Jaffna Nelliady', 'Jaffna Nelliady'),
('Asela', 'Gunawardhana', 'asela.gunawardhana442@slnet.lk', '+94761000442', 'No. 442, Harispattuwa Road, Kandy Harispattuwa', 'Kandy Harispattuwa'),
('Nafiya', 'Rasheed', 'nafiya.rasheed443@gmail.lk', '+94771000443', 'No. 443, Wennappuwa Road, Negombo Wennappuwa', 'Negombo Wennappuwa'),
('Sutharsan', 'Sinniah', 'sutharsan.sinniah444@yahoo.lk', '+94781000444', 'No. 444, Beruwala Road, Galle Beruwala', 'Galle Beruwala'),
('Nalini', 'Kumari', 'nalini.kumari445@slnet.lk', '+94751000445', 'No. 445, Polgahawela Road, Kurunegala Polgahawela', 'Kurunegala Polgahawela'),
('Imran', 'Fawaz', 'imran.fawaz446@gmail.lk', '+94711000446', 'No. 446, Mutur Road, Trincomalee Mutur', 'Trincomalee Mutur'),
('Tharanga', 'Weerathunga', 'tharanga.weerathunga447@yahoo.lk', '+94761000447', 'No. 447, Dickoya Road, Nuwara Eliya Dickoya', 'Nuwara Eliya Dickoya'),
('Vijitharan', 'Raveendran', 'vijitharan.raveendran448@slnet.lk', '+94771000448', 'No. 448, Arugam Bay Road, Batticaloa Arugam Bay', 'Batticaloa Arugam Bay'),
('Shamila', 'Faizer', 'shamila.faizer449@gmail.lk', '+94781000449', 'No. 449, Embilipitiya Road, Ratnapura Embilipitiya', 'Ratnapura Embilipitiya'),
('Ruwan', 'Jayasundara', 'ruwan.jayasundara450@yahoo.lk', '+94751000450', 'No. 450, Weligambay Road, Matara Weligambay', 'Matara Weligambay'),
('Suneetha', 'Galappaththi', 'suneetha.galappaththi451@slnet.lk', '+94711000451', 'No. 451, Kekirawa Road, Anuradhapura Kekirawa', 'Anuradhapura Kekirawa'),
('Nazeer', 'Hameem', 'nazeer.hameem452@gmail.lk', '+94761000452', 'No. 452, Bandarawela Road, Badulla Bandarawela', 'Badulla Bandarawela'),
('Nandana', 'Amarathunga', 'nandana.amarathunga453@yahoo.lk', '+94771000453', 'No. 453, Rajagiriya Road, Colombo Rajagiriya', 'Colombo Rajagiriya'),
('Thayalini', 'Vijayakumar', 'thayalini.vijayakumar454@slnet.lk', '+94781000454', 'No. 454, Chavakachcheri Road, Jaffna Chavakachcheri', 'Jaffna Chavakachcheri'),
('Sarath', 'Weerakoon', 'sarath.weerakoon455@gmail.lk', '+94751000455', 'No. 455, Nawalapitiya Road, Kandy Nawalapitiya', 'Kandy Nawalapitiya'),
('Nuzha', 'Hameed', 'nuzha.hameed456@yahoo.lk', '+94711000456', 'No. 456, Seeduwa Road, Negombo Seeduwa', 'Negombo Seeduwa'),
('Sivakumaran', 'Nadaraja', 'sivakumaran.nadaraja457@slnet.lk', '+94761000457', 'No. 457, Induruwa Road, Galle Induruwa', 'Galle Induruwa'),
('Nirmala', 'Gunathilake', 'nirmala.gunathilake458@gmail.lk', '+94771000458', 'No. 458, Kuliyapitiya Road, Kurunegala Kuliyapitiya', 'Kurunegala Kuliyapitiya'),
('Ramees', 'Niyas', 'ramees.niyas459@yahoo.lk', '+94781000459', 'No. 459, Seruvila Road, Trincomalee Seruvila', 'Trincomalee Seruvila'),
('Dilruk', 'Weerasingha', 'dilruk.weerasingha460@slnet.lk', '+94751000460', 'No. 460, Talawakelle Road, Nuwara Eliya Talawakelle', 'Nuwara Eliya Talawakelle'),
('Sivathas', 'Sivaneswaran', 'sivathas.sivaneswaran461@gmail.lk', '+94711000461', 'No. 461, Pottuvil Road, Batticaloa Pottuvil', 'Batticaloa Pottuvil'),
('Shameem', 'Rifai', 'shameem.rifai462@yahoo.lk', '+94761000462', 'No. 462, Kalawana Road, Ratnapura Kalawana', 'Ratnapura Kalawana'),
('Nimal', 'Jayakody', 'nimal.jayakody463@slnet.lk', '+94771000463', 'No. 463, Deniyaya Road, Matara Deniyaya', 'Matara Deniyaya'),
('Sujatha', 'Abeysekara', 'sujatha.abeysekara464@gmail.lk', '+94781000464', 'No. 464, Medawachchiya Road, Anuradhapura Medawachchiya', 'Anuradhapura Medawachchiya'),
('Fawzul', 'Azeez', 'fawzul.azeez465@yahoo.lk', '+94751000465', 'No. 465, Welimada Road, Badulla Welimada', 'Badulla Welimada'),
('Lalith', 'Edirisinghe', 'lalith.edirisinghe466@slnet.lk', '+94711000466', 'No. 466, Maligawatta Road, Colombo Maligawatta', 'Colombo Maligawatta'),
('Nirusha', 'Sivapatham', 'nirusha.sivapatham467@gmail.lk', '+94761000467', 'No. 467, Anaicoddai Road, Jaffna Anaicoddai', 'Jaffna Anaicoddai'),
('Upul', 'Samarasekara', 'upul.samarasekara468@yahoo.lk', '+94771000468', 'No. 468, Gelioya Road, Kandy Gelioya', 'Kandy Gelioya'),
('Zahra', 'Fazal', 'zahra.fazal469@slnet.lk', '+94781000469', 'No. 469, Minuwangoda Road, Negombo Minuwangoda', 'Negombo Minuwangoda'),
('Sivajothy', 'Sivakumaran', 'sivajothy.sivakumaran470@gmail.lk', '+94751000470', 'No. 470, Hikkaduwa Road, Galle Hikkaduwa', 'Galle Hikkaduwa'),
('Ranjani', 'Wickramasuriya', 'ranjani.wickramasuriya471@yahoo.lk', '+94711000471', 'No. 471, Ibbagamuwa Road, Kurunegala Ibbagamuwa', 'Kurunegala Ibbagamuwa'),
('Nawaz', 'Ismail', 'nawaz.ismail472@slnet.lk', '+94761000472', 'No. 472, Nilaveli Road, Trincomalee Nilaveli', 'Trincomalee Nilaveli'),
('Sampath', 'Gunasekera', 'sampath.gunasekera473@gmail.lk', '+94771000473', 'No. 473, Pundaluoya Road, Nuwara Eliya Pundaluoya', 'Nuwara Eliya Pundaluoya'),
('Sivaneswaran', 'Sivapalan', 'sivaneswaran.sivapalan474@yahoo.lk', '+94781000474', 'No. 474, Akkaraipattu Road, Batticaloa Akkaraipattu', 'Batticaloa Akkaraipattu'),
('Rifka', 'Nazeer', 'rifka.nazeer475@slnet.lk', '+94751000475', 'No. 475, Godakawela Road, Ratnapura Godakawela', 'Ratnapura Godakawela'),
('Nishantha', 'Rathnapala', 'nishantha.rathnapala476@gmail.lk', '+94711000476', 'No. 476, Hakmana Road, Matara Hakmana', 'Matara Hakmana'),
('Kumuduni', 'Abeywickrama', 'kumuduni.abeywickrama477@yahoo.lk', '+94761000477', 'No. 477, Polonnaruwa Road, Anuradhapura Polonnaruwa', 'Anuradhapura Polonnaruwa'),
('Azeem', 'Rahuman', 'azeem.rahuman478@slnet.lk', '+94771000478', 'No. 478, Haputale Road, Badulla Haputale', 'Badulla Haputale'),
('Tharani', 'Sivapragash', 'tharani.sivapragash479@gmail.lk', '+94781000479', 'No. 479, Thalawathugoda Road, Colombo Thalawathugoda', 'Colombo Thalawathugoda'),
('Wasantha', 'Hewage', 'wasantha.hewage480@yahoo.lk', '+94751000480', 'No. 480, Velanai Road, Jaffna Velanai', 'Jaffna Velanai'),
('Shamila', 'Jiffry', 'shamila.jiffry481@slnet.lk', '+94711000481', 'No. 481, Katugastota Road, Kandy Katugastota', 'Kandy Katugastota'),
('Sivakumaran', 'Nadesan', 'sivakumaran.nadesan482@gmail.lk', '+94761000482', 'No. 482, Eththukala Road, Negombo Eththukala', 'Negombo Eththukala'),
('Nayana', 'Sumanadasa', 'nayana.sumanadasa483@yahoo.lk', '+94771000483', 'No. 483, Koggala Road, Galle Koggala', 'Galle Koggala'),
('Saman', 'Jayalath', 'saman.jayalath484@slnet.lk', '+94781000484', 'No. 484, Wariyapola Road, Kurunegala Wariyapola', 'Kurunegala Wariyapola'),
('Fathima', 'Nizar', 'fathima.nizar485@gmail.lk', '+94751000485', 'No. 485, Kuchchaveli Road, Trincomalee Kuchchaveli', 'Trincomalee Kuchchaveli'),
('Nishadi', 'Wickramapala', 'nishadi.wickramapala486@yahoo.lk', '+94711000486', 'No. 486, Ambagahawatte Road, Nuwara Eliya Ambagahawatte', 'Nuwara Eliya Ambagahawatte'),
('Sivaneswar', 'Sivapalan', 'sivaneswar.sivapalan487@slnet.lk', '+94761000487', 'No. 487, Valachchenai Road, Batticaloa Valachchenai', 'Batticaloa Valachchenai'),
('Rifaz', 'Niyas', 'rifaz.niyas488@gmail.lk', '+94771000488', 'No. 488, Balangoda Road, Ratnapura Balangoda', 'Ratnapura Balangoda'),
('Ruwan', 'Samarajeewa', 'ruwan.samarajeewa489@yahoo.lk', '+94781000489', 'No. 489, Gandara Road, Matara Gandara', 'Matara Gandara'),
('Suneetha', 'Galappatti', 'suneetha.galappatti490@slnet.lk', '+94751000490', 'No. 490, Thissa Road, Anuradhapura Thissa', 'Anuradhapura Thissa'),
('Nazeem', 'Hameem', 'nazeem.hameem491@gmail.lk', '+94711000491', 'No. 491, Ella Road, Badulla Ella', 'Badulla Ella'),
('Nandana', 'Amarathunga', 'nandana.amarathunga492@yahoo.lk', '+94761000492', 'No. 492, Dematagoda Road, Colombo Dematagoda', 'Colombo Dematagoda'),
('Thayalini', 'Vijayakumaran', 'thayalini.vijayakumaran493@slnet.lk', '+94771000493', 'No. 493, Tellippalai Road, Jaffna Tellippalai', 'Jaffna Tellippalai'),
('Sarath', 'Weerasekara', 'sarath.weerasekara494@gmail.lk', '+94781000494', 'No. 494, Gampola Road, Kandy Gampola', 'Kandy Gampola'),
('Nuzha', 'Hamid', 'nuzha.hamid495@yahoo.lk', '+94751000495', 'No. 495, Jaela Road, Negombo Jaela', 'Negombo Jaela'),
('Sivakumaran', 'Nadarajah', 'sivakumaran.nadarajah496@slnet.lk', '+94711000496', 'No. 496, Balapitiya Road, Galle Balapitiya', 'Galle Balapitiya'),
('Nirmala', 'Gunathilaka', 'nirmala.gunathilaka497@gmail.lk', '+94761000497', 'No. 497, Nikaweratiya Road, Kurunegala Nikaweratiya', 'Kurunegala Nikaweratiya'),
('Ramees', 'Niyaz', 'ramees.niyaz498@yahoo.lk', '+94771000498', 'No. 498, Uppuveli Road, Trincomalee Uppuveli', 'Trincomalee Uppuveli'),
('Dilruk', 'Weerasinghe', 'dilruk.weerasinghe499@slnet.lk', '+94781000499', 'No. 499, Ragala Road, Nuwara Eliya Ragala', 'Nuwara Eliya Ragala'),
('Sivathasan', 'Sivaneswaran', 'sivathasan.sivaneswaran500@gmail.lk', '+94751000500', 'No. 500, Kalmunai Road, Batticaloa Kalmunai', 'Batticaloa Kalmunai');

INSERT INTO PaymentType (PaymentMethod) VALUES
('Cash'),
('Credit Card'),
('Debit Card'),
('Mobile Payment'),
('Bank Transfer');


INSERT INTO TransportProvider (ProviderName, Address, Email, ContactNo, FaxNumber, BranchLocation, Country) VALUES
('GlobalFreight Solutions', 'No. 10, Galle Road, Colombo 3', 'info@globalfreight.lk', '+94112345678', '+94112345679', 'Colombo', 'Sri Lanka'),
('TransAsia Logistics', '123 Orchard Road, #05-01, Singapore 238874', 'contact@transasia.com', '+6561234567', '+6561234568', 'Singapore', 'Singapore'),
('Pacific Express', '456 George Street, Sydney NSW 2000', 'support@pacificexpress.au', '+61298765432', '+61298765433', 'Sydney', 'Australia'),
('EuroFreight Ltd', '78 Baker Street, London W1U 6TA', 'info@eurofreight.uk', '+442071234567', '+442071234568', 'London', 'United Kingdom'),
('NorthStar Shipping', '350 5th Ave, New York, NY 10118', 'service@northstarship.com', '+12125550123', '+12125550124', 'New York', 'United States'),
('AsiaCargo Connect', '88 Queensway, Admiralty, Hong Kong', 'enquiry@asiacargo.hk', '+85223456789', '+85223456790', 'Hong Kong', 'Hong Kong'),
('BlueOcean Trans', '12/3 MG Road, Bengaluru 560001', 'support@blueocean.in', '+918022345678', '+918022345679', 'Bengaluru', 'India'),
('SwiftFreight Japan', '1-2-3 Ginza, Chuo-ku, Tokyo 104-0061', 'info@swiftfreight.jp', '+81345678901', '+81345678902', 'Tokyo', 'Japan'),
('MapleLeaf Logistics', '789 Bay Street, Toronto, ON M5V 2T3', 'contact@mapleleaf.ca', '+14169876543', '+14169876544', 'Toronto', 'Canada'),
('DesertTrans LLC', 'Al Quoz Industrial Area, Dubai', 'service@deserttrans.ae', '+97143456789', '+97143456790', 'Dubai', 'United Arab Emirates'),
('TransEurope Express', '45 Rue de la Paix, 75002 Paris', 'info@transeurope.fr', '+33123456789', '+33123456790', 'Paris', 'France'),
('GoldenRoute Logistics', 'Room 501, Tower A, Beijing 100022', 'support@goldenroute.cn', '+861012345678', '+861012345679', 'Beijing', 'China'),
('SouthernFreight', '101 Victoria Road, Cape Town 8001', 'enquiry@southernfreight.za', '+27214321098', '+27214321099', 'Cape Town', 'South Africa'),
('Nordic Trans', '12 Drottninggatan, Stockholm 11151', 'contact@nordictrans.se', '+46812345678', '+46812345679', 'Stockholm', 'Sweden'),
('IslandFreight Co', '25 Queens Road, Melbourne 3004', 'info@islandfreight.au', '+61398765432', '+61398765433', 'Melbourne', 'Australia'),
('SilkRoad Carriers', '78 Jalan Ampang, Kuala Lumpur 50450', 'service@silkroad.my', '+60323456789', '+60323456790', 'Kuala Lumpur', 'Malaysia'),
('Skyline Logistics', '456 Sukhumvit Road, Bangkok 10110', 'support@skylinelog.th', '+66212345678', '+66212345679', 'Bangkok', 'Thailand'),
('Horizon Trans', '23 Marina Bay, Dubai Marina, Dubai', 'info@horizontrans.ae', '+97145678901','+66212345674', 'Dubai Marina', 'United Arab Emirates'),
('PacificWave Shipping', '10 Anson Road, #10-01, Singapore 079903', 'contact@pacificwave.sg', '+65678901234', '+65678901235', 'Singapore', 'Singapore'),
('GlobalLink Transport', '34 Orchard Street, Mumbai 400001', 'enquiry@globallink.in', '+912234567890', '+912234567891', 'Mumbai', 'India');


INSERT INTO Shipments (Date, Time, DestinationAddress, ServiceCharge, Tax, EstimatedDeliverDate, TotalShipmentCharge, ProviderID, SalesID) VALUES
('2025-01-01', '08:00:00', 'No. 1, Galle Road, Colombo 4, 400', 1500.00, 150.00, '2025-01-05', 1650.00, 1, 1),
('2025-01-01', '08:10:00', 'No. 2, Orchard Lane, Singapore, 238875', 2000.00, 200.00, '2025-01-06', 2200.00, 2, 8),
('2025-01-01', '08:20:00', 'No. 3, George Street, Sydney, NSW 2001', 1200.00, 120.00, '2025-01-04', 1320.00, 3, 15),
('2025-01-01', '08:30:00', 'No. 4, Baker Street, London, W1U 6TB', 2500.00, 250.00, '2025-01-07', 2750.00, 4, 22),
('2025-01-01', '08:40:00', 'No. 5, 5th Avenue, New York, NY 10119', 1800.00, 180.00, '2025-01-06', 1980.00, 5, 29),
('2025-01-01', '08:50:00', 'No. 6, Queensway, Hong Kong, 999077', 3000.00, 300.00, '2025-01-08', 3300.00, 6, 36),
('2025-01-01', '09:00:00', 'No. 7, MG Road, Bengaluru, 560002', 1400.00, 140.00, '2025-01-05', 1540.00, 7, 43),
('2025-01-01', '09:10:00', 'No. 8, Ginza, Tokyo, 104-0062', 2200.00, 220.00, '2025-01-07', 2420.00, 8, 50),
('2025-01-01', '09:20:00', 'No. 9, Bay Street, Toronto, ON M5V 2T4', 1600.00, 160.00, '2025-01-06', 1760.00, 9, 57),
('2025-01-01', '09:30:00', 'No. 10, Al Quoz, Dubai, 00000', 2800.00, 280.00, '2025-01-08', 3080.00, 10, 64),
('2025-01-01', '09:40:00', 'No. 11, Rue de la Paix, Paris, 75003', 1900.00, 190.00, '2025-01-07', 2090.00, 11, 71),
('2025-01-01', '09:50:00', 'No. 12, Tower A, Beijing, 100023', 2400.00, 240.00, '2025-01-06', 2640.00, 12, 78),
('2025-01-01', '10:00:00', 'No. 13, Victoria Road, Cape Town, 8002', 1700.00, 170.00, '2025-01-05', 1870.00, 13, 85),
('2025-01-01', '10:10:00', 'No. 14, Drottninggatan, Stockholm, 11152', 2600.00, 260.00, '2025-01-08', 2860.00, 14, 92),
('2025-01-01', '10:20:00', 'No. 15, Queens Road, Melbourne, 3005', 2100.00, 210.00, '2025-01-07', 2310.00, 15, 99),
('2025-01-01', '10:30:00', 'No. 16, Jalan Ampang, Kuala Lumpur, 50451', 2900.00, 290.00, '2025-01-09', 3190.00, 16, 106),
('2025-01-01', '10:40:00', 'No. 17, Sukhumvit Road, Bangkok, 10111', 1300.00, 130.00, '2025-01-04', 1430.00, 17, 113),
('2025-01-01', '10:50:00', 'No. 18, Marina Bay, Dubai, 00001', 2700.00, 270.00, '2025-01-08', 2970.00, 18, 120),
('2025-01-01', '11:00:00', 'No. 19, Anson Road, Singapore, 79904', 2000.00, 200.00, '2025-01-06', 2200.00, 19, 127),
('2025-01-01', '11:10:00', 'No. 20, Orchard Street, Mumbai, 400002', 2500.00, 250.00, '2025-01-07', 2750.00, 20, 134),
('2025-01-02', '08:00:00', 'No. 21, Ludwigstraße, Munich, 80334', 1800.00, 180.00, '2025-01-06', 1980.00, 21, 141),
('2025-01-02', '08:10:00', 'No. 22, George Street, Auckland, 1011', 3100.00, 310.00, '2025-01-09', 3410.00, 22, 148),
('2025-01-02', '08:20:00', 'No. 23, Gangnam-daero, Seoul, 6113', 1500.00, 150.00, '2025-01-05', 1650.00, 23, 155),
('2025-01-02', '08:30:00', 'No. 24, Nguyen Hue, Ho Chi Minh City, 700001', 2300.00, 230.00, '2025-01-08', 2530.00, 24, 162),
('2025-01-02', '08:40:00', 'No. 25, Jalan Sudirman, Jakarta, 10271', 2800.00, 280.00, '2025-01-07', 3080.00, 25, 169),
('2025-01-02', '08:50:00', 'No. 26, Havelock Road, Colombo 5, 500', 1900.00, 190.00, '2025-01-06', 2090.00, 1, 176),
('2025-01-02', '09:00:00', 'No. 27, Raffles Place, Singapore, 48623', 2600.00, 260.00, '2025-01-09', 2860.00, 2, 183),
('2025-01-02', '09:10:00', 'No. 28, Pitt Street, Sydney, NSW 2002', 1400.00, 140.00, '2025-01-05', 1540.00, 3, 190),
('2025-01-02', '09:20:00', 'No. 29, Oxford Street, London, W1D 1AR', 3000.00, 300.00, '2025-01-08', 3300.00, 4, 197),
('2025-01-02', '09:30:00', 'No. 30, Broadway, New York, NY 10003', 1700.00, 170.00, '2025-01-07', 1870.00, 5, 204),
('2025-01-02', '09:40:00', 'No. 31, Causeway Bay, Hong Kong, 999078', 2400.00, 240.00, '2025-01-06', 2640.00, 6, 211),
('2025-01-02', '09:50:00', 'No. 32, Brigade Road, Bengaluru, 560003', 2000.00, 200.00, '2025-01-05', 2200.00, 7, 218),
('2025-01-02', '10:00:00', 'No. 33, Shibuya, Tokyo, 150-0002', 2700.00, 270.00, '2025-01-09', 2970.00, 8, 225),
('2025-01-02', '10:10:00', 'No. 34, Yonge Street, Toronto, ON M5B 1R4', 1500.00, 150.00, '2025-01-06', 1650.00, 9, 232),
('2025-01-02', '10:20:00', 'No. 35, Sheikh Zayed Road, Dubai, 00002', 2900.00, 290.00, '2025-01-08', 3190.00, 10, 239),
('2025-01-02', '10:30:00', 'No. 36, Champs-Élysées, Paris, 75008', 1800.00, 180.00, '2025-01-07', 1980.00, 11, 246),
('2025-01-02', '10:40:00', 'No. 37, Wangfujing, Beijing, 100006', 2500.00, 250.00, '2025-01-06', 2750.00, 12, 253),
('2025-01-02', '10:50:00', 'No. 38, Long Street, Cape Town, 8003', 2100.00, 210.00, '2025-01-05', 2310.00, 13, 260),
('2025-01-02', '11:00:00', 'No. 39, Kungsholmen, Stockholm, 11260', 2800.00, 280.00, '2025-01-09', 3080.00, 14, 267),
('2025-01-02', '11:10:00', 'No. 40, Flinders Street, Melbourne, 3006', 1600.00, 160.00, '2025-01-07', 1760.00, 15, 274),
('2025-01-03', '08:00:00', 'No. 41, Petaling Street, Kuala Lumpur, 50000', 2300.00, 230.00, '2025-01-08', 2530.00, 16, 281),
('2025-01-03', '08:10:00', 'No. 42, Silom Road, Bangkok, 10500', 1900.00, 190.00, '2025-01-06', 2090.00, 17, 288),
('2025-01-03', '08:20:00', 'No. 43, Bur Dubai, Dubai, 00003', 2700.00, 270.00, '2025-01-09', 2970.00, 18, 295),
('2025-01-03', '08:30:00', 'No. 44, Marina Bay Sands, Singapore, 18972', 1400.00, 140.00, '2025-01-07', 1540.00, 19, 302),
('2025-01-03', '08:40:00', 'No. 45, Colaba Causeway, Mumbai, 400005', 3000.00, 300.00, '2025-01-10', 3300.00, 20, 309),
('2025-01-03', '08:50:00', 'No. 46, Maximilianstraße, Munich, 80539', 1700.00, 170.00, '2025-01-06', 1870.00, 21, 316),
('2025-01-03', '09:00:00', 'No. 47, Queen Street, Auckland, 1012', 2400.00, 240.00, '2025-01-08', 2640.00, 22, 323),
('2025-01-03', '09:10:00', 'No. 48, Myeongdong, Seoul, 4536', 2000.00, 200.00, '2025-01-07', 2200.00, 23, 330),
('2025-01-03', '09:20:00', 'No. 49, District 1, Ho Chi Minh City, 700002', 2600.00, 260.00, '2025-01-09', 2860.00, 24, 337),
('2025-01-03', '09:30:00', 'No. 50, Thamrin Avenue, Jakarta, 10350', 1500.00, 150.00, '2025-01-06', 1650.00, 25, 344),
('2025-01-03', '09:40:00', 'No. 51, Marine Drive, Colombo 6, 600', 2800.00, 280.00, '2025-01-10', 3080.00, 1, 351),
('2025-01-03', '09:50:00', 'No. 52, Shenton Way, Singapore, 68805', 1900.00, 190.00, '2025-01-07', 2090.00, 2, 358),
('2025-01-03', '10:00:00', 'No. 53, King Street, Sydney, NSW 2003', 2500.00, 250.00, '2025-01-08', 2750.00, 3, 365),
('2025-01-03', '10:10:00', 'No. 54, Regent Street, London, W1B 5AS', 2100.00, 210.00, '2025-01-06', 2310.00, 4, 372),
('2025-01-03', '10:20:00', 'No. 55, Wall Street, New York, NY 10005', 2900.00, 290.00, '2025-01-09', 3190.00, 5, 379),
('2025-01-03', '10:30:00', 'No. 56, Kowloon, Hong Kong, 999079', 1600.00, 160.00, '2025-01-07', 1760.00, 6, 386),
('2025-01-03', '10:40:00', 'No. 57, Commercial Street, Bengaluru, 560004', 2300.00, 230.00, '2025-01-08', 2530.00, 7, 393),
('2025-01-03', '10:50:00', 'No. 58, Shinjuku, Tokyo, 160-0022', 1800.00, 180.00, '2025-01-06', 1980.00, 8, 400),
('2025-01-03', '11:00:00', 'No. 59, Bloor Street, Toronto, ON M4W 1A9', 2700.00, 270.00, '2025-01-10', 2970.00, 9, 407),
('2025-01-03', '11:10:00', 'No. 60, Jumeirah Road, Dubai, 00004', 1400.00, 140.00, '2025-01-07', 1540.00, 10, 414),
('2025-01-04', '08:00:00', 'No. 61, Avenue Montaigne, Paris, 75008', 3000.00, 300.00, '2025-01-11', 3300.00, 11, 421),
('2025-01-04', '08:10:00', 'No. 62, Xidan, Beijing, 100031', 1700.00, 170.00, '2025-01-08', 1870.00, 12, 428),
('2025-01-04', '08:20:00', 'No. 63, Loop Road, Cape Town, 8004', 2400.00, 240.00, '2025-01-09', 2640.00, 13, 435),
('2025-01-04', '08:30:00', 'No. 64, Södermalm, Stockholm, 11821', 2000.00, 200.00, '2025-01-07', 2200.00, 14, 442),
('2025-01-04', '08:40:00', 'No. 65, Bourke Street, Melbourne, 3007', 2600.00, 260.00, '2025-01-10', 2860.00, 15, 449),
('2025-01-04', '08:50:00', 'No. 66, Bukit Bintang, Kuala Lumpur, 55100', 1500.00, 150.00, '2025-01-08', 1650.00, 16, 456),
('2025-01-04', '09:00:00', 'No. 67, Sathorn Road, Bangkok, 10120', 2800.00, 280.00, '2025-01-11', 3080.00, 17, 463),
('2025-01-04', '09:10:00', 'No. 68, Deira, Dubai, 00005', 1900.00, 190.00, '2025-01-07', 2090.00, 18, 470),
('2025-01-04', '09:20:00', 'No. 69, Cecil Street, Singapore, 49711', 2500.00, 250.00, '2025-01-09', 2750.00, 19, 477),
('2025-01-04', '09:30:00', 'No. 70, Bandra West, Mumbai, 400050', 2100.00, 210.00, '2025-01-08', 2310.00, 20, 484),
('2025-01-04', '09:40:00', 'No. 71, Sendlinger Straße, Munich, 80331', 2900.00, 290.00, '2025-01-11', 3190.00, 21, 491),
('2025-01-04', '09:50:00', 'No. 72, Karangahape Road, Auckland, 1013', 1600.00, 160.00, '2025-01-07', 1760.00, 22, 498),
('2025-01-04', '10:00:00', 'No. 73, Itaewon, Seoul, 4351', 2300.00, 230.00, '2025-01-10', 2530.00, 23, 505),
('2025-01-04', '10:10:00', 'No. 74, District 3, Ho Chi Minh City, 700003', 1800.00, 180.00, '2025-01-08', 1980.00, 24, 512),
('2025-01-04', '10:20:00', 'No. 75, Menteng, Jakarta, 10310', 2700.00, 270.00, '2025-01-09', 2970.00, 25, 519),
('2025-01-04', '10:30:00', 'No. 76, Dehiwala Road, Colombo 7, 700', 1400.00, 140.00, '2025-01-07', 1540.00, 1, 526),
('2025-01-04', '10:40:00', 'No. 77, Collyer Quay, Singapore, 49315', 3000.00, 300.00, '2025-01-11', 3300.00, 2, 533),
('2025-01-04', '10:50:00', 'No. 78, Martin Place, Sydney, NSW 2004', 1700.00, 170.00, '2025-01-08', 1870.00, 3, 540),
('2025-01-04', '11:00:00', 'No. 79, Bond Street, London, W1S 1RL', 2400.00, 240.00, '2025-01-10', 2640.00, 4, 547),
('2025-01-04', '11:10:00', 'No. 80, Park Avenue, New York, NY 10022', 2000.00, 200.00, '2025-01-07', 2200.00, 5, 554),
('2025-01-05', '08:00:00', 'No. 81, Tsim Sha Tsui, Hong Kong, 999080', 2600.00, 260.00, '2025-01-12', 2860.00, 6, 561),
('2025-01-05', '08:10:00', 'No. 82, Koramangala, Bengaluru, 560034', 1500.00, 150.00, '2025-01-08', 1650.00, 7, 568),
('2025-01-05', '08:20:00', 'No. 83, Roppongi, Tokyo, 106-0032', 2800.00, 280.00, '2025-01-11', 3080.00, 8, 575),
('2025-01-05', '08:30:00', 'No. 84, King Street West, Toronto, ON M5V 1N3', 1900.00, 190.00, '2025-01-09', 2090.00, 9, 582),
('2025-01-05', '08:40:00', 'No. 85, Al Barsha, Dubai, 00006', 2500.00, 250.00, '2025-01-10', 2750.00, 10, 589),
('2025-01-05', '08:50:00', 'No. 86, Saint-Germain, Paris, 75006', 2100.00, 210.00, '2025-01-08', 2310.00, 11, 596),
('2025-01-05', '09:00:00', 'No. 87, Nanjing Road, Beijing, 100005', 2900.00, 290.00, '2025-01-12', 3190.00, 12, 603),
('2025-01-05', '09:10:00', 'No. 88, Strand Road, Cape Town, 8005', 1600.00, 160.00, '2025-01-09', 1760.00, 13, 610),
('2025-01-05', '09:20:00', 'No. 89, Östermalm, Stockholm, 11439', 2300.00, 230.00, '2025-01-10', 2530.00, 14, 617),
('2025-01-05', '09:30:00', 'No. 90, Collins Street, Melbourne, 3008', 1800.00, 180.00, '2025-01-08', 1980.00, 15, 624),
('2025-01-05', '09:40:00', 'No. 91, Jalan Sultan, Kuala Lumpur, 50050', 2700.00, 270.00, '2025-01-11', 2970.00, 16, 631),
('2025-01-05', '09:50:00', 'No. 92, Ratchadamri Road, Bangkok, 10330', 1400.00, 140.00, '2025-01-09', 1540.00, 17, 638),
('2025-01-05', '10:00:00', 'No. 93, Downtown Dubai, Dubai, 00007', 3000.00, 300.00, '2025-01-12', 3300.00, 18, 645),
('2025-01-05', '10:10:00', 'No. 94, Robinson Road, Singapore, 68898', 1700.00, 170.00, '2025-01-08', 1870.00, 19, 652),
('2025-01-05', '10:20:00', 'No. 95, Fort, Mumbai, 400001', 2400.00, 240.00, '2025-01-10', 2640.00, 20, 659),
('2025-01-05', '10:30:00', 'No. 96, Königsallee, Munich, 80333', 2000.00, 200.00, '2025-01-09', 2200.00, 21, 666),
('2025-01-05', '10:40:00', 'No. 97, Ponsonby Road, Auckland, 1014', 2600.00, 260.00, '2025-01-11', 2860.00, 22, 673),
('2025-01-05', '10:50:00', 'No. 98, Hongdae, Seoul, 4038', 1500.00, 150.00, '2025-01-08', 1650.00, 23, 680),
('2025-01-05', '11:00:00', 'No. 99, District 7, Ho Chi Minh City, 700004', 2800.00, 280.00, '2025-01-12', 3080.00, 24, 687),
('2025-01-05', '11:10:00', 'No. 100, Kemang, Jakarta, 12730', 1900.00, 190.00, '2025-01-09', 2090.00, 25, 694),
('2025-01-06', '08:00:00', 'No. 101, Nawam Mawatha, Colombo 2, 200', 2500.00, 250.00, '2025-01-13', 2750.00, 1, 701),
('2025-01-06', '08:10:00', 'No. 102, Battery Road, Singapore, 49910', 2100.00, 210.00, '2025-01-10', 2310.00, 2, 708),
('2025-01-06', '08:20:00', 'No. 103, Elizabeth Street, Sydney, NSW 2005', 2900.00, 290.00, '2025-01-12', 3190.00, 3, 715),
('2025-01-06', '08:30:00', 'No. 104, Knightsbridge, London, SW1X 7LJ', 1600.00, 160.00, '2025-01-09', 1760.00, 4, 722),
('2025-01-06', '08:40:00', 'No. 105, Madison Avenue, New York, NY 10016', 2300.00, 230.00, '2025-01-11', 2530.00, 5, 729),
('2025-01-06', '08:50:00', 'No. 106, Mong Kok, Hong Kong, 999081', 1800.00, 180.00, '2025-01-10', 1980.00, 6, 736),
('2025-01-06', '09:00:00', 'No. 107, Indiranagar, Bengaluru, 560038', 2700.00, 270.00, '2025-01-12', 2970.00, 7, 743),
('2025-01-06', '09:10:00', 'No. 108, Harajuku, Tokyo, 150-0001', 1400.00, 140.00, '2025-01-09', 1540.00, 8, 750),
('2025-01-06', '09:20:00', 'No. 109, Queen Street, Toronto, ON M5C 1S1', 3000.00, 300.00, '2025-01-13', 3300.00, 9, 757),
('2025-01-06', '09:30:00', 'No. 110, Dubai Marina, Dubai, 00008', 1700.00, 170.00, '2025-01-10', 1870.00, 10, 764),
('2025-01-06', '09:40:00', 'No. 111, Le Marais, Paris, 75004', 2400.00, 240.00, '2025-01-11', 2640.00, 11, 771),
('2025-01-06', '09:50:00', 'No. 112, Tiananmen, Beijing, 100036', 2000.00, 200.00, '2025-01-09', 2200.00, 12, 778),
('2025-01-06', '10:00:00', 'No. 113, Sea Point, Cape Town, 8006', 2600.00, 260.00, '2025-01-12', 2860.00, 13, 785),
('2025-01-06', '10:10:00', 'No. 114, Gamla Stan, Stockholm, 11129', 1500.00, 150.00, '2025-01-10', 1650.00, 14, 792),
('2025-01-06', '10:20:00', 'No. 115, Swanston Street, Melbourne, 3009', 2800.00, 280.00, '2025-01-13', 3080.00, 15, 799),
('2025-01-06', '10:30:00', 'No. 116, Chinatown, Kuala Lumpur, 50060', 1900.00, 190.00, '2025-01-09', 2090.00, 16, 806),
('2025-01-06', '10:40:00', 'No. 117, Khao San Road, Bangkok, 10200', 2500.00, 250.00, '2025-01-11', 2750.00, 17, 813),
('2025-01-06', '10:50:00', 'No. 118, Al Satwa, Dubai, 00009', 2100.00, 210.00, '2025-01-10', 2310.00, 18, 820),
('2025-01-06', '11:00:00', 'No. 119, Clarke Quay, Singapore, 179020', 2900.00, 290.00, '2025-01-12', 3190.00, 19, 827),
('2025-01-06', '11:10:00', 'No. 120, Juhu, Mumbai, 400049', 1600.00, 160.00, '2025-01-09', 1760.00, 20, 834),
('2025-01-07', '08:00:00', 'No. 121, Marienplatz, Munich, 80331', 2300.00, 230.00, '2025-01-14', 2530.00, 21, 841),
('2025-01-07', '08:10:00', 'No. 122, Newmarket, Auckland, 1023', 1800.00, 180.00, '2025-01-11', 1980.00, 22, 848),
('2025-01-07', '08:20:00', 'No. 123, Gangnam, Seoul, 6236', 2700.00, 270.00, '2025-01-13', 2970.00, 23, 855),
('2025-01-07', '08:30:00', 'No. 124, District 2, Ho Chi Minh City, 700005', 1400.00, 140.00, '2025-01-10', 1540.00, 24, 862),
('2025-01-07', '08:40:00', 'No. 125, Sudirman, Jakarta, 10220', 3000.00, 300.00, '2025-01-14', 3300.00, 25, 869),
('2025-01-07', '08:50:00', 'No. 126, Ward Place, Colombo 8, 800', 1700.00, 170.00, '2025-01-11', 1870.00, 1, 876),
('2025-01-07', '09:00:00', 'No. 127, Marina Bay, Singapore, 18981', 2400.00, 240.00, '2025-01-12', 2640.00, 2, 883),
('2025-01-07', '09:10:00', 'No. 128, Circular Quay, Sydney, NSW 2006', 2000.00, 200.00, '2025-01-10', 2200.00, 3, 890),
('2025-01-07', '09:20:00', 'No. 129, Covent Garden, London, WC2E 8RF', 2600.00, 260.00, '2025-01-13', 2860.00, 4, 897),
('2025-01-07', '09:30:00', 'No. 130, Lexington Avenue, New York, NY 10017', 1500.00, 150.00, '2025-01-11', 1650.00, 5, 904),
('2025-01-07', '09:40:00', 'No. 131, Wan Chai, Hong Kong, 999082', 2800.00, 280.00, '2025-01-14', 3080.00, 6, 911),
('2025-01-07', '09:50:00', 'No. 132, Whitefield, Bengaluru, 560066', 1900.00, 190.00, '2025-01-10', 2090.00, 7, 918),
('2025-01-07', '10:00:00', 'No. 133, Omotesando, Tokyo, 150-0001', 2500.00, 250.00, '2025-01-12', 2750.00, 8, 925),
('2025-01-07', '10:10:00', 'No. 134, Bayview Avenue, Toronto, ON M4N 3M6', 2100.00, 210.00, '2025-01-11', 2310.00, 9, 932),
('2025-01-07', '10:20:00', 'No. 135, Business Bay, Dubai, 00010', 2900.00, 290.00, '2025-01-13', 3190.00, 10, 939),
('2025-01-07', '10:30:00', 'No. 136, Louvre, Paris, 75001', 1600.00, 160.00, '2025-01-10', 1760.00, 11, 946),
('2025-01-07', '10:40:00', 'No. 137, Sanlitun, Beijing, 100027', 2300.00, 230.00, '2025-01-12', 2530.00, 12, 953),
('2025-01-07', '10:50:00', 'No. 138, Camps Bay, Cape Town, 8007', 1800.00, 180.00, '2025-01-11', 1980.00, 13, 960),
('2025-01-07', '11:00:00', 'No. 139, Norrmalm, Stockholm, 11157', 2700.00, 270.00, '2025-01-14', 2970.00, 14, 967),
('2025-01-07', '11:10:00', 'No. 140, Chapel Street, Melbourne, 3141', 1400.00, 140.00, '2025-01-10', 1540.00, 15, 974),
('2025-01-08', '08:00:00', 'No. 141, Damansara, Kuala Lumpur, 50490', 3000.00, 300.00, '2025-01-15', 3300.00, 16, 981),
('2025-01-08', '08:10:00', 'No. 142, Sukhumvit Soi 11, Bangkok, 10110', 1700.00, 170.00, '2025-01-12', 1870.00, 17, 988),
('2025-01-08', '08:20:00', 'No. 143, Al Karama, Dubai, 00011', 2400.00, 240.00, '2025-01-13', 2640.00, 18, 995),
('2025-01-08', '08:30:00', 'No. 144, Boat Quay, Singapore, 49845', 2000.00, 200.00, '2025-01-11', 2200.00, 19, 1000),
('2025-01-08', '08:40:00', 'No. 145, Worli, Mumbai, 400018', 2600.00, 260.00, '2025-01-14', 2860.00, 20, 567),
('2025-01-08', '08:50:00', 'No. 146, Odeonsplatz, Munich, 80539', 1500.00, 150.00, '2025-01-12', 1650.00, 21, 234),
('2025-01-08', '09:00:00', 'No. 147, Parnell, Auckland, 1052', 2800.00, 280.00, '2025-01-15', 3080.00, 22, 345),
('2025-01-08', '09:10:00', 'No. 148, Yeouido, Seoul, 7335', 1900.00, 190.00, '2025-01-11', 2090.00, 23, 456),
('2025-01-08', '09:20:00', 'No. 149, District 4, Ho Chi Minh City, 700006', 2500.00, 250.00, '2025-01-13', 2750.00, 24, 678),
('2025-01-08', '09:30:00', 'No. 150, Kuningan, Jakarta, 12940', 2100.00, 210.00, '2025-01-12', 2310.00, 25, 789);




INSERT INTO Sales(CustomerID, PaymentTypeID, Type, ItemsCountPurchased, CashierID, Date, Time, TotalAmount, NetTotal, GivenAmount, DiscountedAmount, Balance) VALUES
(1, 1, 'Online', 3, 1, '2025-01-01', '09:00:00', 1500.00, 1650.00, 1700.00, 0.00, 50.00),
(2, 2, 'In-Store', 5, 2, '2025-01-01', '09:05:00', 2500.00, 2750.00, 2800.00, 100.00, 50.00),
(3, 3, 'Online', 2, 3, '2025-01-01', '09:10:00', 1200.00, 1320.00, 1400.00, 0.00, 80.00),
(4, 4, 'In-Store', 7, 4, '2025-01-01', '09:15:00', 3500.00, 3850.00, 3900.00, 200.00, 50.00),
(5, 5, 'Online', 4, 5, '2025-01-01', '09:20:00', 1800.00, 1980.00, 2000.00, 0.00, 20.00),
(1, 1, 'In-Store', 6, 1, '2025-01-01', '09:25:00', 3000.00, 3300.00, 3300.00, 0.00, 0.00),
(2, 2, 'Online', 1, 2, '2025-01-01', '09:30:00', 1000.00, 1100.00, 1100.00, 0.00, 0.00),
(3, 3, 'In-Store', 8, 3, '2025-01-01', '09:35:00', 4000.00, 4400.00, 4500.00, 300.00, 100.00),
(4, 4, 'Online', 3, 4, '2025-01-01', '09:40:00', 1600.00, 1760.00, 1800.00, 0.00, 40.00),
(5, 5, 'In-Store', 5, 5, '2025-01-01', '09:45:00', 2700.00, 2970.00, 3000.00, 100.00, 30.00),
(1, 1, 'Online', 2, 1, '2025-01-02', '09:00:00', 1300.00, 1430.00, 1500.00, 0.00, 70.00),
(2, 2, 'In-Store', 4, 2, '2025-01-02', '09:05:00', 2000.00, 2200.00, 2200.00, 0.00, 0.00),
(3, 3, 'Online', 6, 3, '2025-01-02', '09:10:00', 3200.00, 3520.00, 3600.00, 200.00, 80.00),
(4, 4, 'In-Store', 3, 4, '2025-01-02', '09:15:00', 1700.00, 1870.00, 1900.00, 0.00, 30.00),
(5, 5, 'Online', 7, 5, '2025-01-02', '09:20:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(1, 1, 'In-Store', 5, 1, '2025-01-02', '09:25:00', 2400.00, 2640.00, 2700.00, 100.00, 60.00),
(2, 2, 'Online', 2, 2, '2025-01-02', '09:30:00', 1100.00, 1210.00, 1300.00, 0.00, 90.00),
(3, 3, 'In-Store', 9, 3, '2025-01-02', '09:35:00', 4500.00, 4950.00, 5000.00, 400.00, 50.00),
(4, 4, 'Online', 4, 4, '2025-01-02', '09:40:00', 1900.00, 2090.00, 2100.00, 0.00, 10.00),
(5, 5, 'In-Store', 6, 5, '2025-01-02', '09:45:00', 3100.00, 3410.00, 3500.00, 200.00, 90.00),
(1, 1, 'Online', 3, 1, '2025-01-03', '09:00:00', 1400.00, 1540.00, 1600.00, 0.00, 60.00),
(2, 2, 'In-Store', 5, 2, '2025-01-03', '09:05:00', 2600.00, 2860.00, 2900.00, 100.00, 40.00),
(3, 3, 'Online', 2, 3, '2025-01-03', '09:10:00', 1250.00, 1375.00, 1400.00, 0.00, 25.00),
(4, 4, 'In-Store', 8, 4, '2025-01-03', '09:15:00', 3900.00, 4290.00, 4300.00, 300.00, 10.00),
(5, 5, 'Online', 4, 5, '2025-01-03', '09:20:00', 1750.00, 1925.00, 2000.00, 0.00, 75.00),
(1, 1, 'In-Store', 7, 1, '2025-01-03', '09:25:00', 3400.00, 3740.00, 3800.00, 200.00, 60.00),
(2, 2, 'Online', 3, 2, '2025-01-03', '09:30:00', 1550.00, 1705.00, 1800.00, 0.00, 95.00),
(3, 3, 'In-Store', 6, 3, '2025-01-03', '09:35:00', 2800.00, 3080.00, 3100.00, 100.00, 20.00),
(4, 4, 'Online', 2, 4, '2025-01-03', '09:40:00', 1150.00, 1265.00, 1300.00, 0.00, 35.00),
(5, 5, 'In-Store', 5, 5, '2025-01-03', '09:45:00', 2300.00, 2530.00, 2600.00, 0.00, 70.00),
(1, 1, 'Online', 4, 1, '2025-01-04', '09:00:00', 1850.00, 2035.00, 2100.00, 0.00, 65.00),
(2, 2, 'In-Store', 6, 2, '2025-01-04', '09:05:00', 2900.00, 3190.00, 3200.00, 200.00, 10.00),
(3, 3, 'Online', 3, 3, '2025-01-04', '09:10:00', 1450.00, 1595.00, 1600.00, 0.00, 5.00),
(4, 4, 'In-Store', 7, 4, '2025-01-04', '09:15:00', 3600.00, 3960.00, 4000.00, 300.00, 40.00),
(5, 5, 'Online', 2, 5, '2025-01-04', '09:20:00', 1050.00, 1155.00, 1200.00, 0.00, 45.00),
(1, 1, 'In-Store', 5, 1, '2025-01-04', '09:25:00', 2450.00, 2695.00, 2700.00, 100.00, 5.00),
(2, 2, 'Online', 8, 2, '2025-01-04', '09:30:00', 4100.00, 4510.00, 4600.00, 400.00, 90.00),
(3, 3, 'In-Store', 4, 3, '2025-01-04', '09:35:00', 1950.00, 2145.00, 2200.00, 0.00, 55.00),
(4, 4, 'Online', 6, 4, '2025-01-04', '09:40:00', 3150.00, 3465.00, 3500.00, 200.00, 35.00),
(5, 5, 'In-Store', 3, 5, '2025-01-04', '09:45:00', 1650.00, 1815.00, 1900.00, 0.00, 85.00),
(1, 1, 'Online', 2, 1, '2025-01-05', '09:00:00', 1350.00, 1485.00, 1500.00, 0.00, 15.00),
(2, 2, 'In-Store', 5, 2, '2025-01-05', '09:05:00', 2550.00, 2805.00, 2900.00, 100.00, 95.00),
(3, 3, 'Online', 7, 3, '2025-01-05', '09:10:00', 3700.00, 4070.00, 4100.00, 300.00, 30.00),
(4, 4, 'In-Store', 4, 4, '2025-01-05', '09:15:00', 2050.00, 2255.00, 2300.00, 0.00, 45.00),
(5, 5, 'Online', 6, 5, '2025-01-05', '09:20:00', 3250.00, 3575.00, 3600.00, 200.00, 25.00),
(1, 1, 'In-Store', 3, 1, '2025-01-05', '09:25:00', 1550.00, 1705.00, 1800.00, 0.00, 95.00),
(2, 2, 'Online', 5, 2, '2025-01-05', '09:30:00', 2650.00, 2915.00, 3000.00, 100.00, 85.00),
(3, 3, 'In-Store', 2, 3, '2025-01-05', '09:35:00', 1100.00, 1210.00, 1300.00, 0.00, 90.00),
(4, 4, 'Online', 8, 4, '2025-01-05', '09:40:00', 4200.00, 4620.00, 4700.00, 400.00, 80.00),
(5, 5, 'In-Store', 4, 5, '2025-01-05', '09:45:00', 2000.00, 2200.00, 2200.00, 0.00, 0.00),
(1, 1, 'Online', 6, 1, '2025-01-06', '09:00:00', 3300.00, 3630.00, 3700.00, 200.00, 70.00),
(2, 2, 'In-Store', 3, 2, '2025-01-06', '09:05:00', 1600.00, 1760.00, 1800.00, 0.00, 40.00),
(3, 3, 'Online', 5, 3, '2025-01-06', '09:10:00', 2750.00, 3025.00, 3100.00, 100.00, 75.00),
(4, 4, 'In-Store', 2, 4, '2025-01-06', '09:15:00', 1200.00, 1320.00, 1400.00, 0.00, 80.00),
(5, 5, 'Online', 7, 5, '2025-01-06', '09:20:00', 3800.00, 4180.00, 4200.00, 300.00, 20.00),
(1, 1, 'In-Store', 4, 1, '2025-01-06', '09:25:00', 2100.00, 2310.00, 2400.00, 0.00, 90.00),
(2, 2, 'Online', 6, 2, '2025-01-06', '09:30:00', 3400.00, 3740.00, 3800.00, 200.00, 60.00),
(3, 3, 'In-Store', 3, 3, '2025-01-06', '09:35:00', 1700.00, 1870.00, 1900.00, 0.00, 30.00),
(4, 4, 'Online', 5, 4, '2025-01-06', '09:40:00', 2850.00, 3135.00, 3200.00, 100.00, 65.00),
(5, 5, 'In-Store', 2, 5, '2025-01-06', '09:45:00', 1300.00, 1430.00, 1500.00, 0.00, 70.00),
(1, 1, 'Online', 8, 1, '2025-01-07', '09:00:00', 4300.00, 4730.00, 4800.00, 400.00, 70.00),
(2, 2, 'In-Store', 4, 2, '2025-01-07', '09:05:00', 2200.00, 2420.00, 2500.00, 0.00, 80.00),
(3, 3, 'Online', 6, 3, '2025-01-07', '09:10:00', 3500.00, 3850.00, 3900.00, 200.00, 50.00),
(4, 4, 'In-Store', 3, 4, '2025-01-07', '09:15:00', 1800.00, 1980.00, 2000.00, 0.00, 20.00),
(5, 5, 'Online', 5, 5, '2025-01-07', '09:20:00', 2950.00, 3245.00, 3300.00, 100.00, 55.00),
(1, 1, 'In-Store', 2, 1, '2025-01-07', '09:25:00', 1400.00, 1540.00, 1600.00, 0.00, 60.00),
(2, 2, 'Online', 7, 2, '2025-01-07', '09:30:00', 3900.00, 4290.00, 4300.00, 300.00, 10.00),
(3, 3, 'In-Store', 4, 3, '2025-01-07', '09:35:00', 2150.00, 2365.00, 2400.00, 0.00, 35.00),
(4, 4, 'Online', 6, 4, '2025-01-07', '09:40:00', 3600.00, 3960.00, 4000.00, 200.00, 40.00),
(5, 5, 'In-Store', 3, 5, '2025-01-07', '09:45:00', 1900.00, 2090.00, 2100.00, 0.00, 10.00),
(1, 1, 'Online', 5, 1, '2025-01-08', '09:00:00', 3050.00, 3355.00, 3400.00, 100.00, 45.00),
(2, 2, 'In-Store', 2, 2, '2025-01-08', '09:05:00', 1500.00, 1650.00, 1700.00, 0.00, 50.00),
(3, 3, 'Online', 8, 3, '2025-01-08', '09:10:00', 4400.00, 4840.00, 4900.00, 400.00, 60.00),
(4, 4, 'In-Store', 4, 4, '2025-01-08', '09:15:00', 2250.00, 2475.00, 2500.00, 0.00, 25.00),
(5, 5, 'Online', 6, 5, '2025-01-08', '09:20:00', 3750.00, 4125.00, 4200.00, 300.00, 75.00),
(1, 1, 'In-Store', 3, 1, '2025-01-08', '09:25:00', 2000.00, 2200.00, 2200.00, 0.00, 0.00),
(2, 2, 'Online', 5, 2, '2025-01-08', '09:30:00', 3150.00, 3465.00, 3500.00, 100.00, 35.00),
(3, 3, 'In-Store', 2, 3, '2025-01-08', '09:35:00', 1600.00, 1760.00, 1800.00, 0.00, 40.00),
(4, 4, 'Online', 7, 4, '2025-01-08', '09:40:00', 4000.00, 4400.00, 4500.00, 300.00, 100.00),
(5, 5, 'In-Store', 4, 5, '2025-01-08', '09:45:00', 2350.00, 2585.00, 2600.00, 0.00, 15.00),
(1, 1, 'Online', 6, 1, '2025-01-09', '09:00:00', 3850.00, 4235.00, 4300.00, 200.00, 65.00),
(2, 2, 'In-Store', 3, 2, '2025-01-09', '09:05:00', 2050.00, 2255.00, 2300.00, 0.00, 45.00),
(3, 3, 'Online', 5, 3, '2025-01-09', '09:10:00', 3200.00, 3520.00, 3600.00, 100.00, 80.00),
(4, 4, 'In-Store', 2, 4, '2025-01-09', '09:15:00', 1700.00, 1870.00, 1900.00, 0.00, 30.00),
(5, 5, 'Online', 8, 5, '2025-01-09', '09:20:00', 4500.00, 4950.00, 5000.00, 400.00, 50.00),
(1, 1, 'In-Store', 4, 1, '2025-01-09', '09:25:00', 2500.00, 2750.00, 2800.00, 0.00, 50.00),
(2, 2, 'Online', 6, 2, '2025-01-09', '09:30:00', 3900.00, 4290.00, 4300.00, 300.00, 10.00),
(3, 3, 'In-Store', 3, 3, '2025-01-09', '09:35:00', 2150.00, 2365.00, 2400.00, 0.00, 35.00),
(4, 4, 'Online', 5, 4, '2025-01-09', '09:40:00', 3300.00, 3630.00, 3700.00, 200.00, 70.00),
(5, 5, 'In-Store', 2, 5, '2025-01-09', '09:45:00', 1800.00, 1980.00, 2000.00, 0.00, 20.00),
(1, 1, 'Online', 7, 1, '2025-01-10', '09:00:00', 4100.00, 4510.00, 4600.00, 300.00, 90.00),
(2, 2, 'In-Store', 4, 2, '2025-01-10', '09:05:00', 2600.00, 2860.00, 2900.00, 0.00, 40.00),
(3, 3, 'Online', 6, 3, '2025-01-10', '09:10:00', 3950.00, 4345.00, 4400.00, 200.00, 55.00),
(4, 4, 'In-Store', 3, 4, '2025-01-10', '09:15:00', 2250.00, 2475.00, 2500.00, 0.00, 25.00),
(5, 5, 'Online', 5, 5, '2025-01-10', '09:20:00', 3400.00, 3740.00, 3800.00, 100.00, 60.00),
(1, 1, 'In-Store', 2, 1, '2025-01-10', '09:25:00', 1900.00, 2090.00, 2100.00, 0.00, 10.00),
(2, 2, 'Online', 8, 2, '2025-01-10', '09:30:00', 4600.00, 5060.00, 5100.00, 400.00, 40.00),
(3, 3, 'In-Store', 4, 3, '2025-01-10', '09:35:00', 2700.00, 2970.00, 3000.00, 0.00, 30.00),
(4, 4, 'Online', 6, 4, '2025-01-10', '09:40:00', 4050.00, 4455.00, 4500.00, 300.00, 45.00),
(5, 5, 'In-Store', 3, 5, '2025-01-10', '09:45:00', 2350.00, 2585.00, 2600.00, 0.00, 15.00),
(1, 1, 'Online', 5, 1, '2025-01-11', '09:00:00', 3500.00, 3850.00, 3900.00, 200.00, 50.00),
(2, 2, 'In-Store', 2, 2, '2025-01-11', '09:05:00', 2000.00, 2200.00, 2200.00, 0.00, 0.00),
(3, 3, 'Online', 7, 3, '2025-01-11', '09:10:00', 4200.00, 4620.00, 4700.00, 300.00, 80.00),
(4, 4, 'In-Store', 4, 4, '2025-01-11', '09:15:00', 2800.00, 3080.00, 3100.00, 0.00, 20.00),
(5, 5, 'Online', 6, 5, '2025-01-11', '09:20:00', 4150.00, 4565.00, 4600.00, 400.00, 35.00),
(1, 1, 'In-Store', 3, 1, '2025-01-11', '09:25:00', 2450.00, 2695.00, 2700.00, 0.00, 5.00),
(2, 2, 'Online', 5, 2, '2025-01-11', '09:30:00', 3600.00, 3960.00, 4000.00, 200.00, 40.00),
(3, 3, 'In-Store', 2, 3, '2025-01-11', '09:35:00', 2100.00, 2310.00, 2400.00, 0.00, 90.00),
(4, 4, 'Online', 8, 4, '2025-01-11', '09:40:00', 4700.00, 5170.00, 5200.00, 400.00, 30.00),
(5, 5, 'In-Store', 4, 5, '2025-01-11', '09:45:00', 2900.00, 3190.00, 3200.00, 0.00, 10.00),
(1, 1, 'Online', 6, 1, '2025-01-12', '09:00:00', 4250.00, 4675.00, 4700.00, 300.00, 25.00),
(2, 2, 'In-Store', 3, 2, '2025-01-12', '09:05:00', 2550.00, 2805.00, 2900.00, 0.00, 95.00),
(3, 3, 'Online', 5, 3, '2025-01-12', '09:10:00', 3700.00, 4070.00, 4100.00, 200.00, 30.00),
(4, 4, 'In-Store', 2, 4, '2025-01-12', '09:15:00', 2200.00, 2420.00, 2500.00, 0.00, 80.00),
(5, 5, 'Online', 7, 5, '2025-01-12', '09:20:00', 4300.00, 4730.00, 4800.00, 300.00, 70.00),
(1, 1, 'In-Store', 4, 1, '2025-01-12', '09:25:00', 3000.00, 3300.00, 3300.00, 0.00, 0.00),
(2, 2, 'Online', 6, 2, '2025-01-12', '09:30:00', 4350.00, 4785.00, 4800.00, 400.00, 15.00),
(3, 3, 'In-Store', 3, 3, '2025-01-12', '09:35:00', 2650.00, 2915.00, 3000.00, 0.00, 85.00),
(4, 4, 'Online', 5, 4, '2025-01-12', '09:40:00', 3800.00, 4180.00, 4200.00, 200.00, 20.00),
(5, 5, 'In-Store', 2, 5, '2025-01-12', '09:45:00', 2300.00, 2530.00, 2600.00, 0.00, 70.00),
(1, 1, 'Online', 8, 1, '2025-01-13', '09:00:00', 4800.00, 5280.00, 5300.00, 400.00, 20.00),
(2, 2, 'In-Store', 4, 2, '2025-01-13', '09:05:00', 3100.00, 3410.00, 3500.00, 0.00, 90.00),
(3, 3, 'Online', 6, 3, '2025-01-13', '09:10:00', 4450.00, 4895.00, 4900.00, 300.00, 5.00),
(4, 4, 'In-Store', 3, 4, '2025-01-13', '09:15:00', 2750.00, 3025.00, 3100.00, 0.00, 75.00),
(5, 5, 'Online', 5, 5, '2025-01-13', '09:20:00', 3900.00, 4290.00, 4300.00, 200.00, 10.00),
(1, 1, 'In-Store', 2, 1, '2025-01-13', '09:25:00', 2400.00, 2640.00, 2700.00, 0.00, 60.00),
(2, 2, 'Online', 7, 2, '2025-01-13', '09:30:00', 4500.00, 4950.00, 5000.00, 400.00, 50.00),
(3, 3, 'In-Store', 4, 3, '2025-01-13', '09:35:00', 3200.00, 3520.00, 3600.00, 0.00, 80.00),
(4, 4, 'Online', 6, 4, '2025-01-13', '09:40:00', 4550.00, 5005.00, 5100.00, 300.00, 95.00),
(5, 5, 'In-Store', 3, 5, '2025-01-13', '09:45:00', 2850.00, 3135.00, 3200.00, 0.00, 65.00),
(1, 1, 'Online', 5, 1, '2025-01-14', '09:00:00', 4000.00, 4400.00, 4500.00, 200.00, 100.00),
(2, 2, 'In-Store', 2, 2, '2025-01-14', '09:05:00', 2500.00, 2750.00, 2800.00, 0.00, 50.00),
(3, 3, 'Online', 8, 3, '2025-01-14', '09:10:00', 4650.00, 5115.00, 5200.00, 400.00, 85.00),
(4, 4, 'In-Store', 4, 4, '2025-01-14', '09:15:00', 3300.00, 3630.00, 3700.00, 0.00, 70.00),
(5, 5, 'Online', 6, 5, '2025-01-14', '09:20:00', 4600.00, 5060.00, 5100.00, 300.00, 40.00),
(1, 1, 'In-Store', 3, 1, '2025-01-14', '09:25:00', 2950.00, 3245.00, 3300.00, 0.00, 55.00),
(2, 2, 'Online', 5, 2, '2025-01-14', '09:30:00', 4100.00, 4510.00, 4600.00, 200.00, 90.00),
(3, 3, 'In-Store', 2, 3, '2025-01-14', '09:35:00', 2600.00, 2860.00, 2900.00, 0.00, 40.00),
(4, 4, 'Online', 7, 4, '2025-01-14', '09:40:00', 4750.00, 5225.00, 5300.00, 400.00, 75.00),
(5, 5, 'In-Store', 4, 5, '2025-01-14', '09:45:00', 3400.00, 3740.00, 3800.00, 0.00, 60.00),
(1, 1, 'Online', 6, 1, '2025-01-15', '09:00:00', 4700.00, 5170.00, 5200.00, 300.00, 30.00),
(2, 2, 'In-Store', 3, 2, '2025-01-15', '09:05:00', 3050.00, 3355.00, 3400.00, 0.00, 45.00),
(3, 3, 'Online', 5, 3, '2025-01-15', '09:10:00', 4200.00, 4620.00, 4700.00, 200.00, 80.00),
(4, 4, 'In-Store', 2, 4, '2025-01-15', '09:15:00', 2700.00, 2970.00, 3000.00, 0.00, 30.00),
(5, 5, 'Online', 8, 5, '2025-01-15', '09:20:00', 4800.00, 5280.00, 5300.00, 400.00, 20.00),
(1, 1, 'In-Store', 4, 1, '2025-01-15', '09:25:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(2, 2, 'Online', 6, 2, '2025-01-15', '09:30:00', 4650.00, 5115.00, 5200.00, 300.00, 85.00),
(3, 3, 'In-Store', 3, 3, '2025-01-15', '09:35:00', 3150.00, 3465.00, 3500.00, 0.00, 35.00),
(4, 4, 'Online', 5, 4, '2025-01-15', '09:40:00', 4300.00, 4730.00, 4800.00, 200.00, 70.00),
(5, 5, 'In-Store', 2, 5, '2025-01-15', '09:45:00', 2800.00, 3080.00, 3100.00, 0.00, 20.00),
(1, 1, 'Online', 7, 1, '2025-01-16', '09:00:00', 4850.00, 5335.00, 5400.00, 400.00, 65.00),
(2, 2, 'In-Store', 4, 2, '2025-01-16', '09:05:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(3, 3, 'Online', 6, 3, '2025-01-16', '09:10:00', 4750.00, 5225.00, 5300.00, 300.00, 75.00),
(4, 4, 'In-Store', 3, 4, '2025-01-16', '09:15:00', 3250.00, 3575.00, 3600.00, 0.00, 25.00),
(5, 5, 'Online', 5, 5, '2025-01-16', '09:20:00', 4400.00, 4840.00, 4900.00, 200.00, 60.00),
(1, 1, 'In-Store', 2, 1, '2025-01-16', '09:25:00', 2900.00, 3190.00, 3200.00, 0.00, 10.00),
(2, 2, 'Online', 8, 2, '2025-01-16', '09:30:00', 4900.00, 5390.00, 5400.00, 400.00, 10.00),
(3, 3, 'In-Store', 4, 3, '2025-01-16', '09:35:00', 3700.00, 4070.00, 4100.00, 0.00, 30.00),
(4, 4, 'Online', 6, 4, '2025-01-16', '09:40:00', 4850.00, 5335.00, 5400.00, 300.00, 65.00),
(5, 5, 'In-Store', 3, 5, '2025-01-16', '09:45:00', 3350.00, 3685.00, 3700.00, 0.00, 15.00),
(1, 1, 'Online', 5, 1, '2025-01-17', '09:00:00', 4500.00, 4950.00, 5000.00, 200.00, 50.00),
(2, 2, 'In-Store', 2, 2, '2025-01-17', '09:05:00', 3000.00, 3300.00, 3300.00, 0.00, 0.00),
(3, 3, 'Online', 7, 3, '2025-01-17', '09:10:00', 4950.00, 5445.00, 5500.00, 400.00, 55.00),
(4, 4, 'In-Store', 4, 4, '2025-01-17', '09:15:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(5, 5, 'Online', 6, 5, '2025-01-17', '09:20:00', 5000.00, 5500.00, 5500.00, 300.00, 0.00),
(1, 1, 'In-Store', 3, 1, '2025-01-17', '09:25:00', 3450.00, 3795.00, 3800.00, 0.00, 5.00),
(2, 2, 'Online', 5, 2, '2025-01-17', '09:30:00', 4600.00, 5060.00, 5100.00, 200.00, 40.00),
(3, 3, 'In-Store', 2, 3, '2025-01-17', '09:35:00', 3100.00, 3410.00, 3500.00, 0.00, 90.00),
(4, 4, 'Online', 8, 4, '2025-01-17', '09:40:00', 5050.00, 5555.00, 5600.00, 400.00, 45.00),
(5, 5, 'In-Store', 4, 5, '2025-01-17', '09:45:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(1, 1, 'Online', 6, 1, '2025-01-18', '09:00:00', 5100.00, 5610.00, 5700.00, 300.00, 90.00),
(2, 2, 'In-Store', 3, 2, '2025-01-18', '09:05:00', 3550.00, 3905.00, 4000.00, 0.00, 95.00),
(3, 3, 'Online', 5, 3, '2025-01-18', '09:10:00', 4700.00, 5170.00, 5200.00, 200.00, 30.00),
(4, 4, 'In-Store', 2, 4, '2025-01-18', '09:15:00', 3200.00, 3520.00, 3600.00, 0.00, 80.00),
(5, 5, 'Online', 7, 5, '2025-01-18', '09:20:00', 5150.00, 5665.00, 5700.00, 400.00, 35.00),
(1, 1, 'In-Store', 4, 1, '2025-01-18', '09:25:00', 4000.00, 4400.00, 4500.00, 0.00, 100.00),
(2, 2, 'Online', 6, 2, '2025-01-18', '09:30:00', 5200.00, 5720.00, 5800.00, 300.00, 80.00),
(3, 3, 'In-Store', 3, 3, '2025-01-18', '09:35:00', 3650.00, 4015.00, 4100.00, 0.00, 85.00),
(4, 4, 'Online', 5, 4, '2025-01-18', '09:40:00', 4800.00, 5280.00, 5300.00, 200.00, 20.00),
(5, 5, 'In-Store', 2, 5, '2025-01-18', '09:45:00', 3300.00, 3630.00, 3700.00, 0.00, 70.00),
(1, 1, 'Online', 8, 1, '2025-01-19', '09:00:00', 5250.00, 5775.00, 5800.00, 400.00, 25.00),
(2, 2, 'In-Store', 4, 2, '2025-01-19', '09:05:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(3, 3, 'Online', 6, 3, '2025-01-19', '09:10:00', 5300.00, 5830.00, 5900.00, 300.00, 70.00),
(4, 4, 'In-Store', 3, 4, '2025-01-19', '09:15:00', 3750.00, 4125.00, 4200.00, 0.00, 75.00),
(5, 5, 'Online', 5, 5, '2025-01-19', '09:20:00', 4900.00, 5390.00, 5400.00, 200.00, 10.00),
(1, 1, 'In-Store', 2, 1, '2025-01-19', '09:25:00', 3400.00, 3740.00, 3800.00, 0.00, 60.00),
(2, 2, 'Online', 7, 2, '2025-01-19', '09:30:00', 5350.00, 5885.00, 5900.00, 400.00, 15.00),
(3, 3, 'In-Store', 4, 3, '2025-01-19', '09:35:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(4, 4, 'Online', 6, 4, '2025-01-19', '09:40:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(5, 5, 'In-Store', 3, 5, '2025-01-19', '09:45:00', 3850.00, 4235.00, 4300.00, 0.00, 65.00),
(1, 1, 'Online', 5, 1, '2025-01-20', '09:00:00', 5000.00, 5500.00, 5500.00, 200.00, 0.00),
(2, 2, 'In-Store', 2, 2, '2025-01-20', '09:05:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(3, 3, 'Online', 8, 3, '2025-01-20', '09:10:00', 5450.00, 5995.00, 6000.00, 400.00, 5.00),
(4, 4, 'In-Store', 4, 4, '2025-01-20', '09:15:00', 4300.00, 4730.00, 4800.00, 0.00, 70.00),
(5, 5, 'Online', 6, 5, '2025-01-20', '09:20:00', 5500.00, 6050.00, 6100.00, 300.00, 50.00),
(1, 1, 'In-Store', 3, 1, '2025-01-20', '09:25:00', 3950.00, 4345.00, 4400.00, 0.00, 55.00),
(2, 2, 'Online', 5, 2, '2025-01-20', '09:30:00', 5100.00, 5610.00, 5700.00, 200.00, 90.00),
(3, 3, 'In-Store', 2, 3, '2025-01-20', '09:35:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(4, 4, 'Online', 7, 4, '2025-01-20', '09:40:00', 5550.00, 6105.00, 6200.00, 400.00, 95.00),
(5, 5, 'In-Store', 4, 5, '2025-01-20', '09:45:00', 4400.00, 4840.00, 4900.00, 0.00, 60.00),
(1, 1, 'Online', 5, 1, '2025-01-21', '09:00:00', 4500.00, 4950.00, 5000.00, 200.00, 50.00),
(2, 2, 'In-Store', 3, 2, '2025-01-21', '09:05:00', 3000.00, 3300.00, 3300.00, 0.00, 0.00),
(3, 3, 'Online', 7, 3, '2025-01-21', '09:10:00', 5200.00, 5720.00, 5800.00, 500.00, 80.00),
(4, 4, 'In-Store', 4, 4, '2025-01-21', '09:15:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(5, 5, 'Online', 6, 5, '2025-01-21', '09:20:00', 4800.00, 5280.00, 5300.00, 300.00, 20.00),
(1, 1, 'In-Store', 2, 1, '2025-01-21', '09:25:00', 2500.00, 2750.00, 2800.00, 0.00, 50.00),
(2, 2, 'Online', 8, 2, '2025-01-21', '09:30:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(3, 3, 'In-Store', 4, 3, '2025-01-21', '09:35:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(4, 4, 'Online', 6, 4, '2025-01-21', '09:40:00', 4900.00, 5390.00, 5400.00, 200.00, 10.00),
(5, 5, 'In-Store', 3, 5, '2025-01-21', '09:45:00', 3200.00, 3520.00, 3600.00, 0.00, 80.00),
(1, 1, 'Online', 5, 1, '2025-01-22', '09:00:00', 4700.00, 5170.00, 5200.00, 300.00, 30.00),
(2, 2, 'In-Store', 2, 2, '2025-01-22', '09:05:00', 2800.00, 3080.00, 3100.00, 0.00, 20.00),
(3, 3, 'Online', 7, 3, '2025-01-22', '09:10:00', 5300.00, 5830.00, 5900.00, 500.00, 70.00),
(4, 4, 'In-Store', 4, 4, '2025-01-22', '09:15:00', 3700.00, 4070.00, 4100.00, 0.00, 30.00),
(5, 5, 'Online', 6, 5, '2025-01-22', '09:20:00', 5100.00, 5610.00, 5700.00, 400.00, 90.00),
(1, 1, 'In-Store', 3, 1, '2025-01-22', '09:25:00', 3300.00, 3630.00, 3700.00, 0.00, 70.00),
(2, 2, 'Online', 5, 2, '2025-01-22', '09:30:00', 4800.00, 5280.00, 5300.00, 200.00, 20.00),
(3, 3, 'In-Store', 2, 3, '2025-01-22', '09:35:00', 2900.00, 3190.00, 3200.00, 0.00, 10.00),
(4, 4, 'Online', 8, 4, '2025-01-22', '09:40:00', 5600.00, 6160.00, 6200.00, 500.00, 40.00),
(5, 5, 'In-Store', 4, 5, '2025-01-22', '09:45:00', 4000.00, 4400.00, 4500.00, 0.00, 100.00),
(1, 1, 'Online', 6, 1, '2025-01-23', '09:00:00', 5200.00, 5720.00, 5800.00, 300.00, 80.00),
(2, 2, 'In-Store', 3, 2, '2025-01-23', '09:05:00', 3400.00, 3740.00, 3800.00, 0.00, 60.00),
(3, 3, 'Online', 5, 3, '2025-01-23', '09:10:00', 4900.00, 5390.00, 5400.00, 200.00, 10.00),
(4, 4, 'In-Store', 2, 4, '2025-01-23', '09:15:00', 3000.00, 3300.00, 3300.00, 0.00, 0.00),
(5, 5, 'Online', 7, 5, '2025-01-23', '09:20:00', 5400.00, 5940.00, 6000.00, 400.00, 60.00),
(1, 1, 'In-Store', 4, 1, '2025-01-23', '09:25:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(2, 2, 'Online', 6, 2, '2025-01-23', '09:30:00', 5100.00, 5610.00, 5700.00, 300.00, 90.00),
(3, 3, 'In-Store', 3, 3, '2025-01-23', '09:35:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(4, 4, 'Online', 5, 4, '2025-01-23', '09:40:00', 5000.00, 5500.00, 5500.00, 200.00, 0.00),
(5, 5, 'In-Store', 2, 5, '2025-01-23', '09:45:00', 3100.00, 3410.00, 3500.00, 0.00, 90.00),
(1, 1, 'Online', 8, 1, '2025-01-24', '09:00:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(2, 2, 'In-Store', 4, 2, '2025-01-24', '09:05:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(3, 3, 'Online', 6, 3, '2025-01-24', '09:10:00', 5300.00, 5830.00, 5900.00, 300.00, 70.00),
(4, 4, 'In-Store', 3, 4, '2025-01-24', '09:15:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(5, 5, 'Online', 5, 5, '2025-01-24', '09:20:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(1, 1, 'In-Store', 2, 1, '2025-01-24', '09:25:00', 3200.00, 3520.00, 3600.00, 0.00, 80.00),
(2, 2, 'Online', 7, 2, '2025-01-24', '09:30:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(3, 3, 'In-Store', 4, 3, '2025-01-24', '09:35:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(4, 4, 'Online', 6, 4, '2025-01-24', '09:40:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(5, 5, 'In-Store', 3, 5, '2025-01-24', '09:45:00', 3700.00, 4070.00, 4100.00, 0.00, 30.00),
(1, 1, 'Online', 5, 1, '2025-01-25', '09:00:00', 5100.00, 5610.00, 5700.00, 200.00, 90.00),
(2, 2, 'In-Store', 2, 2, '2025-01-25', '09:05:00', 3300.00, 3630.00, 3700.00, 0.00, 70.00),
(3, 3, 'Online', 8, 3, '2025-01-25', '09:10:00', 5800.00, 6380.00, 6400.00, 500.00, 20.00),
(4, 4, 'In-Store', 4, 4, '2025-01-25', '09:15:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(5, 5, 'Online', 6, 5, '2025-01-25', '09:20:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(1, 1, 'In-Store', 3, 1, '2025-01-25', '09:25:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(2, 2, 'Online', 5, 2, '2025-01-25', '09:30:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(3, 3, 'In-Store', 2, 3, '2025-01-25', '09:35:00', 3400.00, 3740.00, 3800.00, 0.00, 60.00),
(4, 4, 'Online', 7, 4, '2025-01-25', '09:40:00', 5600.00, 6160.00, 6200.00, 300.00, 40.00),
(5, 5, 'In-Store', 4, 5, '2025-01-25', '09:45:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(1, 1, 'Online', 6, 1, '2025-01-26', '09:00:00', 5300.00, 5830.00, 5900.00, 500.00, 70.00),
(2, 2, 'In-Store', 3, 2, '2025-01-26', '09:05:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(3, 3, 'Online', 5, 3, '2025-01-26', '09:10:00', 5100.00, 5610.00, 5700.00, 200.00, 90.00),
(4, 4, 'In-Store', 2, 4, '2025-01-26', '09:15:00', 3200.00, 3520.00, 3600.00, 0.00, 80.00),
(5, 5, 'Online', 8, 5, '2025-01-26', '09:20:00', 5700.00, 6270.00, 6300.00, 400.00, 30.00),
(1, 1, 'In-Store', 4, 1, '2025-01-26', '09:25:00', 4300.00, 4730.00, 4800.00, 0.00, 70.00),
(2, 2, 'Online', 6, 2, '2025-01-26', '09:30:00', 5500.00, 6050.00, 6100.00, 300.00, 50.00),
(3, 3, 'In-Store', 3, 3, '2025-01-26', '09:35:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(4, 4, 'Online', 5, 4, '2025-01-26', '09:40:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(5, 5, 'In-Store', 2, 5, '2025-01-26', '09:45:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(1, 1, 'Online', 7, 1, '2025-01-27', '09:00:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(2, 2, 'In-Store', 4, 2, '2025-01-27', '09:05:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(3, 3, 'Online', 6, 3, '2025-01-27', '09:10:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(4, 4, 'In-Store', 3, 4, '2025-01-27', '09:15:00', 3700.00, 4070.00, 4100.00, 0.00, 30.00),
(5, 5, 'Online', 5, 5, '2025-01-27', '09:20:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(1, 1, 'In-Store', 2, 1, '2025-01-27', '09:25:00', 3400.00, 3740.00, 3800.00, 0.00, 60.00),
(2, 2, 'Online', 8, 2, '2025-01-27', '09:30:00', 5800.00, 6380.00, 6400.00, 500.00, 20.00),
(3, 3, 'In-Store', 4, 3, '2025-01-27', '09:35:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(4, 4, 'Online', 6, 4, '2025-01-27', '09:40:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(5, 5, 'In-Store', 3, 5, '2025-01-27', '09:45:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(1, 1, 'Online', 5, 1, '2025-01-28', '09:00:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(2, 2, 'In-Store', 2, 2, '2025-01-28', '09:05:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(3, 3, 'Online', 7, 3, '2025-01-28', '09:10:00', 5600.00, 6160.00, 6200.00, 300.00, 40.00),
(4, 4, 'In-Store', 4, 4, '2025-01-28', '09:15:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(5, 5, 'Online', 6, 5, '2025-01-28', '09:20:00', 5400.00, 5940.00, 6000.00, 500.00, 60.00),
(1, 1, 'In-Store', 3, 1, '2025-01-28', '09:25:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(2, 2, 'Online', 5, 2, '2025-01-28', '09:30:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(3, 3, 'In-Store', 2, 3, '2025-01-28', '09:35:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(4, 4, 'Online', 8, 4, '2025-01-28', '09:40:00', 5700.00, 6270.00, 6300.00, 400.00, 30.00),
(5, 5, 'In-Store', 4, 5, '2025-01-28', '09:45:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(1, 1, 'Online', 6, 1, '2025-01-29', '09:00:00', 5500.00, 6050.00, 6100.00, 300.00, 50.00),
(2, 2, 'In-Store', 3, 2, '2025-01-29', '09:05:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(3, 3, 'Online', 5, 3, '2025-01-29', '09:10:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(4, 4, 'In-Store', 2, 4, '2025-01-29', '09:15:00', 3400.00, 3740.00, 3800.00, 0.00, 60.00),
(5, 5, 'Online', 7, 5, '2025-01-29', '09:20:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(1, 1, 'In-Store', 4, 1, '2025-01-29', '09:25:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(2, 2, 'Online', 6, 2, '2025-01-29', '09:30:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(3, 3, 'In-Store', 3, 3, '2025-01-29', '09:35:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(4, 4, 'Online', 5, 4, '2025-01-29', '09:40:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(5, 5, 'In-Store', 2, 5, '2025-01-29', '09:45:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(1, 1, 'Online', 8, 1, '2025-01-30', '09:00:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(2, 2, 'In-Store', 4, 2, '2025-01-30', '09:05:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(3, 3, 'Online', 6, 3, '2025-01-30', '09:10:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(4, 4, 'In-Store', 3, 4, '2025-01-30', '09:15:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(5, 5, 'Online', 5, 5, '2025-01-30', '09:20:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(1, 1, 'In-Store', 2, 1, '2025-01-30', '09:25:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(2, 2, 'Online', 7, 2, '2025-01-30', '09:30:00', 5600.00, 6160.00, 6200.00, 300.00, 40.00),
(3, 3, 'In-Store', 4, 3, '2025-01-30', '09:35:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(4, 4, 'Online', 6, 4, '2025-01-30', '09:40:00', 5400.00, 5940.00, 6000.00, 500.00, 60.00),
(5, 5, 'In-Store', 3, 5, '2025-01-30', '09:45:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(1, 1, 'Online', 5, 1, '2025-01-31', '09:00:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(2, 2, 'In-Store', 2, 2, '2025-01-31', '09:05:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(3, 3, 'Online', 8, 3, '2025-01-31', '09:10:00', 5700.00, 6270.00, 6300.00, 400.00, 30.00),
(4, 4, 'In-Store', 4, 4, '2025-01-31', '09:15:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(5, 5, 'Online', 6, 5, '2025-01-31', '09:20:00', 5500.00, 6050.00, 6100.00, 300.00, 50.00),
(1, 1, 'In-Store', 3, 1, '2025-01-31', '09:25:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(2, 2, 'Online', 5, 2, '2025-01-31', '09:30:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(3, 3, 'In-Store', 2, 3, '2025-01-31', '09:35:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(4, 4, 'Online', 7, 4, '2025-01-31', '09:40:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(5, 5, 'In-Store', 4, 5, '2025-01-31', '09:45:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(1, 1, 'Online', 6, 1, '2025-02-01', '09:00:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(2, 2, 'In-Store', 3, 2, '2025-02-01', '09:05:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(3, 3, 'Online', 5, 3, '2025-02-01', '09:10:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(4, 4, 'In-Store', 2, 4, '2025-02-01', '09:15:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(5, 5, 'Online', 8, 5, '2025-02-01', '09:20:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(1, 1, 'In-Store', 4, 1, '2025-02-01', '09:25:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(2, 2, 'Online', 6, 2, '2025-02-01', '09:30:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(3, 3, 'In-Store', 3, 3, '2025-02-01', '09:35:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(4, 4, 'Online', 5, 4, '2025-02-01', '09:40:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(5, 5, 'In-Store', 2, 5, '2025-02-01', '09:45:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(1, 1, 'Online', 7, 1, '2025-02-02', '09:00:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(2, 2, 'In-Store', 4, 2, '2025-02-02', '09:05:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(3, 3, 'Online', 6, 3, '2025-02-02', '09:10:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(4, 4, 'In-Store', 3, 4, '2025-02-02', '09:15:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(5, 5, 'Online', 5, 5, '2025-02-02', '09:20:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(1, 1, 'In-Store', 2, 1, '2025-02-02', '09:25:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(2, 2, 'Online', 8, 2, '2025-02-02', '09:30:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(3, 3, 'In-Store', 4, 3, '2025-02-02', '09:35:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(4, 4, 'Online', 6, 4, '2025-02-02', '09:40:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(5, 5, 'In-Store', 3, 5, '2025-02-02', '09:45:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(1, 1, 'Online', 5, 1, '2025-02-03', '09:00:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(2, 2, 'In-Store', 2, 2, '2025-02-03', '09:05:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(3, 3, 'Online', 7, 3, '2025-02-03', '09:10:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(4, 4, 'In-Store', 4, 4, '2025-02-03', '09:15:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(5, 5, 'Online', 6, 5, '2025-02-03', '09:20:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(1, 1, 'In-Store', 3, 1, '2025-02-03', '09:25:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(2, 2, 'Online', 5, 2, '2025-02-03', '09:30:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(3, 3, 'In-Store', 2, 3, '2025-02-03', '09:35:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(4, 4, 'Online', 8, 4, '2025-02-03', '09:40:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(5, 5, 'In-Store', 4, 5, '2025-02-03', '09:45:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(1, 1, 'Online', 6, 1, '2025-02-04', '09:00:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(2, 2, 'In-Store', 3, 2, '2025-02-04', '09:05:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(3, 3, 'Online', 5, 3, '2025-02-04', '09:10:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(4, 4, 'In-Store', 2, 4, '2025-02-04', '09:15:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(5, 5, 'Online', 7, 5, '2025-02-04', '09:20:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(1, 1, 'In-Store', 4, 1, '2025-02-04', '09:25:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(2, 2, 'Online', 6, 2, '2025-02-04', '09:30:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(3, 3, 'In-Store', 3, 3, '2025-02-04', '09:35:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(4, 4, 'Online', 5, 4, '2025-02-04', '09:40:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(5, 5, 'In-Store', 2, 5, '2025-02-04', '09:45:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(1, 1, 'Online', 8, 1, '2025-02-05', '09:00:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(2, 2, 'In-Store', 4, 2, '2025-02-05', '09:05:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(3, 3, 'Online', 6, 3, '2025-02-05', '09:10:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(4, 4, 'In-Store', 3, 4, '2025-02-05', '09:15:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(5, 5, 'Online', 5, 5, '2025-02-05', '09:20:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(1, 1, 'In-Store', 2, 1, '2025-02-05', '09:25:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(2, 2, 'Online', 7, 2, '2025-02-05', '09:30:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(3, 3, 'In-Store', 4, 3, '2025-02-05', '09:35:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(4, 4, 'Online', 6, 4, '2025-02-05', '09:40:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(5, 5, 'In-Store', 3, 5, '2025-02-05', '09:45:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(1, 1, 'Online', 5, 1, '2025-02-06', '09:00:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(2, 2, 'In-Store', 2, 2, '2025-02-06', '09:05:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(3, 3, 'Online', 8, 3, '2025-02-06', '09:10:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(4, 4, 'In-Store', 4, 4, '2025-02-06', '09:15:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(5, 5, 'Online', 6, 5, '2025-02-06', '09:20:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(1, 1, 'In-Store', 3, 1, '2025-02-06', '09:25:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(2, 2, 'Online', 5, 2, '2025-02-06', '09:30:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(3, 3, 'In-Store', 2, 3, '2025-02-06', '09:35:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(4, 4, 'Online', 7, 4, '2025-02-06', '09:40:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(5, 5, 'In-Store', 4, 5, '2025-02-06', '09:45:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(1, 1, 'Online', 6, 1, '2025-02-07', '09:00:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(2, 2, 'In-Store', 3, 2, '2025-02-07', '09:05:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(3, 3, 'Online', 5, 3, '2025-02-07', '09:10:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(4, 4, 'In-Store', 2, 4, '2025-02-07', '09:15:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(5, 5, 'Online', 8, 5, '2025-02-07', '09:20:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(1, 1, 'In-Store', 4, 1, '2025-02-07', '09:25:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(2, 2, 'Online', 6, 2, '2025-02-07', '09:30:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(3, 3, 'In-Store', 3, 3, '2025-02-07', '09:35:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(4, 4, 'Online', 5, 4, '2025-02-07', '09:40:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(5, 5, 'In-Store', 2, 5, '2025-02-07', '09:45:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(1, 1, 'Online', 7, 1, '2025-02-08', '09:00:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(2, 2, 'In-Store', 4, 2, '2025-02-08', '09:05:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(3, 3, 'Online', 6, 3, '2025-02-08', '09:10:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(4, 4, 'In-Store', 3, 4, '2025-02-08', '09:15:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(5, 5, 'Online', 5, 5, '2025-02-08', '09:20:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(1, 1, 'In-Store', 2, 1, '2025-02-08', '09:25:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(2, 2, 'Online', 8, 2, '2025-02-08', '09:30:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(3, 3, 'In-Store', 4, 3, '2025-02-08', '09:35:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(4, 4, 'Online', 6, 4, '2025-02-08', '09:40:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(5, 5, 'In-Store', 3, 5, '2025-02-08', '09:45:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(1, 1, 'Online', 5, 1, '2025-02-09', '09:00:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(2, 2, 'In-Store', 2, 2, '2025-02-09', '09:05:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(3, 3, 'Online', 7, 3, '2025-02-09', '09:10:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(4, 4, 'In-Store', 4, 4, '2025-02-09', '09:15:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(5, 5, 'Online', 6, 5, '2025-02-09', '09:20:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(1, 1, 'In-Store', 3, 1, '2025-02-09', '09:25:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(2, 2, 'Online', 5, 2, '2025-02-09', '09:30:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(3, 3, 'In-Store', 2, 3, '2025-02-09', '09:35:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(4, 4, 'Online', 8, 4, '2025-02-09', '09:40:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(5, 5, 'In-Store', 4, 5, '2025-02-09', '09:45:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(1, 1, 'Online', 5, 1, '2025-02-10', '09:00:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(2, 2, 'In-Store', 2, 2, '2025-02-10', '09:05:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(3, 3, 'Online', 7, 3, '2025-02-10', '09:10:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(4, 4, 'In-Store', 4, 4, '2025-02-10', '09:15:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(5, 5, 'Online', 6, 5, '2025-02-10', '09:20:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(1, 1, 'In-Store', 3, 1, '2025-02-10', '09:25:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(2, 2, 'Online', 5, 2, '2025-02-10', '09:30:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(3, 3, 'In-Store', 2, 3, '2025-02-10', '09:35:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(4, 4, 'Online', 8, 4, '2025-02-10', '09:40:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(5, 5, 'In-Store', 4, 5, '2025-02-10', '09:45:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(1, 1, 'Online', 6, 1, '2025-02-11', '09:00:00', 5500.00, 6050.00, 610.00, 300.00, 50.00),
(2, 2, 'In-Store', 3, 2, '2025-02-11', '09:05:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(3, 3, 'Online', 5, 3, '2025-02-11', '09:10:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(4, 4, 'In-Store', 2, 4, '2025-02-11', '09:15:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(5, 5, 'Online', 8, 5, '2025-02-11', '09:20:00', 5700.00, 6270.00, 6300.00, 400.00, 30.00),
(1, 1, 'In-Store', 4, 1, '2025-02-11', '09:25:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(2, 2, 'Online', 6, 2, '2025-02-11', '09:30:00', 5500.00, 6050.00, 6100.00, 300.00, 50.00),
(3, 3, 'In-Store', 3, 3, '2025-02-11', '09:35:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(4, 4, 'Online', 5, 4, '2025-02-11', '09:40:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(5, 5, 'In-Store', 2, 5, '2025-02-11', '09:45:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(1, 1, 'Online', 7, 1, '2025-02-12', '09:00:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(2, 2, 'In-Store', 4, 2, '2025-02-12', '09:05:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(3, 3, 'Online', 6, 3, '2025-02-12', '09:10:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(4, 4, 'In-Store', 3, 4, '2025-02-12', '09:15:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(5, 5, 'Online', 5, 5, '2025-02-12', '09:20:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(1, 1, 'In-Store', 2, 1, '2025-02-12', '09:25:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(2, 2, 'Online', 8, 2, '2025-02-12', '09:30:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(3, 3, 'In-Store', 4, 3, '2025-02-12', '09:35:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(4, 4, 'Online', 6, 4, '2025-02-12', '09:40:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(5, 5, 'In-Store', 3, 5, '2025-02-12', '09:45:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(1, 1, 'Online', 5, 1, '2025-02-13', '09:00:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(2, 2, 'In-Store', 2, 2, '2025-02-13', '09:05:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(3, 3, 'Online', 7, 3, '2025-02-13', '09:10:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(4, 4, 'In-Store', 4, 4, '2025-02-13', '09:15:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(5, 5, 'Online', 6, 5, '2025-02-13', '09:20:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(1, 1, 'In-Store', 3, 1, '2025-02-13', '09:25:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(2, 2, 'Online', 5, 2, '2025-02-13', '09:30:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(3, 3, 'In-Store', 2, 3, '2025-02-13', '09:35:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(4, 4, 'Online', 8, 4, '2025-02-13', '09:40:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(5, 5, 'In-Store', 4, 5, '2025-02-13', '09:45:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(1, 1, 'Online', 6, 1, '2025-02-14', '09:00:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(2, 2, 'In-Store', 3, 2, '2025-02-14', '09:05:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(3, 3, 'Online', 5, 3, '2025-02-14', '09:10:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(4, 4, 'In-Store', 2, 4, '2025-02-14', '09:15:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(5, 5, 'Online', 7, 5, '2025-02-14', '09:20:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(1, 1, 'In-Store', 4, 1, '2025-02-14', '09:25:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(2, 2, 'Online', 6, 2, '2025-02-14', '09:30:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(3, 3, 'In-Store', 3, 3, '2025-02-14', '09:35:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(4, 4, 'Online', 5, 4, '2025-02-14', '09:40:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(5, 5, 'In-Store', 2, 5, '2025-02-14', '09:45:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(1, 1, 'Online', 8, 1, '2025-02-15', '09:00:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(2, 2, 'In-Store', 4, 2, '2025-02-15', '09:05:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(3, 3, 'Online', 6, 3, '2025-02-15', '09:10:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(4, 4, 'In-Store', 3, 4, '2025-02-15', '09:15:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(5, 5, 'Online', 5, 5, '2025-02-15', '09:20:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(1, 1, 'In-Store', 2, 1, '2025-02-15', '09:25:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(2, 2, 'Online', 7, 2, '2025-02-15', '09:30:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(3, 3, 'In-Store', 4, 3, '2025-02-15', '09:35:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(4, 4, 'Online', 6, 4, '2025-02-15', '09:40:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(5, 5, 'In-Store', 3, 5, '2025-02-15', '09:45:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(1, 1, 'Online', 5, 1, '2025-02-16', '09:00:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(2, 2, 'In-Store', 2, 2, '2025-02-16', '09:05:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(3, 3, 'Online', 8, 3, '2025-02-16', '09:10:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(4, 4, 'In-Store', 4, 4, '2025-02-16', '09:15:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(5, 5, 'Online', 6, 5, '2025-02-16', '09:20:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(1, 1, 'In-Store', 3, 1, '2025-02-16', '09:25:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(2, 2, 'Online', 5, 2, '2025-02-16', '09:30:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(3, 3, 'In-Store', 2, 3, '2025-02-16', '09:35:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(4, 4, 'Online', 7, 4, '2025-02-16', '09:40:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(5, 5, 'In-Store', 4, 5, '2025-02-16', '09:45:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(1, 1, 'Online', 6, 1, '2025-02-17', '09:00:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(2, 2, 'In-Store', 3, 2, '2025-02-17', '09:05:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(3, 3, 'Online', 5, 3, '2025-02-17', '09:10:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(4, 4, 'In-Store', 2, 4, '2025-02-17', '09:15:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(5, 5, 'Online', 8, 5, '2025-02-17', '09:20:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(1, 1, 'In-Store', 4, 1, '2025-02-17', '09:25:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(2, 2, 'Online', 6, 2, '2025-02-17', '09:30:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(3, 3, 'In-Store', 3, 3, '2025-02-17', '09:35:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(4, 4, 'Online', 5, 4, '2025-02-17', '09:40:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(5, 5, 'In-Store', 2, 5, '2025-02-17', '09:45:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(1, 1, 'Online', 7, 1, '2025-02-18', '09:00:00', 5600.00, 6160.00, 620.00, 400.00, 40.00),
(2, 2, 'In-Store', 4, 2, '2025-02-18', '09:05:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(3, 3, 'Online', 6, 3, '2025-02-18', '09:10:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(4, 4, 'In-Store', 3, 4, '2025-02-18', '09:15:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(5, 5, 'Online', 5, 5, '2025-02-18', '09:20:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(1, 1, 'In-Store', 2, 1, '2025-02-18', '09:25:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(2, 2, 'Online', 8, 2, '2025-02-18', '09:30:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(3, 3, 'In-Store', 4, 3, '2025-02-18', '09:35:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(4, 4, 'Online', 6, 4, '2025-02-18', '09:40:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(5, 5, 'In-Store', 3, 5, '2025-02-18', '09:45:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(1, 1, 'Online', 5, 1, '2025-02-19', '09:00:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(2, 2, 'In-Store', 2, 2, '2025-02-19', '09:05:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(3, 3, 'Online', 7, 3, '2025-02-19', '09:10:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(4, 4, 'In-Store', 4, 4, '2025-02-19', '09:15:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(5, 5, 'Online', 6, 5, '2025-02-19', '09:20:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(1, 1, 'In-Store', 3, 1, '2025-02-19', '09:25:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(2, 2, 'Online', 5, 2, '2025-02-19', '09:30:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(3, 3, 'In-Store', 2, 3, '2025-02-19', '09:35:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(4, 4, 'Online', 8, 4, '2025-02-19', '09:40:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(5, 5, 'In-Store', 4, 5, '2025-02-19', '09:45:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(1, 1, 'Online', 6, 1, '2025-02-20', '09:00:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(2, 2, 'In-Store', 3, 2, '2025-02-20', '09:05:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(3, 3, 'Online', 5, 3, '2025-02-20', '09:10:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(4, 4, 'In-Store', 2, 4, '2025-02-20', '09:15:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(5, 5, 'Online', 7, 5, '2025-02-20', '09:20:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(1, 1, 'In-Store', 4, 1, '2025-02-20', '09:25:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(2, 2, 'Online', 6, 2, '2025-02-20', '09:30:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(3, 3, 'In-Store', 3, 3, '2025-02-20', '09:35:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(4, 4, 'Online', 5, 4, '2025-02-20', '09:40:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(5, 5, 'In-Store', 2, 5, '2025-02-20', '09:45:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(1, 1, 'Online', 8, 1, '2025-02-21', '09:00:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(2, 2, 'In-Store', 4, 2, '2025-02-21', '09:05:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(3, 3, 'Online', 6, 3, '2025-02-21', '09:10:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(4, 4, 'In-Store', 3, 4, '2025-02-21', '09:15:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(5, 5, 'Online', 5, 5, '2025-02-21', '09:20:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(1, 1, 'In-Store', 2, 1, '2025-02-21', '09:25:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(2, 2, 'Online', 7, 2, '2025-02-21', '09:30:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(3, 3, 'In-Store', 4, 3, '2025-02-21', '09:35:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(4, 4, 'Online', 6, 4, '2025-02-21', '09:40:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(5, 5, 'In-Store', 3, 5, '2025-02-21', '09:45:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(1, 1, 'Online', 5, 1, '2025-02-22', '09:00:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(2, 2, 'In-Store', 2, 2, '2025-02-22', '09:05:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(3, 3, 'Online', 8, 3, '2025-02-22', '09:10:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(4, 4, 'In-Store', 4, 4, '2025-02-22', '09:15:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(5, 5, 'Online', 6, 5, '2025-02-22', '09:20:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(1, 1, 'In-Store', 3, 1, '2025-02-22', '09:25:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(2, 2, 'Online', 5, 2, '2025-02-22', '09:30:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(3, 3, 'In-Store', 2, 3, '2025-02-22', '09:35:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(4, 4, 'Online', 7, 4, '2025-02-22', '09:40:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(5, 5, 'In-Store', 4, 5, '2025-02-22', '09:45:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(1, 1, 'Online', 6, 1, '2025-02-23', '09:00:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(2, 2, 'In-Store', 3, 2, '2025-02-23', '09:09:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(3, 3, 'Online', 5, 3, '2025-02-23', '09:10:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(4, 4, 'In-Store', 2, 4, '2025-02-23', '09:15:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(5, 5, 'Online', 8, 5, '2025-02-23', '09:20:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(1, 1, 'In-Store', 4, 1, '2025-02-23', '09:25:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(2, 2, 'Online', 6, 2, '2025-02-23', '09:30:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(3, 3, 'In-Store', 3, 3, '2025-02-23', '09:35:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(4, 4, 'Online', 5, 4, '2025-02-23', '09:40:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(5, 5, 'In-Store', 2, 5, '2025-02-23', '09:45:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(1, 1, 'Online', 7, 1, '2025-02-24', '09:00:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(2, 2, 'In-Store', 4, 2, '2025-02-24', '09:05:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(3, 3, 'Online', 6, 3, '2025-02-24', '09:10:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(4, 4, 'In-Store', 3, 4, '2025-02-24', '09:15:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(5, 5, 'Online', 5, 5, '2025-02-24', '09:20:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(1, 1, 'In-Store', 2, 1, '2025-02-24', '09:25:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(2, 2, 'Online', 8, 2, '2025-02-24', '09:30:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(3, 3, 'In-Store', 4, 3, '2025-02-24', '09:35:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(4, 4, 'Online', 6, 4, '2025-02-24', '09:40:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(5, 5, 'In-Store', 3, 5, '2025-02-24', '09:45:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(1, 1, 'Online', 5, 1, '2025-02-25', '09:00:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(2, 2, 'In-Store', 2, 2, '2025-02-25', '09:05:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(3, 3, 'Online', 7, 3, '2025-02-25', '09:10:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(4, 4, 'In-Store', 4, 4, '2025-02-25', '09:15:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(5, 5, 'Online', 6, 5, '2025-02-25', '09:20:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(1, 1, 'In-Store', 3, 1, '2025-02-25', '09:25:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(2, 2, 'Online', 5, 2, '2025-02-25', '09:30:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(3, 3, 'In-Store', 2, 3, '2025-02-25', '09:35:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(4, 4, 'Online', 8, 4, '2025-02-25', '09:40:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(5, 5, 'In-Store', 4, 5, '2025-02-25', '09:45:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(1, 1, 'Online', 6, 1, '2025-02-26', '09:00:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(2, 2, 'In-Store', 3, 2, '2025-02-26', '09:05:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(3, 3, 'Online', 5, 3, '2025-02-26', '09:10:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(4, 4, 'In-Store', 2, 4, '2025-02-26', '09:15:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(5, 5, 'Online', 7, 5, '2025-02-26', '09:20:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(1, 1, 'In-Store', 4, 1, '2025-02-26', '09:25:00', 4100.00, 451.00, 4600.00, 0.00, 90.00),
(2, 2, 'Online', 6, 2, '2025-02-26', '09:30:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(3, 3, 'In-Store', 3, 3, '2025-02-26', '09:35:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(4, 4, 'Online', 5, 4, '2025-02-26', '09:40:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(5, 5, 'In-Store', 2, 5, '2025-02-26', '09:45:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(1, 1, 'Online', 8, 1, '2025-02-27', '09:00:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(2, 2, 'In-Store', 4, 2, '2025-02-27', '09:05:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(3, 3, 'Online', 6, 3, '2025-02-27', '09:10:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(4, 4, 'In-Store', 3, 4, '2025-02-27', '09:15:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(5, 5, 'Online', 5, 5, '2025-02-27', '09:20:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(1, 1, 'In-Store', 2, 1, '2025-02-27', '09:25:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(2, 2, 'Online', 7, 2, '2025-02-27', '09:30:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(3, 3, 'In-Store', 4, 3, '2025-02-27', '09:35:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(4, 4, 'Online', 6, 4, '2025-02-27', '09:40:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(5, 5, 'In-Store', 3, 5, '2025-02-27', '09:45:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(1, 1, 'Online', 5, 1, '2025-02-28', '09:00:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(2, 2, 'In-Store', 2, 2, '2025-02-28', '09:05:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(3, 3, 'Online', 7, 3, '2025-02-28', '09:10:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(4, 4, 'In-Store', 4, 4, '2025-02-28', '09:15:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(5, 5, 'Online', 6, 5, '2025-02-28', '09:20:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(1, 1, 'In-Store', 3, 1, '2025-02-28', '09:25:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(2, 2, 'Online', 5, 2, '2025-02-28', '09:30:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(3, 3, 'In-Store', 2, 3, '2025-02-28', '09:35:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(4, 4, 'Online', 8, 4, '2025-02-28', '09:40:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(5, 5, 'In-Store', 4, 5, '2025-02-28', '09:45:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(1, 1, 'Online', 6, 1, '2025-03-01', '09:00:00', 550.00, 6050.00, 6100.00, 400.00, 50.00),
(2, 2, 'In-Store', 3, 2, '2025-03-01', '09:05:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(3, 3, 'Online', 5, 3, '2025-03-01', '09:10:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(4, 4, 'In-Store', 2, 4, '2025-03-01', '09:15:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(5, 5, 'Online', 7, 5, '2025-03-01', '09:20:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(1, 1, 'In-Store', 4, 1, '2025-03-01', '09:25:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(2, 2, 'Online', 6, 2, '2025-03-01', '09:30:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(3, 3, 'In-Store', 3, 3, '2025-03-01', '09:35:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(4, 4, 'Online', 5, 4, '2025-03-01', '09:40:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(5, 5, 'In-Store', 2, 5, '2025-03-01', '09:45:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(1, 1, 'Online', 5, 1, '2025-03-02', '09:00:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(2, 2, 'In-Store', 2, 2, '2025-03-02', '09:05:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(3, 3, 'Online', 7, 3, '2025-03-02', '09:10:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(4, 4, 'In-Store', 4, 4, '2025-03-02', '09:15:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(5, 5, 'Online', 6, 5, '2025-03-02', '09:20:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(1, 1, 'In-Store', 3, 1, '2025-03-02', '09:25:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(2, 2, 'Online', 5, 2, '2025-03-02', '09:30:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(3, 3, 'In-Store', 2, 3, '2025-03-02', '09:35:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(4, 4, 'Online', 8, 4, '2025-03-02', '09:40:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(5, 5, 'In-Store', 4, 5, '2025-03-02', '09:45:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(1, 1, 'Online', 6, 1, '2025-03-03', '09:00:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(2, 2, 'In-Store', 3, 2, '2025-03-03', '09:05:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(3, 3, 'Online', 5, 3, '2025-03-03', '09:10:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(4, 4, 'In-Store', 2, 4, '2025-03-03', '09:15:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(5, 5, 'Online', 7, 5, '2025-03-03', '09:20:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(1, 1, 'In-Store', 4, 1, '2025-03-03', '09:25:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(2, 2, 'Online', 6, 2, '2025-03-03', '09:30:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(3, 3, 'In-Store', 3, 3, '2025-03-03', '09:35:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(4, 4, 'Online', 5, 4, '2025-03-03', '09:40:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(5, 5, 'In-Store', 2, 5, '2025-03-03', '09:45:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(1, 1, 'Online', 8, 1, '2025-03-04', '09:00:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(2, 2, 'In-Store', 4, 2, '2025-03-04', '09:05:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(3, 3, 'Online', 6, 3, '2025-03-04', '09:10:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(4, 4, 'In-Store', 3, 4, '2025-03-04', '09:15:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(5, 5, 'Online', 5, 5, '2025-03-04', '09:20:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(1, 1, 'In-Store', 2, 1, '2025-03-04', '09:25:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(2, 2, 'Online', 7, 2, '2025-03-04', '09:30:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(3, 3, 'In-Store', 4, 3, '2025-03-04', '09:35:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(4, 4, 'Online', 6, 4, '2025-03-04', '09:40:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(5, 5, 'In-Store', 3, 5, '2025-03-04', '09:45:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(1, 1, 'Online', 5, 1, '2025-03-05', '09:00:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(2, 2, 'In-Store', 2, 2, '2025-03-05', '09:05:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(3, 3, 'Online', 8, 3, '2025-03-05', '09:10:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(4, 4, 'In-Store', 4, 4, '2025-03-05', '09:15:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(5, 5, 'Online', 6, 5, '2025-03-05', '09:20:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(1, 1, 'In-Store', 3, 1, '2025-03-05', '09:25:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(2, 2, 'Online', 5, 2, '2025-03-05', '09:30:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(3, 3, 'In-Store', 2, 3, '2025-03-05', '09:35:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(4, 4, 'Online', 7, 4, '2025-03-05', '09:40:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(5, 5, 'In-Store', 4, 5, '2025-03-05', '09:45:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(1, 1, 'Online', 6, 1, '2025-03-06', '09:00:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(2, 2, 'In-Store', 3, 2, '2025-03-06', '09:05:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(3, 3, 'Online', 5, 3, '2025-03-06', '09:10:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(4, 4, 'In-Store', 2, 4, '2025-03-06', '09:15:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(5, 5, 'Online', 8, 5, '2025-03-06', '09:20:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(1, 1, 'In-Store', 4, 1, '2025-03-06', '09:25:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(2, 2, 'Online', 6, 2, '2025-03-06', '09:30:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(3, 3, 'In-Store', 3, 3, '2025-03-06', '09:35:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(4, 4, 'Online', 5, 4, '2025-03-06', '09:40:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(5, 5, 'In-Store', 2, 5, '2025-03-06', '09:45:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(1, 1, 'Online', 7, 1, '2025-03-07', '09:00:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(2, 2, 'In-Store', 4, 2, '2025-03-07', '09:05:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(3, 3, 'Online', 6, 3, '2025-03-07', '09:10:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(4, 4, 'In-Store', 3, 4, '2025-03-07', '09:15:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(5, 5, 'Online', 5, 5, '2025-03-07', '09:20:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(1, 1, 'In-Store', 2, 1, '2025-03-07', '09:25:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(2, 2, 'Online', 8, 2, '2025-03-07', '09:30:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(3, 3, 'In-Store', 4, 3, '2025-03-07', '09:35:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(4, 4, 'Online', 6, 4, '2025-03-07', '09:40:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(5, 5, 'In-Store', 3, 5, '2025-03-07', '09:45:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(1, 1, 'Online', 5, 1, '2025-03-08', '09:00:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(2, 2, 'In-Store', 2, 2, '2025-03-08', '09:05:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(3, 3, 'Online', 7, 3, '2025-03-08', '09:10:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(4, 4, 'In-Store', 4, 4, '2025-03-08', '09:15:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(5, 5, 'Online', 6, 5, '2025-03-08', '09:20:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(1, 1, 'In-Store', 3, 1, '2025-03-08', '09:25:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(2, 2, 'Online', 5, 2, '2025-03-08', '09:30:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(3, 3, 'In-Store', 2, 3, '2025-03-08', '09:35:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(4, 4, 'Online', 8, 4, '2025-03-08', '09:40:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(5, 5, 'In-Store', 4, 5, '2025-03-08', '09:45:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(1, 1, 'Online', 6, 1, '2025-03-09', '09:00:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(2, 2, 'In-Store', 3, 2, '2025-03-09', '09:05:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(3, 3, 'Online', 5, 3, '2025-03-09', '09:10:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(4, 4, 'In-Store', 2, 4, '2025-03-09', '09:15:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(5, 5, 'Online', 7, 5, '2025-03-09', '09:20:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(1, 1, 'In-Store', 4, 1, '2025-03-09', '09:25:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(2, 2, 'Online', 6, 2, '2025-03-09', '09:30:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(3, 3, 'In-Store', 3, 3, '2025-03-09', '09:35:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(4, 4, 'Online', 5, 4, '2025-03-09', '09:40:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(5, 5, 'In-Store', 2, 5, '2025-03-09', '09:45:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(1, 1, 'Online', 8, 1, '2025-03-10', '09:00:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(2, 2, 'In-Store', 4, 2, '2025-03-10', '09:05:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(3, 3, 'Online', 6, 3, '2025-03-10', '09:10:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(4, 4, 'In-Store', 3, 4, '2025-03-10', '09:15:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(5, 5, 'Online', 5, 5, '2025-03-10', '09:20:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(1, 1, 'In-Store', 2, 1, '2025-03-10', '09:25:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(2, 2, 'Online', 7, 2, '2025-03-10', '09:30:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(3, 3, 'In-Store', 4, 3, '2025-03-10', '09:35:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(4, 4, 'Online', 6, 4, '2025-03-10', '09:40:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(5, 5, 'In-Store', 3, 5, '2025-03-10', '09:45:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(1, 1, 'Online', 5, 1, '2025-03-11', '09:00:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(2, 2, 'In-Store', 2, 2, '2025-03-11', '09:05:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(3, 3, 'Online', 8, 3, '2025-03-11', '09:10:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(4, 4, 'In-Store', 4, 4, '2025-03-11', '09:15:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(5, 5, 'Online', 6, 5, '2025-03-11', '09:20:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(1, 1, 'In-Store', 3, 1, '2025-03-11', '09:25:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(2, 2, 'Online', 5, 2, '2025-03-11', '09:30:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(3, 3, 'In-Store', 2, 3, '2025-03-11', '09:35:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(4, 4, 'Online', 7, 4, '2025-03-11', '09:40:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(5, 5, 'In-Store', 4, 5, '2025-03-11', '09:45:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(1, 1, 'Online', 6, 1, '2025-03-12', '09:00:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(2, 2, 'In-Store', 3, 2, '2025-03-12', '09:05:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(3, 3, 'Online', 5, 3, '2025-03-12', '09:10:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(4, 4, 'In-Store', 2, 4, '2025-03-12', '09:15:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(5, 5, 'Online', 8, 5, '2025-03-12', '09:20:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(1, 1, 'In-Store', 4, 1, '2025-03-12', '09:25:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(2, 2, 'Online', 6, 2, '2025-03-12', '09:30:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(3, 3, 'In-Store', 3, 3, '2025-03-12', '09:35:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(4, 4, 'Online', 5, 4, '2025-03-12', '09:40:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(5, 5, 'In-Store', 2, 5, '2025-03-12', '09:45:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(1, 1, 'Online', 7, 1, '2025-03-13', '09:00:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(2, 2, 'In-Store', 4, 2, '2025-03-13', '09:05:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(3, 3, 'Online', 6, 3, '2025-03-13', '09:10:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(4, 4, 'In-Store', 3, 4, '2025-03-13', '09:15:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(5, 5, 'Online', 5, 5, '2025-03-13', '09:20:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(1, 1, 'In-Store', 2, 1, '2025-03-13', '09:25:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(2, 2, 'Online', 8, 2, '2025-03-13', '09:30:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(3, 3, 'In-Store', 4, 3, '2025-03-13', '09:35:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(4, 4, 'Online', 6, 4, '2025-03-13', '09:40:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(5, 5, 'In-Store', 3, 5, '2025-03-13', '09:45:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(1, 1, 'Online', 5, 1, '2025-03-14', '09:00:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(2, 2, 'In-Store', 2, 2, '2025-03-14', '09:05:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(3, 3, 'Online', 7, 3, '2025-03-14', '09:10:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(4, 4, 'In-Store', 4, 4, '2025-03-14', '09:15:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(5, 5, 'Online', 6, 5, '2025-03-14', '09:20:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(1, 1, 'In-Store', 3, 1, '2025-03-14', '09:25:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(2, 2, 'Online', 5, 2, '2025-03-14', '09:30:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(3, 3, 'In-Store', 2, 3, '2025-03-14', '09:35:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(4, 4, 'Online', 8, 4, '2025-03-14', '09:40:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(5, 5, 'In-Store', 4, 5, '2025-03-14', '09:45:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(1, 1, 'Online', 6, 1, '2025-03-15', '09:00:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(2, 2, 'In-Store', 3, 2, '2025-03-15', '09:05:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(3, 3, 'Online', 5, 3, '2025-03-15', '09:10:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(4, 4, 'In-Store', 2, 4, '2025-03-15', '09:15:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(5, 5, 'Online', 7, 5, '2025-03-15', '09:20:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(1, 1, 'In-Store', 4, 1, '2025-03-15', '09:25:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(2, 2, 'Online', 6, 2, '2025-03-15', '09:30:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(3, 3, 'In-Store', 3, 3, '2025-03-15', '09:35:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(4, 4, 'Online', 5, 4, '2025-03-15', '09:40:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(5, 5, 'In-Store', 2, 5, '2025-03-15', '09:45:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(1, 1, 'Online', 8, 1, '2025-03-16', '09:00:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(2, 2, 'In-Store', 4, 2, '2025-03-16', '09:05:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(3, 3, 'Online', 6, 3, '2025-03-16', '09:10:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(4, 4, 'In-Store', 3, 4, '2025-03-16', '09:15:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(5, 5, 'Online', 5, 5, '2025-03-16', '09:20:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(1, 1, 'In-Store', 2, 1, '2025-03-16', '09:25:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(2, 2, 'Online', 7, 2, '2025-03-16', '09:30:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(3, 3, 'In-Store', 4, 3, '2025-03-16', '09:35:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(4, 4, 'Online', 6, 4, '2025-03-16', '09:40:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(5, 5, 'In-Store', 3, 5, '2025-03-16', '09:45:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(1, 1, 'Online', 5, 1, '2025-03-17', '09:00:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(2, 2, 'In-Store', 2, 2, '2025-03-17', '09:05:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(3, 3, 'Online', 8, 3, '2025-03-17', '09:10:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(4, 4, 'In-Store', 4, 4, '2025-03-17', '09:15:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(5, 5, 'Online', 6, 5, '2025-03-17', '09:20:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(1, 1, 'In-Store', 3, 1, '2025-03-17', '09:25:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(2, 2, 'Online', 5, 2, '2025-03-17', '09:30:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(3, 3, 'In-Store', 2, 3, '2025-03-17', '09:35:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(4, 4, 'Online', 7, 4, '2025-03-17', '09:40:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(5, 5, 'In-Store', 4, 5, '2025-03-17', '09:45:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(1, 1, 'Online', 6, 1, '2025-03-18', '09:00:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(2, 2, 'In-Store', 3, 2, '2025-03-18', '09:05:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(3, 3, 'Online', 5, 3, '2025-03-18', '09:10:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(4, 4, 'In-Store', 2, 4, '2025-03-18', '09:15:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(5, 5, 'Online', 8, 5, '2025-03-18', '09:20:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(1, 1, 'In-Store', 4, 1, '2025-03-18', '09:25:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(2, 2, 'Online', 6, 2, '2025-03-18', '09:30:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(3, 3, 'In-Store', 3, 3, '2025-03-18', '09:35:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(4, 4, 'Online', 5, 4, '2025-03-18', '09:40:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(5, 5, 'In-Store', 2, 5, '2025-03-18', '09:45:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(1, 1, 'Online', 7, 1, '2025-03-19', '09:00:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(2, 2, 'In-Store', 4, 2, '2025-03-19', '09:05:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(3, 3, 'Online', 6, 3, '2025-03-19', '09:10:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(4, 4, 'In-Store', 3, 4, '2025-03-19', '09:15:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(5, 5, 'Online', 5, 5, '2025-03-19', '09:20:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(1, 1, 'In-Store', 2, 1, '2025-03-19', '09:25:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(2, 2, 'Online', 8, 2, '2025-03-19', '09:30:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(3, 3, 'In-Store', 4, 3, '2025-03-19', '09:35:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(4, 4, 'Online', 6, 4, '2025-03-19', '09:40:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(5, 5, 'In-Store', 3, 5, '2025-03-19', '09:45:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(1, 1, 'Online', 5, 1, '2025-03-20', '09:00:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(2, 2, 'In-Store', 2, 2, '2025-03-20', '09:05:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(3, 3, 'Online', 7, 3, '2025-03-20', '09:10:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(4, 4, 'In-Store', 4, 4, '2025-03-20', '09:15:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(5, 5, 'Online', 6, 5, '2025-03-20', '09:20:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(1, 1, 'In-Store', 3, 1, '2025-03-20', '09:25:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(2, 2, 'Online', 5, 2, '2025-03-20', '09:30:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(3, 3, 'In-Store', 2, 3, '2025-03-20', '09:35:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(4, 4, 'Online', 8, 4, '2025-03-20', '09:40:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(5, 5, 'In-Store', 4, 5, '2025-03-20', '09:45:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(1, 1, 'Online', 6, 1, '2025-03-21', '09:00:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(2, 2, 'In-Store', 3, 2, '2025-03-21', '09:05:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(3, 3, 'Online', 5, 3, '2025-03-21', '09:10:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(4, 4, 'In-Store', 2, 4, '2025-03-21', '09:15:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(5, 5, 'Online', 7, 5, '2025-03-21', '09:20:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(1, 1, 'In-Store', 4, 1, '2025-03-21', '09:25:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(2, 2, 'Online', 6, 2, '2025-03-21', '09:30:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(3, 3, 'In-Store', 3, 3, '2025-03-21', '09:35:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(4, 4, 'Online', 5, 4, '2025-03-21', '09:40:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(5, 5, 'In-Store', 2, 5, '2025-03-21', '09:45:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(1, 1, 'Online', 5, 1, '2025-03-22', '09:00:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(2, 2, 'In-Store', 2, 2, '2025-03-22', '09:05:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(3, 3, 'Online', 7, 3, '2025-03-22', '09:10:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(4, 4, 'In-Store', 4, 4, '2025-03-22', '09:15:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(5, 5, 'Online', 6, 5, '2025-03-22', '09:20:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(1, 1, 'In-Store', 3, 1, '2025-03-22', '09:25:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(2, 2, 'Online', 5, 2, '2025-03-22', '09:30:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(3, 3, 'In-Store', 2, 3, '2025-03-22', '09:35:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(4, 4, 'Online', 8, 4, '2025-03-22', '09:40:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(5, 5, 'In-Store', 4, 5, '2025-03-22', '09:45:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(1, 1, 'Online', 6, 1, '2025-03-23', '09:00:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(2, 2, 'In-Store', 3, 2, '2025-03-23', '09:05:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(3, 3, 'Online', 5, 3, '2025-03-23', '09:10:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(4, 4, 'In-Store', 2, 4, '2025-03-23', '09:15:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(5, 5, 'Online', 7, 5, '2025-03-23', '09:20:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(1, 1, 'In-Store', 4, 1, '2025-03-23', '09:25:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(2, 2, 'Online', 6, 2, '2025-03-23', '09:30:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(3, 3, 'In-Store', 3, 3, '2025-03-23', '09:35:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(4, 4, 'Online', 5, 4, '2025-03-23', '09:40:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(5, 5, 'In-Store', 2, 5, '2025-03-23', '09:45:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(1, 1, 'Online', 8, 1, '2025-03-24', '09:00:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(2, 2, 'In-Store', 4, 2, '2025-03-24', '09:05:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(3, 3, 'Online', 6, 3, '2025-03-24', '09:10:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(4, 4, 'In-Store', 3, 4, '2025-03-24', '09:15:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(5, 5, 'Online', 5, 5, '2025-03-24', '09:20:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(1, 1, 'In-Store', 2, 1, '2025-03-24', '09:25:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(2, 2, 'Online', 7, 2, '2025-03-24', '09:30:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(3, 3, 'In-Store', 4, 3, '2025-03-24', '09:35:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(4, 4, 'Online', 6, 4, '2025-03-24', '09:40:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(5, 5, 'In-Store', 3, 5, '2025-03-24', '09:45:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(1, 1, 'Online', 5, 1, '2025-03-25', '09:00:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(2, 2, 'In-Store', 2, 2, '2025-03-25', '09:05:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(3, 3, 'Online', 8, 3, '2025-03-25', '09:10:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(4, 4, 'In-Store', 4, 4, '2025-03-25', '09:15:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(5, 5, 'Online', 6, 5, '2025-03-25', '09:20:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(1, 1, 'In-Store', 3, 1, '2025-03-25', '09:25:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(2, 2, 'Online', 5, 2, '2025-03-25', '09:30:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(3, 3, 'In-Store', 2, 3, '2025-03-25', '09:35:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(4, 4, 'Online', 7, 4, '2025-03-25', '09:40:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(5, 5, 'In-Store', 4, 5, '2025-03-25', '09:45:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(1, 1, 'Online', 6, 1, '2025-03-26', '09:00:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(2, 2, 'In-Store', 3, 2, '2025-03-26', '09:05:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(3, 3, 'Online', 5, 3, '2025-03-26', '09:10:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(4, 4, 'In-Store', 2, 4, '2025-03-26', '09:15:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(5, 5, 'Online', 8, 5, '2025-03-26', '09:20:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(1, 1, 'In-Store', 4, 1, '2025-03-26', '09:25:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(2, 2, 'Online', 6, 2, '2025-03-26', '09:30:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(3, 3, 'In-Store', 3, 3, '2025-03-26', '09:35:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(4, 4, 'Online', 5, 4, '2025-03-26', '09:40:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(5, 5, 'In-Store', 2, 5, '2025-03-26', '09:45:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(1, 1, 'Online', 7, 1, '2025-03-27', '09:00:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(2, 2, 'In-Store', 4, 2, '2025-03-27', '09:05:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(3, 3, 'Online', 6, 3, '2025-03-27', '09:10:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(4, 4, 'In-Store', 3, 4, '2025-03-27', '09:15:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(5, 5, 'Online', 5, 5, '2025-03-27', '09:20:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(1, 1, 'In-Store', 2, 1, '2025-03-27', '09:25:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(2, 2, 'Online', 8, 2, '2025-03-27', '09:30:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(3, 3, 'In-Store', 4, 3, '2025-03-27', '09:35:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(4, 4, 'Online', 6, 4, '2025-03-27', '09:40:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(5, 5, 'In-Store', 3, 5, '2025-03-27', '09:45:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(1, 1, 'Online', 5, 1, '2025-03-28', '09:00:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(2, 2, 'In-Store', 2, 2, '2025-03-28', '09:05:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(3, 3, 'Online', 7, 3, '2025-03-28', '09:10:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(4, 4, 'In-Store', 4, 4, '2025-03-28', '09:15:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(5, 5, 'Online', 6, 5, '2025-03-28', '09:20:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(1, 1, 'In-Store', 3, 1, '2025-03-28', '09:25:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(2, 2, 'Online', 5, 2, '2025-03-28', '09:30:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(3, 3, 'In-Store', 2, 3, '2025-03-28', '09:35:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(4, 4, 'Online', 8, 4, '2025-03-28', '09:40:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(5, 5, 'In-Store', 4, 5, '2025-03-28', '09:45:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(1, 1, 'Online', 6, 1, '2025-03-29', '09:00:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(2, 2, 'In-Store', 3, 2, '2025-03-29', '09:05:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(3, 3, 'Online', 5, 3, '2025-03-29', '09:10:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(4, 4, 'In-Store', 2, 4, '2025-03-29', '09:15:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(5, 5, 'Online', 7, 5, '2025-03-29', '09:20:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(1, 1, 'In-Store', 4, 1, '2025-03-29', '09:25:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(2, 2, 'Online', 6, 2, '2025-03-29', '09:30:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(3, 3, 'In-Store', 3, 3, '2025-03-29', '09:35:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(4, 4, 'Online', 5, 4, '2025-03-29', '09:40:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(5, 5, 'In-Store', 2, 5, '2025-03-29', '09:45:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(1, 1, 'Online', 8, 1, '2025-03-30', '09:00:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(2, 2, 'In-Store', 4, 2, '2025-03-30', '09:05:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(3, 3, 'Online', 6, 3, '2025-03-30', '09:10:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(4, 4, 'In-Store', 3, 4, '2025-03-30', '09:15:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(5, 5, 'Online', 5, 5, '2025-03-30', '09:20:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(1, 1, 'In-Store', 2, 1, '2025-03-30', '09:25:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(2, 2, 'Online', 7, 2, '2025-03-30', '09:30:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(3, 3, 'In-Store', 4, 3, '2025-03-30', '09:35:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(4, 4, 'Online', 6, 4, '2025-03-30', '09:40:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(5, 5, 'In-Store', 3, 5, '2025-03-30', '09:45:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(1, 1, 'Online', 5, 1, '2025-03-31', '09:00:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(2, 2, 'In-Store', 2, 2, '2025-03-31', '09:05:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(3, 3, 'Online', 8, 3, '2025-03-31', '09:10:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(4, 4, 'In-Store', 4, 4, '2025-03-31', '09:15:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(5, 5, 'Online', 6, 5, '2025-03-31', '09:20:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(1, 1, 'In-Store', 3, 1, '2025-03-31', '09:25:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(2, 2, 'Online', 5, 2, '2025-03-31', '09:30:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(3, 3, 'In-Store', 2, 3, '2025-03-31', '09:35:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(4, 4, 'Online', 7, 4, '2025-03-31', '09:40:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(5, 5, 'In-Store', 4, 5, '2025-03-31', '09:45:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(1, 1, 'Online', 6, 1, '2025-04-01', '09:00:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(2, 2, 'In-Store', 3, 2, '2025-04-01', '09:05:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(3, 3, 'Online', 5, 3, '2025-04-01', '09:10:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(4, 4, 'In-Store', 2, 4, '2025-04-01', '09:15:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(5, 5, 'Online', 8, 5, '2025-04-01', '09:20:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(1, 1, 'In-Store', 4, 1, '2025-04-01', '09:25:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(2, 2, 'Online', 6, 2, '2025-04-01', '09:30:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(3, 3, 'In-Store', 3, 3, '2025-04-01', '09:35:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(4, 4, 'Online', 5, 4, '2025-04-01', '09:40:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(5, 5, 'In-Store', 2, 5, '2025-04-01', '09:45:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(1, 1, 'Online', 7, 1, '2025-04-02', '09:00:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(2, 2, 'In-Store', 4, 2, '2025-04-02', '09:05:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(3, 3, 'Online', 6, 3, '2025-04-02', '09:10:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(4, 4, 'In-Store', 3, 4, '2025-04-02', '09:15:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(5, 5, 'Online', 5, 5, '2025-04-02', '09:20:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(1, 1, 'In-Store', 2, 1, '2025-04-02', '09:25:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(2, 2, 'Online', 8, 2, '2025-04-02', '09:30:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(3, 3, 'In-Store', 4, 3, '2025-04-02', '09:35:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(4, 4, 'Online', 6, 4, '2025-04-02', '09:40:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(5, 5, 'In-Store', 3, 5, '2025-04-02', '09:45:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(1, 1, 'Online', 5, 1, '2025-04-03', '09:00:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(2, 2, 'In-Store', 2, 2, '2025-04-03', '09:05:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(3, 3, 'Online', 7, 3, '2025-04-03', '09:10:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(4, 4, 'In-Store', 4, 4, '2025-04-03', '09:15:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(5, 5, 'Online', 6, 5, '2025-04-03', '09:20:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(1, 1, 'In-Store', 3, 1, '2025-04-03', '09:25:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(2, 2, 'Online', 5, 2, '2025-04-03', '09:30:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(3, 3, 'In-Store', 2, 3, '2025-04-03', '09:35:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(4, 4, 'Online', 8, 4, '2025-04-03', '09:40:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(5, 5, 'In-Store', 4, 5, '2025-04-03', '09:45:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(1, 1, 'Online', 6, 1, '2025-04-04', '09:00:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(2, 2, 'In-Store', 3, 2, '2025-04-04', '09:05:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(3, 3, 'Online', 5, 3, '2025-04-04', '09:10:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(4, 4, 'In-Store', 2, 4, '2025-04-04', '09:15:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(5, 5, 'Online', 7, 5, '2025-04-04', '09:20:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(1, 1, 'In-Store', 4, 1, '2025-04-04', '09:25:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(2, 2, 'Online', 6, 2, '2025-04-04', '09:30:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(3, 3, 'In-Store', 3, 3, '2025-04-04', '09:35:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(4, 4, 'Online', 5, 4, '2025-04-04', '09:40:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(5, 5, 'In-Store', 2, 5, '2025-04-04', '09:45:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(1, 1, 'Online', 8, 1, '2025-04-05', '09:00:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(2, 2, 'In-Store', 4, 2, '2025-04-05', '09:05:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(3, 3, 'Online', 6, 3, '2025-04-05', '09:10:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(4, 4, 'In-Store', 3, 4, '2025-04-05', '09:15:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(5, 5, 'Online', 5, 5, '2025-04-05', '09:20:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(1, 1, 'In-Store', 2, 1, '2025-04-05', '09:25:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(2, 2, 'Online', 7, 2, '2025-04-05', '09:30:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(3, 3, 'In-Store', 4, 3, '2025-04-05', '09:35:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(4, 4, 'Online', 6, 4, '2025-04-05', '09:40:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(5, 5, 'In-Store', 3, 5, '2025-04-05', '09:45:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(1, 1, 'Online', 5, 1, '2025-04-06', '09:00:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(2, 2, 'In-Store', 2, 2, '2025-04-06', '09:05:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(3, 3, 'Online', 8, 3, '2025-04-06', '09:10:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(4, 4, 'In-Store', 4, 4, '2025-04-06', '09:15:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(5, 5, 'Online', 6, 5, '2025-04-06', '09:20:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(1, 1, 'In-Store', 3, 1, '2025-04-06', '09:25:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(2, 2, 'Online', 5, 2, '2025-04-06', '09:30:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(3, 3, 'In-Store', 2, 3, '2025-04-06', '09:35:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(4, 4, 'Online', 7, 4, '2025-04-06', '09:40:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(5, 5, 'In-Store', 4, 5, '2025-04-06', '09:45:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(1, 1, 'Online', 6, 1, '2025-04-07', '09:00:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(2, 2, 'In-Store', 3, 2, '2025-04-07', '09:05:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(3, 3, 'Online', 5, 3, '2025-04-07', '09:10:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(4, 4, 'In-Store', 2, 4, '2025-04-07', '09:15:00', 3600.00, 3960.00, 4000.00, 0.00, 70.00),
(5, 5, 'Online', 8, 5, '2025-04-07', '09:20:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(1, 1, 'In-Store', 4, 1, '2025-04-07', '09:25:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(2, 2, 'Online', 6, 2, '2025-04-07', '09:30:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(3, 3, 'In-Store', 3, 3, '2025-04-07', '09:35:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(4, 4, 'Online', 5, 4, '2025-04-07', '09:40:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(5, 5, 'In-Store', 2, 5, '2025-04-07', '09:45:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(1, 1, 'Online', 7, 1, '2025-04-08', '09:00:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(2, 2, 'In-Store', 4, 2, '2025-04-08', '09:05:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(3, 3, 'Online', 6, 3, '2025-04-08', '09:10:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(4, 4, 'In-Store', 3, 4, '2025-04-08', '09:15:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(5, 5, 'Online', 5, 5, '2025-04-08', '09:20:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(1, 1, 'In-Store', 2, 1, '2025-04-08', '09:25:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(2, 2, 'Online', 8, 2, '2025-04-08', '09:30:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(3, 3, 'In-Store', 4, 3, '2025-04-08', '09:35:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(4, 4, 'Online', 6, 4, '2025-04-08', '09:40:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(5, 5, 'In-Store', 3, 5, '2025-04-08', '09:45:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(1, 1, 'Online', 5, 1, '2025-04-09', '09:00:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(2, 2, 'In-Store', 2, 2, '2025-04-09', '09:05:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(3, 3, 'Online', 7, 3, '2025-04-09', '09:10:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(4, 4, 'In-Store', 4, 4, '2025-04-09', '09:15:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(5, 5, 'Online', 6, 5, '2025-04-09', '09:20:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(1, 1, 'In-Store', 3, 1, '2025-04-09', '09:25:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(2, 2, 'Online', 5, 2, '2025-04-09', '09:30:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(3, 3, 'In-Store', 2, 3, '2025-04-09', '09:35:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00),
(4, 4, 'Online', 8, 4, '2025-04-09', '09:40:00', 5700.00, 6270.00, 6300.00, 500.00, 30.00),
(5, 5, 'In-Store', 4, 5, '2025-04-09', '09:45:00', 4200.00, 4620.00, 4700.00, 0.00, 80.00),
(1, 1, 'Online', 6, 1, '2025-04-10', '09:00:00', 5500.00, 6050.00, 6100.00, 400.00, 50.00),
(2, 2, 'In-Store', 3, 2, '2025-04-10', '09:05:00', 3800.00, 4180.00, 4200.00, 0.00, 20.00),
(3, 3, 'Online', 5, 3, '2025-04-10', '09:10:00', 5200.00, 5720.00, 5800.00, 200.00, 80.00),
(4, 4, 'In-Store', 2, 4, '2025-04-10', '09:15:00', 3500.00, 3850.00, 3900.00, 0.00, 50.00),
(5, 5, 'Online', 7, 5, '2025-04-10', '09:20:00', 5600.00, 6160.00, 6200.00, 400.00, 40.00),
(1, 1, 'In-Store', 4, 1, '2025-04-10', '09:25:00', 4100.00, 4510.00, 4600.00, 0.00, 90.00),
(2, 2, 'Online', 6, 2, '2025-04-10', '09:30:00', 5400.00, 5940.00, 6000.00, 300.00, 60.00),
(3, 3, 'In-Store', 3, 3, '2025-04-10', '09:35:00', 3900.00, 4290.00, 4300.00, 0.00, 10.00),
(4, 4, 'Online', 5, 4, '2025-04-10', '09:40:00', 5300.00, 5830.00, 5900.00, 200.00, 70.00),
(5, 5, 'In-Store', 2, 5, '2025-04-10', '09:45:00', 3600.00, 3960.00, 4000.00, 0.00, 40.00);


INSERT INTO Wishlist (CustomerID, ItemCount, LastUpdatedDate) VALUES
(127, 3, '2025-01-05'),
(342, 7, '2025-02-12'),
(589, 2, '2025-03-01'),
(876, 5, '2025-01-22'),
(234, 8, '2025-02-28'),
(71, 1, '2025-01-15'),
(453, 4, '2025-03-15'),
(89, 6, '2025-02-05'),
(98, 9, '2025-01-30'),
(12, 2, '2025-03-20'),
(321, 5, '2025-02-17'),
(54, 3, '2025-01-10'),
(387, 7, '2025-03-05'),
(143, 4, '2025-02-22'),
(456, 6, '2025-01-25'),
(189, 2, '2025-03-12'),
(234, 8, '2025-02-08'),
(267, 1, '2025-01-18'),
(390, 5, '2025-03-25'),
(123, 3, '2025-02-15'),
(345, 7, '2025-01-12'),
(278, 4, '2025-03-08'),
(401, 6, '2025-02-20'),
(234, 2, '2025-01-28'),
(567, 8, '2025-03-15'),
(390, 1, '2025-02-10'),
(123, 5, '2025-01-20'),
(456, 3, '2025-03-22'),
(589, 7, '2025-02-05'),
(12, 4, '2025-01-15'),
(345, 6, '2025-03-10'),
(278, 2, '2025-02-18'),
(201, 8, '2025-01-25'),
(234, 1, '2025-03-05'),
(467, 5, '2025-02-12'),
(390, 3, '2025-01-30'),
(123, 7, '2025-03-20'),
(456, 4, '2025-02-08'),
(289, 6, '2025-01-18'),
(120, 2, '2025-03-15'),
(345, 8, '2025-02-22'),
(378, 1, '2025-01-10'),
(501, 5, '2025-03-25'),
(234, 3, '2025-02-15'),
(500, 7, '2025-01-12'),
(490, 4, '2025-03-08'),
(123, 6, '2025-02-20'),
(456, 2, '2025-01-28'),
(689, 8, '2025-03-15'),
(12, 1, '2025-02-10'),
(345, 5, '2025-01-20'),
(378, 3, '2025-03-22'),
(401, 7, '2025-02-05'),
(234, 4, '2025-01-15'),
(367, 6, '2025-03-10'),
(290, 2, '2025-02-18'),
(123, 8, '2025-01-25'),
(456, 1, '2025-03-05'),
(389, 5, '2025-02-12'),
(12, 3, '2025-01-30'),
(345, 7, '2025-03-20'),
(578, 4, '2025-02-08'),
(501, 6, '2025-01-18'),
(234, 2, '2025-03-15'),
(367, 8, '2025-02-22'),
(890, 1, '2025-01-10'),
(123, 5, '2025-03-25'),
(456, 3, '2025-02-15'),
(589, 7, '2025-01-12'),
(12, 4, '2025-03-08'),
(345, 6, '2025-02-20'),
(478, 2, '2025-01-28'),
(201, 8, '2025-03-15'),
(234, 1, '2025-02-10'),
(367, 5, '2025-01-20'),
(290, 3, '2025-03-22'),
(123, 7, '2025-02-05'),
(456, 4, '2025-01-15'),
(389, 6, '2025-03-10'),
(12, 2, '2025-02-18'),
(345, 8, '2025-01-25'),
(178, 1, '2025-03-05'),
(601, 5, '2025-02-12'),
(234, 3, '2025-01-30'),
(567, 7, '2025-03-20'),
(290, 4, '2025-02-08'),
(123, 6, '2025-01-18'),
(456, 2, '2025-03-15'),
(189, 8, '2025-02-22'),
(12, 1, '2025-01-10'),
(345, 5, '2025-03-25'),
(678, 3, '2025-02-15'),
(901, 7, '2025-01-12'),
(234, 4, '2025-03-08'),
(567, 6, '2025-02-20'),
(290, 2, '2025-01-28'),
(123, 8, '2025-03-15'),
(456, 1, '2025-02-10'),
(489, 5, '2025-01-20'),
(12, 3, '2025-03-22');

INSERT INTO WishListItems (WishListID, ProductID, Count, ItemDate) VALUES
(1, 3, 2, '2025-01-07'),
(2, 6, 3, '2025-02-14'),
(3, 9, 1, '2025-03-03'),
(4, 12, 4, '2025-01-24'),
(5, 15, 5, '2025-03-01'),
(6, 18, 2, '2025-02-10'),
(7, 21, 3, '2025-01-17'),
(8, 24, 1, '2025-03-17'),
(9, 27, 4, '2025-02-07'),
(10, 30, 5, '2025-01-31'),
(11, 33, 2, '2025-03-22'),
(12, 36, 3, '2025-02-19'),
(13, 39, 1, '2025-01-12'),
(14, 42, 4, '2025-03-07'),
(15, 45, 5, '2025-02-24'),
(16, 48, 2, '2025-01-27'),
(17, 51, 3, '2025-03-14'),
(18, 54, 1, '2025-02-10'),
(19, 57, 4, '2025-01-20'),
(20, 60, 5, '2025-03-27'),
(21, 63, 2, '2025-02-17'),
(22, 66, 3, '2025-01-14'),
(23, 69, 1, '2025-03-10'),
(24, 72, 4, '2025-02-22'),
(25, 75, 5, '2025-01-30'),
(26, 78, 2, '2025-03-17'),
(27, 81, 3, '2025-02-12'),
(28, 84, 1, '2025-01-22'),
(29, 87, 4, '2025-03-24'),
(30, 90, 5, '2025-02-08'),
(31, 93, 2, '2025-01-17'),
(32, 96, 3, '2025-03-12'),
(33, 99, 1, '2025-02-19'),
(34, 102, 4, '2025-01-25'),
(35, 105, 5, '2025-03-05'),
(36, 108, 2, '2025-02-14'),
(37, 111, 3, '2025-01-30'),
(38, 114, 1, '2025-03-20'),
(39, 117, 4, '2025-02-08'),
(40, 120, 5, '2025-01-18'),
(41, 123, 2, '2025-03-15'),
(42, 126, 3, '2025-02-22'),
(43, 129, 1, '2025-01-10'),
(44, 132, 4, '2025-03-25'),
(45, 135, 5, '2025-02-15'),
(46, 138, 2, '2025-01-12'),
(47, 141, 3, '2025-03-08'),
(48, 144, 1, '2025-02-20'),
(49, 147, 4, '2025-01-28'),
(50, 100, 5, '2025-03-15'),
(51, 103, 2, '2025-02-10'),
(52, 106, 3, '2025-01-20'),
(53, 109, 1, '2025-03-22'),
(54, 112, 4, '2025-02-05'),
(55, 115, 5, '2025-01-15'),
(56, 118, 2, '2025-03-10'),
(57, 121, 3, '2025-02-18'),
(58, 124, 1, '2025-01-25'),
(59, 127, 4, '2025-03-05'),
(60, 130, 5, '2025-02-12'),
(61, 133, 2, '2025-01-30'),
(62, 136, 3, '2025-03-20'),
(63, 139, 1, '2025-02-08'),
(64, 142, 4, '2025-01-18'),
(65, 145, 5, '2025-03-15'),
(66, 148, 2, '2025-02-22'),
(67, 151, 3, '2025-01-10'),
(68, 154, 1, '2025-03-25'),
(69, 157, 4, '2025-02-15'),
(70, 160, 5, '2025-01-12'),
(71, 163, 2, '2025-03-08'),
(72, 166, 3, '2025-02-20'),
(73, 169, 1, '2025-01-28'),
(74, 172, 4, '2025-03-15'),
(75, 175, 5, '2025-02-10'),
(76, 178, 2, '2025-01-20'),
(77, 181, 3, '2025-03-22'),
(78, 184, 1, '2025-02-05'),
(79, 187, 4, '2025-01-15'),
(80, 190, 5, '2025-03-10'),
(81, 193, 2, '2025-02-18'),
(82, 196, 3, '2025-01-25'),
(83, 199, 1, '2025-03-05'),
(84, 202, 4, '2025-02-12'),
(85, 205, 5, '2025-01-30'),
(86, 208, 2, '2025-03-20'),
(87, 211, 3, '2025-02-08'),
(88, 214, 1, '2025-01-18'),
(89, 217, 4, '2025-03-15'),
(90, 220, 5, '2025-02-22'),
(91, 223, 2, '2025-01-10'),
(92, 226, 3, '2025-03-25'),
(93, 229, 1, '2025-02-15'),
(94, 232, 4, '2025-01-12'),
(95, 235, 5, '2025-03-08'),
(96, 238, 2, '2025-02-20'),
(97, 241, 3, '2025-01-28'),
(98, 244, 1, '2025-03-15'),
(99, 247, 4, '2025-02-10'),
(100, 200, 5, '2025-01-20'),
(101, 203, 2, '2025-03-22'),
(102, 206, 3, '2025-02-05'),
(103, 209, 1, '2025-01-15'),
(104, 212, 4, '2025-03-10'),
(105, 215, 5, '2025-02-18'),
(106, 218, 2, '2025-01-25'),
(107, 221, 3, '2025-03-05'),
(108, 224, 1, '2025-02-12'),
(109, 227, 4, '2025-01-30'),
(110, 230, 5, '2025-03-20'),
(111, 233, 2, '2025-02-17'),
(112, 236, 3, '2025-01-14'),
(113, 239, 1, '2025-03-10'),
(114, 242, 4, '2025-02-22'),
(115, 245, 5, '2025-01-30'),
(116, 248, 2, '2025-03-17'),
(117, 251, 3, '2025-02-12'),
(117, 254, 1, '2025-01-22'),
(119, 257, 4, '2025-03-24'),
(120, 260, 5, '2025-02-08'),
(121, 263, 2, '2025-01-17'),
(122, 266, 3, '2025-03-12'),
(123, 269, 1, '2025-02-19'),
(124, 272, 4, '2025-01-25'),
(125, 275, 5, '2025-03-05'),
(126, 278, 2, '2025-02-14'),
(127, 281, 3, '2025-01-30'),
(128, 284, 1, '2025-03-20'),
(129, 287, 4, '2025-02-08'),
(130, 290, 5, '2025-01-18'),
(131, 293, 2, '2025-03-15'),
(132, 296, 3, '2025-02-22'),
(133, 299, 1, '2025-01-10'),
(134, 302, 4, '2025-03-25'),
(135, 305, 5, '2025-02-15'),
(136, 308, 2, '2025-01-12'),
(137, 311, 3, '2025-03-08'),
(138, 314, 1, '2025-02-20'),
(139, 317, 4, '2025-01-28'),
(140, 320, 5, '2025-03-15'),
(141, 323, 2, '2025-02-10'),
(142, 326, 3, '2025-01-20'),
(143, 329, 1, '2025-03-22'),
(144, 332, 4, '2025-02-05'),
(145, 335, 5, '2025-01-15'),
(146, 338, 2, '2025-03-10'),
(147, 341, 3, '2025-02-18'),
(148, 344, 1, '2025-01-25'),
(149, 347, 4, '2025-03-05'),
(150, 300, 5, '2025-02-12'),
(151, 303, 2, '2025-01-30'),
(152, 306, 3, '2025-03-20'),
(153, 309, 1, '2025-02-08'),
(154, 312, 4, '2025-01-18'),
(155, 315, 5, '2025-03-15'),
(156, 318, 2, '2025-02-22'),
(157, 321, 3, '2025-01-10'),
(158, 324, 1, '2025-03-25'),
(159, 327, 4, '2025-02-15'),
(160, 330, 5, '2025-01-12'),
(161, 333, 2, '2025-03-08'),
(162, 336, 3, '2025-02-20'),
(163, 339, 1, '2025-01-28'),
(164, 342, 4, '2025-03-15'),
(165, 345, 5, '2025-02-10'),
(166, 348, 2, '2025-01-20'),
(167, 351, 3, '2025-03-22'),
(168, 354, 1, '2025-02-05'),
(169, 357, 4, '2025-01-15'),
(170, 360, 5, '2025-03-10'),
(171, 363, 2, '2025-02-18'),
(172, 366, 3, '2025-01-25'),
(173, 369, 1, '2025-03-05'),
(174, 372, 4, '2025-02-12'),
(175, 375, 5, '2025-01-30'),
(176, 378, 2, '2025-03-20'),
(177, 381, 3, '2025-02-08'),
(178, 384, 1, '2025-01-18'),
(179, 387, 4, '2025-03-15'),
(180, 390, 5, '2025-02-22'),
(181, 393, 2, '2025-01-10'),
(182, 396, 3, '2025-03-25'),
(183, 399, 1, '2025-02-15'),
(184, 402, 4, '2025-01-12'),
(185, 405, 5, '2025-03-08'),
(186, 408, 2, '2025-02-20'),
(187, 411, 3, '2025-01-28'),
(188, 414, 1, '2025-03-15'),
(189, 417, 4, '2025-02-10'),
(190, 420, 5, '2025-01-20'),
(191, 423, 2, '2025-03-22'),
(192, 426, 3, '2025-02-05'),
(193, 429, 1, '2025-01-15'),
(194, 432, 4, '2025-03-10'),
(195, 435, 5, '2025-02-18'),
(196, 438, 2, '2025-01-25'),
(197, 441, 3, '2025-03-05'),
(198, 444, 1, '2025-02-12'),
(199, 447, 4, '2025-01-30'),
(200, 400, 5, '2025-03-20');




INSERT INTO Product (ProductID, ProductName, SellingPrice, Rating, Amount_allocated, InventoryID) VALUES
(1, 'Handloom Scarf', 2857.86, 3.5, 30, 336),
(2, 'Office Shirt', 1491.86, 4.2, 23, 106),
(3, 'Baby Dress', 4583.4, 3.8, 21, 292),
(4, 'Batik Shirt', 531.98, 4.1, 35, 79),
(5, 'Skirt', 1415.43, 4.9, 10, 325),
(6, 'Shirt', 1272.83, 4.7, 24, 573),
(7, 'T-shirt', 1620.54, 3.1, 90, 619),
(8, 'Batik Shirt', 2829.57, 5.0, 95, 623),
(9, 'School Uniform', 4743.91, 4.7, 77, 8),
(10, 'Shirt', 1975.8, 3.1, 29, 513),
(11, 'Kurta', 1198.89, 5.0, 9, 571),
(12, 'Casual Shorts', 1109.1, 3.8, 31, 197),
(13, 'Office Shirt', 2109.58, 3.0, 10, 385),
(14, 'Saree', 2255.49, 4.4, 47, 667),
(15, 'Dress', 3458.13, 4.9, 34, 620),
(16, 'Skirt', 3896.38, 4.5, 53, 631),
(17, 'Wedding Saree', 2024.32, 3.6, 52, 489),
(18, 'Wedding Saree', 799.79, 4.0, 96, 612),
(19, 'School Uniform', 3855.92, 4.0, 83, 533),
(20, 'Shirt', 4974.78, 4.3, 31, 343),
(21, 'Wedding Saree', 739.63, 4.6, 6, 82),
(22, 'Batik Shirt', 1635.12, 3.7, 92, 23),
(23, 'Batik Shirt', 2631.15, 3.2, 60, 141),
(24, 'Batik Shirt', 869.54, 3.3, 6, 577),
(25, 'Kurta', 3506.28, 4.1, 11, 342),
(26, 'Wedding Saree', 4291.94, 3.3, 46, 585),
(27, 'Baby Dress', 2242.4, 3.9, 73, 179),
(28, 'Casual Shorts', 2272.76, 4.2, 81, 666),
(29, 'Kurta', 1041.07, 5.0, 49, 466),
(30, 'School Uniform', 1979.65, 3.0, 44, 141),
(31, 'School Uniform', 4140.84, 3.0, 44, 642),
(32, 'School Uniform', 2661.3, 4.3, 38, 68),
(33, 'Wedding Saree', 660.26, 4.1, 81, 279),
(34, 'T-shirt', 524.44, 3.8, 39, 45),
(35, 'Batik Shirt', 1944.61, 4.4, 63, 537),
(36, 'Batik Shirt', 4714.59, 4.0, 72, 366),
(37, 'School Uniform', 4645.7, 3.2, 94, 95),
(38, 'Baby Dress', 2358.84, 4.1, 99, 211),
(39, 'Wedding Saree', 3079.38, 4.8, 78, 689),
(40, 'Linen Pants', 4079.08, 4.8, 91, 543),
(41, 'Denim Jacket', 2939.08, 4.0, 22, 614),
(42, 'Dress', 3279.83, 4.5, 70, 511),
(43, 'Kurta', 3115.38, 4.1, 75, 100),
(44, 'Baby Dress', 1598.65, 3.3, 51, 462),
(45, 'Dress', 2965.89, 3.7, 63, 35),
(46, 'Skirt', 4513.39, 3.1, 8, 548),
(47, 'Baby Dress', 1434.23, 4.4, 23, 569),
(48, 'Saree', 2941.24, 3.9, 52, 248),
(49, 'Batik Shirt', 3308.92, 3.9, 29, 483),
(50, 'Office Shirt', 4732.14, 4.8, 30, 368);

select*from Product;
SET SQL_SAFE_UPDATES = 0;

DELETE FROM Product;
SET SQL_SAFE_UPDATES = 1;



INSERT INTO Product (ProductID, ProductName, SellingPrice, Rating, Amount_allocated, InventoryID) VALUES
(51, 'Office Shirt', 903.43, 3.3, 42, 287),
(52, 'Denim Jacket', 1464.69, 3.2, 59, 199),
(53, 'Blouse', 3553.14, 4.0, 43, 53),
(54, 'Sarong', 1576.79, 3.2, 61, 110),
(55, 'Sarong', 4321.72, 4.4, 40, 597),
(56, 'Saree', 3236.95, 3.7, 97, 427),
(57, 'Casual Shorts', 1245.27, 4.0, 98, 643),
(58, 'Casual Shorts', 1011.48, 3.8, 34, 595),
(59, 'T-shirt', 4116.77, 3.8, 21, 573),
(60, 'Linen Pants', 3536.03, 4.3, 89, 416),
(61, 'Baby Dress', 592.31, 4.5, 68, 114),
(62, 'Jeans', 4728.25, 3.4, 54, 698),
(63, 'Wedding Saree', 1422.11, 3.3, 80, 587),
(64, 'Kurta', 1781.44, 4.7, 98, 165),
(65, 'Wedding Saree', 1643.9, 4.1, 52, 291),
(66, 'Kurta', 2449.94, 3.9, 17, 361),
(67, 'Handloom Scarf', 523.42, 3.7, 89, 41),
(68, 'Blouse', 1318.48, 3.3, 19, 444),
(69, 'Shirt', 3999.79, 3.9, 47, 571),
(70, 'Kurta', 4062.8, 4.3, 50, 150),
(71, 'Kurta', 3123.4, 5.0, 94, 468),
(72, 'Jeans', 4292.94, 3.4, 13, 434),
(73, 'Denim Jacket', 3511.56, 4.2, 86, 89),
(74, 'Shirt', 4493.51, 3.0, 89, 479),
(75, 'Shirt', 4993.0, 3.4, 81, 273),
(76, 'Dress', 2463.54, 4.8, 51, 34),
(77, 'Batik Shirt', 2363.37, 4.8, 74, 383),
(78, 'School Uniform', 4744.3, 3.3, 80, 357),
(79, 'Wedding Saree', 2280.3, 3.4, 41, 620),
(80, 'Skirt', 1940.99, 3.9, 9, 230),
(81, 'Skirt', 1102.1, 3.2, 44, 467),
(82, 'Handloom Scarf', 4748.31, 3.6, 52, 247),
(83, 'Handloom Scarf', 3913.69, 4.0, 84, 179),
(84, 'Handloom Scarf', 4474.35, 4.5, 26, 298),
(85, 'Shirt', 2324.61, 3.2, 74, 248),
(86, 'Linen Pants', 4426.25, 4.2, 55, 152),
(87, 'Denim Jacket', 1838.04, 4.9, 28, 695),
(88, 'Jeans', 2004.31, 3.0, 23, 491),
(89, 'T-shirt', 3509.21, 4.4, 49, 268),
(90, 'Batik Shirt', 1112.19, 4.2, 59, 188),
(91, 'Wedding Saree', 4546.32, 4.3, 85, 100),
(92, 'Kurta', 2661.52, 3.3, 31, 159),
(93, 'Linen Pants', 2544.69, 4.8, 49, 436),
(94, 'Sarong', 4191.98, 4.7, 61, 601),
(95, 'Shirt', 4063.9, 3.5, 93, 485),
(96, 'School Uniform', 2303.1, 3.7, 59, 492),
(97, 'Handloom Scarf', 3468.13, 4.5, 45, 581),
(98, 'Office Shirt', 3859.92, 4.4, 14, 3),
(99, 'Casual Shorts', 1044.29, 4.2, 34, 699),
(100, 'Dress', 3019.45, 3.5, 10, 469),
(101, 'Batik Shirt', 1440.58, 4.5, 35, 181),
(102, 'Linen Pants', 1403.96, 4.7, 76, 634),
(103, 'Denim Jacket', 3170.73, 4.4, 63, 362),
(104, 'Skirt', 3878.61, 4.5, 68, 522),
(105, 'Shirt', 3089.59, 3.7, 99, 450),
(106, 'Wedding Saree', 1684.31, 3.6, 70, 487),
(107, 'Handloom Scarf', 3457.1, 3.5, 91, 622),
(108, 'Batik Shirt', 3317.02, 3.8, 87, 624),
(109, 'Jeans', 546.62, 3.5, 64, 115),
(110, 'Handloom Scarf', 1973.22, 3.6, 49, 104),
(111, 'Casual Shorts', 3069.94, 4.0, 50, 274),
(112, 'Wedding Saree', 1786.58, 3.9, 74, 11),
(113, 'Kurta', 4049.46, 3.8, 67, 156),
(114, 'Skirt', 3048.12, 3.9, 37, 188),
(115, 'Skirt', 810.94, 4.9, 74, 240),
(116, 'Saree', 516.96, 3.2, 79, 439),
(117, 'Office Shirt', 3658.4, 3.7, 61, 567),
(118, 'Denim Jacket', 4430.0, 3.6, 91, 676),
(119, 'Kurta', 2282.28, 3.7, 71, 521),
(120, 'Casual Shorts', 4056.2, 3.9, 96, 511),
(121, 'Casual Shorts', 4702.31, 3.3, 62, 511),
(122, 'T-shirt', 1203.53, 4.5, 98, 107),
(123, 'Handloom Scarf', 1957.27, 4.4, 61, 428),
(124, 'Denim Jacket', 892.25, 4.9, 54, 463),
(125, 'Casual Shorts', 2049.65, 3.3, 80, 236),
(126, 'Linen Pants', 1885.2, 3.3, 73, 183),
(127, 'Dress', 1020.0, 4.2, 63, 406),
(128, 'Wedding Saree', 1767.36, 4.4, 37, 293),
(129, 'Batik Shirt', 2437.67, 3.2, 24, 439),
(130, 'Denim Jacket', 1350.13, 3.1, 84, 456),
(131, 'Wedding Saree', 3759.82, 4.5, 96, 371),
(132, 'Wedding Saree', 3694.77, 3.7, 42, 585),
(133, 'Sarong', 3561.67, 4.7, 39, 243),
(134, 'Baby Dress', 1316.21, 4.6, 96, 69),
(135, 'Office Shirt', 3025.53, 4.0, 98, 289),
(136, 'School Uniform', 2423.14, 3.9, 50, 147),
(137, 'Casual Shorts', 2538.25, 4.8, 20, 614),
(138, 'Wedding Saree', 4010.65, 3.1, 67, 213),
(139, 'Denim Jacket', 1608.66, 3.7, 68, 646),
(140, 'Office Shirt', 2840.45, 3.1, 77, 447),
(141, 'Jeans', 4478.35, 3.1, 99, 442),
(142, 'Wedding Saree', 3794.09, 3.8, 11, 121),
(143, 'Linen Pants', 1748.27, 3.9, 10, 270),
(144, 'Casual Shorts', 3322.72, 4.4, 42, 350),
(145, 'Baby Dress', 1139.75, 3.8, 25, 317),
(146, 'Sarong', 3168.45, 3.5, 16, 406),
(147, 'Baby Dress', 4408.3, 4.0, 7, 59),
(148, 'Skirt', 4362.81, 3.3, 76, 11),
(149, 'Wedding Saree', 4876.82, 3.1, 85, 7),
(150, 'Linen Pants', 4898.64, 4.0, 76, 226),
(151, 'Blouse', 2064.33, 3.8, 88, 524),
(152, 'Sarong', 3875.44, 4.1, 41, 129),
(153, 'Wedding Saree', 4877.87, 3.4, 34, 637),
(154, 'Jeans', 4594.03, 3.8, 10, 537),
(155, 'T-shirt', 4752.64, 3.5, 75, 489),
(156, 'Skirt', 4918.19, 3.7, 78, 593),
(157, 'T-shirt', 925.56, 3.8, 26, 448),
(158, 'Dress', 987.96, 4.3, 57, 673),
(159, 'Sarong', 679.42, 4.9, 39, 499),
(160, 'Kurta', 3187.04, 4.7, 46, 572),
(161, 'Kurta', 1631.99, 3.4, 9, 43),
(162, 'Shirt', 1952.5, 4.5, 95, 162),
(163, 'Blouse', 2141.13, 3.6, 55, 632),
(164, 'Casual Shorts', 4482.92, 3.6, 46, 680),
(165, 'Denim Jacket', 4141.58, 3.9, 36, 615),
(166, 'Jeans', 3569.53, 4.1, 58, 421),
(167, 'Denim Jacket', 1276.56, 3.8, 91, 143),
(168, 'Sarong', 3827.72, 4.3, 67, 504),
(169, 'Denim Jacket', 1079.1, 3.6, 29, 222),
(170, 'Wedding Saree', 4260.84, 4.4, 66, 204),
(171, 'Handloom Scarf', 3785.71, 4.1, 30, 638),
(172, 'Linen Pants', 2094.15, 4.0, 68, 633),
(173, 'Linen Pants', 2378.72, 3.9, 12, 136),
(174, 'Sarong', 4776.96, 4.9, 92, 700),
(175, 'Shirt', 1574.44, 3.2, 11, 511),
(176, 'Wedding Saree', 4710.86, 4.9, 90, 505),
(177, 'Office Shirt', 1992.11, 3.5, 20, 73),
(178, 'Blouse', 1543.0, 4.0, 77, 24),
(179, 'Blouse', 3185.4, 3.1, 55, 681),
(180, 'T-shirt', 2901.21, 3.8, 30, 180),
(181, 'Handloom Scarf', 3953.38, 3.4, 12, 230),
(182, 'Kurta', 1196.29, 3.5, 95, 144),
(183, 'Kurta', 1744.24, 4.3, 80, 581),
(184, 'Dress', 1406.69, 4.7, 28, 173),
(185, 'Batik Shirt', 3881.03, 3.5, 39, 242),
(186, 'Casual Shorts', 1570.19, 3.7, 46, 397),
(187, 'Kurta', 4673.44, 4.5, 93, 464),
(188, 'Kurta', 2335.43, 3.8, 76, 335),
(189, 'Saree', 732.03, 3.8, 97, 194),
(190, 'Dress', 3420.66, 4.3, 61, 582),
(191, 'School Uniform', 2864.37, 4.1, 11, 520),
(192, 'Jeans', 2906.67, 4.0, 69, 352),
(193, 'Shirt', 4638.09, 4.7, 17, 494),
(194, 'Jeans', 2177.91, 3.1, 87, 681),
(195, 'Office Shirt', 1554.03, 4.5, 84, 86),
(196, 'Batik Shirt', 4598.44, 3.4, 7, 174),
(197, 'Denim Jacket', 619.6, 4.8, 66, 679),
(198, 'Linen Pants', 1576.72, 4.5, 54, 417),
(199, 'Shirt', 913.36, 4.4, 74, 104),
(200, 'Shirt', 4547.66, 4.8, 61, 522),
(201, 'Sarong', 1631.99, 3.5, 78, 148),
(202, 'Dress', 843.49, 4.8, 52, 231),
(203, 'Blouse', 2553.55, 3.9, 47, 666),
(204, 'Kurta', 3715.33, 3.2, 20, 470),
(205, 'Kurta', 3489.16, 3.1, 81, 332),
(206, 'Sarong', 1496.14, 3.1, 82, 517),
(207, 'T-shirt', 4079.42, 4.1, 59, 527),
(208, 'Batik Shirt', 1498.59, 3.1, 31, 141),
(209, 'School Uniform', 1567.22, 3.5, 58, 690),
(210, 'Dress', 2656.42, 3.8, 15, 370),
(211, 'Dress', 2888.54, 3.2, 68, 684),
(212, 'Kurta', 1065.94, 3.8, 45, 590),
(213, 'Linen Pants', 2651.32, 4.2, 67, 116),
(214, 'Office Shirt', 3544.23, 4.9, 23, 21),
(215, 'Office Shirt', 2243.18, 4.0, 45, 268),
(216, 'Baby Dress', 960.26, 3.9, 78, 653),
(217, 'Linen Pants', 1414.44, 4.1, 80, 175),
(218, 'Handloom Scarf', 3967.64, 4.7, 27, 143),
(219, 'Linen Pants', 2647.18, 4.3, 7, 350),
(220, 'School Uniform', 4717.04, 4.8, 59, 416),
(221, 'Dress', 4742.82, 3.2, 96, 511),
(222, 'Saree', 2443.62, 4.3, 9, 127),
(223, 'Linen Pants', 3351.73, 3.5, 23, 551),
(224, 'Dress', 3539.77, 3.2, 70, 209),
(225, 'Office Shirt', 4531.76, 3.5, 41, 660),
(226, 'Linen Pants', 4974.87, 4.0, 20, 686),
(227, 'Dress', 2612.74, 4.7, 56, 223),
(228, 'Office Shirt', 3185.34, 4.3, 18, 252),
(229, 'T-shirt', 2707.87, 3.5, 66, 330),
(230, 'Dress', 1204.17, 3.8, 39, 417),
(231, 'Blouse', 2964.4, 4.4, 78, 397),
(232, 'Kurta', 2097.98, 4.2, 66, 451),
(233, 'School Uniform', 2266.22, 3.5, 20, 422),
(234, 'Blouse', 1393.61, 3.1, 46, 14),
(235, 'T-shirt', 4128.85, 4.2, 19, 17),
(236, 'Batik Shirt', 1102.64, 3.0, 66, 558),
(237, 'Saree', 4302.53, 4.8, 51, 144),
(238, 'Wedding Saree', 3900.93, 4.0, 74, 96),
(239, 'Blouse', 4332.15, 4.5, 93, 353),
(240, 'Office Shirt', 2226.57, 3.9, 22, 532),
(241, 'Casual Shorts', 2028.28, 4.3, 6, 229),
(242, 'Casual Shorts', 1811.18, 4.7, 37, 243),
(243, 'Linen Pants', 2141.87, 3.8, 97, 368),
(244, 'Saree', 1224.13, 3.8, 37, 538),
(245, 'Shirt', 3892.29, 3.3, 70, 384),
(246, 'Shirt', 4795.78, 4.1, 20, 176),
(247, 'Handloom Scarf', 2796.24, 3.2, 73, 190),
(248, 'Kurta', 4022.84, 3.3, 19, 4),
(249, 'Jeans', 719.07, 4.0, 23, 678),
(250, 'Casual Shorts', 1733.28, 3.9, 9, 428),
(251, 'Linen Pants', 3254.77, 3.6, 65, 240),
(252, 'Handloom Scarf', 3174.67, 3.7, 13, 690),
(253, 'Shirt', 4814.23, 4.2, 10, 457),
(254, 'Shirt', 3381.25, 4.2, 27, 521),
(255, 'Saree', 1613.67, 4.0, 93, 48),
(256, 'T-shirt', 1266.77, 4.6, 31, 546),
(257, 'School Uniform', 593.43, 4.1, 87, 300),
(258, 'Saree', 824.94, 4.7, 89, 361),
(259, 'Handloom Scarf', 1437.67, 3.6, 14, 511),
(260, 'Kurta', 3124.59, 4.6, 99, 600),
(261, 'Shirt', 1624.3, 4.2, 67, 49),
(262, 'Linen Pants', 3053.49, 3.2, 34, 209),
(263, 'Handloom Scarf', 1572.31, 3.8, 89, 373),
(264, 'Sarong', 1457.58, 4.9, 42, 280),
(265, 'Sarong', 3452.65, 3.7, 36, 341),
(266, 'Skirt', 3306.88, 3.5, 81, 658),
(267, 'Blouse', 1923.29, 4.6, 96, 424),
(268, 'Saree', 4744.33, 5.0, 70, 103),
(269, 'Linen Pants', 3570.4, 3.6, 54, 523),
(270, 'T-shirt', 1489.49, 4.3, 83, 177),
(271, 'Skirt', 4311.87, 4.8, 67, 614),
(272, 'School Uniform', 877.05, 3.5, 23, 224),
(273, 'School Uniform', 2041.35, 4.8, 13, 696),
(274, 'Dress', 4653.98, 3.5, 15, 657),
(275, 'Skirt', 4192.64, 3.4, 83, 522),
(276, 'Shirt', 3491.8, 3.5, 17, 416),
(277, 'Batik Shirt', 4814.91, 4.0, 53, 603),
(278, 'T-shirt', 1860.91, 5.0, 34, 496),
(279, 'Kurta', 1267.53, 4.3, 73, 489),
(280, 'Wedding Saree', 3528.91, 5.0, 53, 118),
(281, 'Casual Shorts', 616.4, 4.9, 84, 5),
(282, 'Kurta', 4918.33, 4.8, 99, 118),
(283, 'Shirt', 2467.97, 3.9, 60, 228),
(284, 'Handloom Scarf', 1046.44, 4.4, 41, 139),
(285, 'Wedding Saree', 4477.16, 4.9, 25, 161),
(286, 'T-shirt', 993.07, 4.4, 27, 255),
(287, 'School Uniform', 858.42, 4.8, 92, 571),
(288, 'Sarong', 4528.48, 4.7, 70, 157),
(289, 'School Uniform', 3771.65, 3.5, 71, 381),
(290, 'Shirt', 4859.5, 3.2, 10, 481),
(291, 'Sarong', 3530.92, 3.3, 59, 261),
(292, 'Denim Jacket', 3514.85, 4.3, 89, 409),
(293, 'Handloom Scarf', 694.99, 4.5, 81, 184),
(294, 'Dress', 4417.13, 3.2, 10, 486),
(295, 'Kurta', 3159.61, 4.4, 25, 637),
(296, 'Saree', 671.43, 4.5, 44, 355),
(297, 'Casual Shorts', 2922.3, 4.2, 42, 46),
(298, 'Blouse', 3773.82, 3.2, 74, 293),
(299, 'Handloom Scarf', 1928.71, 4.1, 48, 83),
(300, 'Baby Dress', 4662.41, 3.7, 71, 62),
(301, 'Wedding Saree', 2455.52, 4.0, 42, 516),
(302, 'Linen Pants', 1571.56, 4.4, 24, 339),
(303, 'School Uniform', 1726.1, 4.2, 18, 76),
(304, 'School Uniform', 3684.63, 3.6, 45, 129),
(305, 'Wedding Saree', 1203.2, 4.5, 93, 492),
(306, 'Linen Pants', 2815.42, 4.5, 9, 6),
(307, 'Linen Pants', 2537.53, 3.9, 30, 371),
(308, 'School Uniform', 2729.11, 4.9, 77, 422),
(309, 'Blouse', 1537.22, 3.1, 82, 68),
(310, 'Shirt', 1628.19, 4.1, 78, 601),
(311, 'Jeans', 839.69, 3.9, 93, 227),
(312, 'Denim Jacket', 3959.71, 3.9, 85, 642),
(313, 'Linen Pants', 4026.12, 3.9, 57, 54),
(314, 'Batik Shirt', 1972.56, 3.2, 38, 93),
(315, 'Linen Pants', 1985.43, 3.9, 80, 437),
(316, 'Blouse', 4970.25, 3.9, 48, 661),
(317, 'Batik Shirt', 3308.46, 4.9, 70, 253),
(318, 'School Uniform', 1556.84, 3.7, 45, 138),
(319, 'Kurta', 3984.62, 3.9, 91, 177),
(320, 'Blouse', 1889.42, 3.1, 14, 444),
(321, 'Linen Pants', 3785.51, 3.0, 63, 160),
(322, 'Blouse', 2362.54, 3.3, 58, 455),
(323, 'Dress', 4946.41, 4.4, 86, 555),
(324, 'Saree', 4265.95, 3.2, 74, 457),
(325, 'Handloom Scarf', 3887.17, 3.2, 56, 634),
(326, 'Shirt', 3281.8, 3.4, 58, 282),
(327, 'T-shirt', 1812.19, 4.6, 35, 595),
(328, 'Baby Dress', 828.51, 4.4, 36, 494),
(329, 'Dress', 3866.87, 4.9, 95, 419),
(330, 'Blouse', 4377.73, 4.6, 92, 700),
(331, 'Blouse', 1549.42, 5.0, 22, 325),
(332, 'Sarong', 1490.14, 3.6, 94, 420),
(333, 'T-shirt', 2257.26, 4.5, 28, 38),
(334, 'Baby Dress', 4172.85, 3.4, 89, 79),
(335, 'T-shirt', 1049.54, 4.8, 62, 122),
(336, 'Linen Pants', 595.15, 4.5, 35, 609),
(337, 'Skirt', 1343.56, 3.8, 30, 57),
(338, 'Skirt', 4827.84, 4.4, 65, 126),
(339, 'Denim Jacket', 1610.31, 4.1, 46, 307),
(340, 'Saree', 2348.64, 3.7, 85, 623),
(341, 'Casual Shorts', 4049.51, 3.7, 67, 391),
(342, 'Saree', 1916.97, 5.0, 48, 431),
(343, 'T-shirt', 1658.56, 4.7, 60, 320),
(344, 'Skirt', 3959.76, 3.1, 76, 51),
(345, 'Skirt', 2468.85, 5.0, 22, 389),
(346, 'Handloom Scarf', 1193.45, 4.0, 88, 278),
(347, 'Skirt', 666.04, 4.9, 10, 302),
(348, 'Wedding Saree', 1108.29, 4.7, 57, 558),
(349, 'Blouse', 2350.81, 3.4, 46, 356),
(350, 'Batik Shirt', 1957.52, 5.0, 63, 346),
(351, 'Dress', 4245.59, 3.6, 30, 86),
(352, 'Sarong', 3423.89, 3.5, 49, 548),
(353, 'Denim Jacket', 1261.7, 3.2, 72, 312),
(354, 'Blouse', 3182.7, 4.8, 75, 470),
(355, 'Blouse', 2659.58, 4.1, 78, 290),
(356, 'Jeans', 675.71, 3.4, 87, 451),
(357, 'Sarong', 2152.49, 4.7, 20, 671),
(358, 'Sarong', 4986.93, 3.2, 77, 439),
(359, 'Handloom Scarf', 1253.43, 4.0, 43, 339),
(360, 'Saree', 1191.53, 3.2, 72, 405),
(361, 'Jeans', 2890.15, 4.3, 34, 576),
(362, 'Office Shirt', 4186.83, 3.4, 67, 430),
(363, 'Sarong', 895.09, 3.9, 64, 410),
(364, 'Denim Jacket', 3051.21, 4.3, 93, 260),
(365, 'Wedding Saree', 4419.22, 4.7, 77, 249),
(366, 'T-shirt', 900.26, 4.4, 64, 547),
(367, 'Sarong', 2813.17, 3.6, 83, 392),
(368, 'T-shirt', 4737.95, 4.6, 95, 342),
(369, 'Handloom Scarf', 2687.81, 3.6, 71, 18),
(370, 'Dress', 661.45, 4.8, 16, 486),
(371, 'Baby Dress', 1483.49, 3.4, 94, 649),
(372, 'Skirt', 2408.08, 4.6, 37, 79),
(373, 'Office Shirt', 1252.99, 3.7, 8, 13),
(374, 'Skirt', 2125.54, 4.5, 16, 231),
(375, 'Saree', 4621.4, 4.3, 51, 581),
(376, 'Wedding Saree', 601.81, 3.6, 61, 298),
(377, 'Blouse', 4942.64, 5.0, 54, 82),
(378, 'Casual Shorts', 1218.5, 3.7, 84, 398),
(379, 'Batik Shirt', 2036.56, 4.6, 95, 488),
(380, 'Saree', 4770.96, 4.5, 84, 180),
(381, 'Saree', 3123.63, 3.3, 28, 161),
(382, 'Saree', 1385.7, 4.1, 64, 623),
(383, 'Office Shirt', 2105.72, 4.8, 57, 474),
(384, 'Casual Shorts', 2390.08, 4.2, 68, 685),
(385, 'T-shirt', 1194.18, 3.4, 66, 269),
(386, 'Sarong', 2836.86, 4.2, 85, 633),
(387, 'Baby Dress', 1254.23, 4.3, 44, 201),
(388, 'Batik Shirt', 508.15, 4.3, 45, 40),
(389, 'Baby Dress', 1623.43, 4.2, 62, 657),
(390, 'Baby Dress', 2577.87, 4.3, 7, 418),
(391, 'Denim Jacket', 4542.47, 4.2, 69, 12),
(392, 'Skirt', 3581.78, 4.8, 38, 252),
(393, 'Office Shirt', 4986.53, 3.7, 85, 380),
(394, 'Shirt', 1656.66, 3.9, 12, 205),
(395, 'Wedding Saree', 4182.62, 4.4, 100, 43),
(396, 'Dress', 1018.64, 4.6, 63, 502),
(397, 'Office Shirt', 1242.06, 3.1, 17, 36),
(398, 'Saree', 3290.68, 4.8, 6, 27),
(399, 'Sarong', 598.95, 3.2, 36, 489),
(400, 'Batik Shirt', 557.2, 3.3, 89, 480),
(401, 'Baby Dress', 1856.54, 3.5, 67, 319),
(402, 'Office Shirt', 3197.66, 3.3, 28, 169),
(403, 'Shirt', 625.23, 3.7, 53, 674),
(404, 'Kurta', 2465.84, 3.6, 94, 267),
(405, 'Jeans', 579.21, 3.5, 55, 169),
(406, 'Skirt', 1165.43, 4.3, 10, 5),
(407, 'Batik Shirt', 1458.92, 3.1, 49, 351),
(408, 'Handloom Scarf', 4908.5, 4.5, 44, 310),
(409, 'Dress', 4582.39, 4.6, 7, 468),
(410, 'Batik Shirt', 2153.94, 4.8, 61, 358),
(411, 'Denim Jacket', 2402.49, 4.9, 23, 671),
(412, 'Wedding Saree', 2833.84, 3.1, 31, 228),
(413, 'Handloom Scarf', 4043.14, 4.0, 21, 413),
(414, 'Baby Dress', 4166.42, 3.1, 43, 102),
(415, 'Casual Shorts', 924.21, 3.8, 6, 474),
(416, 'School Uniform', 4573.03, 4.2, 30, 240),
(417, 'Saree', 4405.6, 3.6, 23, 131),
(418, 'Office Shirt', 915.1, 4.7, 90, 603),
(419, 'Handloom Scarf', 2951.01, 4.6, 96, 402),
(420, 'Casual Shorts', 4767.49, 4.7, 47, 682),
(421, 'Blouse', 1479.16, 4.6, 10, 334),
(422, 'Linen Pants', 2258.75, 3.4, 37, 21),
(423, 'T-shirt', 875.92, 4.7, 97, 546),
(424, 'T-shirt', 2957.8, 3.8, 59, 557),
(425, 'Batik Shirt', 3926.03, 4.0, 90, 683),
(426, 'Saree', 2791.6, 3.7, 51, 645),
(427, 'Wedding Saree', 671.34, 4.4, 61, 594),
(428, 'Sarong', 3692.81, 4.4, 11, 685),
(429, 'Sarong', 3523.93, 4.5, 23, 214),
(430, 'Sarong', 1663.49, 3.5, 32, 211),
(431, 'Linen Pants', 2854.48, 4.4, 64, 649),
(432, 'Office Shirt', 4282.4, 4.9, 98, 572),
(433, 'Wedding Saree', 1635.15, 3.3, 31, 521),
(434, 'Jeans', 2358.76, 3.6, 31, 540),
(435, 'Baby Dress', 1925.56, 3.1, 32, 446),
(436, 'Kurta', 2589.25, 3.2, 14, 469),
(437, 'School Uniform', 3047.56, 3.3, 92, 316),
(438, 'Dress', 2948.47, 3.2, 94, 210),
(439, 'Handloom Scarf', 1255.94, 4.4, 85, 262),
(440, 'Dress', 886.29, 4.3, 47, 54),
(441, 'Casual Shorts', 4069.27, 3.7, 83, 610),
(442, 'Blouse', 3295.08, 3.1, 38, 608),
(443, 'Denim Jacket', 959.79, 4.9, 59, 326),
(444, 'Casual Shorts', 1268.91, 4.5, 41, 440),
(445, 'Office Shirt', 1541.5, 4.1, 97, 627),
(446, 'Denim Jacket', 2405.66, 4.0, 80, 403),
(447, 'Sarong', 4502.68, 3.9, 91, 192),
(448, 'Shirt', 1169.62, 4.3, 30, 556),
(449, 'Wedding Saree', 3315.01, 4.3, 79, 592),
(450, 'Saree', 4220.63, 3.4, 91, 432),
(451, 'Kurta', 4758.32, 4.5, 64, 50),
(452, 'Handloom Scarf', 2992.75, 4.0, 23, 158),
(453, 'Dress', 1796.8, 4.1, 76, 298),
(454, 'Batik Shirt', 4206.18, 3.4, 42, 646),
(455, 'Denim Jacket', 4500.52, 4.0, 90, 543),
(456, 'Dress', 914.13, 3.3, 6, 383),
(457, 'Dress', 3085.91, 4.2, 23, 420),
(458, 'Denim Jacket', 2063.21, 4.9, 11, 393),
(459, 'Office Shirt', 4795.76, 3.9, 55, 660),
(460, 'Office Shirt', 3451.49, 3.9, 79, 283),
(461, 'Jeans', 3634.2, 4.4, 26, 530),
(462, 'Handloom Scarf', 4943.95, 3.7, 7, 186),
(463, 'Saree', 1790.66, 4.4, 80, 30),
(464, 'Jeans', 1221.01, 3.7, 58, 492),
(465, 'Sarong', 2508.55, 4.4, 18, 560),
(466, 'Denim Jacket', 1205.0, 3.6, 18, 432),
(467, 'Skirt', 4806.4, 3.4, 44, 651),
(468, 'Baby Dress', 4849.73, 3.9, 72, 34),
(469, 'Dress', 4686.13, 4.4, 17, 141),
(470, 'School Uniform', 2640.06, 4.6, 69, 115),
(471, 'Wedding Saree', 2556.01, 4.1, 27, 211),
(472, 'Kurta', 675.32, 4.2, 58, 327),
(473, 'Denim Jacket', 4687.14, 4.3, 9, 56),
(474, 'T-shirt', 3336.42, 3.3, 87, 49),
(475, 'Shirt', 1940.18, 3.4, 17, 504),
(476, 'Casual Shorts', 892.91, 4.2, 93, 208),
(477, 'School Uniform', 3023.2, 4.5, 17, 582),
(478, 'Baby Dress', 1869.48, 4.5, 31, 382),
(479, 'Baby Dress', 1947.14, 3.5, 26, 227),
(480, 'Denim Jacket', 3637.36, 3.9, 80, 182),
(481, 'T-shirt', 3791.52, 3.9, 23, 439),
(482, 'Kurta', 4396.95, 3.7, 59, 67),
(483, 'Linen Pants', 4011.89, 3.9, 32, 345),
(484, 'Office Shirt', 2258.02, 4.2, 65, 357),
(485, 'Blouse', 3461.08, 4.1, 94, 97),
(486, 'School Uniform', 3075.01, 3.5, 87, 354),
(487, 'T-shirt', 2813.38, 3.9, 50, 537),
(488, 'Sarong', 3985.99, 3.8, 97, 464),
(489, 'School Uniform', 3645.02, 4.3, 99, 236),
(490, 'Sarong', 3170.77, 4.5, 62, 40),
(491, 'Sarong', 818.54, 4.2, 72, 602),
(492, 'Saree', 2247.35, 4.8, 5, 685),
(493, 'Blouse', 4837.61, 4.3, 84, 393),
(494, 'Denim Jacket', 2483.7, 4.1, 24, 385),
(495, 'Saree', 901.73, 3.3, 43, 302),
(496, 'Denim Jacket', 875.38, 3.3, 25, 576),
(497, 'Office Shirt', 740.09, 3.4, 42, 500),
(498, 'Handloom Scarf', 2739.74, 3.1, 50, 61),
(499, 'Sarong', 2740.4, 4.4, 7, 519),
(500, 'Wedding Saree', 4620.49, 3.2, 68, 28);


INSERT INTO ProductCategory (CatID, Category, Description) VALUES
(1, 'Dress', 'Dress description'),
(2, 'Jeans', 'Jeans description'),
(3, 'Shoes', 'Shoes description'),
(4, 'Sweater', 'Sweater description'),
(5, 'Jacket', 'Jacket description'),
(6, 'T-shirt', 'T-shirt description'),
(7, 'Topwear', 'Topwear description'),
(8, 'Bottomwear', 'Bottomwear description'),
(9, 'Outerwear', 'Outerwear description'),
(10, 'Footwear', 'Footwear description'),
(11, 'Accessories', 'Accessories description'),
(12, 'Winterwear', 'Winterwear description'),
(13, 'Formalwear', 'Formalwear description'),
(14, 'Casualwear', 'Casualwear description'),
(15, 'Sportswear', 'Sportswear description');

Drop table ProductCategory;
Drop table Product_Sub_Category;
SET SQL_SAFE_UPDATES = 0;

DELETE FROM Product_Sub_Category;
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_SAFE_UPDATES = 1;
SET FOREIGN_KEY_CHECKS = 1;


INSERT INTO Product_Sub_Category (Sub_CatID, Category, Description, CatID) VALUES
(1, 'T-Shirts', 'T-Shirts description', 1),
(2, 'Jeans', 'Jeans description', 2),
(3, 'Jackets', 'Jackets description', 5),
(4, 'Sweaters', 'Sweaters description', 1),
(5, 'Dresses', 'Dresses description', 6),
(6, 'Skirts', 'Skirts description', 2),
(7, 'Shorts', 'Shorts description', 2),
(8, 'Shoes', 'Shoes description', 3),
(9, 'Sandals', 'Sandals description', 3),
(10, 'Boots', 'Boots description', 3),
(11, 'Socks', 'Socks description', 10),
(12, 'Hats', 'Hats description', 4),
(13, 'Scarves', 'Scarves description', 4),
(14, 'Gloves', 'Gloves description', 8),
(15, 'Belts', 'Belts description', 4),
(16, 'Swimwear', 'Swimwear description', 7),
(17, 'Activewear', 'Activewear description', 9),
(18, 'Underwear', 'Underwear description', 10),
(19, 'Blouses', 'Blouses description', 1),
(20, 'Coats', 'Coats description', 5),
(21, 'Suits', 'Suits description', 6),
(22, 'Ties', 'Ties description', 4),
(23, 'Vests', 'Vests description', 6),
(24, 'Cardigans', 'Cardigans description', 8),
(25, 'Leggings', 'Leggings description', 2);


INSERT INTO ProductImages (ImageID, URL, ProductID) VALUES
(1, 'https://textilelk.com/images/denim-jeans-8472.jpg', 62),
(2, 'https://textilelk.com/images/cotton-saree-8895.jpg', 372),
(3, 'https://textilelk.com/images/kids-frock-3747.jpg', 301),
(4, 'https://textilelk.com/images/traditional-veshti-4660.jpg', 398),
(5, 'https://textilelk.com/images/festival-sarong-4985.jpg', 197),
(6, 'https://textilelk.com/images/festival-sarong-1473.jpg', 194),
(7, 'https://textilelk.com/images/linen-shirt-2388.jpg', 189),
(8, 'https://textilelk.com/images/cotton-saree-8271.jpg', 200),
(9, 'https://textilelk.com/images/batik-dress-9724.jpg', 142),
(10, 'https://textilelk.com/images/kandyan-osari-7007.jpg', 306),
(11, 'https://textilelk.com/images/handloom-scarf-2219.jpg', 75),
(12, 'https://textilelk.com/images/traditional-veshti-5274.jpg', 220),
(13, 'https://textilelk.com/images/traditional-veshti-4065.jpg', 405),
(14, 'https://textilelk.com/images/casual-t-shirt-3484.jpg', 116),
(15, 'https://textilelk.com/images/traditional-veshti-4499.jpg', 287),
(16, 'https://textilelk.com/images/wedding-lehenga-5403.jpg', 477),
(17, 'https://textilelk.com/images/batik-dress-1081.jpg', 86),
(18, 'https://textilelk.com/images/denim-jeans-1589.jpg', 215),
(19, 'https://textilelk.com/images/denim-jeans-6787.jpg', 16),
(20, 'https://textilelk.com/images/silk-blouse-8408.jpg', 281),
(21, 'https://textilelk.com/images/festival-sarong-3973.jpg', 468),
(22, 'https://textilelk.com/images/kids-frock-9966.jpg', 77),
(23, 'https://textilelk.com/images/cotton-pants-6139.jpg', 418),
(24, 'https://textilelk.com/images/office-blouse-1918.jpg', 140),
(25, 'https://textilelk.com/images/traditional-veshti-5749.jpg', 208),
(26, 'https://textilelk.com/images/linen-shirt-2776.jpg', 150),
(27, 'https://textilelk.com/images/denim-jeans-3042.jpg', 19),
(28, 'https://textilelk.com/images/wedding-lehenga-9685.jpg', 474),
(29, 'https://textilelk.com/images/kids-frock-9732.jpg', 285),
(30, 'https://textilelk.com/images/handloom-scarf-7265.jpg', 22),
(31, 'https://textilelk.com/images/kids-frock-9165.jpg', 48),
(32, 'https://textilelk.com/images/casual-t-shirt-7910.jpg', 116),
(33, 'https://textilelk.com/images/linen-shirt-8164.jpg', 18),
(34, 'https://textilelk.com/images/school-uniform-9849.jpg', 160),
(35, 'https://textilelk.com/images/cotton-pants-1529.jpg', 86),
(36, 'https://textilelk.com/images/cotton-pants-5446.jpg', 72),
(37, 'https://textilelk.com/images/wedding-lehenga-2536.jpg', 97),
(38, 'https://textilelk.com/images/kids-frock-8593.jpg', 415),
(39, 'https://textilelk.com/images/kandyan-osari-1068.jpg', 466),
(40, 'https://textilelk.com/images/denim-jeans-6716.jpg', 2),
(41, 'https://textilelk.com/images/linen-shirt-3353.jpg', 375),
(42, 'https://textilelk.com/images/linen-shirt-9249.jpg', 398),
(43, 'https://textilelk.com/images/wedding-lehenga-4367.jpg', 114),
(44, 'https://textilelk.com/images/linen-shirt-9249.jpg', 148),
(45, 'https://textilelk.com/images/cotton-pants-6162.jpg', 387),
(46, 'https://textilelk.com/images/wedding-lehenga-9039.jpg', 291),
(47, 'https://textilelk.com/images/denim-jeans-8529.jpg', 79),
(48, 'https://textilelk.com/images/kids-frock-8650.jpg', 192),
(49, 'https://textilelk.com/images/kids-frock-5488.jpg', 181),
(50, 'https://textilelk.com/images/batik-dress-9333.jpg', 269),
(51, 'https://textilelk.com/images/festival-sarong-4517.jpg', 163),
(52, 'https://textilelk.com/images/silk-blouse-4850.jpg', 291),
(53, 'https://textilelk.com/images/traditional-veshti-5501.jpg', 407),
(54, 'https://textilelk.com/images/kids-frock-8214.jpg', 363),
(55, 'https://textilelk.com/images/kids-frock-6073.jpg', 123),
(56, 'https://textilelk.com/images/batik-dress-9658.jpg', 154),
(57, 'https://textilelk.com/images/batik-dress-3616.jpg', 413),
(58, 'https://textilelk.com/images/casual-t-shirt-1790.jpg', 426),
(59, 'https://textilelk.com/images/linen-shirt-8131.jpg', 67),
(60, 'https://textilelk.com/images/traditional-veshti-8995.jpg', 75),
(61, 'https://textilelk.com/images/linen-shirt-4383.jpg', 328),
(62, 'https://textilelk.com/images/traditional-veshti-9603.jpg', 278),
(63, 'https://textilelk.com/images/wedding-lehenga-7048.jpg', 434),
(64, 'https://textilelk.com/images/denim-jeans-8492.jpg', 77),
(65, 'https://textilelk.com/images/traditional-veshti-4174.jpg', 191),
(66, 'https://textilelk.com/images/silk-blouse-4268.jpg', 259),
(67, 'https://textilelk.com/images/kandyan-osari-4029.jpg', 421),
(68, 'https://textilelk.com/images/silk-blouse-8380.jpg', 447),
(69, 'https://textilelk.com/images/office-blouse-3038.jpg', 280),
(70, 'https://textilelk.com/images/cotton-saree-4117.jpg', 346),
(71, 'https://textilelk.com/images/linen-shirt-5403.jpg', 35),
(72, 'https://textilelk.com/images/handloom-scarf-1910.jpg', 88),
(73, 'https://textilelk.com/images/school-uniform-3608.jpg', 18),
(74, 'https://textilelk.com/images/kandyan-osari-3889.jpg', 391),
(75, 'https://textilelk.com/images/kandyan-osari-2313.jpg', 54),
(76, 'https://textilelk.com/images/festival-sarong-2579.jpg', 320),
(77, 'https://textilelk.com/images/handloom-scarf-6690.jpg', 416),
(78, 'https://textilelk.com/images/festival-sarong-1621.jpg', 425),
(79, 'https://textilelk.com/images/kids-frock-6325.jpg', 481),
(80, 'https://textilelk.com/images/kandyan-osari-3855.jpg', 457),
(81, 'https://textilelk.com/images/kandyan-osari-1331.jpg', 1),
(82, 'https://textilelk.com/images/kids-frock-5999.jpg', 477),
(83, 'https://textilelk.com/images/festival-sarong-1177.jpg', 458),
(84, 'https://textilelk.com/images/wedding-lehenga-9199.jpg', 432),
(85, 'https://textilelk.com/images/cotton-pants-4584.jpg', 308),
(86, 'https://textilelk.com/images/kandyan-osari-4271.jpg', 263),
(87, 'https://textilelk.com/images/denim-jeans-4715.jpg', 284),
(88, 'https://textilelk.com/images/cotton-saree-4583.jpg', 370),
(89, 'https://textilelk.com/images/batik-dress-1302.jpg', 152),
(90, 'https://textilelk.com/images/traditional-veshti-3055.jpg', 353),
(91, 'https://textilelk.com/images/traditional-veshti-8843.jpg', 352),
(92, 'https://textilelk.com/images/kandyan-osari-6115.jpg', 160),
(93, 'https://textilelk.com/images/handloom-scarf-8123.jpg', 320),
(94, 'https://textilelk.com/images/cotton-pants-3858.jpg', 452),
(95, 'https://textilelk.com/images/office-blouse-1932.jpg', 341),
(96, 'https://textilelk.com/images/denim-jeans-3430.jpg', 297),
(97, 'https://textilelk.com/images/school-uniform-2192.jpg', 331),
(98, 'https://textilelk.com/images/batik-dress-4857.jpg', 277),
(99, 'https://textilelk.com/images/cotton-saree-7065.jpg', 218),
(100, 'https://textilelk.com/images/kandyan-osari-8213.jpg', 368),
(101, 'https://textilelk.com/images/denim-jeans-6210.jpg', 449),
(102, 'https://textilelk.com/images/traditional-veshti-1811.jpg', 191),
(103, 'https://textilelk.com/images/kandyan-osari-1672.jpg', 9),
(104, 'https://textilelk.com/images/denim-jeans-1159.jpg', 222),
(105, 'https://textilelk.com/images/wedding-lehenga-4912.jpg', 195),
(106, 'https://textilelk.com/images/cotton-saree-2494.jpg', 106),
(107, 'https://textilelk.com/images/handloom-scarf-8112.jpg', 422),
(108, 'https://textilelk.com/images/batik-dress-4877.jpg', 275),
(109, 'https://textilelk.com/images/batik-dress-4221.jpg', 213),
(110, 'https://textilelk.com/images/linen-shirt-1807.jpg', 266),
(111, 'https://textilelk.com/images/silk-blouse-4681.jpg', 62),
(112, 'https://textilelk.com/images/kandyan-osari-1239.jpg', 168),
(113, 'https://textilelk.com/images/festival-sarong-1378.jpg', 180),
(114, 'https://textilelk.com/images/cotton-saree-3104.jpg', 270),
(115, 'https://textilelk.com/images/handloom-scarf-6133.jpg', 373),
(116, 'https://textilelk.com/images/wedding-lehenga-6158.jpg', 306),
(117, 'https://textilelk.com/images/school-uniform-7788.jpg', 209),
(118, 'https://textilelk.com/images/cotton-pants-5047.jpg', 419),
(119, 'https://textilelk.com/images/festival-sarong-9818.jpg', 475),
(120, 'https://textilelk.com/images/silk-blouse-8367.jpg', 435),
(121, 'https://textilelk.com/images/office-blouse-2702.jpg', 36),
(122, 'https://textilelk.com/images/cotton-saree-4773.jpg', 210),
(123, 'https://textilelk.com/images/cotton-saree-9075.jpg', 151),
(124, 'https://textilelk.com/images/kandyan-osari-1437.jpg', 292),
(125, 'https://textilelk.com/images/kandyan-osari-1612.jpg', 115),
(126, 'https://textilelk.com/images/linen-shirt-9606.jpg', 29),
(127, 'https://textilelk.com/images/traditional-veshti-7676.jpg', 481),
(128, 'https://textilelk.com/images/silk-blouse-3855.jpg', 452),
(129, 'https://textilelk.com/images/denim-jeans-5057.jpg', 329),
(130, 'https://textilelk.com/images/wedding-lehenga-3848.jpg', 2),
(131, 'https://textilelk.com/images/silk-blouse-9514.jpg', 117),
(132, 'https://textilelk.com/images/office-blouse-2496.jpg', 183),
(133, 'https://textilelk.com/images/traditional-veshti-2476.jpg', 81),
(134, 'https://textilelk.com/images/handloom-scarf-5779.jpg', 13),
(135, 'https://textilelk.com/images/linen-shirt-5827.jpg', 34),
(136, 'https://textilelk.com/images/school-uniform-4347.jpg', 46),
(137, 'https://textilelk.com/images/linen-shirt-8933.jpg', 349),
(138, 'https://textilelk.com/images/cotton-pants-1178.jpg', 109),
(139, 'https://textilelk.com/images/office-blouse-3316.jpg', 224),
(140, 'https://textilelk.com/images/silk-blouse-7704.jpg', 268),
(141, 'https://textilelk.com/images/cotton-saree-2864.jpg', 262),
(142, 'https://textilelk.com/images/kids-frock-8536.jpg', 356),
(143, 'https://textilelk.com/images/office-blouse-7231.jpg', 499),
(144, 'https://textilelk.com/images/school-uniform-7169.jpg', 26),
(145, 'https://textilelk.com/images/traditional-veshti-5653.jpg', 380),
(146, 'https://textilelk.com/images/handloom-scarf-7021.jpg', 56),
(147, 'https://textilelk.com/images/school-uniform-4318.jpg', 377),
(148, 'https://textilelk.com/images/school-uniform-7786.jpg', 436),
(149, 'https://textilelk.com/images/batik-dress-2307.jpg', 33),
(150, 'https://textilelk.com/images/linen-shirt-7171.jpg', 7),
(151, 'https://textilelk.com/images/office-blouse-7754.jpg', 381),
(152, 'https://textilelk.com/images/festival-sarong-5413.jpg', 403),
(153, 'https://textilelk.com/images/festival-sarong-6452.jpg', 484),
(154, 'https://textilelk.com/images/denim-jeans-4901.jpg', 136),
(155, 'https://textilelk.com/images/denim-jeans-4991.jpg', 222),
(156, 'https://textilelk.com/images/office-blouse-4765.jpg', 118),
(157, 'https://textilelk.com/images/festival-sarong-7783.jpg', 181),
(158, 'https://textilelk.com/images/office-blouse-3309.jpg', 86),
(159, 'https://textilelk.com/images/traditional-veshti-4078.jpg', 169),
(160, 'https://textilelk.com/images/office-blouse-6967.jpg', 4),
(161, 'https://textilelk.com/images/wedding-lehenga-7935.jpg', 405),
(162, 'https://textilelk.com/images/cotton-saree-3286.jpg', 300),
(163, 'https://textilelk.com/images/casual-t-shirt-3144.jpg', 60),
(164, 'https://textilelk.com/images/linen-shirt-6593.jpg', 259),
(165, 'https://textilelk.com/images/linen-shirt-6826.jpg', 216),
(166, 'https://textilelk.com/images/school-uniform-7079.jpg', 127),
(167, 'https://textilelk.com/images/traditional-veshti-1135.jpg', 289),
(168, 'https://textilelk.com/images/batik-dress-2084.jpg', 314),
(169, 'https://textilelk.com/images/cotton-saree-3865.jpg', 319),
(170, 'https://textilelk.com/images/batik-dress-6350.jpg', 256),
(171, 'https://textilelk.com/images/denim-jeans-2127.jpg', 369),
(172, 'https://textilelk.com/images/kandyan-osari-4705.jpg', 383),
(173, 'https://textilelk.com/images/cotton-saree-7024.jpg', 70),
(174, 'https://textilelk.com/images/denim-jeans-6693.jpg', 357),
(175, 'https://textilelk.com/images/cotton-saree-4873.jpg', 169),
(176, 'https://textilelk.com/images/kandyan-osari-6322.jpg', 440),
(177, 'https://textilelk.com/images/cotton-pants-2066.jpg', 269),
(178, 'https://textilelk.com/images/silk-blouse-4766.jpg', 301),
(179, 'https://textilelk.com/images/handloom-scarf-1740.jpg', 309),
(180, 'https://textilelk.com/images/handloom-scarf-9531.jpg', 280),
(181, 'https://textilelk.com/images/festival-sarong-2944.jpg', 213),
(182, 'https://textilelk.com/images/silk-blouse-1579.jpg', 389),
(183, 'https://textilelk.com/images/school-uniform-4611.jpg', 442),
(184, 'https://textilelk.com/images/denim-jeans-8575.jpg', 471),
(185, 'https://textilelk.com/images/school-uniform-6115.jpg', 151),
(186, 'https://textilelk.com/images/festival-sarong-7414.jpg', 176),
(187, 'https://textilelk.com/images/cotton-saree-1558.jpg', 259),
(188, 'https://textilelk.com/images/handloom-scarf-1267.jpg', 369),
(189, 'https://textilelk.com/images/traditional-veshti-7862.jpg', 299),
(190, 'https://textilelk.com/images/casual-t-shirt-7213.jpg', 335),
(191, 'https://textilelk.com/images/handloom-scarf-3394.jpg', 282),
(192, 'https://textilelk.com/images/wedding-lehenga-7286.jpg', 334),
(193, 'https://textilelk.com/images/linen-shirt-2580.jpg', 361),
(194, 'https://textilelk.com/images/casual-t-shirt-6322.jpg', 218),
(195, 'https://textilelk.com/images/batik-dress-3884.jpg', 470),
(196, 'https://textilelk.com/images/kids-frock-9828.jpg', 340),
(197, 'https://textilelk.com/images/traditional-veshti-7379.jpg', 113),
(198, 'https://textilelk.com/images/kids-frock-4306.jpg', 343),
(199, 'https://textilelk.com/images/handloom-scarf-3257.jpg', 227),
(200, 'https://textilelk.com/images/linen-shirt-8958.jpg', 198),
(201, 'https://textilelk.com/images/handloom-scarf-5005.jpg', 244),
(202, 'https://textilelk.com/images/office-blouse-9227.jpg', 374),
(203, 'https://textilelk.com/images/festival-sarong-1481.jpg', 201),
(204, 'https://textilelk.com/images/linen-shirt-5830.jpg', 204),
(205, 'https://textilelk.com/images/kids-frock-6100.jpg', 363),
(206, 'https://textilelk.com/images/batik-dress-9146.jpg', 223),
(207, 'https://textilelk.com/images/school-uniform-3935.jpg', 301),
(208, 'https://textilelk.com/images/cotton-saree-6689.jpg', 50),
(209, 'https://textilelk.com/images/handloom-scarf-6183.jpg', 350),
(210, 'https://textilelk.com/images/festival-sarong-2750.jpg', 64),
(211, 'https://textilelk.com/images/cotton-pants-7802.jpg', 88),
(212, 'https://textilelk.com/images/festival-sarong-8797.jpg', 419),
(213, 'https://textilelk.com/images/school-uniform-9531.jpg', 344),
(214, 'https://textilelk.com/images/batik-dress-7070.jpg', 84),
(215, 'https://textilelk.com/images/batik-dress-3032.jpg', 109),
(216, 'https://textilelk.com/images/casual-t-shirt-5706.jpg', 421),
(217, 'https://textilelk.com/images/festival-sarong-8030.jpg', 12),
(218, 'https://textilelk.com/images/casual-t-shirt-1201.jpg', 205),
(219, 'https://textilelk.com/images/denim-jeans-7945.jpg', 135),
(220, 'https://textilelk.com/images/batik-dress-8048.jpg', 264),
(221, 'https://textilelk.com/images/festival-sarong-7992.jpg', 180),
(222, 'https://textilelk.com/images/cotton-saree-1630.jpg', 89),
(223, 'https://textilelk.com/images/denim-jeans-4337.jpg', 475),
(224, 'https://textilelk.com/images/traditional-veshti-9593.jpg', 169),
(225, 'https://textilelk.com/images/denim-jeans-1776.jpg', 13),
(226, 'https://textilelk.com/images/kandyan-osari-9377.jpg', 144),
(227, 'https://textilelk.com/images/cotton-saree-6022.jpg', 301),
(228, 'https://textilelk.com/images/casual-t-shirt-7121.jpg', 208),
(229, 'https://textilelk.com/images/handloom-scarf-7598.jpg', 106),
(230, 'https://textilelk.com/images/denim-jeans-4632.jpg', 11),
(231, 'https://textilelk.com/images/cotton-pants-1706.jpg', 329),
(232, 'https://textilelk.com/images/cotton-saree-1324.jpg', 153),
(233, 'https://textilelk.com/images/silk-blouse-9463.jpg', 42),
(234, 'https://textilelk.com/images/cotton-saree-4112.jpg', 436),
(235, 'https://textilelk.com/images/office-blouse-6318.jpg', 248),
(236, 'https://textilelk.com/images/school-uniform-4603.jpg', 48),
(237, 'https://textilelk.com/images/office-blouse-8618.jpg', 324),
(238, 'https://textilelk.com/images/office-blouse-8542.jpg', 296),
(239, 'https://textilelk.com/images/cotton-saree-3369.jpg', 181),
(240, 'https://textilelk.com/images/casual-t-shirt-4116.jpg', 465),
(241, 'https://textilelk.com/images/handloom-scarf-5001.jpg', 153),
(242, 'https://textilelk.com/images/kandyan-osari-9126.jpg', 39),
(243, 'https://textilelk.com/images/office-blouse-7879.jpg', 151),
(244, 'https://textilelk.com/images/cotton-saree-7467.jpg', 24),
(245, 'https://textilelk.com/images/denim-jeans-6104.jpg', 359),
(246, 'https://textilelk.com/images/kandyan-osari-8928.jpg', 133),
(247, 'https://textilelk.com/images/festival-sarong-2863.jpg', 77),
(248, 'https://textilelk.com/images/office-blouse-4270.jpg', 134),
(249, 'https://textilelk.com/images/batik-dress-3920.jpg', 84),
(250, 'https://textilelk.com/images/school-uniform-7891.jpg', 496),
(251, 'https://textilelk.com/images/traditional-veshti-6972.jpg', 323),
(252, 'https://textilelk.com/images/kids-frock-6901.jpg', 348),
(253, 'https://textilelk.com/images/festival-sarong-6134.jpg', 496),
(254, 'https://textilelk.com/images/office-blouse-7256.jpg', 485),
(255, 'https://textilelk.com/images/silk-blouse-8354.jpg', 20),
(256, 'https://textilelk.com/images/batik-dress-5566.jpg', 268),
(257, 'https://textilelk.com/images/kandyan-osari-5389.jpg', 474),
(258, 'https://textilelk.com/images/batik-dress-4791.jpg', 450),
(259, 'https://textilelk.com/images/handloom-scarf-6729.jpg', 431),
(260, 'https://textilelk.com/images/silk-blouse-2525.jpg', 375),
(261, 'https://textilelk.com/images/wedding-lehenga-1324.jpg', 139),
(262, 'https://textilelk.com/images/casual-t-shirt-5834.jpg', 118),
(263, 'https://textilelk.com/images/batik-dress-8388.jpg', 296),
(264, 'https://textilelk.com/images/kids-frock-9315.jpg', 428),
(265, 'https://textilelk.com/images/kids-frock-2709.jpg', 372),
(266, 'https://textilelk.com/images/kandyan-osari-1706.jpg', 441),
(267, 'https://textilelk.com/images/silk-blouse-1450.jpg', 395),
(268, 'https://textilelk.com/images/wedding-lehenga-1944.jpg', 353),
(269, 'https://textilelk.com/images/office-blouse-4953.jpg', 263),
(270, 'https://textilelk.com/images/wedding-lehenga-3041.jpg', 453),
(271, 'https://textilelk.com/images/batik-dress-8765.jpg', 266),
(272, 'https://textilelk.com/images/kandyan-osari-5008.jpg', 211),
(273, 'https://textilelk.com/images/handloom-scarf-8889.jpg', 180),
(274, 'https://textilelk.com/images/kids-frock-1222.jpg', 9),
(275, 'https://textilelk.com/images/school-uniform-4167.jpg', 299),
(276, 'https://textilelk.com/images/linen-shirt-3921.jpg', 386),
(277, 'https://textilelk.com/images/silk-blouse-6893.jpg', 101),
(278, 'https://textilelk.com/images/handloom-scarf-8397.jpg', 294),
(279, 'https://textilelk.com/images/festival-sarong-4675.jpg', 18),
(280, 'https://textilelk.com/images/kids-frock-7522.jpg', 136),
(281, 'https://textilelk.com/images/denim-jeans-4446.jpg', 439),
(282, 'https://textilelk.com/images/office-blouse-8617.jpg', 443),
(283, 'https://textilelk.com/images/cotton-saree-3080.jpg', 175),
(284, 'https://textilelk.com/images/kids-frock-5451.jpg', 191),
(285, 'https://textilelk.com/images/casual-t-shirt-3360.jpg', 45),
(286, 'https://textilelk.com/images/linen-shirt-8838.jpg', 66),
(287, 'https://textilelk.com/images/denim-jeans-6437.jpg', 58),
(288, 'https://textilelk.com/images/linen-shirt-7098.jpg', 262),
(289, 'https://textilelk.com/images/casual-t-shirt-7784.jpg', 447),
(290, 'https://textilelk.com/images/linen-shirt-3970.jpg', 267),
(291, 'https://textilelk.com/images/handloom-scarf-5767.jpg', 255),
(292, 'https://textilelk.com/images/batik-dress-3774.jpg', 100),
(293, 'https://textilelk.com/images/wedding-lehenga-6738.jpg', 379),
(294, 'https://textilelk.com/images/cotton-saree-5917.jpg', 488),
(295, 'https://textilelk.com/images/school-uniform-9611.jpg', 6),
(296, 'https://textilelk.com/images/cotton-pants-6814.jpg', 204),
(297, 'https://textilelk.com/images/kandyan-osari-6443.jpg', 95),
(298, 'https://textilelk.com/images/silk-blouse-4369.jpg', 330),
(299, 'https://textilelk.com/images/wedding-lehenga-8531.jpg', 59),
(300, 'https://textilelk.com/images/cotton-saree-1094.jpg', 154),
(301, 'https://textilelk.com/images/silk-blouse-3023.jpg', 190),
(302, 'https://textilelk.com/images/handloom-scarf-4733.jpg', 218),
(303, 'https://textilelk.com/images/traditional-veshti-1456.jpg', 474),
(304, 'https://textilelk.com/images/kandyan-osari-4331.jpg', 190),
(305, 'https://textilelk.com/images/wedding-lehenga-5906.jpg', 281),
(306, 'https://textilelk.com/images/kandyan-osari-2242.jpg', 289),
(307, 'https://textilelk.com/images/linen-shirt-6600.jpg', 41),
(308, 'https://textilelk.com/images/silk-blouse-2784.jpg', 150),
(309, 'https://textilelk.com/images/silk-blouse-8820.jpg', 308),
(310, 'https://textilelk.com/images/linen-shirt-1303.jpg', 305),
(311, 'https://textilelk.com/images/linen-shirt-7771.jpg', 6),
(312, 'https://textilelk.com/images/school-uniform-5688.jpg', 323),
(313, 'https://textilelk.com/images/batik-dress-8255.jpg', 429),
(314, 'https://textilelk.com/images/silk-blouse-3897.jpg', 472),
(315, 'https://textilelk.com/images/denim-jeans-7695.jpg', 40),
(316, 'https://textilelk.com/images/cotton-pants-9400.jpg', 297),
(317, 'https://textilelk.com/images/cotton-saree-7729.jpg', 69),
(318, 'https://textilelk.com/images/festival-sarong-7542.jpg', 206),
(319, 'https://textilelk.com/images/silk-blouse-5184.jpg', 63),
(320, 'https://textilelk.com/images/kandyan-osari-6505.jpg', 459),
(321, 'https://textilelk.com/images/cotton-pants-4943.jpg', 423),
(322, 'https://textilelk.com/images/kids-frock-6920.jpg', 130),
(323, 'https://textilelk.com/images/kids-frock-3465.jpg', 281),
(324, 'https://textilelk.com/images/denim-jeans-5238.jpg', 123),
(325, 'https://textilelk.com/images/casual-t-shirt-8601.jpg', 44),
(326, 'https://textilelk.com/images/kandyan-osari-6670.jpg', 223),
(327, 'https://textilelk.com/images/denim-jeans-2590.jpg', 159),
(328, 'https://textilelk.com/images/kandyan-osari-8855.jpg', 218),
(329, 'https://textilelk.com/images/office-blouse-2302.jpg', 285),
(330, 'https://textilelk.com/images/kandyan-osari-4273.jpg', 481),
(331, 'https://textilelk.com/images/office-blouse-5208.jpg', 250),
(332, 'https://textilelk.com/images/cotton-pants-7954.jpg', 35),
(333, 'https://textilelk.com/images/traditional-veshti-3476.jpg', 477),
(334, 'https://textilelk.com/images/festival-sarong-1768.jpg', 321),
(335, 'https://textilelk.com/images/handloom-scarf-7567.jpg', 495),
(336, 'https://textilelk.com/images/wedding-lehenga-6044.jpg', 289),
(337, 'https://textilelk.com/images/handloom-scarf-1131.jpg', 8),
(338, 'https://textilelk.com/images/batik-dress-5280.jpg', 141),
(339, 'https://textilelk.com/images/festival-sarong-3034.jpg', 114),
(340, 'https://textilelk.com/images/cotton-pants-2138.jpg', 380),
(341, 'https://textilelk.com/images/traditional-veshti-4457.jpg', 381),
(342, 'https://textilelk.com/images/cotton-saree-5648.jpg', 96),
(343, 'https://textilelk.com/images/cotton-pants-4250.jpg', 10),
(344, 'https://textilelk.com/images/school-uniform-8857.jpg', 122),
(345, 'https://textilelk.com/images/office-blouse-5428.jpg', 282),
(346, 'https://textilelk.com/images/batik-dress-7937.jpg', 270),
(347, 'https://textilelk.com/images/cotton-pants-3094.jpg', 220),
(348, 'https://textilelk.com/images/kandyan-osari-2576.jpg', 235),
(349, 'https://textilelk.com/images/festival-sarong-6356.jpg', 464),
(350, 'https://textilelk.com/images/kandyan-osari-6555.jpg', 131),
(351, 'https://textilelk.com/images/handloom-scarf-9744.jpg', 172),
(352, 'https://textilelk.com/images/denim-jeans-9675.jpg', 154),
(353, 'https://textilelk.com/images/office-blouse-9396.jpg', 428),
(354, 'https://textilelk.com/images/linen-shirt-5865.jpg', 427),
(355, 'https://textilelk.com/images/school-uniform-9145.jpg', 39),
(356, 'https://textilelk.com/images/linen-shirt-2760.jpg', 70),
(357, 'https://textilelk.com/images/casual-t-shirt-5568.jpg', 314),
(358, 'https://textilelk.com/images/traditional-veshti-2889.jpg', 90),
(359, 'https://textilelk.com/images/denim-jeans-4259.jpg', 440),
(360, 'https://textilelk.com/images/handloom-scarf-3300.jpg', 231),
(361, 'https://textilelk.com/images/denim-jeans-4813.jpg', 455),
(362, 'https://textilelk.com/images/kandyan-osari-5717.jpg', 74),
(363, 'https://textilelk.com/images/kids-frock-9135.jpg', 179),
(364, 'https://textilelk.com/images/school-uniform-5153.jpg', 367),
(365, 'https://textilelk.com/images/casual-t-shirt-7372.jpg', 461),
(366, 'https://textilelk.com/images/silk-blouse-4172.jpg', 338),
(367, 'https://textilelk.com/images/cotton-pants-3603.jpg', 438),
(368, 'https://textilelk.com/images/kids-frock-6374.jpg', 224),
(369, 'https://textilelk.com/images/casual-t-shirt-5044.jpg', 196),
(370, 'https://textilelk.com/images/handloom-scarf-8096.jpg', 19),
(371, 'https://textilelk.com/images/batik-dress-8950.jpg', 200),
(372, 'https://textilelk.com/images/denim-jeans-6109.jpg', 492),
(373, 'https://textilelk.com/images/wedding-lehenga-7935.jpg', 399),
(374, 'https://textilelk.com/images/wedding-lehenga-9022.jpg', 382),
(375, 'https://textilelk.com/images/cotton-saree-7003.jpg', 163),
(376, 'https://textilelk.com/images/cotton-pants-2280.jpg', 442),
(377, 'https://textilelk.com/images/batik-dress-4701.jpg', 231),
(378, 'https://textilelk.com/images/casual-t-shirt-5105.jpg', 169),
(379, 'https://textilelk.com/images/kandyan-osari-7333.jpg', 261),
(380, 'https://textilelk.com/images/casual-t-shirt-3336.jpg', 173),
(381, 'https://textilelk.com/images/casual-t-shirt-2291.jpg', 5),
(382, 'https://textilelk.com/images/denim-jeans-9822.jpg', 389),
(383, 'https://textilelk.com/images/casual-t-shirt-6697.jpg', 333),
(384, 'https://textilelk.com/images/cotton-saree-1966.jpg', 284),
(385, 'https://textilelk.com/images/traditional-veshti-3375.jpg', 146),
(386, 'https://textilelk.com/images/denim-jeans-1514.jpg', 210),
(387, 'https://textilelk.com/images/cotton-pants-4853.jpg', 82),
(388, 'https://textilelk.com/images/casual-t-shirt-9989.jpg', 47),
(389, 'https://textilelk.com/images/denim-jeans-4117.jpg', 117),
(390, 'https://textilelk.com/images/casual-t-shirt-1779.jpg', 379),
(391, 'https://textilelk.com/images/cotton-saree-6031.jpg', 282),
(392, 'https://textilelk.com/images/office-blouse-2497.jpg', 284),
(393, 'https://textilelk.com/images/office-blouse-4419.jpg', 78),
(394, 'https://textilelk.com/images/cotton-saree-1471.jpg', 203),
(395, 'https://textilelk.com/images/kids-frock-7512.jpg', 265),
(396, 'https://textilelk.com/images/festival-sarong-3091.jpg', 472),
(397, 'https://textilelk.com/images/linen-shirt-4038.jpg', 87),
(398, 'https://textilelk.com/images/casual-t-shirt-8091.jpg', 254),
(399, 'https://textilelk.com/images/kandyan-osari-2317.jpg', 468),
(400, 'https://textilelk.com/images/festival-sarong-6286.jpg', 315),
(401, 'https://textilelk.com/images/casual-t-shirt-3915.jpg', 159),
(402, 'https://textilelk.com/images/kandyan-osari-8278.jpg', 466),
(403, 'https://textilelk.com/images/festival-sarong-2577.jpg', 6),
(404, 'https://textilelk.com/images/wedding-lehenga-7514.jpg', 199),
(405, 'https://textilelk.com/images/kids-frock-4868.jpg', 190),
(406, 'https://textilelk.com/images/casual-t-shirt-3468.jpg', 419),
(407, 'https://textilelk.com/images/traditional-veshti-5170.jpg', 430),
(408, 'https://textilelk.com/images/handloom-scarf-7716.jpg', 371),
(409, 'https://textilelk.com/images/handloom-scarf-8537.jpg', 351),
(410, 'https://textilelk.com/images/casual-t-shirt-3107.jpg', 195),
(411, 'https://textilelk.com/images/wedding-lehenga-3278.jpg', 22),
(412, 'https://textilelk.com/images/school-uniform-9420.jpg', 49),
(413, 'https://textilelk.com/images/cotton-saree-6037.jpg', 95),
(414, 'https://textilelk.com/images/traditional-veshti-6038.jpg', 32),
(415, 'https://textilelk.com/images/school-uniform-1089.jpg', 247),
(416, 'https://textilelk.com/images/cotton-pants-9117.jpg', 4),
(417, 'https://textilelk.com/images/festival-sarong-4526.jpg', 155),
(418, 'https://textilelk.com/images/denim-jeans-9651.jpg', 372),
(419, 'https://textilelk.com/images/silk-blouse-6230.jpg', 310),
(420, 'https://textilelk.com/images/handloom-scarf-9298.jpg', 455),
(421, 'https://textilelk.com/images/school-uniform-2921.jpg', 318),
(422, 'https://textilelk.com/images/cotton-pants-7309.jpg', 46),
(423, 'https://textilelk.com/images/cotton-saree-4926.jpg', 269),
(424, 'https://textilelk.com/images/cotton-saree-4286.jpg', 493),
(425, 'https://textilelk.com/images/school-uniform-4656.jpg', 319),
(426, 'https://textilelk.com/images/casual-t-shirt-6512.jpg', 246),
(427, 'https://textilelk.com/images/cotton-pants-1543.jpg', 331),
(428, 'https://textilelk.com/images/school-uniform-9506.jpg', 321),
(429, 'https://textilelk.com/images/handloom-scarf-7023.jpg', 282),
(430, 'https://textilelk.com/images/linen-shirt-6131.jpg', 288),
(431, 'https://textilelk.com/images/denim-jeans-8607.jpg', 382),
(432, 'https://textilelk.com/images/handloom-scarf-5430.jpg', 203),
(433, 'https://textilelk.com/images/kandyan-osari-7464.jpg', 15),
(434, 'https://textilelk.com/images/silk-blouse-4335.jpg', 442),
(435, 'https://textilelk.com/images/wedding-lehenga-3358.jpg', 76),
(436, 'https://textilelk.com/images/kids-frock-1096.jpg', 147),
(437, 'https://textilelk.com/images/silk-blouse-3577.jpg', 179),
(438, 'https://textilelk.com/images/kandyan-osari-1890.jpg', 484),
(439, 'https://textilelk.com/images/cotton-saree-7042.jpg', 154),
(440, 'https://textilelk.com/images/wedding-lehenga-2505.jpg', 238),
(441, 'https://textilelk.com/images/cotton-saree-3527.jpg', 243),
(442, 'https://textilelk.com/images/kandyan-osari-9262.jpg', 236),
(443, 'https://textilelk.com/images/linen-shirt-8677.jpg', 313),
(444, 'https://textilelk.com/images/casual-t-shirt-6361.jpg', 381),
(445, 'https://textilelk.com/images/festival-sarong-3054.jpg', 25),
(446, 'https://textilelk.com/images/denim-jeans-2332.jpg', 223),
(447, 'https://textilelk.com/images/wedding-lehenga-7030.jpg', 476),
(448, 'https://textilelk.com/images/office-blouse-5079.jpg', 162),
(449, 'https://textilelk.com/images/school-uniform-2884.jpg', 171),
(450, 'https://textilelk.com/images/linen-shirt-5307.jpg', 21),
(451, 'https://textilelk.com/images/office-blouse-4059.jpg', 58),
(452, 'https://textilelk.com/images/linen-shirt-2530.jpg', 97),
(453, 'https://textilelk.com/images/cotton-saree-6681.jpg', 265),
(454, 'https://textilelk.com/images/handloom-scarf-4105.jpg', 70),
(455, 'https://textilelk.com/images/kids-frock-5575.jpg', 57),
(456, 'https://textilelk.com/images/casual-t-shirt-5287.jpg', 299),
(457, 'https://textilelk.com/images/kids-frock-7644.jpg', 136),
(458, 'https://textilelk.com/images/wedding-lehenga-1277.jpg', 150),
(459, 'https://textilelk.com/images/wedding-lehenga-9388.jpg', 333),
(460, 'https://textilelk.com/images/linen-shirt-1579.jpg', 449),
(461, 'https://textilelk.com/images/festival-sarong-8344.jpg', 352),
(462, 'https://textilelk.com/images/handloom-scarf-1792.jpg', 468),
(463, 'https://textilelk.com/images/cotton-pants-3345.jpg', 236),
(464, 'https://textilelk.com/images/denim-jeans-5147.jpg', 107),
(465, 'https://textilelk.com/images/festival-sarong-8161.jpg', 174),
(466, 'https://textilelk.com/images/office-blouse-2447.jpg', 125),
(467, 'https://textilelk.com/images/festival-sarong-5586.jpg', 398),
(468, 'https://textilelk.com/images/school-uniform-2588.jpg', 334),
(469, 'https://textilelk.com/images/cotton-pants-5477.jpg', 325),
(470, 'https://textilelk.com/images/kandyan-osari-1221.jpg', 25),
(471, 'https://textilelk.com/images/festival-sarong-5021.jpg', 373),
(472, 'https://textilelk.com/images/handloom-scarf-9131.jpg', 164),
(473, 'https://textilelk.com/images/handloom-scarf-3620.jpg', 326),
(474, 'https://textilelk.com/images/linen-shirt-6193.jpg', 294),
(475, 'https://textilelk.com/images/wedding-lehenga-1322.jpg', 277),
(476, 'https://textilelk.com/images/casual-t-shirt-9492.jpg', 444),
(477, 'https://textilelk.com/images/kandyan-osari-1698.jpg', 463),
(478, 'https://textilelk.com/images/festival-sarong-2421.jpg', 81),
(479, 'https://textilelk.com/images/batik-dress-8436.jpg', 352),
(480, 'https://textilelk.com/images/denim-jeans-2121.jpg', 397),
(481, 'https://textilelk.com/images/batik-dress-1658.jpg', 60),
(482, 'https://textilelk.com/images/silk-blouse-7113.jpg', 115),
(483, 'https://textilelk.com/images/kandyan-osari-4423.jpg', 176),
(484, 'https://textilelk.com/images/linen-shirt-6692.jpg', 141),
(485, 'https://textilelk.com/images/traditional-veshti-9197.jpg', 53),
(486, 'https://textilelk.com/images/denim-jeans-7639.jpg', 205),
(487, 'https://textilelk.com/images/cotton-pants-7565.jpg', 178),
(488, 'https://textilelk.com/images/batik-dress-3645.jpg', 375),
(489, 'https://textilelk.com/images/office-blouse-2098.jpg', 327),
(490, 'https://textilelk.com/images/casual-t-shirt-2219.jpg', 122),
(491, 'https://textilelk.com/images/casual-t-shirt-9085.jpg', 380),
(492, 'https://textilelk.com/images/office-blouse-7682.jpg', 183),
(493, 'https://textilelk.com/images/festival-sarong-3412.jpg', 265),
(494, 'https://textilelk.com/images/kandyan-osari-1878.jpg', 326),
(495, 'https://textilelk.com/images/school-uniform-1334.jpg', 475),
(496, 'https://textilelk.com/images/office-blouse-8495.jpg', 308),
(497, 'https://textilelk.com/images/linen-shirt-9328.jpg', 438),
(498, 'https://textilelk.com/images/wedding-lehenga-5513.jpg', 260),
(499, 'https://textilelk.com/images/silk-blouse-9060.jpg', 351),
(500, 'https://textilelk.com/images/linen-shirt-2280.jpg', 2);


INSERT INTO Promotions (PromoID, StartTime, EndTime, Percentage, PromotionName) VALUES
(1, '2025-02-04 00:00:00', '2025-02-13 23:59:59', 15, 'Valentine Day Offer Final Days 2025'),
(2, '2025-02-17 00:00:00', '2025-02-22 23:59:59', 15, 'Valentine Day Offer 2025'),
(3, '2025-02-02 00:00:00', '2025-02-08 23:59:59', 25, 'Navam Perahera Sale 2025'),
(4, '2025-01-04 00:00:00', '2025-01-13 23:59:59', 25, 'Thai Pongal Special 2025'),
(5, '2025-01-01 00:00:00', '2025-01-05 23:59:59', 30, 'New Year Clearance 2025'),
(6, '2025-03-09 00:00:00', '2025-03-13 23:59:59', 20, 'Spring Festival Sale Early Bird 2025'),
(7, '2025-03-07 00:00:00', '2025-03-17 23:59:59', 10, 'Pre-Avurudu Launch 2025'),
(8, '2025-01-18 00:00:00', '2025-01-22 23:59:59', 20, 'New Year Clearance 2025'),
(9, '2025-03-02 00:00:00', '2025-03-06 23:59:59', 20, 'Spring Festival Sale 2025'),
(10, '2025-01-12 00:00:00', '2025-01-19 23:59:59', 20, 'Thai Pongal Special 2025'),
(11, '2025-02-01 00:00:00', '2025-02-08 23:59:59', 15, 'Navam Perahera Sale 2025'),
(12, '2025-01-20 00:00:00', '2025-01-30 23:59:59', 15, 'Back to School Sale 2025'),
(13, '2025-03-06 00:00:00', '2025-03-15 23:59:59', 15, 'Spring Festival Sale Final Days 2025'),
(14, '2025-01-09 00:00:00', '2025-01-15 23:59:59', 30, 'New Year Clearance Final Days 2025'),
(15, '2025-03-05 00:00:00', '2025-03-09 23:59:59', 20, 'Spring Festival Sale Early Bird 2025');


INSERT INTO Returnes (ReturnID, Date, Time, CustomerID) VALUES
(1, '2025-03-02', '13:36:00', 251),
(2, '2025-02-26', '14:08:00', 256),
(3, '2025-02-08', '10:14:00', 6),
(4, '2025-01-04', '20:35:00', 384),
(5, '2025-03-09', '16:23:00', 493),
(6, '2025-02-06', '10:56:00', 431),
(7, '2025-01-06', '15:46:00', 303),
(8, '2025-02-25', '17:50:00', 110),
(9, '2025-01-05', '14:23:00', 149),
(10, '2025-03-12', '13:49:00', 84),
(11, '2025-03-29', '14:38:00', 297),
(12, '2025-03-04', '10:36:00', 16),
(13, '2025-03-14', '13:30:00', 206),
(14, '2025-01-21', '15:15:00', 380),
(15, '2025-02-05', '13:00:00', 64),
(16, '2025-03-27', '12:30:00', 354),
(17, '2025-01-25', '11:52:00', 250),
(18, '2025-02-21', '18:44:00', 203),
(19, '2025-03-28', '14:28:00', 338),
(20, '2025-01-21', '20:22:00', 332),
(21, '2025-03-30', '12:50:00', 427),
(22, '2025-01-14', '18:48:00', 176),
(23, '2025-02-03', '16:59:00', 284),
(24, '2025-03-11', '10:44:00', 288),
(25, '2025-03-30', '15:17:00', 284),
(26, '2025-01-26', '12:53:00', 433),
(27, '2025-01-08', '16:24:00', 451),
(28, '2025-01-26', '17:27:00', 481),
(29, '2025-01-09', '17:46:00', 416),
(30, '2025-01-31', '19:48:00', 134),
(31, '2025-01-23', '19:16:00', 452),
(32, '2025-03-28', '17:41:00', 171),
(33, '2025-02-21', '13:46:00', 463),
(34, '2025-01-01', '17:35:00', 426),
(35, '2025-03-13', '20:03:00', 200),
(36, '2025-03-24', '13:21:00', 287),
(37, '2025-01-16', '12:04:00', 353),
(38, '2025-01-24', '14:04:00', 122),
(39, '2025-02-06', '16:50:00', 263),
(40, '2025-02-28', '12:48:00', 242),
(41, '2025-02-04', '14:31:00', 192),
(42, '2025-02-21', '15:32:00', 373),
(43, '2025-03-28', '18:43:00', 351),
(44, '2025-02-18', '14:52:00', 307),
(45, '2025-02-24', '15:45:00', 131),
(46, '2025-03-11', '18:57:00', 134),
(47, '2025-01-18', '11:35:00', 124),
(48, '2025-01-15', '13:27:00', 211),
(49, '2025-03-30', '16:09:00', 226),
(50, '2025-03-05', '19:44:00', 372),
(51, '2025-02-01', '11:11:00', 70),
(52, '2025-03-06', '19:10:00', 43),
(53, '2025-01-05', '17:12:00', 182),
(54, '2025-03-02', '16:57:00', 193),
(55, '2025-02-06', '14:03:00', 237),
(56, '2025-01-26', '16:42:00', 76),
(57, '2025-03-24', '12:29:00', 268),
(58, '2025-01-23', '20:24:00', 179),
(59, '2025-01-21', '18:40:00', 328),
(60, '2025-03-07', '11:17:00', 355),
(61, '2025-01-12', '15:29:00', 8),
(62, '2025-02-28', '19:23:00', 386),
(63, '2025-01-25', '19:19:00', 306),
(64, '2025-01-03', '12:59:00', 23),
(65, '2025-02-05', '14:12:00', 8),
(66, '2025-03-17', '18:06:00', 11),
(67, '2025-03-27', '17:49:00', 435),
(68, '2025-01-11', '15:14:00', 298),
(69, '2025-02-01', '16:39:00', 154),
(70, '2025-03-18', '10:56:00', 453),
(71, '2025-01-21', '17:27:00', 299),
(72, '2025-02-02', '19:49:00', 150),
(73, '2025-02-24', '17:07:00', 298),
(74, '2025-03-13', '17:58:00', 421),
(75, '2025-03-04', '13:03:00', 122),
(76, '2025-02-07', '14:38:00', 276),
(77, '2025-02-28', '20:16:00', 431),
(78, '2025-01-15', '15:09:00', 105),
(79, '2025-01-13', '15:11:00', 424),
(80, '2025-01-28', '19:18:00', 182),
(81, '2025-03-26', '16:26:00', 343),
(82, '2025-02-03', '10:17:00', 394),
(83, '2025-01-11', '16:14:00', 482),
(84, '2025-02-14', '10:19:00', 57),
(85, '2025-03-11', '18:28:00', 312),
(86, '2025-03-02', '17:14:00', 180),
(87, '2025-02-16', '14:25:00', 344),
(88, '2025-03-03', '16:16:00', 10),
(89, '2025-02-26', '12:44:00', 397),
(90, '2025-01-26', '17:08:00', 121),
(91, '2025-01-25', '14:26:00', 143),
(92, '2025-03-15', '17:40:00', 130),
(93, '2025-02-24', '18:09:00', 296),
(94, '2025-03-02', '10:07:00', 300),
(95, '2025-03-08', '20:03:00', 114),
(96, '2025-02-14', '17:34:00', 466),
(97, '2025-01-03', '13:27:00', 263),
(98, '2025-03-28', '20:17:00', 226),
(99, '2025-02-11', '20:05:00', 64),
(100, '2025-01-11', '19:03:00', 416),
(101, '2025-03-30', '16:40:00', 168),
(102, '2025-02-21', '15:10:00', 379),
(103, '2025-03-08', '11:22:00', 270),
(104, '2025-03-25', '15:49:00', 447),
(105, '2025-03-25', '12:02:00', 140),
(106, '2025-03-02', '13:47:00', 424),
(107, '2025-02-18', '17:12:00', 82),
(108, '2025-02-13', '16:11:00', 207),
(109, '2025-02-20', '19:56:00', 214),
(110, '2025-03-01', '11:24:00', 116),
(111, '2025-02-11', '20:24:00', 393),
(112, '2025-01-13', '16:50:00', 438),
(113, '2025-02-16', '19:26:00', 392),
(114, '2025-02-06', '19:40:00', 67),
(115, '2025-02-22', '14:24:00', 40),
(116, '2025-01-22', '13:30:00', 166),
(117, '2025-03-14', '19:27:00', 58),
(118, '2025-01-23', '19:19:00', 38),
(119, '2025-01-17', '17:27:00', 191),
(120, '2025-01-13', '19:30:00', 130),
(121, '2025-02-08', '20:02:00', 451),
(122, '2025-03-04', '17:24:00', 277),
(123, '2025-03-04', '10:07:00', 295),
(124, '2025-01-19', '17:37:00', 387),
(125, '2025-02-12', '11:04:00', 49),
(126, '2025-03-30', '13:48:00', 415),
(127, '2025-03-07', '17:23:00', 199),
(128, '2025-03-08', '18:01:00', 242),
(129, '2025-03-24', '16:07:00', 16),
(130, '2025-03-10', '10:23:00', 356),
(131, '2025-01-09', '14:24:00', 44),
(132, '2025-02-03', '18:23:00', 408),
(133, '2025-02-06', '10:24:00', 476),
(134, '2025-01-04', '16:17:00', 199),
(135, '2025-03-23', '15:07:00', 50),
(136, '2025-02-19', '17:41:00', 255),
(137, '2025-02-11', '11:56:00', 67),
(138, '2025-02-16', '20:33:00', 328),
(139, '2025-03-29', '14:35:00', 149),
(140, '2025-02-03', '18:07:00', 12),
(141, '2025-02-13', '11:03:00', 263),
(142, '2025-01-28', '11:55:00', 194),
(143, '2025-03-12', '10:25:00', 147),
(144, '2025-03-23', '16:41:00', 27),
(145, '2025-03-02', '15:36:00', 34),
(146, '2025-03-23', '11:40:00', 19),
(147, '2025-01-16', '14:52:00', 446),
(148, '2025-03-14', '18:07:00', 266),
(149, '2025-02-13', '16:44:00', 356),
(150, '2025-02-18', '18:29:00', 341),
(151, '2025-01-26', '12:41:00', 470),
(152, '2025-03-15', '10:27:00', 407),
(153, '2025-03-24', '17:55:00', 35),
(154, '2025-02-10', '12:15:00', 53),
(155, '2025-02-12', '13:57:00', 157),
(156, '2025-01-02', '14:02:00', 489),
(157, '2025-02-01', '13:37:00', 131),
(158, '2025-02-25', '14:19:00', 75),
(159, '2025-03-11', '10:17:00', 46),
(160, '2025-03-08', '11:19:00', 242),
(161, '2025-02-04', '16:15:00', 431),
(162, '2025-02-09', '14:21:00', 54),
(163, '2025-02-25', '19:57:00', 128),
(164, '2025-02-24', '13:37:00', 37),
(165, '2025-01-29', '12:06:00', 402),
(166, '2025-03-26', '13:32:00', 197),
(167, '2025-01-13', '12:23:00', 103),
(168, '2025-01-27', '15:19:00', 63),
(169, '2025-03-19', '19:48:00', 196),
(170, '2025-01-12', '14:42:00', 326),
(171, '2025-03-01', '12:18:00', 328),
(172, '2025-01-08', '10:31:00', 328),
(173, '2025-01-04', '10:36:00', 488),
(174, '2025-01-16', '10:07:00', 310),
(175, '2025-02-12', '10:17:00', 375),
(176, '2025-03-21', '18:54:00', 191),
(177, '2025-03-02', '14:20:00', 171),
(178, '2025-02-03', '11:55:00', 31),
(179, '2025-01-24', '12:37:00', 35),
(180, '2025-02-03', '10:14:00', 239),
(181, '2025-01-21', '11:17:00', 91),
(182, '2025-03-23', '13:10:00', 496),
(183, '2025-02-01', '16:47:00', 278),
(184, '2025-03-28', '15:09:00', 7),
(185, '2025-03-14', '12:33:00', 132),
(186, '2025-02-04', '15:55:00', 155),
(187, '2025-01-20', '16:34:00', 357),
(188, '2025-02-24', '15:58:00', 494),
(189, '2025-02-15', '17:14:00', 169),
(190, '2025-02-25', '16:56:00', 81),
(191, '2025-02-07', '17:03:00', 381),
(192, '2025-02-05', '20:03:00', 379),
(193, '2025-03-17', '16:48:00', 452),
(194, '2025-03-04', '19:30:00', 324),
(195, '2025-02-14', '12:05:00', 324),
(196, '2025-03-14', '11:53:00', 352),
(197, '2025-01-22', '19:47:00', 219),
(198, '2025-03-19', '17:21:00', 489),
(199, '2025-03-08', '17:45:00', 194),
(200, '2025-03-09', '10:36:00', 267);

INSERT INTO ReturnItems (ReturnItemsID, ProductID, ReturnID) VALUES
(1, 497, 21),
(2, 203, 160),
(3, 379, 15),
(4, 200, 34),
(5, 305, 38),
(6, 204, 5),
(7, 291, 65),
(8, 344, 93),
(9, 139, 158),
(10, 163, 60),
(11, 351, 131),
(12, 494, 47),
(13, 307, 22),
(14, 243, 16),
(15, 49, 72),
(16, 90, 195),
(17, 414, 130),
(18, 351, 35),
(19, 13, 67),
(20, 6, 77),
(21, 476, 59),
(22, 164, 116),
(23, 236, 3),
(24, 115, 111),
(25, 327, 101),
(26, 244, 46),
(27, 180, 125),
(28, 437, 88),
(29, 361, 164),
(30, 449, 62),
(31, 274, 109),
(32, 200, 120),
(33, 51, 157),
(34, 455, 26),
(35, 96, 168),
(36, 452, 183),
(37, 156, 64),
(38, 169, 185),
(39, 459, 143),
(40, 268, 117),
(41, 414, 42),
(42, 234, 182),
(43, 403, 114),
(44, 403, 30),
(45, 320, 14),
(46, 331, 98),
(47, 72, 193),
(48, 86, 135),
(49, 445, 50),
(50, 323, 156),
(51, 283, 179),
(52, 267, 196),
(53, 177, 142),
(54, 181, 74),
(55, 89, 166),
(56, 343, 138),
(57, 224, 198),
(58, 418, 123),
(59, 168, 167),
(60, 373, 200),
(61, 379, 163),
(62, 438, 83),
(63, 101, 25),
(64, 414, 63),
(65, 151, 78),
(66, 201, 146),
(67, 40, 133),
(68, 3, 12),
(69, 271, 144),
(70, 269, 40),
(71, 320, 82),
(72, 148, 7),
(73, 145, 6),
(74, 186, 190),
(75, 102, 194),
(76, 262, 36),
(77, 376, 192),
(78, 339, 134),
(79, 68, 80),
(80, 86, 189),
(81, 303, 150),
(82, 469, 56),
(83, 194, 122),
(84, 341, 107),
(85, 415, 89),
(86, 273, 113),
(87, 257, 140),
(88, 261, 49),
(89, 228, 97),
(90, 3, 68),
(91, 49, 151),
(92, 174, 121),
(93, 133, 105),
(94, 316, 99),
(95, 272, 11),
(96, 61, 197),
(97, 426, 39),
(98, 361, 81),
(99, 165, 31),
(100, 230, 76),
(101, 487, 148),
(102, 4, 148),
(103, 107, 155),
(104, 105, 155),
(105, 71, 171),
(106, 336, 171),
(107, 497, 137),
(108, 274, 137),
(109, 47, 175),
(110, 153, 175),
(111, 424, 154),
(112, 237, 154),
(113, 270, 153),
(114, 287, 153),
(115, 310, 188),
(116, 323, 188),
(117, 258, 28),
(118, 371, 28),
(119, 399, 159),
(120, 413, 159),
(121, 362, 17),
(122, 127, 17),
(123, 472, 95),
(124, 460, 95),
(125, 416, 45),
(126, 201, 45),
(127, 45, 29),
(128, 215, 29),
(129, 134, 94),
(130, 48, 94),
(131, 382, 115),
(132, 157, 115),
(133, 267, 2),
(134, 56, 2),
(135, 57, 187),
(136, 26, 187),
(137, 358, 145),
(138, 54, 145),
(139, 117, 79),
(140, 479, 79),
(141, 137, 126),
(142, 36, 126),
(143, 12, 110),
(144, 471, 110),
(145, 215, 177),
(146, 95, 177),
(147, 264, 176),
(148, 217, 176),
(149, 204, 161),
(150, 162, 161),
(151, 272, 149),
(152, 381, 149),
(153, 391, 58),
(154, 217, 58),
(155, 221, 92),
(156, 491, 92),
(157, 251, 71),
(158, 136, 71),
(159, 117, 33),
(160, 294, 33),
(161, 296, 139),
(162, 430, 139),
(163, 54, 32),
(164, 198, 32),
(165, 168, 69),
(166, 177, 69),
(167, 187, 178),
(168, 343, 178),
(169, 72, 128),
(170, 396, 128),
(171, 72, 96),
(172, 198, 96),
(173, 22, 18),
(174, 395, 18),
(175, 20, 108),
(176, 338, 108),
(177, 492, 4),
(178, 368, 4),
(179, 378, 172),
(180, 103, 172),
(181, 74, 86),
(182, 175, 86),
(183, 470, 103),
(184, 422, 103),
(185, 328, 70),
(186, 327, 70),
(187, 293, 152),
(188, 255, 152),
(189, 77, 66),
(190, 61, 66),
(191, 85, 73),
(192, 251, 73),
(193, 100, 54),
(194, 198, 54),
(195, 251, 8),
(196, 253, 8),
(197, 374, 51),
(198, 1, 51),
(199, 104, 84),
(200, 41, 84),
(201, 460, 90),
(202, 24, 90),
(203, 242, 106),
(204, 258, 106),
(205, 94, 27),
(206, 494, 27),
(207, 73, 124),
(208, 164, 124),
(209, 295, 162),
(210, 95, 162),
(211, 412, 136),
(212, 298, 136),
(213, 372, 20),
(214, 12, 20),
(215, 168, 191),
(216, 240, 191),
(217, 120, 132),
(218, 430, 132),
(219, 194, 44),
(220, 89, 44),
(221, 175, 169),
(222, 272, 169),
(223, 355, 43),
(224, 444, 43),
(225, 57, 41),
(226, 396, 41),
(227, 91, 147),
(228, 40, 147),
(229, 89, 91),
(230, 489, 91),
(231, 288, 181),
(232, 220, 181),
(233, 6, 184),
(234, 153, 184),
(235, 190, 129),
(236, 433, 129),
(237, 487, 186),
(238, 89, 186),
(239, 371, 127),
(240, 229, 127),
(241, 494, 118),
(242, 272, 118),
(243, 356, 55),
(244, 44, 55),
(245, 20, 100),
(246, 2, 100),
(247, 177, 1),
(248, 293, 1),
(249, 264, 180),
(250, 284, 180),
(251, 107, 24),
(252, 454, 24),
(253, 84, 112),
(254, 406, 112),
(255, 110, 173),
(256, 448, 173),
(257, 344, 10),
(258, 283, 10),
(259, 324, 52),
(260, 190, 52),
(261, 320, 170),
(262, 198, 170),
(263, 146, 23),
(264, 305, 23),
(265, 5, 53),
(266, 103, 53),
(267, 75, 102),
(268, 409, 102),
(269, 40, 37),
(270, 44, 37),
(271, 78, 61),
(272, 109, 61),
(273, 78, 165),
(274, 282, 165),
(275, 190, 48),
(276, 20, 48),
(277, 475, 87),
(278, 127, 87),
(279, 294, 119),
(280, 68, 119),
(281, 408, 199),
(282, 180, 199),
(283, 132, 75),
(284, 161, 75),
(285, 164, 9),
(286, 78, 9),
(287, 77, 13),
(288, 78, 13),
(289, 40, 104),
(290, 17, 104),
(291, 11, 57),
(292, 448, 57),
(293, 142, 141),
(294, 163, 141),
(295, 449, 85),
(296, 388, 85),
(297, 139, 19),
(298, 403, 19),
(299, 485, 174),
(300, 463, 174);

INSERT INTO Color (ColorID, Name, HexCode) VALUES
(1, 'White', '#FFFFFF'),
(2, 'Black', '#000000'),
(3, 'Red', '#FF0000'),
(4, 'Green', '#008000'),
(5, 'Yellow', '#0000FF'),
(6, 'Blue', '#FFFF00'),
(7, 'Pink', '#FFC0CB'),
(8, 'Purple', '#800080'),
(9, 'Orange', '#FFA500'),
(10, 'Gray', '#808080'),
(11, 'Brown', '#A52A2A'),
(12, 'Navy', '#000080'),
(13, 'Beige', '#F5F5DC'),
(14, 'Maroon', '#800000'),
(15, 'Teal', '#008080');

INSERT INTO Size (SizeID, Name, Measurements) VALUES
(1, 'XS', 'Chest: 32-34 inches, Waist: 24-26 inches'),
(2, 'S', 'Chest: 35-37 inches, Waist: 27-29 inches'),
(3, 'M', 'Chest: 38-40 inches, Waist: 30-32 inches'),
(4, 'L', 'Chest: 41-43 inches, Waist: 33-35 inches'),
(5, 'XL', 'Chest: 44-46 inches, Waist: 36-38 inches'),
(6, 'XXL', 'Chest: 47-49 inches, Waist: 39-41 inches');

Select*from Inventory;


INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (1, 'New Balance Dress 1', 'High quality New Balance Dress 1', 'New Balance', 'Standard specifications', 'Cotton', 47, 199.49, 39.90, 'removed', 10, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (2, 'Under Armour Jeans 2', 'High quality Under Armour Jeans 2', 'Under Armour', 'Standard specifications', 'Cotton', 85, 199.83, 39.97, 'active', 2, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (3, 'Nike Shoes 3', 'High quality Nike Shoes 3', 'Nike', 'Standard specifications', 'Cotton', 86, 89.82, 17.96, 'active', 19, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (4, 'Adidas Sweater 4', 'High quality Adidas Sweater 4', 'Adidas', 'Standard specifications', 'Cotton', 30, 95.46, 19.09, 'active', 12, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (5, 'Reebok Jacket 5', 'High quality Reebok Jacket 5', 'Reebok', 'Standard specifications', 'Cotton', 38, 24.93, 4.99, 'active', 10, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (6, 'Puma T-shirt 6', 'High quality Puma T-shirt 6', 'Puma', 'Standard specifications', 'Cotton', 96, 164.13, 32.83, 'removed', 2, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (7, 'BrandA Topwear 7', 'High quality BrandA Topwear 7', 'BrandA', 'Standard specifications', 'Cotton', 10, 181.03, 36.21, 'active', 14, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (8, 'BrandB Bottomwear 8', 'High quality BrandB Bottomwear 8', 'BrandB', 'Standard specifications', 'Cotton', 57, 30.66, 6.13, 'active', 8, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (9, 'BrandC Outerwear 9', 'High quality BrandC Outerwear 9', 'BrandC', 'Standard specifications', 'Cotton', 13, 140.90, 28.18, 'active', 4, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (10, 'BrandD Footwear 10', 'High quality BrandD Footwear 10', 'BrandD', 'Standard specifications', 'Cotton', 78, 72.13, 14.43, 'active', 17, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (11, 'BrandE Accessories 11', 'High quality BrandE Accessories 11', 'BrandE', 'Standard specifications', 'Cotton', 51, 132.33, 26.47, 'active', 16, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (12, 'BrandF Winterwear 12', 'High quality BrandF Winterwear 12', 'BrandF', 'Standard specifications', 'Cotton', 97, 59.98, 12.00, 'active', 10, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (13, 'BrandG Formalwear 13', 'High quality BrandG Formalwear 13', 'BrandG', 'Standard specifications', 'Cotton', 77, 72.85, 14.57, 'active', 5, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (14, 'BrandH Casualwear 14', 'High quality BrandH Casualwear 14', 'BrandH', 'Standard specifications', 'Cotton', 37, 23.49, 4.70, 'active', 9, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (15, 'BrandI Sportswear 15', 'High quality BrandI Sportswear 15', 'BrandI', 'Standard specifications', 'Cotton', 42, 67.80, 13.56, 'active', 16, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (16, 'New Balance Dress 16', 'High quality New Balance Dress 16', 'New Balance', 'Standard specifications', 'Cotton', 97, 123.34, 24.67, 'active', 11, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (17, 'Under Armour Jeans 17', 'High quality Under Armour Jeans 17', 'Under Armour', 'Standard specifications', 'Cotton', 72, 145.96, 29.19, 'active', 2, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (18, 'Nike Shoes 18', 'High quality Nike Shoes 18', 'Nike', 'Standard specifications', 'Cotton', 87, 94.55, 18.91, 'active', 14, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (19, 'Adidas Sweater 19', 'High quality Adidas Sweater 19', 'Adidas', 'Standard specifications', 'Cotton', 16, 139.48, 27.90, 'active', 13, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (20, 'Reebok Jacket 20', 'High quality Reebok Jacket 20', 'Reebok', 'Standard specifications', 'Cotton', 31, 178.96, 35.79, 'active', 12, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (21, 'Puma T-shirt 21', 'High quality Puma T-shirt 21', 'Puma', 'Standard specifications', 'Cotton', 86, 180.58, 36.12, 'active', 8, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (22, 'BrandA Topwear 22', 'High quality BrandA Topwear 22', 'BrandA', 'Standard specifications', 'Cotton', 17, 137.41, 27.48, 'active', 19, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (23, 'BrandB Bottomwear 23', 'High quality BrandB Bottomwear 23', 'BrandB', 'Standard specifications', 'Cotton', 23, 42.74, 8.55, 'active', 8, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (24, 'BrandC Outerwear 24', 'High quality BrandC Outerwear 24', 'BrandC', 'Standard specifications', 'Cotton', 34, 82.80, 16.56, 'active', 13, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (25, 'BrandD Footwear 25', 'High quality BrandD Footwear 25', 'BrandD', 'Standard specifications', 'Cotton', 75, 97.06, 19.41, 'removed', 19, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (26, 'BrandE Accessories 26', 'High quality BrandE Accessories 26', 'BrandE', 'Standard specifications', 'Cotton', 12, 40.65, 8.13, 'removed', 11, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (27, 'BrandF Winterwear 27', 'High quality BrandF Winterwear 27', 'BrandF', 'Standard specifications', 'Cotton', 64, 124.11, 24.82, 'active', 7, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (28, 'BrandG Formalwear 28', 'High quality BrandG Formalwear 28', 'BrandG', 'Standard specifications', 'Cotton', 76, 182.61, 36.52, 'active', 16, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (29, 'BrandH Casualwear 29', 'High quality BrandH Casualwear 29', 'BrandH', 'Standard specifications', 'Cotton', 15, 131.09, 26.22, 'active', 17, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (30, 'BrandI Sportswear 30', 'High quality BrandI Sportswear 30', 'BrandI', 'Standard specifications', 'Cotton', 32, 179.47, 35.89, 'active', 2, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (31, 'New Balance Dress 31', 'High quality New Balance Dress 31', 'New Balance', 'Standard specifications', 'Cotton', 63, 132.20, 26.44, 'active', 8, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (32, 'Under Armour Jeans 32', 'High quality Under Armour Jeans 32', 'Under Armour', 'Standard specifications', 'Cotton', 93, 44.68, 8.94, 'removed', 12, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (33, 'Nike Shoes 33', 'High quality Nike Shoes 33', 'Nike', 'Standard specifications', 'Cotton', 16, 155.98, 31.20, 'active', 10, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (34, 'Adidas Sweater 34', 'High quality Adidas Sweater 34', 'Adidas', 'Standard specifications', 'Cotton', 76, 42.37, 8.47, 'active', 6, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (35, 'Reebok Jacket 35', 'High quality Reebok Jacket 35', 'Reebok', 'Standard specifications', 'Cotton', 31, 111.77, 22.35, 'active', 18, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (36, 'Puma T-shirt 36', 'High quality Puma T-shirt 36', 'Puma', 'Standard specifications', 'Cotton', 57, 61.72, 12.34, 'removed', 17, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (37, 'BrandA Topwear 37', 'High quality BrandA Topwear 37', 'BrandA', 'Standard specifications', 'Cotton', 38, 70.25, 14.05, 'active', 3, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (38, 'BrandB Bottomwear 38', 'High quality BrandB Bottomwear 38', 'BrandB', 'Standard specifications', 'Cotton', 88, 120.99, 24.20, 'active', 12, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (39, 'BrandC Outerwear 39', 'High quality BrandC Outerwear 39', 'BrandC', 'Standard specifications', 'Cotton', 45, 61.94, 12.39, 'active', 20, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (40, 'BrandD Footwear 40', 'High quality BrandD Footwear 40', 'BrandD', 'Standard specifications', 'Cotton', 58, 155.34, 31.07, 'active', 19, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (41, 'BrandE Accessories 41', 'High quality BrandE Accessories 41', 'BrandE', 'Standard specifications', 'Cotton', 41, 30.79, 6.16, 'active', 14, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (42, 'BrandF Winterwear 42', 'High quality BrandF Winterwear 42', 'BrandF', 'Standard specifications', 'Cotton', 42, 160.75, 32.15, 'active', 16, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (43, 'BrandG Formalwear 43', 'High quality BrandG Formalwear 43', 'BrandG', 'Standard specifications', 'Cotton', 51, 137.78, 27.56, 'active', 18, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (44, 'BrandH Casualwear 44', 'High quality BrandH Casualwear 44', 'BrandH', 'Standard specifications', 'Cotton', 30, 122.26, 24.45, 'active', 15, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (45, 'BrandI Sportswear 45', 'High quality BrandI Sportswear 45', 'BrandI', 'Standard specifications', 'Cotton', 29, 49.09, 9.82, 'removed', 8, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (46, 'New Balance Dress 46', 'High quality New Balance Dress 46', 'New Balance', 'Standard specifications', 'Cotton', 63, 172.43, 34.49, 'active', 3, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (47, 'Under Armour Jeans 47', 'High quality Under Armour Jeans 47', 'Under Armour', 'Standard specifications', 'Cotton', 42, 169.22, 33.84, 'active', 6, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (48, 'Nike Shoes 48', 'High quality Nike Shoes 48', 'Nike', 'Standard specifications', 'Cotton', 48, 27.14, 5.43, 'active', 18, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (49, 'Adidas Sweater 49', 'High quality Adidas Sweater 49', 'Adidas', 'Standard specifications', 'Cotton', 97, 77.13, 15.43, 'removed', 3, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (50, 'Reebok Jacket 50', 'High quality Reebok Jacket 50', 'Reebok', 'Standard specifications', 'Cotton', 40, 111.58, 22.32, 'active', 15, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (51, 'Puma T-shirt 51', 'High quality Puma T-shirt 51', 'Puma', 'Standard specifications', 'Cotton', 27, 67.69, 13.54, 'active', 7, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (52, 'BrandA Topwear 52', 'High quality BrandA Topwear 52', 'BrandA', 'Standard specifications', 'Cotton', 51, 33.37, 6.67, 'active', 7, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (53, 'BrandB Bottomwear 53', 'High quality BrandB Bottomwear 53', 'BrandB', 'Standard specifications', 'Cotton', 58, 66.86, 13.37, 'active', 1, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (54, 'BrandC Outerwear 54', 'High quality BrandC Outerwear 54', 'BrandC', 'Standard specifications', 'Cotton', 96, 123.79, 24.76, 'active', 17, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (55, 'BrandD Footwear 55', 'High quality BrandD Footwear 55', 'BrandD', 'Standard specifications', 'Cotton', 61, 31.87, 6.37, 'active', 15, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (56, 'BrandE Accessories 56', 'High quality BrandE Accessories 56', 'BrandE', 'Standard specifications', 'Cotton', 73, 49.77, 9.95, 'active', 17, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (57, 'BrandF Winterwear 57', 'High quality BrandF Winterwear 57', 'BrandF', 'Standard specifications', 'Cotton', 56, 156.14, 31.23, 'active', 15, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (58, 'BrandG Formalwear 58', 'High quality BrandG Formalwear 58', 'BrandG', 'Standard specifications', 'Cotton', 87, 56.63, 11.33, 'active', 19, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (59, 'BrandH Casualwear 59', 'High quality BrandH Casualwear 59', 'BrandH', 'Standard specifications', 'Cotton', 39, 24.34, 4.87, 'active', 13, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (60, 'BrandI Sportswear 60', 'High quality BrandI Sportswear 60', 'BrandI', 'Standard specifications', 'Cotton', 22, 91.08, 18.22, 'removed', 8, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (61, 'New Balance Dress 61', 'High quality New Balance Dress 61', 'New Balance', 'Standard specifications', 'Cotton', 97, 42.74, 8.55, 'active', 19, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (62, 'Under Armour Jeans 62', 'High quality Under Armour Jeans 62', 'Under Armour', 'Standard specifications', 'Cotton', 48, 23.87, 4.77, 'removed', 3, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (63, 'Nike Shoes 63', 'High quality Nike Shoes 63', 'Nike', 'Standard specifications', 'Cotton', 43, 22.70, 4.54, 'active', 10, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (64, 'Adidas Sweater 64', 'High quality Adidas Sweater 64', 'Adidas', 'Standard specifications', 'Cotton', 62, 43.58, 8.72, 'active', 19, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (65, 'Reebok Jacket 65', 'High quality Reebok Jacket 65', 'Reebok', 'Standard specifications', 'Cotton', 36, 181.33, 36.27, 'active', 3, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (66, 'Puma T-shirt 66', 'High quality Puma T-shirt 66', 'Puma', 'Standard specifications', 'Cotton', 62, 102.78, 20.56, 'active', 7, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (67, 'BrandA Topwear 67', 'High quality BrandA Topwear 67', 'BrandA', 'Standard specifications', 'Cotton', 93, 71.43, 14.29, 'active', 14, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (68, 'BrandB Bottomwear 68', 'High quality BrandB Bottomwear 68', 'BrandB', 'Standard specifications', 'Cotton', 46, 22.80, 4.56, 'active', 11, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (69, 'BrandC Outerwear 69', 'High quality BrandC Outerwear 69', 'BrandC', 'Standard specifications', 'Cotton', 63, 62.35, 12.47, 'active', 14, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (70, 'BrandD Footwear 70', 'High quality BrandD Footwear 70', 'BrandD', 'Standard specifications', 'Cotton', 86, 130.17, 26.03, 'active', 5, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (71, 'BrandE Accessories 71', 'High quality BrandE Accessories 71', 'BrandE', 'Standard specifications', 'Cotton', 26, 91.89, 18.38, 'active', 4, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (72, 'BrandF Winterwear 72', 'High quality BrandF Winterwear 72', 'BrandF', 'Standard specifications', 'Cotton', 51, 87.78, 17.56, 'removed', 5, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (73, 'BrandG Formalwear 73', 'High quality BrandG Formalwear 73', 'BrandG', 'Standard specifications', 'Cotton', 56, 57.71, 11.54, 'active', 3, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (74, 'BrandH Casualwear 74', 'High quality BrandH Casualwear 74', 'BrandH', 'Standard specifications', 'Cotton', 23, 125.63, 25.13, 'active', 9, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (75, 'BrandI Sportswear 75', 'High quality BrandI Sportswear 75', 'BrandI', 'Standard specifications', 'Cotton', 28, 155.91, 31.18, 'active', 15, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (76, 'New Balance Dress 76', 'High quality New Balance Dress 76', 'New Balance', 'Standard specifications', 'Cotton', 99, 67.56, 13.51, 'active', 3, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (77, 'Under Armour Jeans 77', 'High quality Under Armour Jeans 77', 'Under Armour', 'Standard specifications', 'Cotton', 38, 93.95, 18.79, 'active', 9, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (78, 'Nike Shoes 78', 'High quality Nike Shoes 78', 'Nike', 'Standard specifications', 'Cotton', 31, 121.06, 24.21, 'active', 6, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (79, 'Adidas Sweater 79', 'High quality Adidas Sweater 79', 'Adidas', 'Standard specifications', 'Cotton', 21, 21.80, 4.36, 'active', 5, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (80, 'Reebok Jacket 80', 'High quality Reebok Jacket 80', 'Reebok', 'Standard specifications', 'Cotton', 97, 188.28, 37.66, 'active', 1, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (81, 'Puma T-shirt 81', 'High quality Puma T-shirt 81', 'Puma', 'Standard specifications', 'Cotton', 59, 73.78, 14.76, 'active', 2, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (82, 'BrandA Topwear 82', 'High quality BrandA Topwear 82', 'BrandA', 'Standard specifications', 'Cotton', 80, 53.32, 10.66, 'active', 6, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (83, 'BrandB Bottomwear 83', 'High quality BrandB Bottomwear 83', 'BrandB', 'Standard specifications', 'Cotton', 62, 99.89, 19.98, 'active', 19, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (84, 'BrandC Outerwear 84', 'High quality BrandC Outerwear 84', 'BrandC', 'Standard specifications', 'Cotton', 56, 166.12, 33.22, 'active', 12, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (85, 'BrandD Footwear 85', 'High quality BrandD Footwear 85', 'BrandD', 'Standard specifications', 'Cotton', 71, 34.33, 6.87, 'removed', 9, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (86, 'BrandE Accessories 86', 'High quality BrandE Accessories 86', 'BrandE', 'Standard specifications', 'Cotton', 50, 175.72, 35.14, 'active', 1, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (87, 'BrandF Winterwear 87', 'High quality BrandF Winterwear 87', 'BrandF', 'Standard specifications', 'Cotton', 22, 114.01, 22.80, 'removed', 10, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (88, 'BrandG Formalwear 88', 'High quality BrandG Formalwear 88', 'BrandG', 'Standard specifications', 'Cotton', 85, 126.65, 25.33, 'active', 11, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (89, 'BrandH Casualwear 89', 'High quality BrandH Casualwear 89', 'BrandH', 'Standard specifications', 'Cotton', 96, 183.73, 36.75, 'active', 18, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (90, 'BrandI Sportswear 90', 'High quality BrandI Sportswear 90', 'BrandI', 'Standard specifications', 'Cotton', 20, 79.99, 16.00, 'active', 13, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (91, 'New Balance Dress 91', 'High quality New Balance Dress 91', 'New Balance', 'Standard specifications', 'Cotton', 35, 141.17, 28.23, 'active', 19, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (92, 'Under Armour Jeans 92', 'High quality Under Armour Jeans 92', 'Under Armour', 'Standard specifications', 'Cotton', 78, 77.46, 15.49, 'active', 13, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (93, 'Nike Shoes 93', 'High quality Nike Shoes 93', 'Nike', 'Standard specifications', 'Cotton', 71, 56.04, 11.21, 'active', 13, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (94, 'Adidas Sweater 94', 'High quality Adidas Sweater 94', 'Adidas', 'Standard specifications', 'Cotton', 28, 111.86, 22.37, 'removed', 1, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (95, 'Reebok Jacket 95', 'High quality Reebok Jacket 95', 'Reebok', 'Standard specifications', 'Cotton', 70, 113.48, 22.70, 'active', 4, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (96, 'Puma T-shirt 96', 'High quality Puma T-shirt 96', 'Puma', 'Standard specifications', 'Cotton', 54, 78.39, 15.68, 'active', 20, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (97, 'BrandA Topwear 97', 'High quality BrandA Topwear 97', 'BrandA', 'Standard specifications', 'Cotton', 87, 116.92, 23.38, 'active', 4, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (98, 'BrandB Bottomwear 98', 'High quality BrandB Bottomwear 98', 'BrandB', 'Standard specifications', 'Cotton', 44, 168.75, 33.75, 'active', 7, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (99, 'BrandC Outerwear 99', 'High quality BrandC Outerwear 99', 'BrandC', 'Standard specifications', 'Cotton', 48, 137.23, 27.45, 'active', 6, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (100, 'BrandD Footwear 100', 'High quality BrandD Footwear 100', 'BrandD', 'Standard specifications', 'Cotton', 18, 194.52, 38.90, 'active', 15, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (101, 'BrandE Accessories 101', 'High quality BrandE Accessories 101', 'BrandE', 'Standard specifications', 'Cotton', 47, 60.76, 12.15, 'active', 20, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (102, 'BrandF Winterwear 102', 'High quality BrandF Winterwear 102', 'BrandF', 'Standard specifications', 'Cotton', 87, 112.28, 22.46, 'active', 4, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (103, 'BrandG Formalwear 103', 'High quality BrandG Formalwear 103', 'BrandG', 'Standard specifications', 'Cotton', 13, 100.30, 20.06, 'removed', 4, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (104, 'BrandH Casualwear 104', 'High quality BrandH Casualwear 104', 'BrandH', 'Standard specifications', 'Cotton', 90, 119.73, 23.95, 'active', 19, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (105, 'BrandI Sportswear 105', 'High quality BrandI Sportswear 105', 'BrandI', 'Standard specifications', 'Cotton', 88, 198.90, 39.78, 'active', 11, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (106, 'New Balance Dress 106', 'High quality New Balance Dress 106', 'New Balance', 'Standard specifications', 'Cotton', 42, 44.38, 8.88, 'active', 19, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (107, 'Under Armour Jeans 107', 'High quality Under Armour Jeans 107', 'Under Armour', 'Standard specifications', 'Cotton', 46, 48.87, 9.77, 'active', 8, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (108, 'Nike Shoes 108', 'High quality Nike Shoes 108', 'Nike', 'Standard specifications', 'Cotton', 100, 164.94, 32.99, 'active', 18, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (109, 'Adidas Sweater 109', 'High quality Adidas Sweater 109', 'Adidas', 'Standard specifications', 'Cotton', 81, 171.45, 34.29, 'active', 20, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (110, 'Reebok Jacket 110', 'High quality Reebok Jacket 110', 'Reebok', 'Standard specifications', 'Cotton', 42, 56.70, 11.34, 'active', 1, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (111, 'Puma T-shirt 111', 'High quality Puma T-shirt 111', 'Puma', 'Standard specifications', 'Cotton', 40, 155.03, 31.01, 'active', 10, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (112, 'BrandA Topwear 112', 'High quality BrandA Topwear 112', 'BrandA', 'Standard specifications', 'Cotton', 32, 111.53, 22.31, 'active', 7, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (113, 'BrandB Bottomwear 113', 'High quality BrandB Bottomwear 113', 'BrandB', 'Standard specifications', 'Cotton', 28, 73.52, 14.70, 'active', 18, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (114, 'BrandC Outerwear 114', 'High quality BrandC Outerwear 114', 'BrandC', 'Standard specifications', 'Cotton', 93, 110.54, 22.11, 'active', 20, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (115, 'BrandD Footwear 115', 'High quality BrandD Footwear 115', 'BrandD', 'Standard specifications', 'Cotton', 96, 59.51, 11.90, 'active', 20, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (116, 'BrandE Accessories 116', 'High quality BrandE Accessories 116', 'BrandE', 'Standard specifications', 'Cotton', 37, 121.56, 24.31, 'active', 7, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (117, 'BrandF Winterwear 117', 'High quality BrandF Winterwear 117', 'BrandF', 'Standard specifications', 'Cotton', 98, 34.91, 6.98, 'active', 2, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (118, 'BrandG Formalwear 118', 'High quality BrandG Formalwear 118', 'BrandG', 'Standard specifications', 'Cotton', 25, 97.15, 19.43, 'active', 20, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (119, 'BrandH Casualwear 119', 'High quality BrandH Casualwear 119', 'BrandH', 'Standard specifications', 'Cotton', 73, 164.53, 32.91, 'active', 19, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (120, 'BrandI Sportswear 120', 'High quality BrandI Sportswear 120', 'BrandI', 'Standard specifications', 'Cotton', 50, 81.64, 16.33, 'active', 7, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (121, 'New Balance Dress 121', 'High quality New Balance Dress 121', 'New Balance', 'Standard specifications', 'Cotton', 10, 138.14, 27.63, 'active', 8, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (122, 'Under Armour Jeans 122', 'High quality Under Armour Jeans 122', 'Under Armour', 'Standard specifications', 'Cotton', 24, 23.30, 4.66, 'active', 17, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (123, 'Nike Shoes 123', 'High quality Nike Shoes 123', 'Nike', 'Standard specifications', 'Cotton', 98, 40.40, 8.08, 'active', 5, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (124, 'Adidas Sweater 124', 'High quality Adidas Sweater 124', 'Adidas', 'Standard specifications', 'Cotton', 77, 89.68, 17.94, 'active', 12, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (125, 'Reebok Jacket 125', 'High quality Reebok Jacket 125', 'Reebok', 'Standard specifications', 'Cotton', 21, 125.36, 25.07, 'active', 14, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (126, 'Puma T-shirt 126', 'High quality Puma T-shirt 126', 'Puma', 'Standard specifications', 'Cotton', 74, 198.46, 39.69, 'active', 2, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (127, 'BrandA Topwear 127', 'High quality BrandA Topwear 127', 'BrandA', 'Standard specifications', 'Cotton', 68, 159.30, 31.86, 'active', 8, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (128, 'BrandB Bottomwear 128', 'High quality BrandB Bottomwear 128', 'BrandB', 'Standard specifications', 'Cotton', 60, 116.95, 23.39, 'active', 19, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (129, 'BrandC Outerwear 129', 'High quality BrandC Outerwear 129', 'BrandC', 'Standard specifications', 'Cotton', 81, 111.91, 22.38, 'active', 2, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (130, 'BrandD Footwear 130', 'High quality BrandD Footwear 130', 'BrandD', 'Standard specifications', 'Cotton', 11, 53.77, 10.75, 'active', 7, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (131, 'BrandE Accessories 131', 'High quality BrandE Accessories 131', 'BrandE', 'Standard specifications', 'Cotton', 94, 175.01, 35.00, 'active', 18, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (132, 'BrandF Winterwear 132', 'High quality BrandF Winterwear 132', 'BrandF', 'Standard specifications', 'Cotton', 48, 123.27, 24.65, 'active', 20, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (133, 'BrandG Formalwear 133', 'High quality BrandG Formalwear 133', 'BrandG', 'Standard specifications', 'Cotton', 76, 166.27, 33.25, 'active', 2, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (134, 'BrandH Casualwear 134', 'High quality BrandH Casualwear 134', 'BrandH', 'Standard specifications', 'Cotton', 15, 167.44, 33.49, 'active', 12, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (135, 'BrandI Sportswear 135', 'High quality BrandI Sportswear 135', 'BrandI', 'Standard specifications', 'Cotton', 34, 163.94, 32.79, 'active', 10, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (136, 'New Balance Dress 136', 'High quality New Balance Dress 136', 'New Balance', 'Standard specifications', 'Cotton', 34, 42.37, 8.47, 'removed', 4, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (137, 'Under Armour Jeans 137', 'High quality Under Armour Jeans 137', 'Under Armour', 'Standard specifications', 'Cotton', 72, 61.15, 12.23, 'active', 14, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (138, 'Nike Shoes 138', 'High quality Nike Shoes 138', 'Nike', 'Standard specifications', 'Cotton', 98, 180.38, 36.08, 'active', 1, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (139, 'Adidas Sweater 139', 'High quality Adidas Sweater 139', 'Adidas', 'Standard specifications', 'Cotton', 43, 174.71, 34.94, 'active', 8, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (140, 'Reebok Jacket 140', 'High quality Reebok Jacket 140', 'Reebok', 'Standard specifications', 'Cotton', 23, 133.10, 26.62, 'active', 3, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (141, 'Puma T-shirt 141', 'High quality Puma T-shirt 141', 'Puma', 'Standard specifications', 'Cotton', 71, 76.06, 15.21, 'active', 9, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (142, 'BrandA Topwear 142', 'High quality BrandA Topwear 142', 'BrandA', 'Standard specifications', 'Cotton', 44, 49.15, 9.83, 'removed', 15, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (143, 'BrandB Bottomwear 143', 'High quality BrandB Bottomwear 143', 'BrandB', 'Standard specifications', 'Cotton', 93, 188.64, 37.73, 'active', 15, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (144, 'BrandC Outerwear 144', 'High quality BrandC Outerwear 144', 'BrandC', 'Standard specifications', 'Cotton', 60, 35.75, 7.15, 'active', 1, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (145, 'BrandD Footwear 145', 'High quality BrandD Footwear 145', 'BrandD', 'Standard specifications', 'Cotton', 100, 174.17, 34.83, 'active', 2, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (146, 'BrandE Accessories 146', 'High quality BrandE Accessories 146', 'BrandE', 'Standard specifications', 'Cotton', 48, 99.09, 19.82, 'active', 10, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (147, 'BrandF Winterwear 147', 'High quality BrandF Winterwear 147', 'BrandF', 'Standard specifications', 'Cotton', 81, 82.82, 16.56, 'active', 11, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (148, 'BrandG Formalwear 148', 'High quality BrandG Formalwear 148', 'BrandG', 'Standard specifications', 'Cotton', 49, 139.54, 27.91, 'active', 5, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (149, 'BrandH Casualwear 149', 'High quality BrandH Casualwear 149', 'BrandH', 'Standard specifications', 'Cotton', 76, 122.73, 24.55, 'removed', 4, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (150, 'BrandI Sportswear 150', 'High quality BrandI Sportswear 150', 'BrandI', 'Standard specifications', 'Cotton', 88, 195.68, 39.14, 'removed', 17, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (151, 'New Balance Dress 151', 'High quality New Balance Dress 151', 'New Balance', 'Standard specifications', 'Cotton', 79, 36.84, 7.37, 'active', 2, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (152, 'Under Armour Jeans 152', 'High quality Under Armour Jeans 152', 'Under Armour', 'Standard specifications', 'Cotton', 82, 77.57, 15.51, 'active', 2, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (153, 'Nike Shoes 153', 'High quality Nike Shoes 153', 'Nike', 'Standard specifications', 'Cotton', 17, 94.84, 18.97, 'active', 12, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (154, 'Adidas Sweater 154', 'High quality Adidas Sweater 154', 'Adidas', 'Standard specifications', 'Cotton', 71, 132.47, 26.49, 'active', 19, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (155, 'Reebok Jacket 155', 'High quality Reebok Jacket 155', 'Reebok', 'Standard specifications', 'Cotton', 22, 104.35, 20.87, 'active', 2, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (156, 'Puma T-shirt 156', 'High quality Puma T-shirt 156', 'Puma', 'Standard specifications', 'Cotton', 51, 40.14, 8.03, 'active', 16, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (157, 'BrandA Topwear 157', 'High quality BrandA Topwear 157', 'BrandA', 'Standard specifications', 'Cotton', 50, 59.64, 11.93, 'active', 1, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (158, 'BrandB Bottomwear 158', 'High quality BrandB Bottomwear 158', 'BrandB', 'Standard specifications', 'Cotton', 100, 155.88, 31.18, 'active', 17, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (159, 'BrandC Outerwear 159', 'High quality BrandC Outerwear 159', 'BrandC', 'Standard specifications', 'Cotton', 67, 76.25, 15.25, 'active', 1, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (160, 'BrandD Footwear 160', 'High quality BrandD Footwear 160', 'BrandD', 'Standard specifications', 'Cotton', 52, 83.99, 16.80, 'active', 7, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (161, 'BrandE Accessories 161', 'High quality BrandE Accessories 161', 'BrandE', 'Standard specifications', 'Cotton', 22, 101.14, 20.23, 'removed', 13, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (162, 'BrandF Winterwear 162', 'High quality BrandF Winterwear 162', 'BrandF', 'Standard specifications', 'Cotton', 100, 100.86, 20.17, 'removed', 16, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (163, 'BrandG Formalwear 163', 'High quality BrandG Formalwear 163', 'BrandG', 'Standard specifications', 'Cotton', 47, 20.94, 4.19, 'active', 20, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (164, 'BrandH Casualwear 164', 'High quality BrandH Casualwear 164', 'BrandH', 'Standard specifications', 'Cotton', 11, 136.85, 27.37, 'active', 17, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (165, 'BrandI Sportswear 165', 'High quality BrandI Sportswear 165', 'BrandI', 'Standard specifications', 'Cotton', 60, 69.34, 13.87, 'active', 10, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (166, 'New Balance Dress 166', 'High quality New Balance Dress 166', 'New Balance', 'Standard specifications', 'Cotton', 79, 83.44, 16.69, 'active', 19, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (167, 'Under Armour Jeans 167', 'High quality Under Armour Jeans 167', 'Under Armour', 'Standard specifications', 'Cotton', 59, 64.98, 13.00, 'active', 19, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (168, 'Nike Shoes 168', 'High quality Nike Shoes 168', 'Nike', 'Standard specifications', 'Cotton', 56, 88.45, 17.69, 'active', 14, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (169, 'Adidas Sweater 169', 'High quality Adidas Sweater 169', 'Adidas', 'Standard specifications', 'Cotton', 73, 75.56, 15.11, 'active', 6, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (170, 'Reebok Jacket 170', 'High quality Reebok Jacket 170', 'Reebok', 'Standard specifications', 'Cotton', 74, 52.87, 10.57, 'active', 15, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (171, 'Puma T-shirt 171', 'High quality Puma T-shirt 171', 'Puma', 'Standard specifications', 'Cotton', 78, 87.87, 17.57, 'active', 9, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (172, 'BrandA Topwear 172', 'High quality BrandA Topwear 172', 'BrandA', 'Standard specifications', 'Cotton', 65, 144.21, 28.84, 'active', 12, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (173, 'BrandB Bottomwear 173', 'High quality BrandB Bottomwear 173', 'BrandB', 'Standard specifications', 'Cotton', 18, 128.32, 25.66, 'active', 19, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (174, 'BrandC Outerwear 174', 'High quality BrandC Outerwear 174', 'BrandC', 'Standard specifications', 'Cotton', 92, 74.81, 14.96, 'active', 20, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (175, 'BrandD Footwear 175', 'High quality BrandD Footwear 175', 'BrandD', 'Standard specifications', 'Cotton', 83, 147.09, 29.42, 'active', 14, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (176, 'BrandE Accessories 176', 'High quality BrandE Accessories 176', 'BrandE', 'Standard specifications', 'Cotton', 62, 48.77, 9.75, 'active', 16, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (177, 'BrandF Winterwear 177', 'High quality BrandF Winterwear 177', 'BrandF', 'Standard specifications', 'Cotton', 71, 92.76, 18.55, 'active', 3, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (178, 'BrandG Formalwear 178', 'High quality BrandG Formalwear 178', 'BrandG', 'Standard specifications', 'Cotton', 96, 28.54, 5.71, 'active', 17, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (179, 'BrandH Casualwear 179', 'High quality BrandH Casualwear 179', 'BrandH', 'Standard specifications', 'Cotton', 97, 178.66, 35.73, 'active', 11, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (180, 'BrandI Sportswear 180', 'High quality BrandI Sportswear 180', 'BrandI', 'Standard specifications', 'Cotton', 49, 75.18, 15.04, 'removed', 12, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (181, 'New Balance Dress 181', 'High quality New Balance Dress 181', 'New Balance', 'Standard specifications', 'Cotton', 84, 84.82, 16.96, 'active', 3, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (182, 'Under Armour Jeans 182', 'High quality Under Armour Jeans 182', 'Under Armour', 'Standard specifications', 'Cotton', 84, 30.11, 6.02, 'active', 12, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (183, 'Nike Shoes 183', 'High quality Nike Shoes 183', 'Nike', 'Standard specifications', 'Cotton', 13, 34.82, 6.96, 'active', 18, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (184, 'Adidas Sweater 184', 'High quality Adidas Sweater 184', 'Adidas', 'Standard specifications', 'Cotton', 18, 149.77, 29.95, 'active', 10, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (185, 'Reebok Jacket 185', 'High quality Reebok Jacket 185', 'Reebok', 'Standard specifications', 'Cotton', 15, 56.26, 11.25, 'active', 8, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (186, 'Puma T-shirt 186', 'High quality Puma T-shirt 186', 'Puma', 'Standard specifications', 'Cotton', 76, 129.16, 25.83, 'removed', 13, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (187, 'BrandA Topwear 187', 'High quality BrandA Topwear 187', 'BrandA', 'Standard specifications', 'Cotton', 74, 128.07, 25.61, 'active', 16, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (188, 'BrandB Bottomwear 188', 'High quality BrandB Bottomwear 188', 'BrandB', 'Standard specifications', 'Cotton', 75, 123.03, 24.61, 'active', 20, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (189, 'BrandC Outerwear 189', 'High quality BrandC Outerwear 189', 'BrandC', 'Standard specifications', 'Cotton', 27, 115.02, 23.00, 'active', 18, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (190, 'BrandD Footwear 190', 'High quality BrandD Footwear 190', 'BrandD', 'Standard specifications', 'Cotton', 91, 58.99, 11.80, 'active', 1, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (191, 'BrandE Accessories 191', 'High quality BrandE Accessories 191', 'BrandE', 'Standard specifications', 'Cotton', 17, 175.15, 35.03, 'active', 4, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (192, 'BrandF Winterwear 192', 'High quality BrandF Winterwear 192', 'BrandF', 'Standard specifications', 'Cotton', 53, 120.60, 24.12, 'active', 19, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (193, 'BrandG Formalwear 193', 'High quality BrandG Formalwear 193', 'BrandG', 'Standard specifications', 'Cotton', 73, 154.00, 30.80, 'removed', 20, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (194, 'BrandH Casualwear 194', 'High quality BrandH Casualwear 194', 'BrandH', 'Standard specifications', 'Cotton', 87, 36.48, 7.30, 'active', 12, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (195, 'BrandI Sportswear 195', 'High quality BrandI Sportswear 195', 'BrandI', 'Standard specifications', 'Cotton', 21, 169.66, 33.93, 'active', 19, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (196, 'New Balance Dress 196', 'High quality New Balance Dress 196', 'New Balance', 'Standard specifications', 'Cotton', 61, 87.48, 17.50, 'active', 12, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (197, 'Under Armour Jeans 197', 'High quality Under Armour Jeans 197', 'Under Armour', 'Standard specifications', 'Cotton', 98, 31.13, 6.23, 'active', 20, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (198, 'Nike Shoes 198', 'High quality Nike Shoes 198', 'Nike', 'Standard specifications', 'Cotton', 32, 59.65, 11.93, 'active', 10, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (199, 'Adidas Sweater 199', 'High quality Adidas Sweater 199', 'Adidas', 'Standard specifications', 'Cotton', 16, 54.64, 10.93, 'active', 10, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (200, 'Reebok Jacket 200', 'High quality Reebok Jacket 200', 'Reebok', 'Standard specifications', 'Cotton', 84, 133.34, 26.67, 'removed', 11, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (201, 'Puma T-shirt 201', 'High quality Puma T-shirt 201', 'Puma', 'Standard specifications', 'Cotton', 16, 103.56, 20.71, 'active', 9, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (202, 'BrandA Topwear 202', 'High quality BrandA Topwear 202', 'BrandA', 'Standard specifications', 'Cotton', 63, 82.23, 16.45, 'active', 4, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (203, 'BrandB Bottomwear 203', 'High quality BrandB Bottomwear 203', 'BrandB', 'Standard specifications', 'Cotton', 24, 182.88, 36.58, 'active', 10, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (204, 'BrandC Outerwear 204', 'High quality BrandC Outerwear 204', 'BrandC', 'Standard specifications', 'Cotton', 52, 119.10, 23.82, 'active', 14, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (205, 'BrandD Footwear 205', 'High quality BrandD Footwear 205', 'BrandD', 'Standard specifications', 'Cotton', 52, 138.12, 27.62, 'active', 3, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (206, 'BrandE Accessories 206', 'High quality BrandE Accessories 206', 'BrandE', 'Standard specifications', 'Cotton', 54, 48.88, 9.78, 'active', 9, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (207, 'BrandF Winterwear 207', 'High quality BrandF Winterwear 207', 'BrandF', 'Standard specifications', 'Cotton', 40, 188.99, 37.80, 'active', 12, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (208, 'BrandG Formalwear 208', 'High quality BrandG Formalwear 208', 'BrandG', 'Standard specifications', 'Cotton', 66, 123.19, 24.64, 'removed', 14, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (209, 'BrandH Casualwear 209', 'High quality BrandH Casualwear 209', 'BrandH', 'Standard specifications', 'Cotton', 35, 55.00, 11.00, 'active', 3, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (210, 'BrandI Sportswear 210', 'High quality BrandI Sportswear 210', 'BrandI', 'Standard specifications', 'Cotton', 42, 190.79, 38.16, 'active', 9, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (211, 'New Balance Dress 211', 'High quality New Balance Dress 211', 'New Balance', 'Standard specifications', 'Cotton', 37, 131.48, 26.30, 'active', 2, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (212, 'Under Armour Jeans 212', 'High quality Under Armour Jeans 212', 'Under Armour', 'Standard specifications', 'Cotton', 19, 174.79, 34.96, 'active', 4, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (213, 'Nike Shoes 213', 'High quality Nike Shoes 213', 'Nike', 'Standard specifications', 'Cotton', 65, 97.17, 19.43, 'active', 20, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (214, 'Adidas Sweater 214', 'High quality Adidas Sweater 214', 'Adidas', 'Standard specifications', 'Cotton', 14, 115.84, 23.17, 'active', 13, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (215, 'Reebok Jacket 215', 'High quality Reebok Jacket 215', 'Reebok', 'Standard specifications', 'Cotton', 62, 79.02, 15.80, 'active', 16, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (216, 'Puma T-shirt 216', 'High quality Puma T-shirt 216', 'Puma', 'Standard specifications', 'Cotton', 84, 143.02, 28.60, 'active', 4, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (217, 'BrandA Topwear 217', 'High quality BrandA Topwear 217', 'BrandA', 'Standard specifications', 'Cotton', 74, 180.72, 36.14, 'removed', 19, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (218, 'BrandB Bottomwear 218', 'High quality BrandB Bottomwear 218', 'BrandB', 'Standard specifications', 'Cotton', 67, 45.98, 9.20, 'active', 1, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (219, 'BrandC Outerwear 219', 'High quality BrandC Outerwear 219', 'BrandC', 'Standard specifications', 'Cotton', 80, 163.02, 32.60, 'active', 1, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (220, 'BrandD Footwear 220', 'High quality BrandD Footwear 220', 'BrandD', 'Standard specifications', 'Cotton', 36, 31.39, 6.28, 'active', 2, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (221, 'BrandE Accessories 221', 'High quality BrandE Accessories 221', 'BrandE', 'Standard specifications', 'Cotton', 87, 45.87, 9.17, 'active', 19, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (222, 'BrandF Winterwear 222', 'High quality BrandF Winterwear 222', 'BrandF', 'Standard specifications', 'Cotton', 69, 63.46, 12.69, 'active', 7, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (223, 'BrandG Formalwear 223', 'High quality BrandG Formalwear 223', 'BrandG', 'Standard specifications', 'Cotton', 33, 46.34, 9.27, 'active', 3, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (224, 'BrandH Casualwear 224', 'High quality BrandH Casualwear 224', 'BrandH', 'Standard specifications', 'Cotton', 29, 70.77, 14.15, 'active', 14, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (225, 'BrandI Sportswear 225', 'High quality BrandI Sportswear 225', 'BrandI', 'Standard specifications', 'Cotton', 36, 97.93, 19.59, 'active', 15, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (226, 'New Balance Dress 226', 'High quality New Balance Dress 226', 'New Balance', 'Standard specifications', 'Cotton', 78, 31.29, 6.26, 'active', 8, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (227, 'Under Armour Jeans 227', 'High quality Under Armour Jeans 227', 'Under Armour', 'Standard specifications', 'Cotton', 84, 107.83, 21.57, 'active', 14, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (228, 'Nike Shoes 228', 'High quality Nike Shoes 228', 'Nike', 'Standard specifications', 'Cotton', 21, 187.97, 37.59, 'active', 16, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (229, 'Adidas Sweater 229', 'High quality Adidas Sweater 229', 'Adidas', 'Standard specifications', 'Cotton', 78, 185.94, 37.19, 'active', 7, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (230, 'Reebok Jacket 230', 'High quality Reebok Jacket 230', 'Reebok', 'Standard specifications', 'Cotton', 12, 142.84, 28.57, 'active', 4, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (231, 'Puma T-shirt 231', 'High quality Puma T-shirt 231', 'Puma', 'Standard specifications', 'Cotton', 92, 188.93, 37.79, 'active', 10, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (232, 'BrandA Topwear 232', 'High quality BrandA Topwear 232', 'BrandA', 'Standard specifications', 'Cotton', 16, 51.45, 10.29, 'active', 4, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (233, 'BrandB Bottomwear 233', 'High quality BrandB Bottomwear 233', 'BrandB', 'Standard specifications', 'Cotton', 81, 50.86, 10.17, 'active', 10, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (234, 'BrandC Outerwear 234', 'High quality BrandC Outerwear 234', 'BrandC', 'Standard specifications', 'Cotton', 77, 60.91, 12.18, 'active', 8, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (235, 'BrandD Footwear 235', 'High quality BrandD Footwear 235', 'BrandD', 'Standard specifications', 'Cotton', 18, 134.85, 26.97, 'active', 4, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (236, 'BrandE Accessories 236', 'High quality BrandE Accessories 236', 'BrandE', 'Standard specifications', 'Cotton', 71, 130.45, 26.09, 'active', 20, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (237, 'BrandF Winterwear 237', 'High quality BrandF Winterwear 237', 'BrandF', 'Standard specifications', 'Cotton', 50, 165.88, 33.18, 'active', 10, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (238, 'BrandG Formalwear 238', 'High quality BrandG Formalwear 238', 'BrandG', 'Standard specifications', 'Cotton', 98, 189.66, 37.93, 'active', 1, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (239, 'BrandH Casualwear 239', 'High quality BrandH Casualwear 239', 'BrandH', 'Standard specifications', 'Cotton', 29, 81.64, 16.33, 'active', 9, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (240, 'BrandI Sportswear 240', 'High quality BrandI Sportswear 240', 'BrandI', 'Standard specifications', 'Cotton', 31, 96.80, 19.36, 'active', 4, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (241, 'New Balance Dress 241', 'High quality New Balance Dress 241', 'New Balance', 'Standard specifications', 'Cotton', 39, 73.45, 14.69, 'active', 11, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (242, 'Under Armour Jeans 242', 'High quality Under Armour Jeans 242', 'Under Armour', 'Standard specifications', 'Cotton', 52, 134.03, 26.81, 'active', 8, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (243, 'Nike Shoes 243', 'High quality Nike Shoes 243', 'Nike', 'Standard specifications', 'Cotton', 97, 197.58, 39.52, 'removed', 3, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (244, 'Adidas Sweater 244', 'High quality Adidas Sweater 244', 'Adidas', 'Standard specifications', 'Cotton', 13, 135.04, 27.01, 'active', 17, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (245, 'Reebok Jacket 245', 'High quality Reebok Jacket 245', 'Reebok', 'Standard specifications', 'Cotton', 25, 97.05, 19.41, 'active', 3, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (246, 'Puma T-shirt 246', 'High quality Puma T-shirt 246', 'Puma', 'Standard specifications', 'Cotton', 57, 186.45, 37.29, 'active', 17, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (247, 'BrandA Topwear 247', 'High quality BrandA Topwear 247', 'BrandA', 'Standard specifications', 'Cotton', 97, 29.54, 5.91, 'active', 18, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (248, 'BrandB Bottomwear 248', 'High quality BrandB Bottomwear 248', 'BrandB', 'Standard specifications', 'Cotton', 62, 125.29, 25.06, 'removed', 15, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (249, 'BrandC Outerwear 249', 'High quality BrandC Outerwear 249', 'BrandC', 'Standard specifications', 'Cotton', 30, 139.62, 27.92, 'active', 1, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (250, 'BrandD Footwear 250', 'High quality BrandD Footwear 250', 'BrandD', 'Standard specifications', 'Cotton', 87, 20.69, 4.14, 'removed', 12, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (251, 'BrandE Accessories 251', 'High quality BrandE Accessories 251', 'BrandE', 'Standard specifications', 'Cotton', 57, 114.62, 22.92, 'active', 7, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (252, 'BrandF Winterwear 252', 'High quality BrandF Winterwear 252', 'BrandF', 'Standard specifications', 'Cotton', 89, 61.26, 12.25, 'active', 19, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (253, 'BrandG Formalwear 253', 'High quality BrandG Formalwear 253', 'BrandG', 'Standard specifications', 'Cotton', 43, 127.94, 25.59, 'active', 15, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (254, 'BrandH Casualwear 254', 'High quality BrandH Casualwear 254', 'BrandH', 'Standard specifications', 'Cotton', 19, 134.58, 26.92, 'removed', 4, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (255, 'BrandI Sportswear 255', 'High quality BrandI Sportswear 255', 'BrandI', 'Standard specifications', 'Cotton', 57, 61.12, 12.22, 'active', 14, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (256, 'New Balance Dress 256', 'High quality New Balance Dress 256', 'New Balance', 'Standard specifications', 'Cotton', 34, 31.67, 6.33, 'active', 17, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (257, 'Under Armour Jeans 257', 'High quality Under Armour Jeans 257', 'Under Armour', 'Standard specifications', 'Cotton', 68, 157.88, 31.58, 'active', 19, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (258, 'Nike Shoes 258', 'High quality Nike Shoes 258', 'Nike', 'Standard specifications', 'Cotton', 65, 65.52, 13.10, 'active', 6, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (259, 'Adidas Sweater 259', 'High quality Adidas Sweater 259', 'Adidas', 'Standard specifications', 'Cotton', 78, 147.52, 29.50, 'active', 14, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (260, 'Reebok Jacket 260', 'High quality Reebok Jacket 260', 'Reebok', 'Standard specifications', 'Cotton', 36, 60.24, 12.05, 'active', 2, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (261, 'Puma T-shirt 261', 'High quality Puma T-shirt 261', 'Puma', 'Standard specifications', 'Cotton', 55, 102.93, 20.59, 'active', 2, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (262, 'BrandA Topwear 262', 'High quality BrandA Topwear 262', 'BrandA', 'Standard specifications', 'Cotton', 53, 179.48, 35.90, 'active', 20, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (263, 'BrandB Bottomwear 263', 'High quality BrandB Bottomwear 263', 'BrandB', 'Standard specifications', 'Cotton', 36, 73.77, 14.75, 'active', 8, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (264, 'BrandC Outerwear 264', 'High quality BrandC Outerwear 264', 'BrandC', 'Standard specifications', 'Cotton', 72, 181.41, 36.28, 'active', 13, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (265, 'BrandD Footwear 265', 'High quality BrandD Footwear 265', 'BrandD', 'Standard specifications', 'Cotton', 56, 89.66, 17.93, 'active', 3, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (266, 'BrandE Accessories 266', 'High quality BrandE Accessories 266', 'BrandE', 'Standard specifications', 'Cotton', 97, 159.88, 31.98, 'active', 15, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (267, 'BrandF Winterwear 267', 'High quality BrandF Winterwear 267', 'BrandF', 'Standard specifications', 'Cotton', 66, 91.86, 18.37, 'active', 13, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (268, 'BrandG Formalwear 268', 'High quality BrandG Formalwear 268', 'BrandG', 'Standard specifications', 'Cotton', 100, 81.24, 16.25, 'active', 7, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (269, 'BrandH Casualwear 269', 'High quality BrandH Casualwear 269', 'BrandH', 'Standard specifications', 'Cotton', 30, 88.59, 17.72, 'active', 1, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (270, 'BrandI Sportswear 270', 'High quality BrandI Sportswear 270', 'BrandI', 'Standard specifications', 'Cotton', 24, 96.42, 19.28, 'active', 1, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (271, 'New Balance Dress 271', 'High quality New Balance Dress 271', 'New Balance', 'Standard specifications', 'Cotton', 40, 77.78, 15.56, 'active', 15, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (272, 'Under Armour Jeans 272', 'High quality Under Armour Jeans 272', 'Under Armour', 'Standard specifications', 'Cotton', 69, 199.60, 39.92, 'active', 13, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (273, 'Nike Shoes 273', 'High quality Nike Shoes 273', 'Nike', 'Standard specifications', 'Cotton', 65, 105.32, 21.06, 'active', 5, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (274, 'Adidas Sweater 274', 'High quality Adidas Sweater 274', 'Adidas', 'Standard specifications', 'Cotton', 28, 162.80, 32.56, 'active', 18, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (275, 'Reebok Jacket 275', 'High quality Reebok Jacket 275', 'Reebok', 'Standard specifications', 'Cotton', 71, 37.21, 7.44, 'active', 3, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (276, 'Puma T-shirt 276', 'High quality Puma T-shirt 276', 'Puma', 'Standard specifications', 'Cotton', 100, 79.11, 15.82, 'active', 5, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (277, 'BrandA Topwear 277', 'High quality BrandA Topwear 277', 'BrandA', 'Standard specifications', 'Cotton', 40, 140.86, 28.17, 'active', 19, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (278, 'BrandB Bottomwear 278', 'High quality BrandB Bottomwear 278', 'BrandB', 'Standard specifications', 'Cotton', 41, 62.64, 12.53, 'active', 20, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (279, 'BrandC Outerwear 279', 'High quality BrandC Outerwear 279', 'BrandC', 'Standard specifications', 'Cotton', 15, 114.64, 22.93, 'active', 4, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (280, 'BrandD Footwear 280', 'High quality BrandD Footwear 280', 'BrandD', 'Standard specifications', 'Cotton', 98, 191.20, 38.24, 'active', 12, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (281, 'BrandE Accessories 281', 'High quality BrandE Accessories 281', 'BrandE', 'Standard specifications', 'Cotton', 17, 115.01, 23.00, 'active', 9, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (282, 'BrandF Winterwear 282', 'High quality BrandF Winterwear 282', 'BrandF', 'Standard specifications', 'Cotton', 34, 76.11, 15.22, 'active', 18, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (283, 'BrandG Formalwear 283', 'High quality BrandG Formalwear 283', 'BrandG', 'Standard specifications', 'Cotton', 28, 159.41, 31.88, 'active', 7, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (284, 'BrandH Casualwear 284', 'High quality BrandH Casualwear 284', 'BrandH', 'Standard specifications', 'Cotton', 17, 155.31, 31.06, 'active', 4, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (285, 'BrandI Sportswear 285', 'High quality BrandI Sportswear 285', 'BrandI', 'Standard specifications', 'Cotton', 61, 57.94, 11.59, 'active', 3, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (286, 'New Balance Dress 286', 'High quality New Balance Dress 286', 'New Balance', 'Standard specifications', 'Cotton', 25, 26.68, 5.34, 'active', 1, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (287, 'Under Armour Jeans 287', 'High quality Under Armour Jeans 287', 'Under Armour', 'Standard specifications', 'Cotton', 73, 116.48, 23.30, 'active', 11, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (288, 'Nike Shoes 288', 'High quality Nike Shoes 288', 'Nike', 'Standard specifications', 'Cotton', 70, 134.07, 26.81, 'active', 15, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (289, 'Adidas Sweater 289', 'High quality Adidas Sweater 289', 'Adidas', 'Standard specifications', 'Cotton', 42, 131.14, 26.23, 'active', 14, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (290, 'Reebok Jacket 290', 'High quality Reebok Jacket 290', 'Reebok', 'Standard specifications', 'Cotton', 99, 178.78, 35.76, 'active', 8, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (291, 'Puma T-shirt 291', 'High quality Puma T-shirt 291', 'Puma', 'Standard specifications', 'Cotton', 24, 172.69, 34.54, 'active', 14, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (292, 'BrandA Topwear 292', 'High quality BrandA Topwear 292', 'BrandA', 'Standard specifications', 'Cotton', 29, 99.69, 19.94, 'active', 20, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (293, 'BrandB Bottomwear 293', 'High quality BrandB Bottomwear 293', 'BrandB', 'Standard specifications', 'Cotton', 44, 72.09, 14.42, 'active', 15, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (294, 'BrandC Outerwear 294', 'High quality BrandC Outerwear 294', 'BrandC', 'Standard specifications', 'Cotton', 17, 159.12, 31.82, 'active', 1, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (295, 'BrandD Footwear 295', 'High quality BrandD Footwear 295', 'BrandD', 'Standard specifications', 'Cotton', 56, 63.09, 12.62, 'removed', 4, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (296, 'BrandE Accessories 296', 'High quality BrandE Accessories 296', 'BrandE', 'Standard specifications', 'Cotton', 94, 189.56, 37.91, 'active', 15, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (297, 'BrandF Winterwear 297', 'High quality BrandF Winterwear 297', 'BrandF', 'Standard specifications', 'Cotton', 72, 98.23, 19.65, 'active', 11, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (298, 'BrandG Formalwear 298', 'High quality BrandG Formalwear 298', 'BrandG', 'Standard specifications', 'Cotton', 24, 66.72, 13.34, 'active', 11, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (299, 'BrandH Casualwear 299', 'High quality BrandH Casualwear 299', 'BrandH', 'Standard specifications', 'Cotton', 45, 129.74, 25.95, 'active', 5, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (300, 'BrandI Sportswear 300', 'High quality BrandI Sportswear 300', 'BrandI', 'Standard specifications', 'Cotton', 15, 128.09, 25.62, 'active', 17, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (301, 'New Balance Dress 301', 'High quality New Balance Dress 301', 'New Balance', 'Standard specifications', 'Cotton', 82, 123.58, 24.72, 'active', 11, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (302, 'Under Armour Jeans 302', 'High quality Under Armour Jeans 302', 'Under Armour', 'Standard specifications', 'Cotton', 74, 177.08, 35.42, 'active', 10, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (303, 'Nike Shoes 303', 'High quality Nike Shoes 303', 'Nike', 'Standard specifications', 'Cotton', 60, 181.46, 36.29, 'active', 9, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (304, 'Adidas Sweater 304', 'High quality Adidas Sweater 304', 'Adidas', 'Standard specifications', 'Cotton', 25, 178.72, 35.74, 'active', 2, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (305, 'Reebok Jacket 305', 'High quality Reebok Jacket 305', 'Reebok', 'Standard specifications', 'Cotton', 89, 114.91, 22.98, 'active', 3, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (306, 'Puma T-shirt 306', 'High quality Puma T-shirt 306', 'Puma', 'Standard specifications', 'Cotton', 93, 70.79, 14.16, 'active', 11, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (307, 'BrandA Topwear 307', 'High quality BrandA Topwear 307', 'BrandA', 'Standard specifications', 'Cotton', 28, 136.00, 27.20, 'active', 9, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (308, 'BrandB Bottomwear 308', 'High quality BrandB Bottomwear 308', 'BrandB', 'Standard specifications', 'Cotton', 62, 43.65, 8.73, 'active', 20, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (309, 'BrandC Outerwear 309', 'High quality BrandC Outerwear 309', 'BrandC', 'Standard specifications', 'Cotton', 42, 128.39, 25.68, 'removed', 10, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (310, 'BrandD Footwear 310', 'High quality BrandD Footwear 310', 'BrandD', 'Standard specifications', 'Cotton', 78, 127.21, 25.44, 'active', 1, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (311, 'BrandE Accessories 311', 'High quality BrandE Accessories 311', 'BrandE', 'Standard specifications', 'Cotton', 30, 155.06, 31.01, 'removed', 1, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (312, 'BrandF Winterwear 312', 'High quality BrandF Winterwear 312', 'BrandF', 'Standard specifications', 'Cotton', 58, 138.97, 27.79, 'active', 2, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (313, 'BrandG Formalwear 313', 'High quality BrandG Formalwear 313', 'BrandG', 'Standard specifications', 'Cotton', 83, 137.08, 27.42, 'removed', 9, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (314, 'BrandH Casualwear 314', 'High quality BrandH Casualwear 314', 'BrandH', 'Standard specifications', 'Cotton', 91, 152.15, 30.43, 'active', 2, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (315, 'BrandI Sportswear 315', 'High quality BrandI Sportswear 315', 'BrandI', 'Standard specifications', 'Cotton', 92, 35.21, 7.04, 'active', 18, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (316, 'New Balance Dress 316', 'High quality New Balance Dress 316', 'New Balance', 'Standard specifications', 'Cotton', 98, 188.75, 37.75, 'removed', 2, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (317, 'Under Armour Jeans 317', 'High quality Under Armour Jeans 317', 'Under Armour', 'Standard specifications', 'Cotton', 22, 173.16, 34.63, 'active', 7, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (318, 'Nike Shoes 318', 'High quality Nike Shoes 318', 'Nike', 'Standard specifications', 'Cotton', 89, 173.96, 34.79, 'removed', 13, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (319, 'Adidas Sweater 319', 'High quality Adidas Sweater 319', 'Adidas', 'Standard specifications', 'Cotton', 39, 72.81, 14.56, 'removed', 12, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (320, 'Reebok Jacket 320', 'High quality Reebok Jacket 320', 'Reebok', 'Standard specifications', 'Cotton', 30, 74.95, 14.99, 'active', 10, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (321, 'Puma T-shirt 321', 'High quality Puma T-shirt 321', 'Puma', 'Standard specifications', 'Cotton', 73, 125.22, 25.04, 'active', 18, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (322, 'BrandA Topwear 322', 'High quality BrandA Topwear 322', 'BrandA', 'Standard specifications', 'Cotton', 32, 174.59, 34.92, 'active', 19, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (323, 'BrandB Bottomwear 323', 'High quality BrandB Bottomwear 323', 'BrandB', 'Standard specifications', 'Cotton', 31, 34.41, 6.88, 'active', 18, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (324, 'BrandC Outerwear 324', 'High quality BrandC Outerwear 324', 'BrandC', 'Standard specifications', 'Cotton', 87, 141.05, 28.21, 'active', 9, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (325, 'BrandD Footwear 325', 'High quality BrandD Footwear 325', 'BrandD', 'Standard specifications', 'Cotton', 94, 57.03, 11.41, 'removed', 2, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (326, 'BrandE Accessories 326', 'High quality BrandE Accessories 326', 'BrandE', 'Standard specifications', 'Cotton', 37, 77.70, 15.54, 'active', 2, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (327, 'BrandF Winterwear 327', 'High quality BrandF Winterwear 327', 'BrandF', 'Standard specifications', 'Cotton', 44, 156.80, 31.36, 'active', 19, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (328, 'BrandG Formalwear 328', 'High quality BrandG Formalwear 328', 'BrandG', 'Standard specifications', 'Cotton', 21, 171.34, 34.27, 'removed', 1, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (329, 'BrandH Casualwear 329', 'High quality BrandH Casualwear 329', 'BrandH', 'Standard specifications', 'Cotton', 95, 143.99, 28.80, 'active', 4, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (330, 'BrandI Sportswear 330', 'High quality BrandI Sportswear 330', 'BrandI', 'Standard specifications', 'Cotton', 91, 116.72, 23.34, 'active', 10, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (331, 'New Balance Dress 331', 'High quality New Balance Dress 331', 'New Balance', 'Standard specifications', 'Cotton', 56, 176.31, 35.26, 'active', 11, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (332, 'Under Armour Jeans 332', 'High quality Under Armour Jeans 332', 'Under Armour', 'Standard specifications', 'Cotton', 73, 52.69, 10.54, 'active', 19, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (333, 'Nike Shoes 333', 'High quality Nike Shoes 333', 'Nike', 'Standard specifications', 'Cotton', 50, 168.62, 33.72, 'active', 9, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (334, 'Adidas Sweater 334', 'High quality Adidas Sweater 334', 'Adidas', 'Standard specifications', 'Cotton', 92, 74.90, 14.98, 'active', 18, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (335, 'Reebok Jacket 335', 'High quality Reebok Jacket 335', 'Reebok', 'Standard specifications', 'Cotton', 92, 79.37, 15.87, 'active', 17, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (336, 'Puma T-shirt 336', 'High quality Puma T-shirt 336', 'Puma', 'Standard specifications', 'Cotton', 91, 178.15, 35.63, 'active', 15, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (337, 'BrandA Topwear 337', 'High quality BrandA Topwear 337', 'BrandA', 'Standard specifications', 'Cotton', 40, 140.08, 28.02, 'active', 3, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (338, 'BrandB Bottomwear 338', 'High quality BrandB Bottomwear 338', 'BrandB', 'Standard specifications', 'Cotton', 51, 29.53, 5.91, 'active', 14, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (339, 'BrandC Outerwear 339', 'High quality BrandC Outerwear 339', 'BrandC', 'Standard specifications', 'Cotton', 21, 126.19, 25.24, 'active', 18, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (340, 'BrandD Footwear 340', 'High quality BrandD Footwear 340', 'BrandD', 'Standard specifications', 'Cotton', 44, 163.84, 32.77, 'active', 4, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (341, 'BrandE Accessories 341', 'High quality BrandE Accessories 341', 'BrandE', 'Standard specifications', 'Cotton', 84, 86.66, 17.33, 'active', 5, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (342, 'BrandF Winterwear 342', 'High quality BrandF Winterwear 342', 'BrandF', 'Standard specifications', 'Cotton', 24, 198.36, 39.67, 'removed', 12, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (343, 'BrandG Formalwear 343', 'High quality BrandG Formalwear 343', 'BrandG', 'Standard specifications', 'Cotton', 18, 38.93, 7.79, 'active', 1, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (344, 'BrandH Casualwear 344', 'High quality BrandH Casualwear 344', 'BrandH', 'Standard specifications', 'Cotton', 93, 95.60, 19.12, 'active', 17, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (345, 'BrandI Sportswear 345', 'High quality BrandI Sportswear 345', 'BrandI', 'Standard specifications', 'Cotton', 89, 53.92, 10.78, 'active', 9, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (346, 'New Balance Dress 346', 'High quality New Balance Dress 346', 'New Balance', 'Standard specifications', 'Cotton', 62, 110.90, 22.18, 'active', 2, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (347, 'Under Armour Jeans 347', 'High quality Under Armour Jeans 347', 'Under Armour', 'Standard specifications', 'Cotton', 78, 28.56, 5.71, 'active', 17, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (348, 'Nike Shoes 348', 'High quality Nike Shoes 348', 'Nike', 'Standard specifications', 'Cotton', 88, 46.17, 9.23, 'active', 8, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (349, 'Adidas Sweater 349', 'High quality Adidas Sweater 349', 'Adidas', 'Standard specifications', 'Cotton', 71, 146.05, 29.21, 'active', 12, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (350, 'Reebok Jacket 350', 'High quality Reebok Jacket 350', 'Reebok', 'Standard specifications', 'Cotton', 18, 109.86, 21.97, 'active', 4, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (351, 'Puma T-shirt 351', 'High quality Puma T-shirt 351', 'Puma', 'Standard specifications', 'Cotton', 11, 89.66, 17.93, 'active', 14, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (352, 'BrandA Topwear 352', 'High quality BrandA Topwear 352', 'BrandA', 'Standard specifications', 'Cotton', 20, 149.17, 29.83, 'active', 13, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (353, 'BrandB Bottomwear 353', 'High quality BrandB Bottomwear 353', 'BrandB', 'Standard specifications', 'Cotton', 10, 140.55, 28.11, 'active', 7, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (354, 'BrandC Outerwear 354', 'High quality BrandC Outerwear 354', 'BrandC', 'Standard specifications', 'Cotton', 77, 132.18, 26.44, 'active', 11, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (355, 'BrandD Footwear 355', 'High quality BrandD Footwear 355', 'BrandD', 'Standard specifications', 'Cotton', 79, 72.33, 14.47, 'removed', 15, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (356, 'BrandE Accessories 356', 'High quality BrandE Accessories 356', 'BrandE', 'Standard specifications', 'Cotton', 10, 146.01, 29.20, 'active', 6, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (357, 'BrandF Winterwear 357', 'High quality BrandF Winterwear 357', 'BrandF', 'Standard specifications', 'Cotton', 20, 55.89, 11.18, 'active', 6, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (358, 'BrandG Formalwear 358', 'High quality BrandG Formalwear 358', 'BrandG', 'Standard specifications', 'Cotton', 26, 121.17, 24.23, 'active', 8, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (359, 'BrandH Casualwear 359', 'High quality BrandH Casualwear 359', 'BrandH', 'Standard specifications', 'Cotton', 53, 44.08, 8.82, 'active', 15, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (360, 'BrandI Sportswear 360', 'High quality BrandI Sportswear 360', 'BrandI', 'Standard specifications', 'Cotton', 63, 30.46, 6.09, 'active', 3, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (361, 'New Balance Dress 361', 'High quality New Balance Dress 361', 'New Balance', 'Standard specifications', 'Cotton', 49, 33.77, 6.75, 'active', 6, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (362, 'Under Armour Jeans 362', 'High quality Under Armour Jeans 362', 'Under Armour', 'Standard specifications', 'Cotton', 60, 131.44, 26.29, 'active', 9, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (363, 'Nike Shoes 363', 'High quality Nike Shoes 363', 'Nike', 'Standard specifications', 'Cotton', 87, 179.91, 35.98, 'active', 15, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (364, 'Adidas Sweater 364', 'High quality Adidas Sweater 364', 'Adidas', 'Standard specifications', 'Cotton', 44, 69.65, 13.93, 'active', 12, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (365, 'Reebok Jacket 365', 'High quality Reebok Jacket 365', 'Reebok', 'Standard specifications', 'Cotton', 54, 90.74, 18.15, 'active', 15, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (366, 'Puma T-shirt 366', 'High quality Puma T-shirt 366', 'Puma', 'Standard specifications', 'Cotton', 92, 90.90, 18.18, 'active', 10, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (367, 'BrandA Topwear 367', 'High quality BrandA Topwear 367', 'BrandA', 'Standard specifications', 'Cotton', 56, 44.50, 8.90, 'active', 10, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (368, 'BrandB Bottomwear 368', 'High quality BrandB Bottomwear 368', 'BrandB', 'Standard specifications', 'Cotton', 86, 186.64, 37.33, 'active', 8, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (369, 'BrandC Outerwear 369', 'High quality BrandC Outerwear 369', 'BrandC', 'Standard specifications', 'Cotton', 47, 117.55, 23.51, 'active', 2, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (370, 'BrandD Footwear 370', 'High quality BrandD Footwear 370', 'BrandD', 'Standard specifications', 'Cotton', 93, 175.27, 35.05, 'active', 14, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (371, 'BrandE Accessories 371', 'High quality BrandE Accessories 371', 'BrandE', 'Standard specifications', 'Cotton', 18, 32.89, 6.58, 'removed', 20, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (372, 'BrandF Winterwear 372', 'High quality BrandF Winterwear 372', 'BrandF', 'Standard specifications', 'Cotton', 14, 138.91, 27.78, 'active', 9, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (373, 'BrandG Formalwear 373', 'High quality BrandG Formalwear 373', 'BrandG', 'Standard specifications', 'Cotton', 99, 80.99, 16.20, 'removed', 7, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (374, 'BrandH Casualwear 374', 'High quality BrandH Casualwear 374', 'BrandH', 'Standard specifications', 'Cotton', 91, 81.06, 16.21, 'active', 4, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (375, 'BrandI Sportswear 375', 'High quality BrandI Sportswear 375', 'BrandI', 'Standard specifications', 'Cotton', 84, 90.31, 18.06, 'active', 18, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (376, 'New Balance Dress 376', 'High quality New Balance Dress 376', 'New Balance', 'Standard specifications', 'Cotton', 52, 28.62, 5.72, 'active', 3, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (377, 'Under Armour Jeans 377', 'High quality Under Armour Jeans 377', 'Under Armour', 'Standard specifications', 'Cotton', 64, 143.75, 28.75, 'active', 6, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (378, 'Nike Shoes 378', 'High quality Nike Shoes 378', 'Nike', 'Standard specifications', 'Cotton', 73, 57.69, 11.54, 'active', 15, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (379, 'Adidas Sweater 379', 'High quality Adidas Sweater 379', 'Adidas', 'Standard specifications', 'Cotton', 30, 51.63, 10.33, 'removed', 8, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (380, 'Reebok Jacket 380', 'High quality Reebok Jacket 380', 'Reebok', 'Standard specifications', 'Cotton', 35, 148.03, 29.61, 'active', 7, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (381, 'Puma T-shirt 381', 'High quality Puma T-shirt 381', 'Puma', 'Standard specifications', 'Cotton', 67, 95.53, 19.11, 'active', 16, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (382, 'BrandA Topwear 382', 'High quality BrandA Topwear 382', 'BrandA', 'Standard specifications', 'Cotton', 15, 156.81, 31.36, 'active', 13, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (383, 'BrandB Bottomwear 383', 'High quality BrandB Bottomwear 383', 'BrandB', 'Standard specifications', 'Cotton', 90, 96.50, 19.30, 'active', 17, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (384, 'BrandC Outerwear 384', 'High quality BrandC Outerwear 384', 'BrandC', 'Standard specifications', 'Cotton', 64, 168.14, 33.63, 'active', 18, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (385, 'BrandD Footwear 385', 'High quality BrandD Footwear 385', 'BrandD', 'Standard specifications', 'Cotton', 88, 22.65, 4.53, 'removed', 13, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (386, 'BrandE Accessories 386', 'High quality BrandE Accessories 386', 'BrandE', 'Standard specifications', 'Cotton', 73, 171.51, 34.30, 'active', 1, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (387, 'BrandF Winterwear 387', 'High quality BrandF Winterwear 387', 'BrandF', 'Standard specifications', 'Cotton', 54, 83.66, 16.73, 'active', 3, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (388, 'BrandG Formalwear 388', 'High quality BrandG Formalwear 388', 'BrandG', 'Standard specifications', 'Cotton', 24, 24.67, 4.93, 'active', 2, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (389, 'BrandH Casualwear 389', 'High quality BrandH Casualwear 389', 'BrandH', 'Standard specifications', 'Cotton', 34, 25.21, 5.04, 'active', 8, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (390, 'BrandI Sportswear 390', 'High quality BrandI Sportswear 390', 'BrandI', 'Standard specifications', 'Cotton', 32, 79.35, 15.87, 'active', 19, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (391, 'New Balance Dress 391', 'High quality New Balance Dress 391', 'New Balance', 'Standard specifications', 'Cotton', 46, 195.84, 39.17, 'active', 14, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (392, 'Under Armour Jeans 392', 'High quality Under Armour Jeans 392', 'Under Armour', 'Standard specifications', 'Cotton', 41, 113.25, 22.65, 'active', 3, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (393, 'Nike Shoes 393', 'High quality Nike Shoes 393', 'Nike', 'Standard specifications', 'Cotton', 81, 102.02, 20.40, 'active', 19, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (394, 'Adidas Sweater 394', 'High quality Adidas Sweater 394', 'Adidas', 'Standard specifications', 'Cotton', 32, 159.30, 31.86, 'active', 8, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (395, 'Reebok Jacket 395', 'High quality Reebok Jacket 395', 'Reebok', 'Standard specifications', 'Cotton', 15, 59.90, 11.98, 'active', 2, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (396, 'Puma T-shirt 396', 'High quality Puma T-shirt 396', 'Puma', 'Standard specifications', 'Cotton', 21, 58.77, 11.75, 'active', 12, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (397, 'BrandA Topwear 397', 'High quality BrandA Topwear 397', 'BrandA', 'Standard specifications', 'Cotton', 71, 192.33, 38.47, 'removed', 10, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (398, 'BrandB Bottomwear 398', 'High quality BrandB Bottomwear 398', 'BrandB', 'Standard specifications', 'Cotton', 57, 21.04, 4.21, 'active', 17, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (399, 'BrandC Outerwear 399', 'High quality BrandC Outerwear 399', 'BrandC', 'Standard specifications', 'Cotton', 11, 191.66, 38.33, 'active', 18, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (400, 'BrandD Footwear 400', 'High quality BrandD Footwear 400', 'BrandD', 'Standard specifications', 'Cotton', 74, 110.54, 22.11, 'active', 13, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (401, 'BrandE Accessories 401', 'High quality BrandE Accessories 401', 'BrandE', 'Standard specifications', 'Cotton', 58, 98.94, 19.79, 'active', 20, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (402, 'BrandF Winterwear 402', 'High quality BrandF Winterwear 402', 'BrandF', 'Standard specifications', 'Cotton', 42, 88.73, 17.75, 'active', 17, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (403, 'BrandG Formalwear 403', 'High quality BrandG Formalwear 403', 'BrandG', 'Standard specifications', 'Cotton', 47, 60.65, 12.13, 'removed', 7, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (404, 'BrandH Casualwear 404', 'High quality BrandH Casualwear 404', 'BrandH', 'Standard specifications', 'Cotton', 17, 129.36, 25.87, 'active', 3, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (405, 'BrandI Sportswear 405', 'High quality BrandI Sportswear 405', 'BrandI', 'Standard specifications', 'Cotton', 78, 178.35, 35.67, 'active', 4, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (406, 'New Balance Dress 406', 'High quality New Balance Dress 406', 'New Balance', 'Standard specifications', 'Cotton', 10, 82.12, 16.42, 'active', 18, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (407, 'Under Armour Jeans 407', 'High quality Under Armour Jeans 407', 'Under Armour', 'Standard specifications', 'Cotton', 48, 35.08, 7.02, 'active', 1, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (408, 'Nike Shoes 408', 'High quality Nike Shoes 408', 'Nike', 'Standard specifications', 'Cotton', 43, 95.47, 19.09, 'active', 10, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (409, 'Adidas Sweater 409', 'High quality Adidas Sweater 409', 'Adidas', 'Standard specifications', 'Cotton', 86, 112.92, 22.58, 'active', 14, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (410, 'Reebok Jacket 410', 'High quality Reebok Jacket 410', 'Reebok', 'Standard specifications', 'Cotton', 48, 68.33, 13.67, 'active', 15, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (411, 'Puma T-shirt 411', 'High quality Puma T-shirt 411', 'Puma', 'Standard specifications', 'Cotton', 72, 28.19, 5.64, 'active', 3, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (412, 'BrandA Topwear 412', 'High quality BrandA Topwear 412', 'BrandA', 'Standard specifications', 'Cotton', 69, 73.04, 14.61, 'active', 10, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (413, 'BrandB Bottomwear 413', 'High quality BrandB Bottomwear 413', 'BrandB', 'Standard specifications', 'Cotton', 88, 109.30, 21.86, 'active', 10, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (414, 'BrandC Outerwear 414', 'High quality BrandC Outerwear 414', 'BrandC', 'Standard specifications', 'Cotton', 84, 43.98, 8.80, 'removed', 15, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (415, 'BrandD Footwear 415', 'High quality BrandD Footwear 415', 'BrandD', 'Standard specifications', 'Cotton', 52, 53.37, 10.67, 'removed', 11, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (416, 'BrandE Accessories 416', 'High quality BrandE Accessories 416', 'BrandE', 'Standard specifications', 'Cotton', 14, 92.49, 18.50, 'active', 7, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (417, 'BrandF Winterwear 417', 'High quality BrandF Winterwear 417', 'BrandF', 'Standard specifications', 'Cotton', 14, 99.58, 19.92, 'active', 8, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (418, 'BrandG Formalwear 418', 'High quality BrandG Formalwear 418', 'BrandG', 'Standard specifications', 'Cotton', 31, 193.51, 38.70, 'active', 19, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (419, 'BrandH Casualwear 419', 'High quality BrandH Casualwear 419', 'BrandH', 'Standard specifications', 'Cotton', 58, 75.68, 15.14, 'active', 13, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (420, 'BrandI Sportswear 420', 'High quality BrandI Sportswear 420', 'BrandI', 'Standard specifications', 'Cotton', 50, 30.68, 6.14, 'active', 16, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (421, 'New Balance Dress 421', 'High quality New Balance Dress 421', 'New Balance', 'Standard specifications', 'Cotton', 33, 165.21, 33.04, 'active', 6, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (422, 'Under Armour Jeans 422', 'High quality Under Armour Jeans 422', 'Under Armour', 'Standard specifications', 'Cotton', 15, 63.23, 12.65, 'active', 14, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (423, 'Nike Shoes 423', 'High quality Nike Shoes 423', 'Nike', 'Standard specifications', 'Cotton', 66, 77.34, 15.47, 'active', 8, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (424, 'Adidas Sweater 424', 'High quality Adidas Sweater 424', 'Adidas', 'Standard specifications', 'Cotton', 91, 110.04, 22.01, 'active', 16, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (425, 'Reebok Jacket 425', 'High quality Reebok Jacket 425', 'Reebok', 'Standard specifications', 'Cotton', 58, 172.99, 34.60, 'active', 11, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (426, 'Puma T-shirt 426', 'High quality Puma T-shirt 426', 'Puma', 'Standard specifications', 'Cotton', 67, 115.56, 23.11, 'active', 11, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (427, 'BrandA Topwear 427', 'High quality BrandA Topwear 427', 'BrandA', 'Standard specifications', 'Cotton', 67, 54.46, 10.89, 'active', 6, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (428, 'BrandB Bottomwear 428', 'High quality BrandB Bottomwear 428', 'BrandB', 'Standard specifications', 'Cotton', 54, 46.24, 9.25, 'active', 8, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (429, 'BrandC Outerwear 429', 'High quality BrandC Outerwear 429', 'BrandC', 'Standard specifications', 'Cotton', 12, 146.31, 29.26, 'active', 5, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (430, 'BrandD Footwear 430', 'High quality BrandD Footwear 430', 'BrandD', 'Standard specifications', 'Cotton', 47, 41.67, 8.33, 'active', 1, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (431, 'BrandE Accessories 431', 'High quality BrandE Accessories 431', 'BrandE', 'Standard specifications', 'Cotton', 10, 99.18, 19.84, 'removed', 18, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (432, 'BrandF Winterwear 432', 'High quality BrandF Winterwear 432', 'BrandF', 'Standard specifications', 'Cotton', 64, 164.15, 32.83, 'active', 19, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (433, 'BrandG Formalwear 433', 'High quality BrandG Formalwear 433', 'BrandG', 'Standard specifications', 'Cotton', 56, 55.68, 11.14, 'active', 2, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (434, 'BrandH Casualwear 434', 'High quality BrandH Casualwear 434', 'BrandH', 'Standard specifications', 'Cotton', 10, 173.56, 34.71, 'active', 12, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (435, 'BrandI Sportswear 435', 'High quality BrandI Sportswear 435', 'BrandI', 'Standard specifications', 'Cotton', 35, 57.60, 11.52, 'active', 3, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (436, 'New Balance Dress 436', 'High quality New Balance Dress 436', 'New Balance', 'Standard specifications', 'Cotton', 74, 49.64, 9.93, 'active', 20, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (437, 'Under Armour Jeans 437', 'High quality Under Armour Jeans 437', 'Under Armour', 'Standard specifications', 'Cotton', 55, 95.62, 19.12, 'active', 1, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (438, 'Nike Shoes 438', 'High quality Nike Shoes 438', 'Nike', 'Standard specifications', 'Cotton', 82, 26.06, 5.21, 'active', 8, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (439, 'Adidas Sweater 439', 'High quality Adidas Sweater 439', 'Adidas', 'Standard specifications', 'Cotton', 37, 51.47, 10.29, 'active', 19, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (440, 'Reebok Jacket 440', 'High quality Reebok Jacket 440', 'Reebok', 'Standard specifications', 'Cotton', 26, 166.06, 33.21, 'active', 10, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (441, 'Puma T-shirt 441', 'High quality Puma T-shirt 441', 'Puma', 'Standard specifications', 'Cotton', 15, 35.71, 7.14, 'active', 7, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (442, 'BrandA Topwear 442', 'High quality BrandA Topwear 442', 'BrandA', 'Standard specifications', 'Cotton', 60, 173.03, 34.61, 'active', 8, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (443, 'BrandB Bottomwear 443', 'High quality BrandB Bottomwear 443', 'BrandB', 'Standard specifications', 'Cotton', 99, 47.42, 9.48, 'active', 10, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (444, 'BrandC Outerwear 444', 'High quality BrandC Outerwear 444', 'BrandC', 'Standard specifications', 'Cotton', 21, 133.41, 26.68, 'active', 20, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (445, 'BrandD Footwear 445', 'High quality BrandD Footwear 445', 'BrandD', 'Standard specifications', 'Cotton', 94, 178.16, 35.63, 'active', 15, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (446, 'BrandE Accessories 446', 'High quality BrandE Accessories 446', 'BrandE', 'Standard specifications', 'Cotton', 79, 144.25, 28.85, 'active', 20, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (447, 'BrandF Winterwear 447', 'High quality BrandF Winterwear 447', 'BrandF', 'Standard specifications', 'Cotton', 26, 49.89, 9.98, 'active', 5, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (448, 'BrandG Formalwear 448', 'High quality BrandG Formalwear 448', 'BrandG', 'Standard specifications', 'Cotton', 77, 176.25, 35.25, 'active', 7, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (449, 'BrandH Casualwear 449', 'High quality BrandH Casualwear 449', 'BrandH', 'Standard specifications', 'Cotton', 84, 104.01, 20.80, 'removed', 3, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (450, 'BrandI Sportswear 450', 'High quality BrandI Sportswear 450', 'BrandI', 'Standard specifications', 'Cotton', 34, 151.17, 30.23, 'active', 9, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (451, 'New Balance Dress 451', 'High quality New Balance Dress 451', 'New Balance', 'Standard specifications', 'Cotton', 97, 76.09, 15.22, 'active', 12, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (452, 'Under Armour Jeans 452', 'High quality Under Armour Jeans 452', 'Under Armour', 'Standard specifications', 'Cotton', 31, 137.15, 27.43, 'active', 5, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (453, 'Nike Shoes 453', 'High quality Nike Shoes 453', 'Nike', 'Standard specifications', 'Cotton', 21, 138.88, 27.78, 'active', 16, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (454, 'Adidas Sweater 454', 'High quality Adidas Sweater 454', 'Adidas', 'Standard specifications', 'Cotton', 11, 193.99, 38.80, 'active', 7, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (455, 'Reebok Jacket 455', 'High quality Reebok Jacket 455', 'Reebok', 'Standard specifications', 'Cotton', 25, 118.73, 23.75, 'active', 8, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (456, 'Puma T-shirt 456', 'High quality Puma T-shirt 456', 'Puma', 'Standard specifications', 'Cotton', 24, 162.54, 32.51, 'active', 10, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (457, 'BrandA Topwear 457', 'High quality BrandA Topwear 457', 'BrandA', 'Standard specifications', 'Cotton', 30, 182.13, 36.43, 'active', 11, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (458, 'BrandB Bottomwear 458', 'High quality BrandB Bottomwear 458', 'BrandB', 'Standard specifications', 'Cotton', 82, 137.23, 27.45, 'active', 3, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (459, 'BrandC Outerwear 459', 'High quality BrandC Outerwear 459', 'BrandC', 'Standard specifications', 'Cotton', 14, 147.07, 29.41, 'active', 5, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (460, 'BrandD Footwear 460', 'High quality BrandD Footwear 460', 'BrandD', 'Standard specifications', 'Cotton', 85, 137.07, 27.41, 'active', 18, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (461, 'BrandE Accessories 461', 'High quality BrandE Accessories 461', 'BrandE', 'Standard specifications', 'Cotton', 64, 64.66, 12.93, 'active', 1, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (462, 'BrandF Winterwear 462', 'High quality BrandF Winterwear 462', 'BrandF', 'Standard specifications', 'Cotton', 69, 31.98, 6.40, 'active', 16, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (463, 'BrandG Formalwear 463', 'High quality BrandG Formalwear 463', 'BrandG', 'Standard specifications', 'Cotton', 91, 66.46, 13.29, 'active', 18, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (464, 'BrandH Casualwear 464', 'High quality BrandH Casualwear 464', 'BrandH', 'Standard specifications', 'Cotton', 16, 131.31, 26.26, 'active', 16, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (465, 'BrandI Sportswear 465', 'High quality BrandI Sportswear 465', 'BrandI', 'Standard specifications', 'Cotton', 82, 124.26, 24.85, 'active', 3, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (466, 'New Balance Dress 466', 'High quality New Balance Dress 466', 'New Balance', 'Standard specifications', 'Cotton', 48, 58.11, 11.62, 'active', 10, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (467, 'Under Armour Jeans 467', 'High quality Under Armour Jeans 467', 'Under Armour', 'Standard specifications', 'Cotton', 44, 63.22, 12.64, 'removed', 19, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (468, 'Nike Shoes 468', 'High quality Nike Shoes 468', 'Nike', 'Standard specifications', 'Cotton', 61, 76.23, 15.25, 'active', 2, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (469, 'Adidas Sweater 469', 'High quality Adidas Sweater 469', 'Adidas', 'Standard specifications', 'Cotton', 47, 51.00, 10.20, 'active', 18, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (470, 'Reebok Jacket 470', 'High quality Reebok Jacket 470', 'Reebok', 'Standard specifications', 'Cotton', 54, 49.75, 9.95, 'active', 17, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (471, 'Puma T-shirt 471', 'High quality Puma T-shirt 471', 'Puma', 'Standard specifications', 'Cotton', 86, 195.72, 39.14, 'active', 17, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (472, 'BrandA Topwear 472', 'High quality BrandA Topwear 472', 'BrandA', 'Standard specifications', 'Cotton', 48, 165.91, 33.18, 'active', 20, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (473, 'BrandB Bottomwear 473', 'High quality BrandB Bottomwear 473', 'BrandB', 'Standard specifications', 'Cotton', 55, 66.42, 13.28, 'removed', 2, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (474, 'BrandC Outerwear 474', 'High quality BrandC Outerwear 474', 'BrandC', 'Standard specifications', 'Cotton', 50, 114.07, 22.81, 'active', 11, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (475, 'BrandD Footwear 475', 'High quality BrandD Footwear 475', 'BrandD', 'Standard specifications', 'Cotton', 93, 78.83, 15.77, 'active', 1, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (476, 'BrandE Accessories 476', 'High quality BrandE Accessories 476', 'BrandE', 'Standard specifications', 'Cotton', 24, 160.97, 32.19, 'active', 4, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (477, 'BrandF Winterwear 477', 'High quality BrandF Winterwear 477', 'BrandF', 'Standard specifications', 'Cotton', 66, 116.06, 23.21, 'active', 13, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (478, 'BrandG Formalwear 478', 'High quality BrandG Formalwear 478', 'BrandG', 'Standard specifications', 'Cotton', 12, 91.99, 18.40, 'removed', 16, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (479, 'BrandH Casualwear 479', 'High quality BrandH Casualwear 479', 'BrandH', 'Standard specifications', 'Cotton', 47, 187.90, 37.58, 'removed', 16, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (480, 'BrandI Sportswear 480', 'High quality BrandI Sportswear 480', 'BrandI', 'Standard specifications', 'Cotton', 70, 58.60, 11.72, 'active', 19, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (481, 'New Balance Dress 481', 'High quality New Balance Dress 481', 'New Balance', 'Standard specifications', 'Cotton', 18, 164.58, 32.92, 'active', 14, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (482, 'Under Armour Jeans 482', 'High quality Under Armour Jeans 482', 'Under Armour', 'Standard specifications', 'Cotton', 71, 182.53, 36.51, 'active', 12, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (483, 'Nike Shoes 483', 'High quality Nike Shoes 483', 'Nike', 'Standard specifications', 'Cotton', 34, 83.46, 16.69, 'removed', 15, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (484, 'Adidas Sweater 484', 'High quality Adidas Sweater 484', 'Adidas', 'Standard specifications', 'Cotton', 88, 93.93, 18.79, 'active', 9, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (485, 'Reebok Jacket 485', 'High quality Reebok Jacket 485', 'Reebok', 'Standard specifications', 'Cotton', 48, 127.33, 25.47, 'active', 18, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (486, 'Puma T-shirt 486', 'High quality Puma T-shirt 486', 'Puma', 'Standard specifications', 'Cotton', 55, 62.29, 12.46, 'active', 14, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (487, 'BrandA Topwear 487', 'High quality BrandA Topwear 487', 'BrandA', 'Standard specifications', 'Cotton', 97, 94.15, 18.83, 'active', 6, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (488, 'BrandB Bottomwear 488', 'High quality BrandB Bottomwear 488', 'BrandB', 'Standard specifications', 'Cotton', 52, 109.21, 21.84, 'active', 1, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (489, 'BrandC Outerwear 489', 'High quality BrandC Outerwear 489', 'BrandC', 'Standard specifications', 'Cotton', 36, 165.13, 33.03, 'active', 8, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (490, 'BrandD Footwear 490', 'High quality BrandD Footwear 490', 'BrandD', 'Standard specifications', 'Cotton', 85, 113.04, 22.61, 'active', 17, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (491, 'BrandE Accessories 491', 'High quality BrandE Accessories 491', 'BrandE', 'Standard specifications', 'Cotton', 49, 148.17, 29.63, 'active', 5, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (492, 'BrandF Winterwear 492', 'High quality BrandF Winterwear 492', 'BrandF', 'Standard specifications', 'Cotton', 34, 39.61, 7.92, 'active', 2, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (493, 'BrandG Formalwear 493', 'High quality BrandG Formalwear 493', 'BrandG', 'Standard specifications', 'Cotton', 17, 105.64, 21.13, 'active', 4, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (494, 'BrandH Casualwear 494', 'High quality BrandH Casualwear 494', 'BrandH', 'Standard specifications', 'Cotton', 95, 22.01, 4.40, 'active', 12, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (495, 'BrandI Sportswear 495', 'High quality BrandI Sportswear 495', 'BrandI', 'Standard specifications', 'Cotton', 62, 188.97, 37.79, 'active', 20, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (496, 'New Balance Dress 496', 'High quality New Balance Dress 496', 'New Balance', 'Standard specifications', 'Cotton', 77, 155.61, 31.12, 'removed', 8, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (497, 'Under Armour Jeans 497', 'High quality Under Armour Jeans 497', 'Under Armour', 'Standard specifications', 'Cotton', 89, 136.21, 27.24, 'active', 10, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (498, 'Nike Shoes 498', 'High quality Nike Shoes 498', 'Nike', 'Standard specifications', 'Cotton', 56, 177.57, 35.51, 'removed', 14, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (499, 'Adidas Sweater 499', 'High quality Adidas Sweater 499', 'Adidas', 'Standard specifications', 'Cotton', 32, 83.29, 16.66, 'removed', 4, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (500, 'Reebok Jacket 500', 'High quality Reebok Jacket 500', 'Reebok', 'Standard specifications', 'Cotton', 42, 119.37, 23.87, 'active', 17, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (501, 'Puma T-shirt 501', 'High quality Puma T-shirt 501', 'Puma', 'Standard specifications', 'Cotton', 70, 192.17, 38.43, 'active', 14, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (502, 'BrandA Topwear 502', 'High quality BrandA Topwear 502', 'BrandA', 'Standard specifications', 'Cotton', 67, 148.30, 29.66, 'active', 14, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (503, 'BrandB Bottomwear 503', 'High quality BrandB Bottomwear 503', 'BrandB', 'Standard specifications', 'Cotton', 35, 191.76, 38.35, 'active', 8, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (504, 'BrandC Outerwear 504', 'High quality BrandC Outerwear 504', 'BrandC', 'Standard specifications', 'Cotton', 85, 22.09, 4.42, 'active', 9, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (505, 'BrandD Footwear 505', 'High quality BrandD Footwear 505', 'BrandD', 'Standard specifications', 'Cotton', 76, 73.98, 14.80, 'active', 20, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (506, 'BrandE Accessories 506', 'High quality BrandE Accessories 506', 'BrandE', 'Standard specifications', 'Cotton', 24, 70.34, 14.07, 'active', 18, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (507, 'BrandF Winterwear 507', 'High quality BrandF Winterwear 507', 'BrandF', 'Standard specifications', 'Cotton', 21, 91.22, 18.24, 'active', 4, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (508, 'BrandG Formalwear 508', 'High quality BrandG Formalwear 508', 'BrandG', 'Standard specifications', 'Cotton', 20, 138.04, 27.61, 'removed', 1, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (509, 'BrandH Casualwear 509', 'High quality BrandH Casualwear 509', 'BrandH', 'Standard specifications', 'Cotton', 39, 39.62, 7.92, 'active', 12, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (510, 'BrandI Sportswear 510', 'High quality BrandI Sportswear 510', 'BrandI', 'Standard specifications', 'Cotton', 75, 63.73, 12.75, 'removed', 17, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (511, 'New Balance Dress 511', 'High quality New Balance Dress 511', 'New Balance', 'Standard specifications', 'Cotton', 63, 61.71, 12.34, 'active', 8, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (512, 'Under Armour Jeans 512', 'High quality Under Armour Jeans 512', 'Under Armour', 'Standard specifications', 'Cotton', 31, 119.94, 23.99, 'active', 17, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (513, 'Nike Shoes 513', 'High quality Nike Shoes 513', 'Nike', 'Standard specifications', 'Cotton', 73, 65.54, 13.11, 'active', 5, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (514, 'Adidas Sweater 514', 'High quality Adidas Sweater 514', 'Adidas', 'Standard specifications', 'Cotton', 42, 114.35, 22.87, 'active', 15, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (515, 'Reebok Jacket 515', 'High quality Reebok Jacket 515', 'Reebok', 'Standard specifications', 'Cotton', 77, 97.77, 19.55, 'active', 2, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (516, 'Puma T-shirt 516', 'High quality Puma T-shirt 516', 'Puma', 'Standard specifications', 'Cotton', 74, 41.05, 8.21, 'active', 16, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (517, 'BrandA Topwear 517', 'High quality BrandA Topwear 517', 'BrandA', 'Standard specifications', 'Cotton', 53, 183.59, 36.72, 'active', 14, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (518, 'BrandB Bottomwear 518', 'High quality BrandB Bottomwear 518', 'BrandB', 'Standard specifications', 'Cotton', 92, 109.88, 21.98, 'active', 8, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (519, 'BrandC Outerwear 519', 'High quality BrandC Outerwear 519', 'BrandC', 'Standard specifications', 'Cotton', 62, 85.88, 17.18, 'active', 16, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (520, 'BrandD Footwear 520', 'High quality BrandD Footwear 520', 'BrandD', 'Standard specifications', 'Cotton', 72, 76.66, 15.33, 'active', 9, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (521, 'BrandE Accessories 521', 'High quality BrandE Accessories 521', 'BrandE', 'Standard specifications', 'Cotton', 53, 92.60, 18.52, 'active', 13, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (522, 'BrandF Winterwear 522', 'High quality BrandF Winterwear 522', 'BrandF', 'Standard specifications', 'Cotton', 82, 103.94, 20.79, 'active', 6, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (523, 'BrandG Formalwear 523', 'High quality BrandG Formalwear 523', 'BrandG', 'Standard specifications', 'Cotton', 57, 172.77, 34.55, 'active', 10, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (524, 'BrandH Casualwear 524', 'High quality BrandH Casualwear 524', 'BrandH', 'Standard specifications', 'Cotton', 32, 138.54, 27.71, 'active', 19, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (525, 'BrandI Sportswear 525', 'High quality BrandI Sportswear 525', 'BrandI', 'Standard specifications', 'Cotton', 13, 128.52, 25.70, 'removed', 4, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (526, 'New Balance Dress 526', 'High quality New Balance Dress 526', 'New Balance', 'Standard specifications', 'Cotton', 44, 103.93, 20.79, 'active', 11, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (527, 'Under Armour Jeans 527', 'High quality Under Armour Jeans 527', 'Under Armour', 'Standard specifications', 'Cotton', 44, 150.67, 30.13, 'active', 4, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (528, 'Nike Shoes 528', 'High quality Nike Shoes 528', 'Nike', 'Standard specifications', 'Cotton', 52, 190.29, 38.06, 'active', 8, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (529, 'Adidas Sweater 529', 'High quality Adidas Sweater 529', 'Adidas', 'Standard specifications', 'Cotton', 51, 54.86, 10.97, 'active', 4, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (530, 'Reebok Jacket 530', 'High quality Reebok Jacket 530', 'Reebok', 'Standard specifications', 'Cotton', 23, 193.70, 38.74, 'active', 6, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (531, 'Puma T-shirt 531', 'High quality Puma T-shirt 531', 'Puma', 'Standard specifications', 'Cotton', 32, 53.94, 10.79, 'active', 8, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (532, 'BrandA Topwear 532', 'High quality BrandA Topwear 532', 'BrandA', 'Standard specifications', 'Cotton', 11, 127.15, 25.43, 'active', 20, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (533, 'BrandB Bottomwear 533', 'High quality BrandB Bottomwear 533', 'BrandB', 'Standard specifications', 'Cotton', 25, 123.30, 24.66, 'active', 8, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (534, 'BrandC Outerwear 534', 'High quality BrandC Outerwear 534', 'BrandC', 'Standard specifications', 'Cotton', 63, 123.11, 24.62, 'active', 18, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (535, 'BrandD Footwear 535', 'High quality BrandD Footwear 535', 'BrandD', 'Standard specifications', 'Cotton', 91, 124.43, 24.89, 'active', 14, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (536, 'BrandE Accessories 536', 'High quality BrandE Accessories 536', 'BrandE', 'Standard specifications', 'Cotton', 43, 128.36, 25.67, 'active', 8, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (537, 'BrandF Winterwear 537', 'High quality BrandF Winterwear 537', 'BrandF', 'Standard specifications', 'Cotton', 45, 176.58, 35.32, 'active', 10, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (538, 'BrandG Formalwear 538', 'High quality BrandG Formalwear 538', 'BrandG', 'Standard specifications', 'Cotton', 24, 61.13, 12.23, 'active', 6, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (539, 'BrandH Casualwear 539', 'High quality BrandH Casualwear 539', 'BrandH', 'Standard specifications', 'Cotton', 49, 64.63, 12.93, 'active', 14, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (540, 'BrandI Sportswear 540', 'High quality BrandI Sportswear 540', 'BrandI', 'Standard specifications', 'Cotton', 83, 97.18, 19.44, 'active', 18, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (541, 'New Balance Dress 541', 'High quality New Balance Dress 541', 'New Balance', 'Standard specifications', 'Cotton', 74, 96.96, 19.39, 'active', 15, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (542, 'Under Armour Jeans 542', 'High quality Under Armour Jeans 542', 'Under Armour', 'Standard specifications', 'Cotton', 40, 135.82, 27.16, 'active', 8, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (543, 'Nike Shoes 543', 'High quality Nike Shoes 543', 'Nike', 'Standard specifications', 'Cotton', 10, 163.68, 32.74, 'active', 19, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (544, 'Adidas Sweater 544', 'High quality Adidas Sweater 544', 'Adidas', 'Standard specifications', 'Cotton', 10, 140.29, 28.06, 'active', 7, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (545, 'Reebok Jacket 545', 'High quality Reebok Jacket 545', 'Reebok', 'Standard specifications', 'Cotton', 63, 163.75, 32.75, 'active', 6, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (546, 'Puma T-shirt 546', 'High quality Puma T-shirt 546', 'Puma', 'Standard specifications', 'Cotton', 49, 56.89, 11.38, 'active', 5, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (547, 'BrandA Topwear 547', 'High quality BrandA Topwear 547', 'BrandA', 'Standard specifications', 'Cotton', 39, 124.65, 24.93, 'active', 16, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (548, 'BrandB Bottomwear 548', 'High quality BrandB Bottomwear 548', 'BrandB', 'Standard specifications', 'Cotton', 10, 20.83, 4.17, 'active', 10, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (549, 'BrandC Outerwear 549', 'High quality BrandC Outerwear 549', 'BrandC', 'Standard specifications', 'Cotton', 34, 27.98, 5.60, 'active', 12, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (550, 'BrandD Footwear 550', 'High quality BrandD Footwear 550', 'BrandD', 'Standard specifications', 'Cotton', 24, 83.62, 16.72, 'active', 13, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (551, 'BrandE Accessories 551', 'High quality BrandE Accessories 551', 'BrandE', 'Standard specifications', 'Cotton', 10, 136.13, 27.23, 'removed', 18, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (552, 'BrandF Winterwear 552', 'High quality BrandF Winterwear 552', 'BrandF', 'Standard specifications', 'Cotton', 69, 51.56, 10.31, 'active', 6, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (553, 'BrandG Formalwear 553', 'High quality BrandG Formalwear 553', 'BrandG', 'Standard specifications', 'Cotton', 82, 62.07, 12.41, 'removed', 12, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (554, 'BrandH Casualwear 554', 'High quality BrandH Casualwear 554', 'BrandH', 'Standard specifications', 'Cotton', 80, 47.19, 9.44, 'active', 17, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (555, 'BrandI Sportswear 555', 'High quality BrandI Sportswear 555', 'BrandI', 'Standard specifications', 'Cotton', 54, 90.57, 18.11, 'active', 13, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (556, 'New Balance Dress 556', 'High quality New Balance Dress 556', 'New Balance', 'Standard specifications', 'Cotton', 95, 65.76, 13.15, 'active', 17, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (557, 'Under Armour Jeans 557', 'High quality Under Armour Jeans 557', 'Under Armour', 'Standard specifications', 'Cotton', 16, 100.62, 20.12, 'active', 3, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (558, 'Nike Shoes 558', 'High quality Nike Shoes 558', 'Nike', 'Standard specifications', 'Cotton', 96, 42.26, 8.45, 'active', 3, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (559, 'Adidas Sweater 559', 'High quality Adidas Sweater 559', 'Adidas', 'Standard specifications', 'Cotton', 10, 101.20, 20.24, 'active', 19, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (560, 'Reebok Jacket 560', 'High quality Reebok Jacket 560', 'Reebok', 'Standard specifications', 'Cotton', 91, 72.19, 14.44, 'active', 20, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (561, 'Puma T-shirt 561', 'High quality Puma T-shirt 561', 'Puma', 'Standard specifications', 'Cotton', 58, 53.21, 10.64, 'active', 17, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (562, 'BrandA Topwear 562', 'High quality BrandA Topwear 562', 'BrandA', 'Standard specifications', 'Cotton', 43, 96.42, 19.28, 'active', 8, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (563, 'BrandB Bottomwear 563', 'High quality BrandB Bottomwear 563', 'BrandB', 'Standard specifications', 'Cotton', 79, 149.90, 29.98, 'active', 5, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (564, 'BrandC Outerwear 564', 'High quality BrandC Outerwear 564', 'BrandC', 'Standard specifications', 'Cotton', 56, 68.81, 13.76, 'removed', 15, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (565, 'BrandD Footwear 565', 'High quality BrandD Footwear 565', 'BrandD', 'Standard specifications', 'Cotton', 71, 194.60, 38.92, 'removed', 17, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (566, 'BrandE Accessories 566', 'High quality BrandE Accessories 566', 'BrandE', 'Standard specifications', 'Cotton', 40, 142.26, 28.45, 'active', 12, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (567, 'BrandF Winterwear 567', 'High quality BrandF Winterwear 567', 'BrandF', 'Standard specifications', 'Cotton', 84, 71.29, 14.26, 'active', 8, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (568, 'BrandG Formalwear 568', 'High quality BrandG Formalwear 568', 'BrandG', 'Standard specifications', 'Cotton', 66, 164.24, 32.85, 'active', 19, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (569, 'BrandH Casualwear 569', 'High quality BrandH Casualwear 569', 'BrandH', 'Standard specifications', 'Cotton', 93, 74.72, 14.94, 'active', 2, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (570, 'BrandI Sportswear 570', 'High quality BrandI Sportswear 570', 'BrandI', 'Standard specifications', 'Cotton', 31, 100.11, 20.02, 'active', 3, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (571, 'New Balance Dress 571', 'High quality New Balance Dress 571', 'New Balance', 'Standard specifications', 'Cotton', 50, 95.42, 19.08, 'active', 20, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (572, 'Under Armour Jeans 572', 'High quality Under Armour Jeans 572', 'Under Armour', 'Standard specifications', 'Cotton', 69, 186.06, 37.21, 'active', 11, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (573, 'Nike Shoes 573', 'High quality Nike Shoes 573', 'Nike', 'Standard specifications', 'Cotton', 60, 75.48, 15.10, 'active', 14, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (574, 'Adidas Sweater 574', 'High quality Adidas Sweater 574', 'Adidas', 'Standard specifications', 'Cotton', 25, 183.54, 36.71, 'active', 17, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (575, 'Reebok Jacket 575', 'High quality Reebok Jacket 575', 'Reebok', 'Standard specifications', 'Cotton', 25, 63.11, 12.62, 'removed', 1, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (576, 'Puma T-shirt 576', 'High quality Puma T-shirt 576', 'Puma', 'Standard specifications', 'Cotton', 23, 173.26, 34.65, 'active', 3, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (577, 'BrandA Topwear 577', 'High quality BrandA Topwear 577', 'BrandA', 'Standard specifications', 'Cotton', 13, 186.60, 37.32, 'removed', 1, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (578, 'BrandB Bottomwear 578', 'High quality BrandB Bottomwear 578', 'BrandB', 'Standard specifications', 'Cotton', 19, 45.07, 9.01, 'active', 18, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (579, 'BrandC Outerwear 579', 'High quality BrandC Outerwear 579', 'BrandC', 'Standard specifications', 'Cotton', 23, 105.13, 21.03, 'active', 10, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (580, 'BrandD Footwear 580', 'High quality BrandD Footwear 580', 'BrandD', 'Standard specifications', 'Cotton', 48, 159.06, 31.81, 'active', 6, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (581, 'BrandE Accessories 581', 'High quality BrandE Accessories 581', 'BrandE', 'Standard specifications', 'Cotton', 63, 68.95, 13.79, 'active', 13, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (582, 'BrandF Winterwear 582', 'High quality BrandF Winterwear 582', 'BrandF', 'Standard specifications', 'Cotton', 30, 26.78, 5.36, 'active', 2, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (583, 'BrandG Formalwear 583', 'High quality BrandG Formalwear 583', 'BrandG', 'Standard specifications', 'Cotton', 72, 79.62, 15.92, 'active', 6, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (584, 'BrandH Casualwear 584', 'High quality BrandH Casualwear 584', 'BrandH', 'Standard specifications', 'Cotton', 57, 140.61, 28.12, 'active', 9, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (585, 'BrandI Sportswear 585', 'High quality BrandI Sportswear 585', 'BrandI', 'Standard specifications', 'Cotton', 97, 137.98, 27.60, 'active', 20, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (586, 'New Balance Dress 586', 'High quality New Balance Dress 586', 'New Balance', 'Standard specifications', 'Cotton', 13, 139.66, 27.93, 'active', 10, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (587, 'Under Armour Jeans 587', 'High quality Under Armour Jeans 587', 'Under Armour', 'Standard specifications', 'Cotton', 21, 125.01, 25.00, 'active', 9, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (588, 'Nike Shoes 588', 'High quality Nike Shoes 588', 'Nike', 'Standard specifications', 'Cotton', 74, 194.50, 38.90, 'active', 19, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (589, 'Adidas Sweater 589', 'High quality Adidas Sweater 589', 'Adidas', 'Standard specifications', 'Cotton', 92, 75.33, 15.07, 'active', 3, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (590, 'Reebok Jacket 590', 'High quality Reebok Jacket 590', 'Reebok', 'Standard specifications', 'Cotton', 76, 134.02, 26.80, 'active', 7, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (591, 'Puma T-shirt 591', 'High quality Puma T-shirt 591', 'Puma', 'Standard specifications', 'Cotton', 80, 85.61, 17.12, 'active', 1, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (592, 'BrandA Topwear 592', 'High quality BrandA Topwear 592', 'BrandA', 'Standard specifications', 'Cotton', 44, 106.66, 21.33, 'active', 16, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (593, 'BrandB Bottomwear 593', 'High quality BrandB Bottomwear 593', 'BrandB', 'Standard specifications', 'Cotton', 21, 136.82, 27.36, 'active', 16, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (594, 'BrandC Outerwear 594', 'High quality BrandC Outerwear 594', 'BrandC', 'Standard specifications', 'Cotton', 70, 176.96, 35.39, 'active', 6, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (595, 'BrandD Footwear 595', 'High quality BrandD Footwear 595', 'BrandD', 'Standard specifications', 'Cotton', 48, 183.38, 36.68, 'active', 6, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (596, 'BrandE Accessories 596', 'High quality BrandE Accessories 596', 'BrandE', 'Standard specifications', 'Cotton', 69, 121.05, 24.21, 'active', 20, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (597, 'BrandF Winterwear 597', 'High quality BrandF Winterwear 597', 'BrandF', 'Standard specifications', 'Cotton', 94, 56.57, 11.31, 'active', 17, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (598, 'BrandG Formalwear 598', 'High quality BrandG Formalwear 598', 'BrandG', 'Standard specifications', 'Cotton', 19, 140.59, 28.12, 'active', 17, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (599, 'BrandH Casualwear 599', 'High quality BrandH Casualwear 599', 'BrandH', 'Standard specifications', 'Cotton', 31, 52.67, 10.53, 'removed', 4, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (600, 'BrandI Sportswear 600', 'High quality BrandI Sportswear 600', 'BrandI', 'Standard specifications', 'Cotton', 13, 85.74, 17.15, 'active', 16, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (601, 'New Balance Dress 601', 'High quality New Balance Dress 601', 'New Balance', 'Standard specifications', 'Cotton', 89, 24.48, 4.90, 'active', 17, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (602, 'Under Armour Jeans 602', 'High quality Under Armour Jeans 602', 'Under Armour', 'Standard specifications', 'Cotton', 92, 128.75, 25.75, 'active', 11, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (603, 'Nike Shoes 603', 'High quality Nike Shoes 603', 'Nike', 'Standard specifications', 'Cotton', 95, 152.29, 30.46, 'active', 10, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (604, 'Adidas Sweater 604', 'High quality Adidas Sweater 604', 'Adidas', 'Standard specifications', 'Cotton', 66, 53.31, 10.66, 'active', 5, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (605, 'Reebok Jacket 605', 'High quality Reebok Jacket 605', 'Reebok', 'Standard specifications', 'Cotton', 89, 79.03, 15.81, 'active', 16, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (606, 'Puma T-shirt 606', 'High quality Puma T-shirt 606', 'Puma', 'Standard specifications', 'Cotton', 37, 198.15, 39.63, 'active', 16, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (607, 'BrandA Topwear 607', 'High quality BrandA Topwear 607', 'BrandA', 'Standard specifications', 'Cotton', 52, 93.37, 18.67, 'active', 11, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (608, 'BrandB Bottomwear 608', 'High quality BrandB Bottomwear 608', 'BrandB', 'Standard specifications', 'Cotton', 54, 123.15, 24.63, 'removed', 3, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (609, 'BrandC Outerwear 609', 'High quality BrandC Outerwear 609', 'BrandC', 'Standard specifications', 'Cotton', 74, 53.15, 10.63, 'active', 18, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (610, 'BrandD Footwear 610', 'High quality BrandD Footwear 610', 'BrandD', 'Standard specifications', 'Cotton', 41, 159.49, 31.90, 'active', 3, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (611, 'BrandE Accessories 611', 'High quality BrandE Accessories 611', 'BrandE', 'Standard specifications', 'Cotton', 57, 112.74, 22.55, 'active', 1, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (612, 'BrandF Winterwear 612', 'High quality BrandF Winterwear 612', 'BrandF', 'Standard specifications', 'Cotton', 51, 123.08, 24.62, 'active', 20, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (613, 'BrandG Formalwear 613', 'High quality BrandG Formalwear 613', 'BrandG', 'Standard specifications', 'Cotton', 38, 90.85, 18.17, 'active', 6, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (614, 'BrandH Casualwear 614', 'High quality BrandH Casualwear 614', 'BrandH', 'Standard specifications', 'Cotton', 48, 114.81, 22.96, 'active', 10, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (615, 'BrandI Sportswear 615', 'High quality BrandI Sportswear 615', 'BrandI', 'Standard specifications', 'Cotton', 74, 64.89, 12.98, 'active', 7, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (616, 'New Balance Dress 616', 'High quality New Balance Dress 616', 'New Balance', 'Standard specifications', 'Cotton', 95, 139.71, 27.94, 'active', 5, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (617, 'Under Armour Jeans 617', 'High quality Under Armour Jeans 617', 'Under Armour', 'Standard specifications', 'Cotton', 25, 189.35, 37.87, 'active', 13, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (618, 'Nike Shoes 618', 'High quality Nike Shoes 618', 'Nike', 'Standard specifications', 'Cotton', 14, 167.81, 33.56, 'active', 16, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (619, 'Adidas Sweater 619', 'High quality Adidas Sweater 619', 'Adidas', 'Standard specifications', 'Cotton', 28, 99.28, 19.86, 'active', 14, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (620, 'Reebok Jacket 620', 'High quality Reebok Jacket 620', 'Reebok', 'Standard specifications', 'Cotton', 19, 99.44, 19.89, 'active', 15, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (621, 'Puma T-shirt 621', 'High quality Puma T-shirt 621', 'Puma', 'Standard specifications', 'Cotton', 97, 40.10, 8.02, 'active', 8, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (622, 'BrandA Topwear 622', 'High quality BrandA Topwear 622', 'BrandA', 'Standard specifications', 'Cotton', 15, 187.78, 37.56, 'active', 20, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (623, 'BrandB Bottomwear 623', 'High quality BrandB Bottomwear 623', 'BrandB', 'Standard specifications', 'Cotton', 47, 20.88, 4.18, 'active', 13, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (624, 'BrandC Outerwear 624', 'High quality BrandC Outerwear 624', 'BrandC', 'Standard specifications', 'Cotton', 74, 117.77, 23.55, 'active', 6, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (625, 'BrandD Footwear 625', 'High quality BrandD Footwear 625', 'BrandD', 'Standard specifications', 'Cotton', 60, 86.01, 17.20, 'active', 6, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (626, 'BrandE Accessories 626', 'High quality BrandE Accessories 626', 'BrandE', 'Standard specifications', 'Cotton', 78, 63.69, 12.74, 'active', 6, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (627, 'BrandF Winterwear 627', 'High quality BrandF Winterwear 627', 'BrandF', 'Standard specifications', 'Cotton', 65, 68.19, 13.64, 'active', 19, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (628, 'BrandG Formalwear 628', 'High quality BrandG Formalwear 628', 'BrandG', 'Standard specifications', 'Cotton', 58, 20.46, 4.09, 'active', 15, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (629, 'BrandH Casualwear 629', 'High quality BrandH Casualwear 629', 'BrandH', 'Standard specifications', 'Cotton', 48, 106.85, 21.37, 'active', 8, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (630, 'BrandI Sportswear 630', 'High quality BrandI Sportswear 630', 'BrandI', 'Standard specifications', 'Cotton', 68, 152.37, 30.47, 'active', 7, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (631, 'New Balance Dress 631', 'High quality New Balance Dress 631', 'New Balance', 'Standard specifications', 'Cotton', 83, 147.31, 29.46, 'active', 7, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (632, 'Under Armour Jeans 632', 'High quality Under Armour Jeans 632', 'Under Armour', 'Standard specifications', 'Cotton', 42, 193.34, 38.67, 'active', 20, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (633, 'Nike Shoes 633', 'High quality Nike Shoes 633', 'Nike', 'Standard specifications', 'Cotton', 38, 154.31, 30.86, 'active', 15, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (634, 'Adidas Sweater 634', 'High quality Adidas Sweater 634', 'Adidas', 'Standard specifications', 'Cotton', 99, 153.59, 30.72, 'active', 15, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (635, 'Reebok Jacket 635', 'High quality Reebok Jacket 635', 'Reebok', 'Standard specifications', 'Cotton', 39, 114.77, 22.95, 'active', 16, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (636, 'Puma T-shirt 636', 'High quality Puma T-shirt 636', 'Puma', 'Standard specifications', 'Cotton', 54, 163.41, 32.68, 'removed', 14, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (637, 'BrandA Topwear 637', 'High quality BrandA Topwear 637', 'BrandA', 'Standard specifications', 'Cotton', 59, 156.36, 31.27, 'active', 15, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (638, 'BrandB Bottomwear 638', 'High quality BrandB Bottomwear 638', 'BrandB', 'Standard specifications', 'Cotton', 12, 23.65, 4.73, 'active', 11, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (639, 'BrandC Outerwear 639', 'High quality BrandC Outerwear 639', 'BrandC', 'Standard specifications', 'Cotton', 12, 29.08, 5.82, 'removed', 6, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (640, 'BrandD Footwear 640', 'High quality BrandD Footwear 640', 'BrandD', 'Standard specifications', 'Cotton', 36, 44.04, 8.81, 'active', 10, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (641, 'BrandE Accessories 641', 'High quality BrandE Accessories 641', 'BrandE', 'Standard specifications', 'Cotton', 64, 70.08, 14.02, 'active', 13, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (642, 'BrandF Winterwear 642', 'High quality BrandF Winterwear 642', 'BrandF', 'Standard specifications', 'Cotton', 77, 32.65, 6.53, 'active', 16, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (643, 'BrandG Formalwear 643', 'High quality BrandG Formalwear 643', 'BrandG', 'Standard specifications', 'Cotton', 84, 144.78, 28.96, 'active', 16, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (644, 'BrandH Casualwear 644', 'High quality BrandH Casualwear 644', 'BrandH', 'Standard specifications', 'Cotton', 21, 87.33, 17.47, 'active', 17, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (645, 'BrandI Sportswear 645', 'High quality BrandI Sportswear 645', 'BrandI', 'Standard specifications', 'Cotton', 47, 121.75, 24.35, 'active', 18, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (646, 'New Balance Dress 646', 'High quality New Balance Dress 646', 'New Balance', 'Standard specifications', 'Cotton', 88, 194.99, 39.00, 'active', 18, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (647, 'Under Armour Jeans 647', 'High quality Under Armour Jeans 647', 'Under Armour', 'Standard specifications', 'Cotton', 100, 88.69, 17.74, 'removed', 20, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (648, 'Nike Shoes 648', 'High quality Nike Shoes 648', 'Nike', 'Standard specifications', 'Cotton', 45, 166.02, 33.20, 'active', 3, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (649, 'Adidas Sweater 649', 'High quality Adidas Sweater 649', 'Adidas', 'Standard specifications', 'Cotton', 57, 173.73, 34.75, 'active', 11, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (650, 'Reebok Jacket 650', 'High quality Reebok Jacket 650', 'Reebok', 'Standard specifications', 'Cotton', 85, 24.80, 4.96, 'active', 11, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (651, 'Puma T-shirt 651', 'High quality Puma T-shirt 651', 'Puma', 'Standard specifications', 'Cotton', 76, 51.66, 10.33, 'active', 5, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (652, 'BrandA Topwear 652', 'High quality BrandA Topwear 652', 'BrandA', 'Standard specifications', 'Cotton', 70, 139.82, 27.96, 'active', 13, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (653, 'BrandB Bottomwear 653', 'High quality BrandB Bottomwear 653', 'BrandB', 'Standard specifications', 'Cotton', 42, 22.78, 4.56, 'removed', 10, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (654, 'BrandC Outerwear 654', 'High quality BrandC Outerwear 654', 'BrandC', 'Standard specifications', 'Cotton', 91, 195.34, 39.07, 'active', 7, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (655, 'BrandD Footwear 655', 'High quality BrandD Footwear 655', 'BrandD', 'Standard specifications', 'Cotton', 12, 77.26, 15.45, 'active', 15, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (656, 'BrandE Accessories 656', 'High quality BrandE Accessories 656', 'BrandE', 'Standard specifications', 'Cotton', 81, 134.75, 26.95, 'removed', 11, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (657, 'BrandF Winterwear 657', 'High quality BrandF Winterwear 657', 'BrandF', 'Standard specifications', 'Cotton', 49, 65.74, 13.15, 'removed', 19, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (658, 'BrandG Formalwear 658', 'High quality BrandG Formalwear 658', 'BrandG', 'Standard specifications', 'Cotton', 94, 166.47, 33.29, 'active', 10, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (659, 'BrandH Casualwear 659', 'High quality BrandH Casualwear 659', 'BrandH', 'Standard specifications', 'Cotton', 35, 128.85, 25.77, 'active', 14, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (660, 'BrandI Sportswear 660', 'High quality BrandI Sportswear 660', 'BrandI', 'Standard specifications', 'Cotton', 54, 80.05, 16.01, 'active', 4, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (661, 'New Balance Dress 661', 'High quality New Balance Dress 661', 'New Balance', 'Standard specifications', 'Cotton', 80, 61.32, 12.26, 'active', 19, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (662, 'Under Armour Jeans 662', 'High quality Under Armour Jeans 662', 'Under Armour', 'Standard specifications', 'Cotton', 97, 185.74, 37.15, 'active', 16, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (663, 'Nike Shoes 663', 'High quality Nike Shoes 663', 'Nike', 'Standard specifications', 'Cotton', 92, 114.25, 22.85, 'active', 1, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (664, 'Adidas Sweater 664', 'High quality Adidas Sweater 664', 'Adidas', 'Standard specifications', 'Cotton', 92, 122.50, 24.50, 'active', 18, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (665, 'Reebok Jacket 665', 'High quality Reebok Jacket 665', 'Reebok', 'Standard specifications', 'Cotton', 70, 51.04, 10.21, 'removed', 3, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (666, 'Puma T-shirt 666', 'High quality Puma T-shirt 666', 'Puma', 'Standard specifications', 'Cotton', 65, 132.72, 26.54, 'active', 8, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (667, 'BrandA Topwear 667', 'High quality BrandA Topwear 667', 'BrandA', 'Standard specifications', 'Cotton', 10, 96.77, 19.35, 'active', 1, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (668, 'BrandB Bottomwear 668', 'High quality BrandB Bottomwear 668', 'BrandB', 'Standard specifications', 'Cotton', 49, 163.09, 32.62, 'active', 16, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (669, 'BrandC Outerwear 669', 'High quality BrandC Outerwear 669', 'BrandC', 'Standard specifications', 'Cotton', 25, 133.14, 26.63, 'active', 13, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (670, 'BrandD Footwear 670', 'High quality BrandD Footwear 670', 'BrandD', 'Standard specifications', 'Cotton', 36, 187.58, 37.52, 'active', 3, 10, 4, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (671, 'BrandE Accessories 671', 'High quality BrandE Accessories 671', 'BrandE', 'Standard specifications', 'Cotton', 62, 72.11, 14.42, 'active', 15, 11, 5, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (672, 'BrandF Winterwear 672', 'High quality BrandF Winterwear 672', 'BrandF', 'Standard specifications', 'Cotton', 74, 123.21, 24.64, 'active', 9, 12, 6, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (673, 'BrandG Formalwear 673', 'High quality BrandG Formalwear 673', 'BrandG', 'Standard specifications', 'Cotton', 66, 106.65, 21.33, 'removed', 9, 13, 1, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (674, 'BrandH Casualwear 674', 'High quality BrandH Casualwear 674', 'BrandH', 'Standard specifications', 'Cotton', 84, 33.51, 6.70, 'active', 14, 14, 2, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (675, 'BrandI Sportswear 675', 'High quality BrandI Sportswear 675', 'BrandI', 'Standard specifications', 'Cotton', 96, 193.35, 38.67, 'removed', 10, 15, 3, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (676, 'New Balance Dress 676', 'High quality New Balance Dress 676', 'New Balance', 'Standard specifications', 'Cotton', 68, 56.25, 11.25, 'active', 12, 1, 4, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (677, 'Under Armour Jeans 677', 'High quality Under Armour Jeans 677', 'Under Armour', 'Standard specifications', 'Cotton', 22, 124.63, 24.93, 'active', 13, 2, 5, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (678, 'Nike Shoes 678', 'High quality Nike Shoes 678', 'Nike', 'Standard specifications', 'Cotton', 66, 67.86, 13.57, 'active', 20, 3, 6, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (679, 'Adidas Sweater 679', 'High quality Adidas Sweater 679', 'Adidas', 'Standard specifications', 'Cotton', 98, 94.00, 18.80, 'active', 19, 4, 1, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (680, 'Reebok Jacket 680', 'High quality Reebok Jacket 680', 'Reebok', 'Standard specifications', 'Cotton', 50, 39.52, 7.90, 'active', 3, 5, 2, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (681, 'Puma T-shirt 681', 'High quality Puma T-shirt 681', 'Puma', 'Standard specifications', 'Cotton', 18, 178.25, 35.65, 'active', 11, 6, 3, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (682, 'BrandA Topwear 682', 'High quality BrandA Topwear 682', 'BrandA', 'Standard specifications', 'Cotton', 82, 40.75, 8.15, 'active', 6, 7, 4, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (683, 'BrandB Bottomwear 683', 'High quality BrandB Bottomwear 683', 'BrandB', 'Standard specifications', 'Cotton', 58, 40.73, 8.15, 'active', 7, 8, 5, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (684, 'BrandC Outerwear 684', 'High quality BrandC Outerwear 684', 'BrandC', 'Standard specifications', 'Cotton', 28, 192.59, 38.52, 'active', 15, 9, 6, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (685, 'BrandD Footwear 685', 'High quality BrandD Footwear 685', 'BrandD', 'Standard specifications', 'Cotton', 84, 165.19, 33.04, 'active', 2, 10, 1, 10);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (686, 'BrandE Accessories 686', 'High quality BrandE Accessories 686', 'BrandE', 'Standard specifications', 'Cotton', 16, 182.31, 36.46, 'active', 9, 11, 2, 11);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (687, 'BrandF Winterwear 687', 'High quality BrandF Winterwear 687', 'BrandF', 'Standard specifications', 'Cotton', 90, 153.52, 30.70, 'active', 19, 12, 3, 12);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (688, 'BrandG Formalwear 688', 'High quality BrandG Formalwear 688', 'BrandG', 'Standard specifications', 'Cotton', 18, 110.68, 22.14, 'active', 12, 13, 4, 13);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (689, 'BrandH Casualwear 689', 'High quality BrandH Casualwear 689', 'BrandH', 'Standard specifications', 'Cotton', 35, 196.07, 39.21, 'active', 9, 14, 5, 14);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (690, 'BrandI Sportswear 690', 'High quality BrandI Sportswear 690', 'BrandI', 'Standard specifications', 'Cotton', 86, 118.43, 23.69, 'active', 15, 15, 6, 15);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (691, 'New Balance Dress 691', 'High quality New Balance Dress 691', 'New Balance', 'Standard specifications', 'Cotton', 41, 148.20, 29.64, 'active', 10, 1, 1, 1);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (692, 'Under Armour Jeans 692', 'High quality Under Armour Jeans 692', 'Under Armour', 'Standard specifications', 'Cotton', 66, 147.52, 29.50, 'active', 6, 2, 2, 2);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (693, 'Nike Shoes 693', 'High quality Nike Shoes 693', 'Nike', 'Standard specifications', 'Cotton', 46, 163.33, 32.67, 'active', 20, 3, 3, 3);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (694, 'Adidas Sweater 694', 'High quality Adidas Sweater 694', 'Adidas', 'Standard specifications', 'Cotton', 55, 49.98, 10.00, 'active', 19, 4, 4, 4);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (695, 'Reebok Jacket 695', 'High quality Reebok Jacket 695', 'Reebok', 'Standard specifications', 'Cotton', 81, 36.26, 7.25, 'active', 7, 5, 5, 5);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (696, 'Puma T-shirt 696', 'High quality Puma T-shirt 696', 'Puma', 'Standard specifications', 'Cotton', 13, 56.29, 11.26, 'active', 11, 6, 6, 6);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (697, 'BrandA Topwear 697', 'High quality BrandA Topwear 697', 'BrandA', 'Standard specifications', 'Cotton', 91, 146.26, 29.25, 'active', 12, 7, 1, 7);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (698, 'BrandB Bottomwear 698', 'High quality BrandB Bottomwear 698', 'BrandB', 'Standard specifications', 'Cotton', 53, 112.15, 22.43, 'removed', 4, 8, 2, 8);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (699, 'BrandC Outerwear 699', 'High quality BrandC Outerwear 699', 'BrandC', 'Standard specifications', 'Cotton', 56, 71.55, 14.31, 'active', 18, 9, 3, 9);
INSERT INTO Inventory (InventoryID, ProductName, Description, Brand, Specifications, Material, InventoryAmount, BuyingPrice, ProfitAmount, Status, SupplierID, ColorID, SizeID, CatID) VALUES (700, 'BrandD Footwear 700', 'High quality BrandD Footwear 700', 'BrandD', 'Standard specifications', 'Cotton', 68, 119.38, 23.88, 'active', 1, 10, 4, 10);


INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (1, 'Damage description 1', 3.51, 9.59, 44);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (2, 'Damage description 2', 6.53, 4.91, 613);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (3, 'Damage description 3', 3.51, 3.01, 378);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (4, 'Damage description 4', 3.35, 4.6, 66);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (5, 'Damage description 5', 3.63, 2.28, 570);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (6, 'Damage description 6', 7.51, 1.91, 71);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (7, 'Damage description 7', 6.83, 0.66, 258);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (8, 'Damage description 8', 4.33, 8.77, 581);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (9, 'Damage description 9', 6.18, 8.79, 301);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (10, 'Damage description 10', 9.98, 1.56, 122);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (11, 'Damage description 11', 1.51, 2.44, 295);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (12, 'Damage description 12', 1.99, 5.7, 529);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (13, 'Damage description 13', 0.58, 1.61, 196);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (14, 'Damage description 14', 2.02, 4.58, 214);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (15, 'Damage description 15', 9.01, 1.28, 241);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (16, 'Damage description 16', 8.33, 4.74, 308);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (17, 'Damage description 17', 1.18, 5.96, 8);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (18, 'Damage description 18', 1.88, 8.63, 477);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (19, 'Damage description 19', 8.98, 5.77, 585);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (20, 'Damage description 20', 5.55, 9.71, 508);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (21, 'Damage description 21', 0.6, 1.31, 420);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (22, 'Damage description 22', 3.9, 2.89, 198);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (23, 'Damage description 23', 3.48, 9.28, 206);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (24, 'Damage description 24', 4.69, 6.78, 86);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (25, 'Damage description 25', 5.75, 2.15, 526);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (26, 'Damage description 26', 4.21, 6.64, 119);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (27, 'Damage description 27', 3.76, 4.02, 311);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (28, 'Damage description 28', 6.93, 4.38, 77);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (29, 'Damage description 29', 3.18, 9.51, 174);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (30, 'Damage description 30', 9.02, 8.72, 82);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (31, 'Damage description 31', 0.16, 1.53, 588);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (32, 'Damage description 32', 5.29, 9.04, 107);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (33, 'Damage description 33', 3.52, 4.79, 438);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (34, 'Damage description 34', 8.38, 3.2, 8);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (35, 'Damage description 35', 0.47, 7.38, 691);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (36, 'Damage description 36', 3.45, 7.76, 266);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (37, 'Damage description 37', 8.47, 5.03, 36);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (38, 'Damage description 38', 0.78, 7.96, 42);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (39, 'Damage description 39', 0.02, 2.77, 376);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (40, 'Damage description 40', 2.84, 0.86, 26);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (41, 'Damage description 41', 4.16, 8.57, 604);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (42, 'Damage description 42', 0.55, 8.6, 187);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (43, 'Damage description 43', 1.49, 1.32, 503);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (44, 'Damage description 44', 7.34, 1.79, 161);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (45, 'Damage description 45', 5.94, 1.25, 131);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (46, 'Damage description 46', 0.93, 9.07, 260);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (47, 'Damage description 47', 7.01, 9.87, 345);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (48, 'Damage description 48', 1.18, 6.91, 441);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (49, 'Damage description 49', 3.67, 4.41, 622);
INSERT INTO DamagedInventory (DamagedInventoryID, DamageDescription, ReturningAmount, DamagedAmount, InventoryID) VALUES (50, 'Damage description 50', 3.03, 6.2, 126);

INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (1, '2025-03-29', '10:05:22', 233, 10, 18);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (2, '2025-02-21', '14:58:39', 84, 16, 12);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (3, '2025-02-22', '21:56:25', 37, 5, 19);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (4, '2025-01-12', '10:22:57', 469, 19, 33);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (5, '2025-02-28', '23:22:04', 23, 3, 10);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (6, '2025-01-02', '01:16:07', 64, 6, 6);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (7, '2025-02-12', '15:35:46', 133, 15, 32);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (8, '2025-01-26', '20:18:11', 120, 14, 7);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (9, '2025-01-21', '05:03:39', 396, 13, 45);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (10, '2025-01-27', '19:21:56', 465, 20, 37);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (11, '2025-02-07', '14:11:00', 57, 20, 23);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (12, '2025-02-26', '12:10:07', 549, 19, 32);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (13, '2025-01-24', '00:39:32', 123, 15, 16);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (14, '2025-02-07', '21:26:24', 34, 3, 26);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (15, '2025-03-20', '19:45:19', 505, 12, 21);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (16, '2025-03-05', '00:15:34', 298, 7, 40);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (17, '2025-01-07', '04:08:00', 88, 11, 19);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (18, '2025-02-14', '11:29:37', 390, 3, 41);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (19, '2025-02-06', '19:19:23', 253, 18, 35);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (20, '2025-02-09', '23:23:16', 394, 17, 50);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (21, '2025-02-07', '19:21:00', 672, 19, 40);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (22, '2025-02-14', '17:44:23', 293, 18, 26);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (23, '2025-03-11', '11:10:21', 581, 12, 47);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (24, '2025-02-23', '10:12:35', 652, 5, 24);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (25, '2025-01-27', '01:16:11', 379, 17, 16);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (26, '2025-03-26', '19:45:54', 674, 2, 30);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (27, '2025-02-08', '19:53:05', 348, 1, 20);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (28, '2025-02-24', '08:11:05', 199, 4, 23);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (29, '2025-03-23', '01:09:57', 179, 16, 33);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (30, '2025-02-13', '15:46:53', 442, 16, 16);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (31, '2025-01-02', '23:12:39', 627, 20, 3);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (32, '2025-03-30', '21:53:55', 3, 2, 45);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (33, '2025-02-23', '05:46:09', 317, 6, 9);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (34, '2025-03-28', '18:12:48', 393, 20, 1);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (35, '2025-01-27', '20:17:27', 427, 17, 29);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (36, '2025-01-15', '20:45:28', 400, 2, 26);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (37, '2025-03-12', '14:50:26', 464, 2, 14);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (38, '2025-01-27', '19:23:29', 651, 9, 48);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (39, '2025-02-21', '19:02:36', 407, 3, 31);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (40, '2025-02-28', '21:34:37', 413, 12, 47);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (41, '2025-03-01', '02:03:22', 523, 2, 7);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (42, '2025-01-13', '03:40:15', 494, 8, 43);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (43, '2025-01-04', '21:25:12', 612, 19, 11);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (44, '2025-03-17', '22:37:59', 376, 3, 6);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (45, '2025-02-20', '01:28:21', 470, 16, 12);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (46, '2025-02-13', '03:20:06', 119, 2, 2);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (47, '2025-01-19', '21:07:48', 327, 15, 44);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (48, '2025-01-26', '12:48:48', 675, 8, 49);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (49, '2025-03-05', '11:12:49', 80, 4, 6);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (50, '2025-03-23', '09:31:18', 674, 10, 10);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (51, '2025-03-30', '08:10:31', 616, 2, 20);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (52, '2025-01-12', '08:41:23', 235, 4, 30);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (53, '2025-01-15', '06:01:49', 680, 18, 28);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (54, '2025-02-27', '19:32:11', 112, 20, 41);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (55, '2025-03-29', '21:00:12', 632, 9, 40);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (56, '2025-03-26', '06:33:18', 260, 15, 41);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (57, '2025-02-01', '10:23:16', 217, 2, 12);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (58, '2025-03-25', '11:06:18', 46, 1, 22);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (59, '2025-02-13', '16:57:50', 622, 14, 8);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (60, '2025-01-01', '05:46:58', 551, 3, 34);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (61, '2025-03-08', '05:40:25', 217, 7, 16);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (62, '2025-03-16', '13:19:50', 23, 3, 43);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (63, '2025-03-17', '07:49:11', 42, 9, 48);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (64, '2025-03-25', '09:06:18', 335, 6, 20);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (65, '2025-02-05', '03:56:53', 535, 14, 49);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (66, '2025-01-22', '07:49:58', 128, 7, 14);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (67, '2025-01-29', '11:20:06', 285, 10, 26);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (68, '2025-01-07', '21:13:08', 106, 19, 49);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (69, '2025-02-08', '02:04:01', 564, 7, 40);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (70, '2025-03-27', '15:49:38', 469, 7, 32);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (71, '2025-03-20', '14:08:36', 608, 9, 38);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (72, '2025-03-19', '02:39:19', 452, 7, 1);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (73, '2025-02-25', '12:25:13', 159, 8, 25);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (74, '2025-02-01', '19:40:43', 129, 20, 11);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (75, '2025-03-14', '07:40:12', 526, 6, 6);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (76, '2025-02-19', '11:12:59', 486, 14, 26);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (77, '2025-02-01', '19:25:00', 87, 3, 19);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (78, '2025-03-28', '03:34:34', 37, 17, 15);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (79, '2025-02-10', '13:14:00', 439, 19, 21);
INSERT INTO InventoryUpdatedHistory (ModifyID, Date, Time, InventoryID, SupplierID, EmployeeID) VALUES (80, '2025-03-26', '23:45:51', 56, 9, 38);


INSERT INTO Contains (PromoID, ProductID) VALUES
 (1, 101),  
 (1, 102),  
 (1, 103),  
 (1, 104),  
 (1, 105),  
 (1, 106),  
 (1, 107),  
 (1, 108),
 (2, 201),  
 (2, 202),  
 (2, 203),  
 (2, 204),
 (2, 205),  
 (2, 206),  
 (2, 207),
 (3, 301),  
 (3, 302),  
 (3, 303),  
 (3, 304),
 (3, 305),  
 (3, 306),  
 (3, 307),  
 (3, 308),
 (4, 401),  
 (4, 402),  
 (4, 403),  
 (4, 404),
 (4, 405),  
 (4, 406),  
 (4, 407),
 (1, 109),  
 (2, 208),  
 (4, 408);



