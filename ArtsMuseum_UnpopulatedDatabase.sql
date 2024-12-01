DROP DATABASE IF EXISTS ARTSMUSEUM ;
CREATE DATABASE ARTSMUSEUM; 
USE ARTSMUSEUM;

DROP TABLE IF EXISTS ARTIST;
CREATE TABLE ARTIST(
	Aname					varchar(50) not null,
    Epoch					varchar(50),
    Date_born				timestamp,
    Date_died				timestamp,
    ADescription			varchar(300),
    Main_style				varchar(30),
    Origin_Country			varchar(30),
    primary key (Aname)
    );
    
DROP TABLE IF EXISTS EXHIBITION;
CREATE TABLE EXHIBITION(
	Ename					varchar(80) not null,
    Start_date				timestamp,
    End_date				timestamp,
    primary key (Ename)
    );
    
DROP TABLE IF EXISTS ART_OBJECTS;
CREATE TABLE ART_OBJECTS(
	Artist					varchar(60),
	Title					varchar(60),
	ArtID					integer not null,
    Epoch			        varchar(50),
    Year_of_Object			integer,
    Description_of_Object	varchar(300),
    Origin_Culture			varchar(50),
    Exhibition_name			varchar(80),
	primary key (ArtID),
    foreign key (Artist) references ARTIST(AName),
    foreign key (Exhibition_name) references EXHIBITION(EName)
);

DROP TABLE IF EXISTS PAINTING;
CREATE TABLE PAINTING(
	ArtID					integer not null,
    Paint_type				varchar(50),
    Style					varchar(50),
    Drawn_on				varchar(30),
    primary key (ArtID),
    foreign key (ArtID) references ART_OBJECTS(ArtID)
);

DROP TABLE IF EXISTS SCULPTURE_OR_STATUE;
CREATE TABLE SCULPTURE_OR_STATUE(
	ArtID					integer not null,
    Material				varchar(30),
    Height_Centimeters		float,
    Weight_Kilograms		float,
    Style					varchar(50),
    primary key (ArtID),
    foreign Key (ArtID) references ART_OBJECTS(ArtID)
    );

DROP TABLE IF EXISTS OTHER;
CREATE TABLE OTHER(
	ArtID					integer not null,
    Style					varchar(50),
    Art_Type				varchar(30),
    primary key (ArtID),
    foreign key (ArtID) references ART_OBJECTS(ArtID)
    );

DROP TABLE IF EXISTS OTHER_COLLECTIONS;
CREATE TABLE OTHER_COLLECTIONS(
	CName					varchar(50) not null,
    Phone_No				varchar(30),
    CDescription			varchar(300),
    Address					varchar(100),
    CType					varchar(30),
    Contact_person			varchar(50),
    primary key (CName)
    );

DROP TABLE IF EXISTS BORROWED;
CREATE TABLE BORROWED(
	ArtID					integer not null,
    Collection_name			varchar(50),
    Date_borrowed			timestamp,
    Date_returned			timestamp,
    primary key (ArtID),
    foreign key (ArtID) references ART_OBJECTS(ArtID),
    foreign key (Collection_name) references OTHER_COLLECTIONS(CName)
    );
    
DROP TABLE IF EXISTS PERMANENT;
CREATE TABLE PERMANENT(
	ArtID					integer not null,
    Cost					decimal(15, 2),
    Date_aquired			timestamp,
    Item_Status				varchar(30),
    primary key (ArtID),
    foreign key (ArtID) references ART_OBJECTS(ArtID)
    );


    


    