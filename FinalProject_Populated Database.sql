DROP DATABASE IF EXISTS ARTSMUSEUM ;
CREATE DATABASE ARTSMUSEUM; 
USE ARTSMUSEUM;

DROP TABLE IF EXISTS ARTIST;
CREATE TABLE ARTIST(
	AName					varchar(100) not null,
    Epoch					varchar(50),
    Date_born				date,
    Date_died				date,
    ADescription			varchar(1000),
    Main_style				varchar(80),
    Origin_Country			varchar(100),
    primary key (AName)
    );
    
INSERT INTO ARTIST(AName, Epoch, Date_born, Date_died, ADescription, Main_Style, Origin_Country)
VALUES
('Hans Holbein the Younger', 'Renaissance', '1497-10-07', '1543-11-29', 'A German-Swiss painter and printmaker who worked in a Northern Renaissance style, and is considered one of the greatest portraitists of the 16th century.', 'Baroque', 'Germany'),
('Pietro Torrigiano', 'Renaissance', '1472-11-24', '1528-08-18', "Pietro Torrigiano was an Italian Renaissance sculptor from Florence, who had to flee the city after breaking Michelangelo's nose.", 'Realism', 'Italy'),
('Marcus Gheeraerts the Younger', 'Renaissance', '1561-12-23', '1636-01-19', 'He was brought to England as a child by his father Marcus Gheeraerts the Elder, also a painter', 'Realism', 'Belgium'),
('Pablo Picasso', 'Modern', '1881-10-25', '1973-04-08', 'Pablo Ruiz Picasso was a Spanish painter, sculptor, printmaker, ceramicist, and theatre designer who spent most of his adult life in France.', 'Cubism', 'Spain'),
('Antonio Leonelli', 'Renaissance', '1438-01-23', '1525-02-27', 'Antonio Leonelli or Antonio da Crevalcore was an Italian painter, mainly of still-life painting and some sacred subjects', 'Naturalism', 'Italy'),
('Jefferson D. Chalfant', 'Modern', '1856-11-06', '1931-02-03', "Jefferson David Chalfant (November 6, 1856 – February 3, 1931) was an American painter who is remembered mostly for his trompe-l'œil still life paintings", 'Realism', 'America'),
('Simone Martini', 'Gothic', '1284-12-13', '1344-07-15', 'Simone Martini was an Italian painter born in Siena. He was a major figure in the development of early Italian painting and greatly influenced the development of the International Gothic style', 'International Gothic', 'Italy'),
('Limbourg Brothers', 'Gothic', null, null, 'The Limbourg brothers were Dutch miniature painters (Herman, Paul, and Jean) from the city of Nijmegen. They were active in the early 15th century in France and Burgundy, working in the International Gothic style', 'International Gothic', 'Netherlands'),
('Jean-Baptiste Greuze', 'Rococo', '1725-09-21', '1805-03-21', 'Greuze began his formal training at the Royal Academy of Painting and Sculpture in Paris. His career flourished in the mid-18th century, particularly after he gained fame with works that depicted sentimental and moral themes', 'Neoclassical', 'France'),
('Jacques-Louis David', 'Neoclassical', '1748-08-30', '1825-12-29', 'Jacques-Louis David was a leading figure in the Neoclassical movement, deeply influenced by the ideals of the French Revolution. His works often conveyed themes of virtue, sacrifice, and patriotism, aligning with the values of his time', 'Neoclassical', 'France'),
('Hyacinthe Rigaud', 'Baroque', '1659-07-18', '1743-12-29', 'Catalan-French baroque painter most famous for his portraits of Louis XIV and other members of the French nobility', 'Baroque', 'France'); 

DROP TABLE IF EXISTS EXHIBITION;
CREATE TABLE EXHIBITION(
	EName					varchar(300) not null,
    Start_date				date,
    End_date				date,
    primary key (EName)
    );

INSERT INTO EXHIBITION(EName, Start_date, End_Date)
VALUES
('The Tudors: Art and Majesty in Renaissance England', '2022-10-10', '2023-01-08'),
("Cubism and the Trompe l'Oeil Tradition", '2022-10-20', '2023-01-22'),
('Siena: The Rise of Painting, 1300–1350', '2024-10-13', '2025-01-26');

DROP TABLE IF EXISTS ART_OBJECTS;
CREATE TABLE ART_OBJECTS(
	Artist					varchar(100),
	Title					varchar(150),
	ArtID					varchar(80) not null,
    Epoch			        varchar(50),
    Year_of_Object			integer,
    Description_of_Object	varchar(1000),
    Origin_Culture			varchar(50),
    Exhibition_name			varchar(300),
	primary key (ArtID),
    foreign key (Artist) references ARTIST(AName),
    foreign key (Exhibition_name) references EXHIBITION(EName)
);

INSERT INTO ART_OBJECTS(Artist, Title, ArtID, Epoch, Year_of_Object, Description_of_Object, Origin_Culture, Exhibition_name)
VALUES
(null, "Field Armor of king Henry VII of England", '32.130.7a–l', 'Renaissance', 1544, 'This impressive armor was made for Henry VIII (reigned 1509–47) toward the end of his life, when he was overweight and crippled with gout. Constructed for use both on horse and on foot, it was probably worn by the king during his last military campaign, the siege of Boulogne in 1544, which he commanded personally in spite of his infirmities', 'Italian', 'The Tudors: Art and Majesty in Renaissance England'),
('Hans Holbein the Younger', 'Armor Garniture, Probably of King Henry VIII', '19.131.1a-r', 'Renaissance', 1527, 'This is the earliest dated armor from the royal workshops at Greenwich, which were established in 1515 by Henry VIII (reigned 1509–47) to produce armors for himself and his court.', 'British', 'The Tudors: Art and Majesty in Renaissance England'),
('Pietro Torrigiano', 'Bust of John Fisher, Bishop of Rochester', '36.69', 'Renaissance', 1510, "The subject was traditionally identified as John Fisher, Bishop of Rochester and confessor to Henry VIII's first queen, Catherine of Aragon, but the identification has been increasingly called into question.", 'British', 'The Tudors: Art and Majesty in Renaissance England'),
(null, 'Bearing Cloth', '2016.526', 'Renaissance', 1600, 'This magnificent satin embellished with a broad border of elaborate, ornamental embroidery was almost certainly a bearing cloth', 'British', 'The Tudors: Art and Majesty in Renaissance England'),
('Hans Holbein the Younger', 'Portrait of a Man in Royal Livery', '50.145.24', 'Renaissance', 1535, 'The man in this portrait wears English royal livery, a uniform consisting of a red cap and coat embroidered with Henry VIII’s initials (HR)', 'German', 'The Tudors: Art and Majesty in Renaissance England'),
('Marcus Gheeraerts the Younger', 'Ellen Maurice', '2017.249', 'Renaissance', 1597, "Ellen (Welsh: Elin) Maurice was an heiress claiming direct descent from the ancient princes of Wales. In the sixteenth century, the Welsh gentry, unlike their Irish counterparts, largely embraced the Protestant Reformation and the ascendance of the (originally Welsh) Tudor dynasty", 'Flemish', 'The Tudors: Art and Majesty in Renaissance England'),
('Pablo Picasso', 'The Absinthe Glass', '31.63.1973', 'Modern', 1914, 'Cast in bronze in an edition of six, and then hand-painted, none of the finished works is colored green, so it was clearly not absinthe’s distinctive color that inspired Picasso', 'French', "Cubism and the Trompe l'Oeil Tradition"),
('Pablo Picasso', 'Glass and Die', '39.67.1973', 'Modern', 1914, "Decorative pattern thus supersedes realism in this exercise in trompe l’esprit (fool the mind). A jutting nail—a motif represented in countless trompe l’oeil paintings", 'French', "Cubism and the Trompe l'Oeil Tradition"),
('Antonio Leonelli', 'Still Life with Grapes and a Bird', 'L.2016.26', 'Renaissance', 1506, 'This sort of classically-inspired picture appealed to erudite patrons such as Isabella d’Este (1474–1539), marchioness of Mantua', 'Italian', "Cubism and the Trompe l'Oeil Tradition"),
('Jefferson D. Chalfant', 'Which is Which?', '817.15.1931', 'Modern', 1890, 'Chalfant pasted a U.S. stamp onto canvas and placed next to it a hand-painted double, with identical sawtooth edges and paper-thin relief', 'American', "Cubism and the Trompe l'Oeil Tradition"),
(null, 'Dessert Plate', '14.31.1735', 'Rococo', 1774, 'Typically, the miniature faux prints depict landscapes with buildings and tiny figures; delicately executed cast shadows make the paper appear to lift', 'French', "Cubism and the Trompe l'Oeil Tradition"),
(null, 'Coffee Pot', '15.32.1750', 'Rococo', 1780, 'The trompe l’oeil motif of a print attached to wood planking by nails or sealing wax became so popular that during the second half of the eighteenth century many factories imitated it on tableware', 'Belgian', "Cubism and the Trompe l'Oeil Tradition"),
('Simone Martini', 'Saint Andrew', '41.100.23', 'Gotchic', 1326, 'This panel is from an important five-part portable altarpiece that was possibly commissioned by the governing body of the city of Siena', 'Italian', 'Siena: The Rise of Painting, 1300–1350'),
('Simone Martini', 'Saint Ansansus', '1975.1.13', 'Gotchic', 1326, 'Ansanus is the city’s patron saint and holds its black and white banner. The format of the polyptych was highly unusual in that the central image', 'Italian', 'Siena: The Rise of Painting, 1300–1350'),
('Limbourg Brothers', 'The Belles Heures of Jean de Franc duc de Berry', '54.1.1a,b', 'Gothic', 1409, 'Commissioned by Jean de France, duc de Berry from the Limbourg brothers, the most gifted artists of their time, it is the only manuscript completed by them in its entirety', 'French', 'Siena: The Rise of Painting, 1300–1350'),
(null, 'Box with Romance Scenes', '17.190.173a,b;1988.16', 'Gothic', 1330, 'The lid represents the assault on the metaphorical fortress, Castle of Love, with a tournament and knights catapulting roses', 'French', 'Siena: The Rise of Painting, 1300–1350'),
(null, 'Panel of Velvet', '46.156.72', 'Late Medieval', 1356, 'Imported Middle Eastern textiles were highly valued luxury goods during this period, and this velvet pattern was originally the product of the Persian workshops of Tabriz', 'Iranian', 'Siena: The Rise of Painting, 1300–1350'),
('Jean-Baptiste Greuze', 'Septimius Severus and Caracalla', 'INV 5031', 'Baroque', 1769, 'The artist wished to be recognized as a history painter; he chose an obscure subject to illustrate: Septimius Severus Roman emperor reproaches his son, Caracalla for trying to assassinate him. Varied emotions are at work within it', 'French', null),
('Jacques-Louis David', 'The Oath of Horatii', 'INV 3692', 'Neoclassical', 1784, 'It depicts three men, brothers, saluting toward three swords held up by their father as the women behind him grieve', 'French', null),
('Jacques-Louis David', 'Les Sabines', 'INV 3691', 'Neoclassical', 1799, 'The painting captures a dramatic scene from Roman mythology, where Romulus, the founder of Rome, and his men, abduct the Sabine women. It depicts the chaotic struggle between the Romans and the Sabines', 'French', null),
(null, 'Bust of Marcus Aurelius', 'MR 559', 'Ancient', 180, 'A portrait statue of prominent Roman leader Marcus Aurelius in the trademark Greco-Roman design', 'Roman', null),
(null, 'Statue of Tiy and Amenhotep III', 'N 2312', 'Ancient', -1390, 'The statue portrays Queen Tiy, seated alongside her husband Amenhotep III. The figures are often highlighted for their regal posture and detailed expression', 'Egyptian', null),
('Hyacinthe Rigaud', 'Louis XIV, King of France (1638-1715)', 'INV 7492', 'Baroque', 1701, 'This portrait is considered the most recognizable portrait of Louis XIV. It depicts the king in his coronation robes, wearing a large red and gold curtain, a heavy cape, and his wig', 'French', null);

DROP TABLE IF EXISTS PAINTING;
CREATE TABLE PAINTING(
	ArtID					varchar(60) not null,
    Paint_type				varchar(50),
    Style					varchar(50),
    Drawn_on				varchar(30),
    primary key (ArtID),
    foreign key (ArtID) references ART_OBJECTS(ArtID)
);

INSERT INTO PAINTING(ArtID, Paint_type, Style, Drawn_on)
VALUES
('50.145.24', 'Oil', 'Baroque', 'Parchment'),
('2017.249', 'Oil', 'Realism', 'Oak'),
('L.2016.26', 'Oil', 'Naturalism', 'Canvas'),
('817.15.1931', 'Oil', 'Realism', 'Wood'),
('41.100.23', 'Tempera', 'International Gothic', 'Wood'),
('1975.1.13', 'Tempera', 'International Gothic', 'Wood'),
('INV 5031', 'Oil', 'Neoclassical', 'Canvas'),
('INV 3692', 'Oil', 'Neoclassical', 'Canvas'),
('INV 3691', 'Oil', 'Neoclassical', 'Canvas'),
('INV 7492', 'Oil', 'Baroque', 'Canvas');

DROP TABLE IF EXISTS SCULPTURE;
CREATE TABLE SCULPTURE(
	ArtID					varchar(60) not null,
    Material				varchar(30),
    Height_Centimeters		float,
    Weight_Kilograms		float,
    Style					varchar(50),
    primary key (ArtID),
    foreign Key (ArtID) references ART_OBJECTS(ArtID)
    );

INSERT INTO SCULPTURE(ArtID, Material, Height_Centimeters, Weight_Kilograms, Style)
VALUES
('36.69', 'Polychrome Terracotta', 61.6, 28.1, 'Realism'),
('31.63.1973', 'Tin', 22.5, 5.0, 'Cubism'),
('39.67.1973', 'Wood', 23.5, 3.22, 'Cubism'),
('17.190.173a,b;1988.16', 'Elephant Ivory', 10.9, 1.454, 'International Gothic');

DROP TABLE IF EXISTS STATUE;
CREATE TABLE STATUE(
	ArtID					varchar(60) not null,
    Material				varchar(30),
    Height_Centimeters		float,
    Weight_Kilograms		float,
    Style					varchar(50),
    primary key (ArtID),
    foreign Key (ArtID) references ART_OBJECTS(ArtID)
    );
    
INSERT INTO STATUE(ArtID, Material, Height_Centimeters, Weight_Kilograms, Style)
VALUES
('19.131.1a-r', 'Steel', 185.4, 28.45, 'Baroque'),
('MR 559', 'Marble', 108.0, 233.0, 'Greco-Roman'),
('N 2312', 'Steatite', 29.0, 3.947, 'Realism');


DROP TABLE IF EXISTS OTHER;
CREATE TABLE OTHER(
	ArtID					varchar(60) not null,
    Style					varchar(50),
    Art_Type				varchar(30),
    primary key (ArtID),
    foreign key (ArtID) references ART_OBJECTS(ArtID)
    );
    
INSERT INTO OTHER(ArtID, Style, Art_Type)
VALUES
('32.130.7a–l', 'Baroque', 'Armor for Man'),
('2016.526', 'Baroque', 'Textile'),
('14.31.1735', 'Rococo', 'Ceramic'),
('15.32.1750', 'Rococo', 'Ceramic'),
('54.1.1a,b', 'International Gothic', 'Manuscripts'),
('46.156.72', 'Persianic', 'Textile');

DROP TABLE IF EXISTS OTHER_COLLECTIONS;
CREATE TABLE OTHER_COLLECTIONS(
	CName					varchar(200) not null,
    Phone_No				varchar(50),
    CDescription			varchar(1000),
    Address					varchar(100),
    CType					varchar(30),
    Contact_person			varchar(50),
    primary key (CName)
    );
    
INSERT INTO OTHER_COLLECTIONS(CName, Phone_No, CDescription, Address, CType, Contact_person)
Values
('Major Events in History','+33 (0)1 40 20 50 50', 'Many works in the collections of the Musée du Louvre depict key moments in the history of humanity. From the entry of Alexander the Great into Babylon to the proclamation of the French Republic, these dramatic moments have become a source of inspiration to many artists', 'Rue de Rivoli, 75001 Paris, France', 'Museum', 'Sebastien Allard'),
('Queens, Kings, and Emperors', '+33 (0)1 40 20 50 50', 'The Musée du Louvre boasts a number of artworks illustrating royal power in all its forms. From objects associated with the Coronation to statues and portraits, kings, queens and emperors succeeded in imposing their image on the people through the arts', 'Rue de Rivoli, 75001 Paris, France', 'Museum', 'Cecile Giroire');

DROP TABLE IF EXISTS BORROWED;
CREATE TABLE BORROWED(
	ArtID					varchar(60) not null,
    Collection_name			varchar(200),
    Date_borrowed			date,
    Date_returned			date,
    primary key (ArtID),
    foreign key (ArtID) references ART_OBJECTS(ArtID),
    foreign key (Collection_name) references OTHER_COLLECTIONS(CName)
    );
    
INSERT INTO BORROWED(ArtID, Collection_name, Date_borrowed, Date_returned)
Values
('INV 5031', 'Major Events in History', '2010-12-02', '2011-02-14'),
('INV 3692', 'Major Events in History', '2010-12-02', '2011-02-14'),
('INV 3691', 'Major Events in History', '2012-11-15', '2015-12-15'),
('MR 559', 'Queens, Kings, and Emperors', '2022-04-06', '2022-07-25'),
('N 2312', 'Queens, Kings, and Emperors', '2022-09-28', '2023-01-23'),
('INV 7492', 'Queens, Kings, and Emperors', '2020-11-17', '2021-06-13');
    
DROP TABLE IF EXISTS PERMANENT;
CREATE TABLE PERMANENT(
	ArtID					varchar(60) not null,
    Cost					decimal(15, 2),
    Date_acquired			date,
    Item_Status				varchar(30),
    primary key (ArtID),
    foreign key (ArtID) references ART_OBJECTS(ArtID)
    );
    
INSERT INTO PERMANENT(ArtID, Cost, Date_acquired, Item_Status)
VALUES
('32.130.7a–l', 1450000, '1919-01-28', 'Stored'),
('19.131.1a-r', 2000000, '1925-06-15', 'Stored'),
('36.69', 135000, '1950-04-30', 'On Display'),
('2016.526', 20000, '1895-05-26', 'On Loan'),
('50.145.24', 80000, '1950-12-22', 'Stored'),
('2017.249', 120000, '1947-03-12', 'On Display'),
('31.63.1973', 1020000, '1923-07-16', 'Stored'),
('39.67.1973', 1320000, '1927-12-27', 'Stored'),
('L.2016.26', 2100000, '1968-07-26', 'On Loan'),
('817.15.1931', 83000, '1937-09-28', 'Stored'),
('14.31.1735', 14000, '1947-05-04', 'Stored'),
('15.32.1750', 19000, '1953-10-13', 'Stored'),
('41.100.23', 580000, '1947-04-05', 'On Display'),
('1975.1.13', 430000, '1924-12-23', 'On Display'),
('54.1.1a,b', 730000, '1934-05-24', 'On Display'),
('17.190.173a,b;1988.16', 230000, '1964-04-08', 'On Display'),
('46.156.72', 42000, '1907-09-12', 'On Display');
