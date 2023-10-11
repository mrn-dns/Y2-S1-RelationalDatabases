
DROP TABLE IF EXISTS prize;
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS map;
DROP TABLE IF EXISTS place;
DROP TABLE IF EXISTS tournament;
DROP TABLE IF EXISTS passport;
DROP TABLE IF EXISTS idcard; 
DROP TABLE IF EXISTS player;
DROP TABLE IF EXISTS team;

CREATE TABLE tournament
(
	tournamentID INT(10) PRIMARY KEY AUTO_INCREMENT,
    tournamentName VARCHAR(50) NOT NULL,
    location VARCHAR(30) NOT NULL,
    tournamentDate DATE NOT NULL,
    prizeAmount INT(7) NOT NULL,
    fee INT(4) NOT NULL
);

CREATE TABLE prize
(
	prizeID INT(10) PRIMARY KEY AUTO_INCREMENT,
    amount INT(10) NOT NULL,
    dscp CHAR(50) NOT NULL,
    lvl INT(1) NOT NULL,
    trnID INT(10),
    FOREIGN KEY fk_trnm(trnID) REFERENCES
    tournament(tournamentID)
);

CREATE TABLE team
(
	teamID INT(7) PRIMARY KEY AUTO_INCREMENT,
    teamName CHAR(10) NOT NULL,
    country CHAR(20) NOT NULL,
    ranking INT(4) NOT NULL,
    earnings INT(8) NOT NULL,
    noOfMatches INT(5) NOT NULL
);

CREATE TABLE place
(
	pos INT(2) PRIMARY KEY,
    trnID INT(10) NOT NULL,
    tmID INT(7) NOT NULL,
    FOREIGN KEY fk_trnm(trnID) REFERENCES
    tournament(tournamentID),
    FOREIGN KEY fk_team(tmID) REFERENCES
	team(teamID)
);

CREATE TABLE map
(
	mapID INT(7) PRIMARY KEY AUTO_INCREMENT,
    mapName CHAR(15) NOT NULL,
    dscp CHAR(100) NOT NULL,
    creator CHAR(20) NOT NULL,
    trnID INT(10) NOT NULL,
    FOREIGN KEY fk_trnm(trnID) REFERENCES
    tournament(tournamentID)
);

CREATE TABLE matches
(
	matchID INT(10) PRIMARY KEY AUTO_INCREMENT,
    matchDate DATE NOT NULL,
    trnID INT(10) NOT NULL,
    mapNo INT(7) NOT NULL,
    winner INT(7) NOT NULL,
    FOREIGN KEY fk_trnm(trnID) REFERENCES
    tournament(tournamentID),
    FOREIGN KEY fk_map(mapNo) REFERENCES
    map(mapID),
    FOREIGN KEY fk_team(winner) REFERENCES
	team(teamID)
);

CREATE TABLE player
(
	playerID INT(7) PRIMARY KEY AUTO_INCREMENT,
    fullName CHAR(30) NOT NULL,
    country CHAR(20) NOT NULL,
    nick CHAR(10) NOT NULL,
    inventoryValue FLOAT(8,2),
    hoursPlayed INT(5),
    tmID int(7) NOT NULL,
    FOREIGN KEY fk_team(tmID) REFERENCES
	team(teamID)
);

CREATE TABLE passport
(
	passportNo INT(13) PRIMARY KEY AUTO_INCREMENT,
    placeOfBirth CHAR(20) NOT NULL,
    expiryDate DATE NOT NULL,
    nationality CHAR(10) NOT NULL,
    dob DATE NOT NULL,
    plyID int(7) NOT NULL,
    FOREIGN KEY fk_player(plyID) REFERENCES
    player(playerID)
);

CREATE TABLE idcard
(
	cardNo INT(13) PRIMARY KEY AUTO_INCREMENT,
    homeCity CHAR(20) NOT NULL,
    expiryDate DATE NOT NULL,
    nationality CHAR(10) NOT NULL,
    dob DATE NOT NULL,
    plyID int(7) NOT NULL,
    FOREIGN KEY fk_player(plyID) REFERENCES
    player(playerID)
);

-- adding tournaments
INSERT INTO tournament(tournamentID,tournamentName,location,tournamentDate,prizeAmount,fee)
VALUES (DEFAULT,'DreamHack Open Cluj-Napoca','Cluj-Napoca','2015-10-28',1000000,3500);
    
-- adding teams
INSERT INTO team(teamID,teamName,country,ranking,earnings,noOfMatches)
VALUES
	(DEFAULT,'NAVI','Ukraine',1,88145405,567),
    (DEFAULT,'FaZe','USA',2,5512278,420);
    
-- adding players
INSERT INTO player(playerID,fullName,country,nick,inventoryValue,hoursPlayed,tmID)
VALUES
	-- team1 players
	(DEFAULT,'Oleksandr Kostyliev','Ukraine','s1mple',17654.45,23581,1), -- passport
    (DEFAULT,'Danylo Teslenko','Ukraine','Zeus',1763.22,17443,1), -- idcard
    (DEFAULT,'Egor Vasilyev','Russia','flamie',76.53,11494,1), -- idcard
    (DEFAULT,'Nicolai Reedtz','Denmark','dev1ce',4261.11,13690,1), -- passport
    (DEFAULT,'Robin Kool','Estonia','ropz',325.67,15322,1), -- idcard
    -- team2 players
    (DEFAULT,'Mihail Stolyarov','Russia','Dosia',20.45,19672,2), -- passport
    (DEFAULT,'Kenny Schrub','France','kennyS',3519.22,27512,2), -- idcard
    (DEFAULT,'Dan Madesclaire','France','apEX',1231.55,16922,2), -- passport
    (DEFAULT,'Finn Andersen','Denmark','Karrigan',4566.78,20488,2), -- idcard
    (DEFAULT,'Marcelo David','Brazil','coldzera',1184.26,17284,2); -- passport
    
-- adding idproofs
	-- adding passports
INSERT INTO passport(passportNo,placeOfBirth,expiryDate,nationality,dob,plyID)
VALUES
	(DEFAULT,'Ukraine','2027-05-03','Ukranian','1988-06-27',1),
    (DEFAULT,'Denmark','2028-03-27','Danish','1991-05-22',4),
    (DEFAULT,'Russia','2025-12-12','Russian','1988-02-04',6),
    (DEFAULT,'France','2029-07-05','French','1994-01-16',8),
    (DEFAULT,'Brazil','2023-01-02','Braziian','1989-06-11',10);
    
    -- adding idcards
INSERT INTO idcard(cardNo,homeCity,expiryDate,nationality,dob,plyID)
VALUES
	(DEFAULT,'Kiev','2027-05-04','Ukranian','1987-04-02',2),
    (DEFAULT,'Moscow','2025-03-22','Russian','2000-02-15',3),
    (DEFAULT,'Paris','2023-12-05','French','1994-01-18',7),
    (DEFAULT,'Tallinn','2024-11-14','Estonian','1995-11-07',5),
    (DEFAULT,'Copenhagen;','2023-05-04','Danish','1993-05-06',9);

	-- adding maps
INSERT INTO map(mapID,mapName,dscp,creator,trnID)
VALUES (DEFAULT,'Mirage','Sand blasted and covered resort in the Gobi Desert. The sand offers interesting, varied fights.','Michael Hull',1);

	-- adding matches
INSERT INTO matches(matchID,matchDate,trnID,mapNo,winner)
VALUES
	(DEFAULT, '2015-10-28',1,1,1);
    
	-- adding prizes
INSERT INTO prize(prizeID,amount,dscp,lvl,trnID)
VALUES
	(DEFAULT,20000,'Money Prize',1,1),
    (DEFAULT,5000,'Money Prize',2,1),
    (DEFAULT,2000,'Gaming Gear',3,1);
    
	-- adding places
INSERT INTO place(pos,trnID,tmID)
VALUES (1,1,1),(2,1,2);

