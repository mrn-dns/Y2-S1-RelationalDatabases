-- database select
SELECT DATABASE(); -- used by support team to know what database they are inserting data into 

-- idproof select
SELECT player.fullName, passport.dob FROM player inner join passport ON player.playerID = passport.plyID; -- select players that have passports (used by organizer to register players)
SELECT player.fullName, idcard.dob FROM player inner join idcard ON player.playerID = idcard.plyID; -- select players that have idcards (used by organizer to register players)

-- team select
SELECT player.fullName AS Name,team.teamName AS Team -- displays players from team 1 (used by organizers, team leader,team coach,players and presenters to get information on team 1)
FROM player	
INNER JOIN team
ON player.tmID=team.teamID
WHERE tmID=1;

SELECT player.fullName AS Name,team.teamName AS Team -- displays players from team 2 (used by organizers, team leader,team coach,players and presenters to get information on team 2)
FROM player	
INNER JOIN team
ON player.tmID=team.teamID
WHERE tmID=2;

-- counts
SELECT COUNT(playerID) AS "Number of players" FROM player; -- number of players (used by organizer to keep track of how many people take part in the tournament)
SELECT COUNT(teamID) AS "Number of teams" FROM team; -- number of teams (used by organizer to keep track of how many teams take part in the tournament)

-- inventory select
SELECT AVG(inventoryValue) AS "Average inventory Value" FROM player; -- average inventory value (used by presenters and organizers to create a statistic)
SELECT LOWER(fullName) AS "Player Name",inventoryValue "Inventory Value" -- used lower function on fullName string
FROM player												-- sort inventories by descending value (used by promoters to see who they could sponsor)
ORDER BY inventoryValue DESC;
SELECT UCASE(fullName) AS "Player Name",inventoryValue "Inventory Value" -- used uppercase function on fullName string
FROM player												-- sort inventories by ascending value (used by promoters to see who they could sponsor)
ORDER BY inventoryValue;
SELECT MIN(inventoryValue) FROM player; -- least expensive inventory
SELECT MAX(inventoryValue) FROM player; -- most expensive inventory

-- tournament select
SELECT DATEDIFF('2015-10-28',CURDATE()); -- used by organizers to make sure they organize the tournaments approximately one year apart from eachother (365 days)

SELECT p.pos AS "Position",t.teamName AS "Team Name",p.trnID AS "Tournament" -- displays tournament rankings (used by organizer to know what prize to give each team)
FROM place p
LEFT JOIN team t ON p.tmID = t.teamID;