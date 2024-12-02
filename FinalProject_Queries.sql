-- Query 2: Return names of all art pieces made by Picasso
SELECT
	Title
FROM
	ART_OBJECTS
WHERE
	Artist = 'Pablo Picasso';
    
-- Query 3: Return name and cost of all permanent items
SELECT
	Title,
    Cost AS $
FROM
	ART_OBJECTS, PERMANENT
WHERE
	ART_OBJECTS.ArtID = PERMANENT.ArtID
ORDER BY
	Cost ASC;
    
-- Query 4: Return oldest and youngest artist names and birthdates in the database
SELECT
	AName AS Artist,
    Date_born
FROM
	ARTIST
WHERE 
	(Date_born = (
    SELECT
		Max(Date_born)
	FROM
		ARTIST) 
	OR 
    Date_born = (
    SELECT
		Min(Date_born)
	FROM
		ARTIST));
        
-- Query 5: Return all sculptures with their names, dimensions, and artists
SELECT
	Title AS Sculpture_Name, 
    Height_Centimeters,
    Weight_Kilograms,
    Artist
FROM
	(ART_OBJECTS JOIN SCULPTURE ON ART_OBJECTS.ArtID = SCULPTURE.ArtID);

-- Query 5 (Extra for fun): Return all paintings with their names, dimensions, and artists
SELECT
	Title AS Painting_Name, 
    Paint_type,
    Drawn_on,
    Artist
FROM
	(ART_OBJECTS JOIN PAINTING ON ART_OBJECTS.ArtID = PAINTING.ArtID)
WHERE
	Drawn_on = 'Wood' OR Drawn_on = 'Oak';
    
-- Query 6: Will not allow changing permanent item's cost below 10000 dollars in value
DROP TRIGGER IF EXISTS Check_Value_Before_Update;

DELIMITER //

CREATE TRIGGER Check_Value_Before_Update
BEFORE UPDATE ON PERMANENT
FOR EACH ROW
BEGIN

	IF NEW.Cost < 10000 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "This isn't a charity. Value is too low";
	END IF;
END; //

DELIMITER ;

UPDATE PERMANENT
SET Cost = 8000
WHERE PERMANENT.ArtID = '50.145.24';

-- Query 7: Will not allow user to delete any objects made by Picasso 
DROP TRIGGER IF EXISTS Prevent_Picasso_Deletion;
DELIMITER //

CREATE TRIGGER Prevent_Picasso_Deletion
BEFORE DELETE ON ART_OBJECTS
FOR EACH ROW
BEGIN

	IF OLD.Artist = 'Pablo Picasso' THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "We don't direspect Picasso like that";
	END IF;
END; //

DELIMITER ;

-- To test this Delete operation, you must first comment out the UPDATE PERMANENT operation in Query 6

DELETE
FROM ART_OBJECTS
WHERE ArtID = '31.63.1973';
