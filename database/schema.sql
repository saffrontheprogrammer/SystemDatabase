-- schema.sql - Tales of Time database schema
-- Run once to create all tables: python database/init_db.py

PRAGMA foreign_keys = ON;

-- ── Lookup tables ─────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS CharacterClass (
    ClassID     INTEGER PRIMARY KEY AUTOINCREMENT,
    ClassName   VARCHAR(50) NOT NULL UNIQUE,
    Description TEXT
);

CREATE TABLE IF NOT EXISTS Species (
    SpeciesID   INTEGER PRIMARY KEY AUTOINCREMENT,
    SpeciesName VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Alignment (
    AlignmentID INTEGER PRIMARY KEY AUTOINCREMENT,
    AlignmentName   VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS ItemType (
    ItemTypeID INTEGER PRIMARY KEY AUTOINCREMENT,
    TypeName VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Rarity (
    RarityID INTEGER PRIMARY KEY AUTOINCREMENT,
    RarityName VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Region (
    RegionID INTEGER PRIMARY KEY AUTOINCREMENT,
    RegionName VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Difficulty (
    DifficultyID INTEGER PRIMARY KEY AUTOINCREMENT,
    DifficultyName VARCHAR(50) NOT NULL UNIQUE
);


-- ── Core entities ─────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS Player (
    PlayerID    INTEGER PRIMARY KEY AUTOINCREMENT,
    Email       VARCHAR(255) NOT NULL UNIQUE,
    DisplayName VARCHAR(100) NOT NULL,
    DateCreated DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Character (
    CharacterID   INTEGER PRIMARY KEY AUTOINCREMENT,
    PlayerID      INTEGER NOT NULL,
    CharacterName VARCHAR(100) NOT NULL,
    CharacterType VARCHAR(20) NOT NULL CHECK (CharacterType IN ('Player', 'Non-Player')),
    ClassID       INTEGER NOT NULL,
    SpeciesID     INTEGER NOT NULL,
    AlignmentID   INTEGER NOT NULL,
    Level         INTEGER NOT NULL DEFAULT 1,

    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID),
    FOREIGN KEY (ClassID) REFERENCES CharacterClass(ClassID),
    FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID),
    FOREIGN KEY (AlignmentID) REFERENCES Alignment(AlignmentID)
);

CREATE TABLE IF NOT EXISTS Item (
    ItemID     INTEGER PRIMARY KEY AUTOINCREMENT,
    ItemName   VARCHAR(100) NOT NULL,
    ItemTypeID INTEGER NOT NULL REFERENCES ItemType(ItemTypeID),
    RarityID   INTEGER NOT NULL REFERENCES Rarity(RarityID)

    FOREIGN KEY (ItemTypeID) REFERENCES ItemType(ItemTypeID),
    FOREIGN KEY (RarityID) REFERENCES Rarity(RarityID)


);

CREATE TABLE IF NOT EXISTS Quest (
    QuestID      INTEGER PRIMARY KEY AUTOINCREMENT,
    QuestName    VARCHAR(100) NOT NULL,
    RegionID     INTEGER NOT NULL REFERENCES Region(RegionID),
    DifficultyID INTEGER NOT NULL REFERENCES Difficulty(DifficultyID)

    FOREIGN KEY (RegionID) REFERENCES Region(RegionID),
    FOREIGN KEY (DifficultyID) REFERENCES Difficulty(DifficultyID)
);


-- Join tables

CREATE TABLE IF NOT EXISTS Inventory (
    InventoryID INTEGER PRIMARY KEY AUTOINCREMENT,
    CharacterID INTEGER NOT NULL REFERENCES Character(CharacterID) ON DELETE CASCADE,
    ItemID      INTEGER NOT NULL REFERENCES Item(ItemID),
    Quantity    INTEGER NOT NULL DEFAULT 1

    FOREIGN KEY (CharacterID) REFERENCES Character(CharacterID),
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);

CREATE TABLE IF NOT EXISTS CharacterQuest (
    CharacterQuestID INTEGER PRIMARY KEY AUTOINCREMENT,
    CharacterID      INTEGER NOT NULL REFERENCES Character(CharacterID) ON DELETE CASCADE,
    QuestID          INTEGER NOT NULL REFERENCES Quest(QuestID),
    CompletionDate   DATETIME NULL

    FOREIGN KEY (CharacterID) REFERENCES Character(CharacterID),
    FOREIGN KEY (QuestID) REFERENCES Quest(QuestID)
);