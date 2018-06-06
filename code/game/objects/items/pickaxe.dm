/obj/item/pickaxe
	name = "mining drill"
	desc = "The most basic of mining drills, for short excavations and small mineral extractions."
	icon = 'icons/obj/items.dmi'
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 15
	throwforce = 4
	icon_state = "pickaxe"
	item_state = "jackhammer"
	w_class = 5
	matter = list(MATERIAL_STEEL = 3750)
	attack_verb = list("hit", "pierced", "sliced", "attacked")
	sharp = 1

	var/dig_rock = TRUE
	var/dig_sand = FALSE
	var/digspeed = 40 //moving the delay to an item var so R&D can make improved picks. --NEO
	var/drill_sound = 'sound/weapons/Genhit.ogg'
	var/drill_verb = "drilling"

/obj/item/pickaxe/silver
	name = "silver pickaxe"
	desc = "This makes no metallurgic sense."
	icon_state = "spickaxe"
	item_state = "spickaxe"
	digspeed = 30

/obj/item/pickaxe/drill
	name = "advanced mining drill"
	desc = "Yours is the drill that will pierce through the rock walls."
	icon_state = "handdrill"
	item_state = "jackhammer"
	digspeed = 30
	drill_verb = "drilling"
	dig_sand = TRUE

/obj/item/pickaxe/jackhammer
	name = "sonic jackhammer"
	desc = "Cracks rocks with sonic blasts, perfect for killing cave lizards."
	icon_state = "jackhammer"
	item_state = "jackhammer"
	digspeed = 20
	drill_verb = "hammering"
	dig_sand = TRUE

/obj/item/pickaxe/gold
	name = "golden pickaxe"
	desc = "This makes no metallurgic sense."
	icon_state = "gpickaxe"
	item_state = "gpickaxe"
	digspeed = 20
	drill_verb = "picking"

/obj/item/pickaxe/plasmacutter
	name = "plasma cutter"
	desc = "A rock cutter that uses bursts of hot plasma. You could use it to cut limbs off of zombies! Or, you know, mine stuff."
	icon_state = "plasmacutter"
	item_state = "gun"
	w_class = 3
	damtype = "fire"
	digspeed = 20
	edge = 1
	drill_verb = "cutting"
	drill_sound = 'sound/items/Welder.ogg'

/obj/item/pickaxe/diamond
	name = "diamond pickaxe"
	desc = "A pickaxe with a diamond pick head."
	icon_state = "dpickaxe"
	item_state = "dpickaxe"
	digspeed = 10
	drill_verb = "picking"

/obj/item/pickaxe/diamonddrill
	name = "diamond mining drill"
	desc = "Yours is the drill that will pierce the heavens!"
	icon_state = "diamonddrill"
	item_state = "jackhammer"
	digspeed = 10
	drill_verb = "drilling"
	dig_sand = TRUE

/obj/item/pickaxe/borgdrill
	name = "robot mining drill"
	desc = "DRILL.EXE"
	icon_state = "diamonddrill"
	item_state = "jackhammer"
	digspeed = 15
	drill_verb = "drilling"
	dig_sand = TRUE

/obj/item/pickaxe/shovel
	name = "shovel"
	desc = "A large tool for digging and moving dirt."
	icon = 'icons/obj/items.dmi'
	icon_state = "shovel"
	item_state = "shovel"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 8
	matter = list(MATERIAL_STEEL = 50)
	attack_verb = list("bashed", "bludgeoned", "thrashed", "whacked")
	sharp = 0
	edge = 1
	drill_verb = "digging"
	dig_sand = TRUE
	dig_rock = FALSE
	drill_sound = 'sound/effects/squelch1.ogg'

/obj/item/pickaxe/shovel/spade
	name = "spade"
	desc = "A small tool for digging and moving dirt."
	icon_state = "spade"
	item_state = "spade"
	force = 5
	throwforce = 7
	w_class = 2