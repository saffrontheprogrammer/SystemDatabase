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
    SpeciesName VARCHAR(50) NOT NUL UNIQUE
);

CREATE TABLE IF NOT EXISTS Alignment (
    AlignmentID INTEGER PRIMARY KEY AUTOINCREMENT,
    AlignmentName   VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS ItemType (
    ItemTypeID INTEGER PRIMARY KEY AUTOINCREMENT,
    TypeName
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
    DifficultyID INTEGER PRIMARY key AUTOINCREMENT,
    
)

-- ── Core entities ─────────────────────────────────────────────────────────────



-- ── Join tables ───────────────────────────────────────────────────────────────

