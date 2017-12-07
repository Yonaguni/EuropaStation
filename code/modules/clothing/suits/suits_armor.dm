/obj/item/clothing/suit/armour
	name = "armoured vest"
	desc = "An armour vest made of synthetic fibers."
	icon_state = "armor"
	item_state = "armor"
	blood_overlay_type = "armor"

	armor = list(melee = 30, bullet = 15, laser = 40, energy = 10, bomb = 25, bio = 0, rad = 0)
	w_class = 3

	allowed = list(/obj/item/gun/composite,/obj/item/radio,/obj/item/reagent_containers/spray/pepper,/obj/item/gun/composite,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/melee/baton,/obj/item/handcuffs)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	item_flags = THICKMATERIAL

	cold_protection = UPPER_TORSO|LOWER_TORSO
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = UPPER_TORSO|LOWER_TORSO
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.6

/obj/item/clothing/suit/armour/meleeproof
	name = "stab vest"
	desc = "An armored vest with heavy padding to protect against melee attacks."
	armor = list(melee = 75, bullet = 33, laser = 50, energy = 10, bomb = 25, bio = 0, rad = 0)
	siemens_coefficient = 0.5
	icon_state = "armor_stab"

/obj/item/clothing/suit/armour/bulletproof
	name = "ballistic vest"
	desc = "A vest that excels in protecting the wearer against high-velocity solid projectiles."
	armor = list(melee = 42, bullet = 75, laser = 42, energy = 10, bomb = 25, bio = 0, rad = 0)
	icon_state = "armor_kevlar"

/obj/item/clothing/suit/armour/laserproof
	name = "ablative vest"
	desc = "A vest with advanced shielding to protect against energy weapons. Looks like it might impair movement."
	armor = list(melee = 33, bullet = 33, laser = 77, energy = 50, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0
	icon_state = "armor_laser"

/obj/item/clothing/suit/armour/laserproof/handle_shield(mob/user, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	if(istype(damage_source, /obj/item/projectile/energy) || istype(damage_source, /obj/item/projectile/beam))
		var/obj/item/projectile/P = damage_source
		var/reflectchance = 40 - round(damage/3)
		if(!(def_zone in list(BP_CHEST, BP_GROIN))) //not changing this so arm and leg shots reflect, gives some incentive to not aim center-mass
			reflectchance /= 2
		if(P.starting && prob(reflectchance))
			visible_message("<span class='danger'>\The [user]'s [src.name] reflects [attack_text]!</span>")
			// Find a turf near or on the original location to bounce to
			var/new_x = P.starting.x + pick(0, 0, 0, 0, 0, -1, 1, -2, 2)
			var/new_y = P.starting.y + pick(0, 0, 0, 0, 0, -1, 1, -2, 2)
			var/turf/curloc = get_turf(user)
			// redirect the projectile
			P.redirect(new_x, new_y, curloc, user)
			return PROJECTILE_CONTINUE // complete projectile permutation

/obj/item/clothing/suit/armour/makeshift
	name = "makeshift armour"
	desc = "A poorly put-together armour vest."
	icon_state = "improvised_armour"
	armor = list(melee = 10, bullet = 5, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/suit/storage/armour
	name = "webbed armoured vest"
	desc = "A synthetic armor vest. This one has added webbing and ballistic plates."
	icon_state = "vest"
	armor = list(melee = 40, bullet = 40, laser = 40, energy = 25, bomb = 30, bio = 0, rad = 0)
	allowed = list(/obj/item/gun/composite,/obj/item/radio,/obj/item/reagent_containers/spray/pepper,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/melee/baton,/obj/item/handcuffs)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	item_flags = THICKMATERIAL
	cold_protection = UPPER_TORSO|LOWER_TORSO
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = UPPER_TORSO|LOWER_TORSO
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.6

/obj/item/clothing/suit/armour/polymer
	name = "polymer vest"
	desc = "An advanced polymer armour vest"
	icon_state = "heavy_armour"
	armor = list(melee = 50, bullet = 65, laser = 5, energy = 5, bomb = 10, bio = 0, rad = 0)
