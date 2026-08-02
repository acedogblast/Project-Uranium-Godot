extends Node
class_name FieldItemEffects
# Field (out-of-battle) item effects, ported 1:1 from the official
# 118__ PItem_ItemEffects.rb handlers. Returns {used: bool, message: String}.
# Items without a handler here return used=false ("It won't have any effect.").

static func heal_hp(poke, amount: int) -> Dictionary:
	if poke.current_hp <= 0:
		return {"used": false, "message": "It won't have any effect."}
	if poke.current_hp >= poke.hp:
		return {"used": false, "message": "It won't have any effect."}
	var before = poke.current_hp
	poke.current_hp = mini(poke.current_hp + amount, poke.hp)
	return {"used": true, "message": poke.name + "'s HP was restored\nby " + str(poke.current_hp - before) + " points."}

static func heal_status(poke, ailment) -> Dictionary:
	if poke.current_hp <= 0 or poke.major_ailment == null:
		return {"used": false, "message": "It won't have any effect."}
	if ailment != null and poke.major_ailment != ailment:
		return {"used": false, "message": "It won't have any effect."}
	poke.major_ailment = null
	return {"used": true, "message": poke.name + " became healthy."}

static func revive(poke, fraction: float) -> Dictionary:
	if poke.current_hp > 0:
		return {"used": false, "message": "It won't have any effect."}
	poke.current_hp = maxi(int(poke.hp * fraction), 1)
	poke.major_ailment = null
	return {"used": true, "message": poke.name + " was revived!"}

static func rare_candy(poke) -> Dictionary:
	if poke.level >= 100:
		return {"used": false, "message": "It won't have any effect."}
	var old_hp_max = poke.hp
	poke.set_basic_pokemon_by_level(poke.ID, poke.level + 1)
	# Keep the current HP proportionally sane: add the max-HP gain
	poke.current_hp = mini(poke.current_hp + (poke.hp - old_hp_max), poke.hp)
	return {"used": true, "message": poke.name + " grew to\nlevel " + str(poke.level) + "!"}

static func use_on_pokemon(item_id: int, poke) -> Dictionary:
	match item_id:
		170, 186:            # Potion, Berry Juice
			return heal_hp(poke, 20)
		171, 187:            # Super Potion, Fresh Water
			return heal_hp(poke, 50)
		188:                 # Soda Pop
			return heal_hp(poke, 60)
		189:                 # Lemonade
			return heal_hp(poke, 80)
		190:                 # Moomoo Milk
			return heal_hp(poke, 100)
		172:                 # Hyper Potion
			return heal_hp(poke, 200)
		173:                 # Max Potion
			return heal_hp(poke, 99999)
		174:                 # Full Restore
			var r = heal_hp(poke, 99999)
			if poke.current_hp > 0 and poke.major_ailment != null:
				poke.major_ailment = null
				r = {"used": true, "message": poke.name + " became\nfully healthy!"}
			return r
		176:                 # Antidote
			return heal_status(poke, MajorAilment.POISON)
		177:                 # Burn Heal
			return heal_status(poke, MajorAilment.BURN)
		178:                 # Ice Heal
			return heal_status(poke, MajorAilment.FROZEN)
		179:                 # Awakening
			return heal_status(poke, MajorAilment.SLEEP)
		180:                 # Parlyz Heal
			return heal_status(poke, MajorAilment.PARALYSIS)
		181, 182, 183:       # Full Heal, Lava Cookie, Old Gateau
			return heal_status(poke, null)
		184:                 # Revive
			return revive(poke, 0.5)
		185:                 # Max Revive
			return revive(poke, 1.0)
		175:                 # Sacred Ash is party-wide; handled by caller
			return {"used": false, "message": "It won't have any effect."}
		207:                 # Rare Candy
			return rare_candy(poke)
	return {"used": false, "message": "It won't have any effect."}

# True if the item can target a party Pokémon from the bag
static func is_usable_on_pokemon(item_id: int) -> bool:
	return (item_id >= 170 and item_id <= 190 and item_id != 175) or item_id == 207
