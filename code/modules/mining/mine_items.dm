/**********************Miner Lockers**************************/

/obj/structure/closet/secure_closet/miner
	name = "miner's equipment"
	icon_state = "miningsec1"
	icon_closed = "miningsec"
	icon_locked = "miningsec1"
	icon_opened = "miningsecopen"
	icon_broken = "miningsecbroken"
	icon_off = "miningsecoff"
	req_access = list(access_mining)

/obj/structure/closet/secure_closet/miner/New()
	..()
	sleep(2)
	if(prob(50))
		new /obj/item/storage/backpack/industrial(src)
	else
		new /obj/item/storage/backpack/satchel_eng(src)
	new /obj/item/clothing/under/jumpsuit/yellow(src)
	new /obj/item/clothing/gloves/thick(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/analyzer(src)
	new /obj/item/storage/ore(src)
	new /obj/item/flashlight/lantern(src)
	new /obj/item/shovel(src)
	new /obj/item/pickaxe(src)
	new /obj/item/clothing/glasses/material(src)

/******************************Lantern*******************************/

/obj/item/flashlight/lantern
	name = "lantern"
	icon_state = "lantern"
	desc = "A mining lantern."
	light_range = 3

/*****************************Pickaxe********************************/

/obj/item/pickaxe
	name = "mining drill"
	desc = "The most basic of mining drills, for short excavations and small mineral extractions."
	icon = 'icons/obj/items.dmi'
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 15.0
	throwforce = 4.0
	icon_state = "pickaxe"
	item_state = "jackhammer"
	w_class = 5
	matter = list(DEFAULT_WALL_MATERIAL = 3750)
	var/digspeed = 40 //moving the delay to an item var so R&D can make improved picks. --NEO

	attack_verb = list("hit", "pierced", "sliced", "attacked")
	var/drill_sound = 'sound/weapons/Genhit.ogg'
	var/drill_verb = "drilling"
	sharp = 1

	var/excavation_amount = 100

/obj/item/pickaxe/hammer
	name = "sledgehammer"
	//icon_state = "sledgehammer" Waiting on sprite
	desc = "A mining hammer made of reinforced metal. You feel like smashing your boss in the face with this."

/obj/item/pickaxe/silver
	name = "silver pickaxe"
	icon_state = "spickaxe"
	item_state = "spickaxe"
	digspeed = 30

	desc = "This makes no metallurgic sense."

/obj/item/pickaxe/drill
	name = "advanced mining drill" // Can dig sand as well!
	icon_state = "handdrill"
	item_state = "jackhammer"
	digspeed = 30

	desc = "Yours is the drill that will pierce through the rock walls."
	drill_verb = "drilling"

/obj/item/pickaxe/jackhammer
	name = "sonic jackhammer"
	icon_state = "jackhammer"
	item_state = "jackhammer"
	digspeed = 20 //faster than drill, but cannot dig

	desc = "Cracks rocks with sonic blasts, perfect for killing cave lizards."
	drill_verb = "hammering"

/obj/item/pickaxe/gold
	name = "golden pickaxe"
	icon_state = "gpickaxe"
	item_state = "gpickaxe"
	digspeed = 20

	desc = "This makes no metallurgic sense."
	drill_verb = "picking"

/obj/item/pickaxe/plasmacutter
	name = "plasma cutter"
	icon_state = "plasmacutter"
	item_state = "gun"
	w_class = 3.0 //it is smaller than the pickaxe
	damtype = "fire"
	digspeed = 20 //Can slice though normal walls, all girders, or be used in reinforced wall deconstruction/ light thermite on fire

	desc = "A rock cutter that uses bursts of hot plasma. You could use it to cut limbs off of zombies! Or, you know, mine stuff."
	drill_verb = "cutting"
	drill_sound = 'sound/items/Welder.ogg'
	sharp = 1
	edge = 1

/obj/item/pickaxe/diamond
	name = "diamond pickaxe"
	icon_state = "dpickaxe"
	item_state = "dpickaxe"
	digspeed = 10

	desc = "A pickaxe with a diamond pick head."
	drill_verb = "picking"

/obj/item/pickaxe/diamonddrill //When people ask about the badass leader of the mining tools, they are talking about ME!
	name = "diamond mining drill"
	icon_state = "diamonddrill"
	item_state = "jackhammer"
	digspeed = 5 //Digs through walls, girders, and can dig up sand

	desc = "Yours is the drill that will pierce the heavens!"
	drill_verb = "drilling"

/obj/item/pickaxe/borgdrill
	name = "robot mining drill"
	icon_state = "diamonddrill"
	item_state = "jackhammer"
	digspeed = 15
	desc = ""
	drill_verb = "drilling"

/*****************************Shovel********************************/

/obj/item/shovel
	name = "shovel"
	desc = "A large tool for digging and moving dirt."
	icon = 'icons/obj/items.dmi'
	icon_state = "shovel"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 8.0
	throwforce = 4.0
	item_state = "shovel"
	w_class = 5

	matter = list(DEFAULT_WALL_MATERIAL = 50)
	attack_verb = list("bashed", "bludgeoned", "thrashed", "whacked")
	sharp = 0
	edge = 1

/obj/item/shovel/spade
	name = "spade"
	desc = "A small tool for digging and moving dirt."
	icon_state = "spade"
	item_state = "spade"
	force = 5.0
	throwforce = 7.0
	w_class = 2.0


/**********************Mining car (Crate like thing, not the rail car)**************************/

/obj/structure/closet/crate/miningcar
	desc = "A mining car. This one doesn't work on rails, but has to be dragged."
	name = "Mining car (not for rails)"
	icon = 'icons/obj/storage.dmi'
	icon_state = "miningcar"
	density = 1
	icon_opened = "miningcaropen"
	icon_closed = "miningcar"

// Flags.

/obj/item/stack/flag
	name = "flags"
	desc = "Some colourful flags."
	singular_name = "flag"
	amount = 10
	max_amount = 10
	icon = 'icons/obj/mining.dmi'
	var/upright = 0
	var/base_state

/obj/item/stack/flag/New()
	..()
	base_state = icon_state

/obj/item/stack/flag/red
	name = "red flags"
	singular_name = "red flag"
	icon_state = "redflag"

/obj/item/stack/flag/yellow
	name = "yellow flags"
	singular_name = "yellow flag"
	icon_state = "yellowflag"

/obj/item/stack/flag/green
	name = "green flags"
	singular_name = "green flag"
	icon_state = "greenflag"

/obj/item/stack/flag/attackby(obj/item/W as obj, var/mob/user)
	if(upright && istype(W,src.type))
		src.attack_hand(user)
	else
		..()

/obj/item/stack/flag/attack_hand(var/mob/user)
	if(upright)
		upright = 0
		icon_state = base_state
		anchored = 0
		src.visible_message("<b>[user]</b> knocks down [src].")
	else
		..()

/obj/item/stack/flag/attack_self(var/mob/user)

	var/turf/T = get_turf(src)
	if(!T || !istype(T,/turf/simulated/mineral/floor))
		user << "The flag won't stand up in this terrain."
		return

	var/obj/item/stack/flag/F = locate() in T
	if(F && F.upright)
		user << "There is already a flag here."
		return

	var/obj/item/stack/flag/newflag = new src.type(T)
	newflag.amount = 1
	newflag.upright = 1
	newflag.anchored = 1
	newflag.name = newflag.singular_name
	newflag.icon_state = "[newflag.base_state]_open"
	newflag.visible_message("\The [user] plants \the [newflag] firmly in the ground.")
	src.use(1)
