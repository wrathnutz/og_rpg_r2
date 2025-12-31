extends Node

enum proficiency_stat {STRENGTH, DEXTERITY, CONSTITUTION, INTELLIGENCE, WISDOM, CHARISMA}
enum alignment {good, neutral, evil}

enum door_state {OPEN = 0, CLOSED = 1, LOCKED = 2, MAGIC_LOCK = 3, SEALED = 4}

enum chest_state{OPENED=0, CLOSED=1, OPENING=3}

enum item_type {RESOURCE, CONSUMABLE, WEAPON, ARMOR, QUEST_ITEM}
enum item_quality {POOR, NORMAL, GOOD, EXQUISITE}

var rng = RandomNumberGenerator.new()
