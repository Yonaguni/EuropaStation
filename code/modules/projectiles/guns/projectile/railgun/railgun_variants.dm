/obj/item/weapon/gun/projectile/railgun/rifle
	name = "rail rifle"
	desc = "A bulky, reliable ballistic weapon that uses induced magnetic fields to fire slugs. Weapon of choice for the mercenary on the go."
	w_class = 4
	force = 10
	icon_state = "railgun"
	max_shells = 32
	magazine_type = /obj/item/ammo_magazine/railgun/large
	rail_damage_threshold = 4 // Chance of damaging itself when firing beyond a 3-round burst.
	rail_damage_prob = 15
	rail_repair_time = 100

	slot_flags = SLOT_BACK
	firemodes = list(
		list(name="semiauto",       burst=1, fire_delay=0,    move_delay=6, burst_accuracy=null, dispersion=null),
		list(name="3-round bursts", burst=3, fire_delay=null, move_delay=18,    burst_accuracy=list(0,-1,-2),       dispersion=list(0.0, 0.6, 0.6))
		)

/obj/item/weapon/gun/projectile/railgun/rifle/heavy
	name = "heavy rail rifle"
	desc = "A bulky, reliable ballistic weapon that uses induced magnetic fields to fire slugs. This one is has been fitted with a custom firing mechanism and bore fit for shells."
	icon_state = "railheavy"
	ammo_type = /obj/item/ammo_casing/railgun/shell
	magazine_type = /obj/item/ammo_magazine/railgun/shell
	caliber = "railgun shell"
	max_shells = 16
	rail_damage_threshold = 3
	rail_damage_prob = 20 // Almost guaranteed to break it if you fire faster than the threshold.

/obj/item/weapon/gun/projectile/railgun/rifle/heavy/auto
	name = "automatic railgun"
	icon_state = "railauto"
	desc = "A miniaturized man-portable version of a capital ship cannon. Use of these extraordinarily heavy weapons is illegal on most stations, as they tend to chew through the target, their armour, the wall behind them, and then the hull."
	magazine_type = /obj/item/ammo_magazine/railgun/shell/large
	max_shells = 80 // oh god.
	rail_repair_time = 300

	firemodes = list(
		list(name="short bursts",	burst=8, move_delay=20, burst_accuracy = list(0,-1,-1,-2,-2),          dispersion = list(0.6, 1.0, 1.0, 1.0, 1.2)),
		list(name="long bursts",	burst=12, move_delay=30, burst_accuracy = list(0,-1,-1,-2,-2,-2,-3,-3), dispersion = list(1.0, 1.0, 1.0, 1.0, 1.2)),
		)
	rail_damage_threshold = 10 // Risk of warping every time it's fired.
	rail_damage_prob = 7       // Near-100% chance of warping when firing a long burst. GG.

// Mostly a fluff distinction. Build these out of an SMES core, a cable coil and some metal rods.
// Single-shot, hand-loaded, most likely destroyed after use.
/obj/item/weapon/gun/projectile/railgun/gauss
	name = "improvised coilgun"
	desc = "The forces leashed in this jury-rigged piece of crap are enough to put a hole in six inches of plate steel. Keep pointed away from face."
	icon_state = "coilgun"
	magazine_type = null
	ammo_type = /obj/item/ammo_casing/railgun/shell
	max_shells = 1
	handle_casings = HOLD_CASINGS
	load_method = SINGLE_CASING
	w_class = 3
	force = 8
	rail_damage_threshold = 0
	rail_damage_prob = 100
	fire_sound = 'sound/weapons/pulse.ogg'

/obj/item/weapon/gun/projectile/railgun/gauss/check_damage()
	if(!src || !loc)
		return
	var/mob/living/M = loc
	if(istype(M))
		M << "<span class='danger'>\The [src] explodes with the force of the shot!</span>"
		M.unEquip(src)
		explosion(M, -1, 0, 2)
	qdel(src)
	return