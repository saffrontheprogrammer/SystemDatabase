"""
seed.py - Populates all reference / lookup tables with initial data.
Run once: python database/seed.py
"""
import sys
import os
from datetime import datetime

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

from app import create_app
from extensions import db
from models.models import (
    CharacterClass, Speciess, Alignment,
    ItemType, Rarity, Region, Difficulty,
    Character, Item, Quest, Inventory, CharacterQuest
)

LOOKUP_SEED_DATA = {
    CharacterClass: [
        {"ClassName: "Warrior", "Description": "A powerful melee fighter."},
    ],
    Species: [
        "SpeciesName": "Human"},
    ],
    Alignment: [
        {"AlignmentName": "Lawful Good"},
    ],
    ItemType: [
        {"TypeName": "Weapon"},
    ],
    Rarity: [
        {"RarityName": "Common"}, 
    ],
    Region: [
        {"RegionName": "The Verdant Vale"},
    ],
    Difficulty: [
        {"DifficulyName": "Novice"},
    ],
}

def seed_lookup_tables():
    for model, rows in LOOKUP_SEED_DATA.items():
        if model.query.count() == 0:
            for row in rows:
                db.session.add(model(**row))
            print(f"  ✓ Seeded {model.__tablename__}")
        else:
            print(f"  ⏭ Skipped {model.__tablename__} (already has data)")
    db.session.commit()

classes = {c.ClassName: c for c in CharacterClass.query.all()}
species = {s.SpeciesName: s for s in Species.query.all()}
alignments = {a.AlignmentName: a for a in Alignment.query.all()}
item_types = {i.TypeName: i fir i in ItemType.query.all()}
rarities = {r.RarityName: r for r in Rarity.query.all()}
regions = {r.RegionName: r for r in Region.query.all()}
difficulties = {d.DifficultyName: d for d n Difficulty.query.all()}

#Characters

character_rows = [
    {
        "CharacterName": "Thorin Ironblade",
        "ClassID": classes["Warrior"].ClassID,
        "SpeciesID": species["Dwarf"].SpeciesID
        "AlignmentID": alignments["Lawful Good"].AlignmentID,
        "Level": 12,
    },
]

characters = []
for rows in character_rows:
    character = Character(**row)
    db.session.add(character)
    characters.append(character)

db.session.commit()
print("  ✓ Seeded Character")

chracter_map = {c.CharacterName: c for c in Character.query.all()}

item_rows = [
    {
        "ItemName": "Iron Sword",
        "ItemTypeID": item_types["Weapon"].ItemT
    }
]
for row in item_rows:
    db.session.add(Item(**row))

db.session.commit()
print("  ✓ Seeded Item")

item_map = {i.ItemName: i for i in Item.query.all()}

quest_rows = [
    {}
