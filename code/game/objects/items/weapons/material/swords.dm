/obj/item/weapon/material/sword
	name = "claymore"
	desc = "What are you standing around staring at this for? Get to killing!"
	icon_state = "claymore"
	item_state = "claymore"
	slot_flags = SLOT_BELT
	force_divisor = 0.6
	thrown_force_divisor = 0.5 // 10 when thrown with weight 20 (steel)
	sharp = 1
	edge = 1
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/weapon/material/sword/handle_shield(mob/user, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")

	if(default_parry_check(user, attacker, damage_source) && prob(50))
		user.visible_message("<span class='danger'>\The [user] parries [attack_text] with \the [src]!</span>")
		playsound(user.loc, 'sound/weapons/punchmiss.ogg', 50, 1)
		return 1
	return 0

/obj/item/weapon/material/sword/katana
	name = "katana"
	desc = "Woefully underpowered in D20. This one looks pretty sharp."
	icon_state = "katana"
	item_state = "katana"
	slot_flags = SLOT_BELT | SLOT_BACK

/obj/item/weapon/material/sword/basic
	name = "sword"
	icon_state = "longsword"

/obj/item/weapon/material/sword/gladius
	name = "gladius"
	desc = "Are you not entertained!?"
	icon_state = "gladius"

/obj/item/weapon/material/sword/khopesh
	name = "khopesh"
	icon_state = "khopesh"
	item_state = "katana"

/obj/item/weapon/material/sword/sabre
	name = "sabre"
	icon_state = "sabre"
	item_state = "katana"

/obj/item/weapon/material/sword/dao
	name = "dao"
	icon_state = "dao"
	item_state = "katana"

/obj/item/weapon/material/sword/rapier
	name = "rapier"
	desc = "En guarde!"
	icon_state = "rapier"
	item_state = "katana"

/obj/item/weapon/material/sword/trench
	name = "trench knife"
	icon_state = "trench"
	item_state = "katana"