BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Alignment" (
	"AlignmentID"	INTEGER,
	"AlignmentName"	VARCHAR(50) NOT NULL UNIQUE,
	PRIMARY KEY("AlignmentID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Character" (
	"CharacterID"	INTEGER,
	"PlayerID"	INTEGER NOT NULL,
	"CharacterName"	VARCHAR(100) NOT NULL,
	"CharacterType"	VARCHAR(20) NOT NULL CHECK("CharacterType" IN ('Player', 'Non-Player')),
	"ClassID"	INTEGER NOT NULL,
	"SpeciesID"	INTEGER NOT NULL,
	"AlignmentID"	INTEGER NOT NULL,
	"Level"	INTEGER NOT NULL DEFAULT 1,
	PRIMARY KEY("CharacterID" AUTOINCREMENT),
	FOREIGN KEY("AlignmentID") REFERENCES "Alignment"("AlignmentID"),
	FOREIGN KEY("ClassID") REFERENCES "CharacterClass"("ClassID"),
	FOREIGN KEY("PlayerID") REFERENCES "Player"("PlayerID"),
	FOREIGN KEY("SpeciesID") REFERENCES "Species"("SpeciesID")
);
CREATE TABLE IF NOT EXISTS "CharacterClass" (
	"ClassID"	INTEGER,
	"ClassName"	VARCHAR(50) NOT NULL UNIQUE,
	"Description"	TEXT,
	PRIMARY KEY("ClassID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "CharacterQuest" (
	"CharacterQuestID"	INTEGER,
	"CharacterID"	INTEGER NOT NULL,
	"QuestID"	INTEGER NOT NULL,
	"CompletionDate"	DATETIME,
	PRIMARY KEY("CharacterQuestID" AUTOINCREMENT),
	FOREIGN KEY("CharacterID") REFERENCES "Character"("CharacterID"),
	FOREIGN KEY("QuestID") REFERENCES "Quest"("QuestID")
);
CREATE TABLE IF NOT EXISTS "Difficulty" (
	"DifficultyID"	INTEGER,
	"DifficultyName"	VARCHAR(50) NOT NULL UNIQUE,
	PRIMARY KEY("DifficultyID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Inventory" (
	"InventoryID"	INTEGER,
	"CharacterID"	INTEGER NOT NULL,
	"ItemID"	INTEGER NOT NULL,
	"Quantity"	INTEGER NOT NULL DEFAULT 1,
	PRIMARY KEY("InventoryID" AUTOINCREMENT),
	FOREIGN KEY("CharacterID") REFERENCES "Character"("CharacterID"),
	FOREIGN KEY("ItemID") REFERENCES "Item"("ItemID")
);
CREATE TABLE IF NOT EXISTS "Item" (
	"ItemID"	INTEGER,
	"ItemName"	VARCHAR(100) NOT NULL,
	"ItemTypeID"	INTEGER NOT NULL,
	"RarityID"	INTEGER NOT NULL,
	PRIMARY KEY("ItemID" AUTOINCREMENT),
	FOREIGN KEY("ItemTypeID") REFERENCES "ItemType"("ItemTypeID"),
	FOREIGN KEY("RarityID") REFERENCES "Rarity"("RarityID")
);
CREATE TABLE IF NOT EXISTS "ItemType" (
	"ItemTypeID"	INTEGER,
	"TypeName"	VARCHAR(50) NOT NULL UNIQUE,
	PRIMARY KEY("ItemTypeID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Player" (
	"PlayerID"	INTEGER,
	"Email"	VARCHAR(255) NOT NULL UNIQUE,
	"DisplayName"	VARCHAR(100) NOT NULL,
	"DateCreated"	DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("PlayerID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Quest" (
	"QuestID"	INTEGER,
	"QuestName"	VARCHAR(100) NOT NULL,
	"RegionID"	INTEGER NOT NULL,
	"DifficultyID"	INTEGER NOT NULL,
	PRIMARY KEY("QuestID" AUTOINCREMENT),
	FOREIGN KEY("DifficultyID") REFERENCES "Difficulty"("DifficultyID"),
	FOREIGN KEY("RegionID") REFERENCES "Region"("RegionID")
);
CREATE TABLE IF NOT EXISTS "Rarity" (
	"RarityID"	INTEGER,
	"RarityName"	VARCHAR(50) NOT NULL UNIQUE,
	PRIMARY KEY("RarityID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Region" (
	"RegionID"	INTEGER,
	"RegionName"	VARCHAR(100) NOT NULL UNIQUE,
	PRIMARY KEY("RegionID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Species" (
	"SpeciesID"	INTEGER,
	"SpeciesName"	VARCHAR(50) NOT NULL UNIQUE,
	PRIMARY KEY("SpeciesID" AUTOINCREMENT)
);
INSERT INTO "Alignment" VALUES (1,'Lawful Good');
INSERT INTO "Alignment" VALUES (2,'Moderately Unfair');
INSERT INTO "Alignment" VALUES (3,'Destructively Evil');
INSERT INTO "Character" VALUES (1,1,'Thorin Ironblade','Player',1,3,1,12);
INSERT INTO "Character" VALUES (2,2,'Loretta Fusion','Player',3,1,3,1);
INSERT INTO "Character" VALUES (3,3,'Kaelen Stormhart','Player',2,4,1,7);
INSERT INTO "Character" VALUES (4,4,'Mira Ashvale','Player',5,2,2,4);
INSERT INTO "Character" VALUES (5,1,'Garrick Stonefist','Non-Player',4,5,3,5);
INSERT INTO "Character" VALUES (6,2,'Dorian Blackthorn','Non-Player',1,1,2,20);
INSERT INTO "Character" VALUES (7,3,'Elara Moonwhisper','Player',3,2,1,9);
INSERT INTO "Character" VALUES (8,4,'Brakka Doomfang','Non-Player',2,5,3,14);
INSERT INTO "Character" VALUES (9,1,'Finn Quickstep','Player',5,4,2,6);
INSERT INTO "Character" VALUES (10,2,'Cedric Oakshield','Non-Player',4,3,1,11);
INSERT INTO "CharacterClass" VALUES (1,'Warrior','A powerful melee fighter.');
INSERT INTO "CharacterClass" VALUES (2,'Barbarian','A lawless warrior with no limits.');
INSERT INTO "CharacterClass" VALUES (3,'Sorcerer','A spell casting powerhouse.');
INSERT INTO "CharacterClass" VALUES (4,'Mage','A master of magic who casts powerful spells.');
INSERT INTO "CharacterClass" VALUES (5,'Rogue','A stealthy fighter who relies on speed and trickery');
INSERT INTO "CharacterQuest" VALUES (1,1,1,'2026-01-12 14:30:00');
INSERT INTO "CharacterQuest" VALUES (2,4,1,'2026-01-13 10:15:00');
INSERT INTO "CharacterQuest" VALUES (3,10,1,NULL);
INSERT INTO "CharacterQuest" VALUES (4,9,2,'2026-01-05 09:45:00');
INSERT INTO "CharacterQuest" VALUES (5,2,3,'2026-01-06 11:20:00');
INSERT INTO "CharacterQuest" VALUES (6,4,4,'2026-01-08 16:10:00');
INSERT INTO "CharacterQuest" VALUES (7,3,5,NULL);
INSERT INTO "CharacterQuest" VALUES (8,3,6,'2026-01-15 13:00:00');
INSERT INTO "CharacterQuest" VALUES (9,6,6,NULL);
INSERT INTO "CharacterQuest" VALUES (10,8,7,'2026-01-18 18:45:00');
INSERT INTO "CharacterQuest" VALUES (11,7,8,'2026-01-20 12:30:00');
INSERT INTO "CharacterQuest" VALUES (12,7,9,NULL);
INSERT INTO "CharacterQuest" VALUES (13,1,9,NULL);
INSERT INTO "CharacterQuest" VALUES (14,6,10,NULL);
INSERT INTO "Difficulty" VALUES (1,'Novice');
INSERT INTO "Difficulty" VALUES (2,'Apprentice');
INSERT INTO "Difficulty" VALUES (3,'Legendary');
INSERT INTO "Difficulty" VALUES (4,'Journeyman');
INSERT INTO "Difficulty" VALUES (5,'Master');
INSERT INTO "Difficulty" VALUES (6,'Expert');
INSERT INTO "Inventory" VALUES (1,1,1,1);
INSERT INTO "Inventory" VALUES (2,1,18,1);
INSERT INTO "Inventory" VALUES (3,1,7,3);
INSERT INTO "Inventory" VALUES (4,4,5,1);
INSERT INTO "Inventory" VALUES (5,4,28,1);
INSERT INTO "Inventory" VALUES (6,4,30,1);
INSERT INTO "Inventory" VALUES (7,3,2,1);
INSERT INTO "Inventory" VALUES (8,3,29,2);
INSERT INTO "Inventory" VALUES (9,3,11,4);
INSERT INTO "Inventory" VALUES (10,2,20,1);
INSERT INTO "Inventory" VALUES (11,2,22,1);
INSERT INTO "Inventory" VALUES (12,2,27,1);
INSERT INTO "Inventory" VALUES (13,6,1,1);
INSERT INTO "Inventory" VALUES (14,9,7,2);
INSERT INTO "Inventory" VALUES (15,10,29,1);
INSERT INTO "Inventory" VALUES (16,5,21,1);
INSERT INTO "Inventory" VALUES (17,8,3,1);
INSERT INTO "Inventory" VALUES (18,7,23,1);
INSERT INTO "Item" VALUES (1,'Iron Sword',1,1);
INSERT INTO "Item" VALUES (2,'Axe',1,1);
INSERT INTO "Item" VALUES (3,'Warhammer',1,2);
INSERT INTO "Item" VALUES (4,'Gun',1,3);
INSERT INTO "Item" VALUES (5,'Nunchucks',1,2);
INSERT INTO "Item" VALUES (6,'Water Gun',1,1);
INSERT INTO "Item" VALUES (7,'Bread',2,1);
INSERT INTO "Item" VALUES (8,'Beans',2,1);
INSERT INTO "Item" VALUES (9,'Beef',2,2);
INSERT INTO "Item" VALUES (10,'Chicken',2,2);
INSERT INTO "Item" VALUES (11,'Rice',2,3);
INSERT INTO "Item" VALUES (12,'Carrot',2,1);
INSERT INTO "Item" VALUES (13,'Helmet',3,1);
INSERT INTO "Item" VALUES (14,'Chestplate',3,1);
INSERT INTO "Item" VALUES (15,'Gauntlets',3,2);
INSERT INTO "Item" VALUES (16,'Leggings',3,2);
INSERT INTO "Item" VALUES (17,'Boots',3,3);
INSERT INTO "Item" VALUES (18,'Shield',3,1);
INSERT INTO "Item" VALUES (19,'Ancient Coin',4,1);
INSERT INTO "Item" VALUES (20,'Crystal Feather',4,3);
INSERT INTO "Item" VALUES (21,'Dragon Scale',4,2);
INSERT INTO "Item" VALUES (22,'Moonlit Gem',4,3);
INSERT INTO "Item" VALUES (23,'Forgotten Rune',4,2);
INSERT INTO "Item" VALUES (24,'Cursed Key',4,1);
INSERT INTO "Item" VALUES (25,'Explorer''s Lantern',5,1);
INSERT INTO "Item" VALUES (26,'Rope of Climbing',5,1);
INSERT INTO "Item" VALUES (27,'Enchanted Compass',5,3);
INSERT INTO "Item" VALUES (28,'Shadow Cloak',5,2);
INSERT INTO "Item" VALUES (29,'Healing Satchel',5,3);
INSERT INTO "Item" VALUES (30,'Traveller''s Map',5,2);
INSERT INTO "ItemType" VALUES (1,'Weapon');
INSERT INTO "ItemType" VALUES (2,'Food');
INSERT INTO "ItemType" VALUES (3,'Armour');
INSERT INTO "ItemType" VALUES (4,'Collectables');
INSERT INTO "ItemType" VALUES (5,'Equipment');
INSERT INTO "Player" VALUES (1,'aria.vale@example.com','Aria Vale','2026-01-01 09:00:00');
INSERT INTO "Player" VALUES (2,'rowan.dusk@example.com','Rowan Dusk','2026-01-02 10:15:00');
INSERT INTO "Player" VALUES (3,'nyra.star@example.com','Nyra Star','2026-01-03 11:30:00');
INSERT INTO "Player" VALUES (4,'orin.flint@example.com','Orin Flint','2026-01-04 12:45:00');
INSERT INTO "Quest" VALUES (1,'Defend the Vale',1,4);
INSERT INTO "Quest" VALUES (2,'Gather Vale Herbs',1,1);
INSERT INTO "Quest" VALUES (3,'Find the Lost Sand Compass',3,1);
INSERT INTO "Quest" VALUES (4,'Clear the Eldergrove Path',4,2);
INSERT INTO "Quest" VALUES (5,'Escort the Desert Caravan',3,2);
INSERT INTO "Quest" VALUES (6,'Climb the Frozen Watchtower',2,4);
INSERT INTO "Quest" VALUES (7,'Hunt the Ashen Wyrm',5,6);
INSERT INTO "Quest" VALUES (8,'Seal the Eldergrove Root Rift',4,6);
INSERT INTO "Quest" VALUES (9,'Break the Moonlight Isles Curse',6,5);
INSERT INTO "Quest" VALUES (10,'Awaken the Fallen Star Dragon',6,3);
INSERT INTO "Rarity" VALUES (1,'Common');
INSERT INTO "Rarity" VALUES (2,'Harder-to-find');
INSERT INTO "Rarity" VALUES (3,'Rare');
INSERT INTO "Region" VALUES (1,'The Verdant Vale');
INSERT INTO "Region" VALUES (2,'The Atrophic Alps');
INSERT INTO "Region" VALUES (3,'The Sunny Sands');
INSERT INTO "Region" VALUES (4,'The Eldergrove Forest');
INSERT INTO "Region" VALUES (5,'The Ashen Badlands');
INSERT INTO "Region" VALUES (6,'The Moonlight Isles');
INSERT INTO "Species" VALUES (1,'Human');
INSERT INTO "Species" VALUES (2,'Fairy');
INSERT INTO "Species" VALUES (3,'Dwarf');
INSERT INTO "Species" VALUES (4,'Hybrid');
INSERT INTO "Species" VALUES (5,'Zombie');
COMMIT;
