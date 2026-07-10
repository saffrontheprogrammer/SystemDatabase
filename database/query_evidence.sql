-- This file demonstrates CRUD testing, LIKE, JOINs, statistics, update and delete functionality.

PRAGMA foreign_keys = ON;


-- ─────────────────────────────────────────────────────────────
-- READ:
--
-- 1. View all players
-- Demonstrates SELECT/read functionality at a basic level.
-- ─────────────────────────────────────────────────────────────

SELECT 
    PlayerID,
    Email,
    DisplayName,
    DateCreated
FROM Player;


-- ─────────────────────────────────────────────────────────────
-- READ:
--
-- 2. Views all characters with player, class, species and alignment.
-- Demonstrates JOINs involving multiple tables.
-- ─────────────────────────────────────────────────────────────

SELECT
    c.CharacterID,
    c.CharacterName,
    c.CharacterType,
    p.DisplayName AS PlayerName,
    p.Email AS PlayerEmail,
    cc.ClassName,
    s.SpeciesName,
    a.AlignmentName,
    c.Level
FROM Character c
JOIN Player p ON c.PlayerID = p.PlayerID
JOIN CharacterClass cc ON c.ClassID = cc.ClassID
JOIN Species s ON c.SpeciesID = s.SpeciesID
JOIN Alignment a ON c.AlignmentID = a.AlignmentID
ORDER BY c.CharacterName;


-- ─────────────────────────────────────────────────────────────
-- LIKE:
--
-- 1. Find characters with names containing "thorn"
-- Demonstrates pattern matching using LIKE.
-- ─────────────────────────────────────────────────────────────

SELECT
    CharacterID,
    CharacterName,
    Level
FROM Character
WHERE CharacterName LIKE '%thorn%';


-- ─────────────────────────────────────────────────────────────
-- LIKE:
--
-- 2. Find items containing "Sword"
-- Demonstrates another LIKE query on item data.
-- ─────────────────────────────────────────────────────────────

SELECT
    i.ItemID,
    i.ItemName,
    it.TypeName,
    r.RarityName
FROM Item i
JOIN ItemType it ON i.ItemTypeID = it.ItemTypeID
JOIN Rarity r ON i.RarityID = r.RarityID
WHERE i.ItemName LIKE '%Sword%';


-- ─────────────────────────────────────────────────────────────
-- JOIN:
--
-- 1. Show character inventories
-- Demonstrates items linked to characters through Inventory.
-- ─────────────────────────────────────────────────────────────

SELECT
    c.CharacterName,
    i.ItemName,
    it.TypeName AS ItemType,
    r.RarityName,
    inv.Quantity
FROM Inventory inv
JOIN Character c ON inv.CharacterID = c.CharacterID
JOIN Item i ON inv.ItemID = i.ItemID
JOIN ItemType it ON i.ItemTypeID = it.ItemTypeID
JOIN Rarity r ON i.RarityID = r.RarityID
ORDER BY c.CharacterName, i.ItemName;


-- ─────────────────────────────────────────────────────────────
-- JOIN:
--
-- 2. Show quest progress for characters
-- Demonstrates quests linked to characters through CharacterQuest.
-- ─────────────────────────────────────────────────────────────

SELECT
    c.CharacterName,
    q.QuestName,
    rg.RegionName,
    d.DifficultyName,
    cq.CompletionDate
FROM CharacterQuest cq
JOIN Character c ON cq.CharacterID = c.CharacterID
JOIN Quest q ON cq.QuestID = q.QuestID
JOIN Region rg ON q.RegionID = rg.RegionID
JOIN Difficulty d ON q.DifficultyID = d.DifficultyID
ORDER BY q.QuestName, c.CharacterName;


-- ─────────────────────────────────────────────────────────────
-- STATISTICS:
--
-- 1. Count characters by class
-- Demonstrates COUNT and GROUP BY.
-- ─────────────────────────────────────────────────────────────

SELECT
    cc.ClassName,
    COUNT(c.CharacterID) AS TotalCharacters
FROM Character c
JOIN CharacterClass cc ON c.ClassID = cc.ClassID
GROUP BY cc.ClassName
ORDER BY TotalCharacters DESC;


-- ─────────────────────────────────────────────────────────────
-- STATISTICS:
--
-- 2. Average character level
-- Demonstrates AVG function.
-- ─────────────────────────────────────────────────────────────

SELECT
    ROUND(AVG(Level), 2) AS AverageCharacterLevel
FROM Character;


-- ─────────────────────────────────────────────────────────────
-- STATISTICS:
--
-- 3. Count quests by difficulty
-- Demonstrates COUNT and GROUP BY on quests.
-- ─────────────────────────────────────────────────────────────

SELECT
    d.DifficultyName,
    COUNT(q.QuestID) AS TotalQuests
FROM Quest q
JOIN Difficulty d ON q.DifficultyID = d.DifficultyID
GROUP BY d.DifficultyName
ORDER BY TotalQuests DESC;


-- ─────────────────────────────────────────────────────────────
-- CREATE:
--
-- 1. Insert a new player
-- Demonstrates CREATE functionality.
-- ─────────────────────────────────────────────────────────────

INSERT INTO Player (Email, DisplayName, DateCreated)
VALUES ('test.player@example.com', 'Test Player', CURRENT_TIMESTAMP);

SELECT * 
FROM Player
WHERE Email = 'test.player@example.com';


-- ─────────────────────────────────────────────────────────────
-- CREATE:
--
-- 2.Insert a new character linked to the test player
-- Demonstrates creating a character with foreign keys.
-- ─────────────────────────────────────────────────────────────

INSERT INTO Character (
    PlayerID,
    CharacterName,
    CharacterType,
    ClassID,
    SpeciesID,
    AlignmentID,
    Level
)
VALUES (
    (SELECT PlayerID FROM Player WHERE Email = 'test.player@example.com'),
    'Test Character',
    'Player',
    (SELECT ClassID FROM CharacterClass WHERE ClassName = 'Warrior'),
    (SELECT SpeciesID FROM Species WHERE SpeciesName = 'Human'),
    (SELECT AlignmentID FROM Alignment WHERE AlignmentName = 'Lawful Good'),
    1
);

SELECT
    c.CharacterName,
    p.DisplayName,
    c.CharacterType,
    c.Level
FROM Character c
JOIN Player p ON c.PlayerID = p.PlayerID
WHERE c.CharacterName = 'Test Character';


-- ─────────────────────────────────────────────────────────────
-- UPDATE: Update an existing character level
-- Demonstrates UPDATE functionality.
-- ─────────────────────────────────────────────────────────────

UPDATE Character
SET Level = 2
WHERE CharacterName = 'Test Character';

SELECT
    CharacterName,
    Level
FROM Character
WHERE CharacterName = 'Test Character';


-- ─────────────────────────────────────────────────────────────
-- DELETE: Delete the test character
-- Demonstrates DELETE functionality.
-- ─────────────────────────────────────────────────────────────

DELETE FROM Character
WHERE CharacterName = 'Test Character';

SELECT
    CharacterName
FROM Character
WHERE CharacterName = 'Test Character';


-- ─────────────────────────────────────────────────────────────
-- DELETE:
--
-- 2. Delete the test player
-- Demonstrates DELETE functionality and keeps test data looking clean.
-- ─────────────────────────────────────────────────────────────

DELETE FROM Player
WHERE Email = 'test.player@example.com';

SELECT
    Email,
    DisplayName
FROM Player
WHERE Email = 'test.player@example.com';