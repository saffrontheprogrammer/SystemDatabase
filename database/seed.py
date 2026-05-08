"""
seed.py - Populates all reference / lookup tables with initial data.
Run once: python database/seed.py
"""

import sys
import os
from datetime import datetime

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

from models.models import get_db, init_db

LOOKUP_SEED_DATA = {
    "CharacterClass": [
        {"ClassName": "Warrior",  "Description": "A powerful melee fighter."},
        {"ClassName": "Barbarian",  "Description": "A lawless warrior with no limits."},
        {"ClassName": "Sorcerer",  "Description": "A spell casting powerhouse."},
        {"ClassName": "Mage",  "Description": "A master of magic who casts powerful spells."},
        {"ClassName": "Rogue",  "Description": "A stealthy fighter who relies on speed and trickery"},

    ],
    "Species": [
        {"SpeciesName": "Human"},
        {"SpeciesName": "Fairy"},
        {"SpeciesName": "Dwarf"},
        {"SpeciesName": "Hybrid"},
        {"SpeciesName": "Zombie"},

    ],
    "Alignment": [
        {"AlignmentName": "Lawful Good"},
        {"AlignmentName": "Moderately Unfair"},
        {"AlignmentName": "Destructively Evil"},
    ],
    "ItemType": [
        {"TypeName": "Weapon"},
        {"TypeName": "Food"},
        {"TypeName": "Armour"},
        {"TypeName": "Collectables"},


    ],
    "Rarity": [
        {"RarityName": "Common"},
        {"RarityName": "Harder to find"},
        {"RarityName": "Rare"},
    ],
    "Region": [
        {"RegionName": "The Verdant Vale"},
        {"RegionName": "The Atrophic Alps"},
        {"RegionName": "The Sunny Sands"},
        {"RegionName": "The Eldergrove Forest"},
        {"RegionName": "The Ashen Badlands"},
        {"RegionName": "The Moonlight Isles"},
    ],
    "Difficulty": [
        {"DifficultyName": "Novice"},
        {"DifficultyName": "Apprentice"},
        {"DifficultyName": "Lengendary"},
        {"DifficultyName": "Journeyman"},
        {"DifficultyName": "Master"},
        {"DifficultyName": "Expert"},
    ]
}


def table_count(cursor, table_name):
    cursor.execute(f"SELECT COUNT(*) AS Total FROM {table_name}")
    return cursor.fetchone()["Total"]


def fetch_lookup_map(cursor, table_name, key_field):
    cursor.execute(f"SELECT * FROM {table_name}")
    return {row[key_field]: dict(row) for row in cursor.fetchall()}


def seed_lookup_tables(cursor):
    for table_name, rows in LOOKUP_SEED_DATA.items():
        if table_count(cursor, table_name) == 0:
            for row in rows:
                columns      = ", ".join(row.keys())
                placeholders = ", ".join(["?"] * len(row))
                cursor.execute(
                    f"INSERT INTO {table_name} ({columns}) VALUES ({placeholders})",
                    tuple(row.values())
                )
            print(f"  ✔ Seeded {table_name}")
        else:
            print(f"  – Skipped {table_name} (already has data)")


def seed_core_data(cursor):
    if table_count(cursor, "Character") > 0:
        print("  – Skipped Character / Item / Quest / Inventory / CharacterQuest (already has data)")
        return

    classes    = fetch_lookup_map(cursor, "CharacterClass", "ClassName")
    species    = fetch_lookup_map(cursor, "Species",        "SpeciesName")
    alignments = fetch_lookup_map(cursor, "Alignment",      "AlignmentName")
    item_types = fetch_lookup_map(cursor, "ItemType",       "TypeName")
    rarities   = fetch_lookup_map(cursor, "Rarity",         "RarityName")
    regions    = fetch_lookup_map(cursor, "Region",         "RegionName")
    difficulties = fetch_lookup_map(cursor, "Difficulty",   "DifficultyName")

    # ── Characters ────────────────────────────────────────────────────────────
    character_rows = [ 
        {"CharacterName": "Thorin Ironblade",    "ClassID": classes["Warrior"]["ClassID"],  "SpeciesID": species["Dwarf"]["SpeciesID"],  "AlignmentID": alignments["Lawful Good"]["AlignmentID"],     "Level": 12},
        {"CharacterName": "Loretta Fusion",    "ClassID": classes["Sorcerer"]["ClassID"],  "SpeciesID": species["Human"]["SpeciesID"],  "AlignmentID": alignments["Destructively Evil"]["AlignmentID"],     "Level": 1},
        {"CharacterName": "Kaelen Stormhart",    "ClassID": classes["Barbarian"]["ClassID"],  "SpeciesID": species["Hybrid"]["SpeciesID"],  "AlignmentID": alignments["Lawful Good"]["AlignmentID"],     "Level": 7},
        {"CharacterName": "Mira Ashvale",    "ClassID": classes["Rogue"]["ClassID"],  "SpeciesID": species["Fairy"]["SpeciesID"],  "AlignmentID": alignments["Moderately Unfair"]["AlignmentID"],     "Level": 4},
        {"CharacterName": "Garrick Stonefist",    "ClassID": classes["Mage"]["ClassID"],  "SpeciesID": species["Zombie"]["SpeciesID"],  "AlignmentID": alignments["Destructively Evil"]["AlignmentID"],     "Level": 5},
        {"CharacterName": "Dorian Blackthorn",    "ClassID": classes["Warrior"]["ClassID"],  "SpeciesID": species["Human"]["SpeciesID"],  "AlignmentID": alignments["Moderately Unfair"]["AlignmentID"],     "Level": 20},
       ]

    for row in character_rows:
        cursor.execute("""
            INSERT INTO Character (CharacterName, ClassID, SpeciesID, AlignmentID, Level)
            VALUES (?, ?, ?, ?, ?)
        """, (row["CharacterName"], row["ClassID"], row["SpeciesID"], row["AlignmentID"], row["Level"]))

    print("  ✔ Seeded Character")
    character_map = fetch_lookup_map(cursor, "Character", "CharacterName")

    # ── Items ─────────────────────────────────────────────────────────────────
    item_rows = [
        {"ItemName": "Iron Sword",          "ItemTypeID": item_types["Weapon"]["ItemTypeID"],  "RarityID": rarities["Common"]["RarityID"]},
        {"ItemName": "Iron Sword",          "ItemTypeID": item_types["Weapon"]["ItemTypeID"],  "RarityID": rarities["Common"]["RarityID"]},
        {"ItemName": "Iron Sword",          "ItemTypeID": item_types["Weapon"]["ItemTypeID"],  "RarityID": rarities["Common"]["RarityID"]},
        {"ItemName": "Iron Sword",          "ItemTypeID": item_types["Weapon"]["ItemTypeID"],  "RarityID": rarities["Common"]["RarityID"]},
        {"ItemName": "Iron Sword",          "ItemTypeID": item_types["Weapon"]["ItemTypeID"],  "RarityID": rarities["Common"]["RarityID"]},
        {"ItemName": "Iron Sword",          "ItemTypeID": item_types["Weapon"]["ItemTypeID"],  "RarityID": rarities["Common"]["RarityID"]},

        {"ItemName": "Bread",          "ItemTypeID": item_types["Food"]["ItemTypeID"],  "RarityID": rarities["Common"]["RarityID"]},
        {"ItemName": "Beans",          "ItemTypeID": item_types["Food"]["ItemTypeID"],  "RarityID": rarities["Common"]["RarityID"]},
        {"ItemName": "Beef",          "ItemTypeID": item_types["Food"]["ItemTypeID"],  "RarityID": rarities["Harder to find"]["RarityID"]},
        {"ItemName": "Chicken",          "ItemTypeID": item_types["Food"]["ItemTypeID"],  "RarityID": rarities["Harder to find"]["RarityID"]},
        {"ItemName": "Rice",          "ItemTypeID": item_types["Food"]["ItemTypeID"],  "RarityID": rarities["Rare"]["RarityID"]},
        {"ItemName": "Carrot",          "ItemTypeID": item_types["Food"]["ItemTypeID"],  "RarityID": rarities["Common"]["RarityID"]},

        {"ItemName": "Helmet",          "ItemTypeID": item_types["Armour"]["ItemTypeID"],  "RarityID": rarities["Common"]["RarityID"]},
        {"ItemName": "Chestplate",          "ItemTypeID": item_types["Armour"]["ItemTypeID"],  "RarityID": rarities["Common"]["RarityID"]},
        {"ItemName": "Gauntlets",          "ItemTypeID": item_types["Armour"]["ItemTypeID"],  "RarityID": rarities["Harder to find"]["RarityID"]},
        {"ItemName": "Leggings",          "ItemTypeID": item_types["Armour"]["ItemTypeID"],  "RarityID": rarities["Harder to find"]["RarityID"]},
        {"ItemName": "Boots",          "ItemTypeID": item_types["Armour"]["ItemTypeID"],  "RarityID": rarities["Rare"]["RarityID"]},
        {"ItemName": "Shield",          "ItemTypeID": item_types["Armour"]["ItemTypeID"],  "RarityID": rarities["Common"]["RarityID"]},
        ]
    for row in item_rows:
        cursor.execute("""
            INSERT INTO Item (ItemName, ItemTypeID, RarityID)
            VALUES (?, ?, ?)
        """, (row["ItemName"], row["ItemTypeID"], row["RarityID"]))

    print("  ✔ Seeded Item")
    item_map = fetch_lookup_map(cursor, "Item", "ItemName")

    # ── Quests ────────────────────────────────────────────────────────────────
    quest_rows = [
        {"QuestName": "Defend the Vale",       "RegionID": regions["The Verdant Vale"]["RegionID"],        "DifficultyID": difficulties["Journeyman"]["DifficultyID"]},
    ]

    for row in quest_rows:
        cursor.execute("""
            INSERT INTO Quest (QuestName, RegionID, DifficultyID)
            VALUES (?, ?, ?)
        """, (row["QuestName"], row["RegionID"], row["DifficultyID"]))

    print("  ✔ Seeded Quest")
    quest_map = fetch_lookup_map(cursor, "Quest", "QuestName")

    # ── Inventory ─────────────────────────────────────────────────────────────
    inventory_rows = [
        {"CharacterID": character_map["Thorin Ironblade"]["CharacterID"],    "ItemID": item_map["Iron Sword"]["ItemID"],           "Quantity": 1},
    ]

    for row in inventory_rows:
        cursor.execute("""
            INSERT INTO Inventory (CharacterID, ItemID, Quantity)
            VALUES (?, ?, ?)
        """, (row["CharacterID"], row["ItemID"], row["Quantity"]))

    print("  ✔ Seeded Inventory")

    # ── CharacterQuest ────────────────────────────────────────────────────────
    character_quest_rows = [
        {"CharacterID": character_map["Thorin Ironblade"]["CharacterID"],    "QuestID": quest_map["Defend the Vale"]["QuestID"],       "CompletionDate": datetime(2026, 1, 12, 14, 30).isoformat(sep=" ")},
    ]

    for row in character_quest_rows:
        cursor.execute("""
            INSERT INTO CharacterQuest (CharacterID, QuestID, CompletionDate)
            VALUES (?, ?, ?)
        """, (row["CharacterID"], row["QuestID"], row["CompletionDate"]))

    print("  ✔ Seeded CharacterQuest")


def seed():
    init_db()
    conn = get_db()          # was: get_connection() - does not exist
    cursor = conn.cursor()

    try:
        seed_lookup_tables(cursor)
        seed_core_data(cursor)
        conn.commit()
        print("\nSeed complete.")
    except Exception as e:
        conn.rollback()
        print(f"\nSeed failed: {e}")
        raise
    finally:
        conn.close()


if __name__ == "__main__":
    seed()