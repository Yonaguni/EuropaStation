/obj/random
	name = "random object"
	desc = "This item type is used to spawn random objects at round-start."
	icon = 'icons/misc/mark.dmi'
	icon_state = "rup"
	auto_init = TRUE
	var/spawn_nothing_percentage = 0 // this variable determines the likelyhood that this random object will not spawn anything


// creates a new object and deletes itself
/obj/random/New()
	..()
	if (!prob(spawn_nothing_percentage))
		spawn_item()

/obj/random/initialize()
	..()
	qdel(src)

// this function should return a specific item to spawn
/obj/random/proc/item_to_spawn()
	return 0


// creates the random item
/obj/random/proc/spawn_item()
	var/build_path = item_to_spawn()

	var/atom/A = new build_path(src.loc)
	if(pixel_x || pixel_y)
		A.pixel_x = pixel_x
		A.pixel_y = pixel_y


/obj/random/single
	name = "randomly spawned object"
	desc = "This item type is used to randomly spawn a given object at round-start."
	icon_state = "x3"
	var/spawn_object = null
	item_to_spawn()
		return ispath(spawn_object) ? spawn_object : text2path(spawn_object)


/obj/random/tool
	name = "random tool"
	desc = "This is a random tool."
	icon = 'icons/obj/items.dmi'
	icon_state = "welder"
	item_to_spawn()
		return pick(/obj/item/screwdriver,\
					/obj/item/wirecutters,\
					/obj/item/weldingtool,\
					/obj/item/crowbar,\
					/obj/item/wrench,\
					/obj/item/flashlight)


/obj/random/technology_scanner
	name = "random scanner"
	desc = "This is a random technology scanner."
	icon = 'icons/obj/items.dmi'
	icon_state = "atmos"
	item_to_spawn()
		return pick(prob(5);/obj/item/t_scanner,\
					prob(2);/obj/item/radio,\
					prob(5);/obj/item/analyzer)


/obj/random/powercell
	name = "random powercell"
	desc = "This is a random powercell."
	icon = 'icons/obj/power.dmi'
	icon_state = "cell"
	item_to_spawn()
		return pick(prob(10);/obj/item/cell/crap,\
					prob(80);/obj/item/cell,\
					prob(5);/obj/item/cell/high,\
					prob(4);/obj/item/cell/super,\
					prob(1);/obj/item/cell/hyper)


/obj/random/bomb_supply
	name = "bomb supply"
	desc = "This is a random bomb supply."
	icon = 'icons/obj/assemblies/new_assemblies.dmi'
	icon_state = "signaller"
	item_to_spawn()
		return pick(/obj/item/assembly/igniter,\
					/obj/item/assembly/prox_sensor,\
					/obj/item/assembly/signaler,\
					/obj/item/multitool)


/obj/random/toolbox
	name = "random toolbox"
	desc = "This is a random toolbox."
	icon = 'icons/obj/storage.dmi'
	icon_state = "red"
	item_to_spawn()
		return pick(prob(3);/obj/item/storage/toolbox/mechanical,\
					prob(2);/obj/item/storage/toolbox/electrical,\
					prob(1);/obj/item/storage/toolbox/syndicate,\
					prob(2);/obj/item/storage/toolbox/emergency)


/obj/random/tech_supply
	name = "random tech supply"
	desc = "This is a random piece of technology supplies."
	icon = 'icons/obj/power.dmi'
	icon_state = "cell"
	spawn_nothing_percentage = 50
	item_to_spawn()
		return pick(prob(3);/obj/random/powercell,\
					prob(2);/obj/random/technology_scanner,\
					prob(1);/obj/item/packageWrap,\
					prob(2);/obj/random/bomb_supply,\
					prob(1);/obj/item/extinguisher,\
					prob(1);/obj/item/clothing/gloves/insulated/cheap,\
					prob(3);/obj/item/stack/cable_coil/random,\
					prob(2);/obj/random/toolbox,\
					prob(2);/obj/item/storage/belt/utility,\
					prob(5);/obj/random/tool,\
					prob(2);/obj/item/tape_roll)

/obj/random/medical
	name = "Random Medicine"
	desc = "This is a random medical item."
	icon = 'icons/obj/items.dmi'
	icon_state = "brutepack"
	spawn_nothing_percentage = 25
	item_to_spawn()
		return pick(prob(4);/obj/item/stack/medical/bruise_pack,\
					prob(4);/obj/item/stack/medical/ointment,\
					prob(2);/obj/item/stack/medical/advanced/bruise_pack,\
					prob(2);/obj/item/stack/medical/advanced/ointment,\
					prob(1);/obj/item/stack/medical/splint,\
					prob(2);/obj/item/bodybag,\
					prob(1);/obj/item/bodybag/cryobag,\
					prob(2);/obj/item/storage/pill_bottle/fotiazine,\
					prob(2);/obj/item/storage/pill_bottle/antitox,\
					prob(2);/obj/item/storage/pill_bottle/morphine,\
					prob(2);/obj/item/reagent_containers/syringe/antitoxin,\
					prob(1);/obj/item/reagent_containers/syringe/antiviral,\
					prob(2);/obj/item/reagent_containers/syringe/adrenaline,\
					prob(1);/obj/item/stack/nanopaste)


/obj/random/firstaid
	name = "Random First Aid Kit"
	desc = "This is a random first aid kit."
	icon = 'icons/obj/storage.dmi'
	icon_state = "firstaid"
	item_to_spawn()
		return pick(prob(4);/obj/item/storage/firstaid/regular,\
					prob(3);/obj/item/storage/firstaid/toxin,\
					prob(3);/obj/item/storage/firstaid/o2,\
					prob(2);/obj/item/storage/firstaid/adv,\
					prob(1);/obj/item/storage/firstaid/combat,\
					prob(2);/obj/item/storage/firstaid/empty,\
					prob(3);/obj/item/storage/firstaid/fire)


/obj/random/contraband
	name = "Random Illegal Item"
	desc = "Hot Stuff."
	icon = 'icons/obj/items.dmi'
	icon_state = "purplecomb"
	spawn_nothing_percentage = 50
	item_to_spawn()
		return pick(prob(3);/obj/item/storage/pill_bottle/morphine,\
					prob(4);/obj/item/haircomb,\
					prob(2);/obj/item/storage/pill_bottle/happy,\
					prob(2);/obj/item/storage/pill_bottle/zoom,\
					prob(5);/obj/item/sign/poster,\
					prob(2);/obj/item/material/butterfly,\
					prob(3);/obj/item/material/butterflyblade,\
					prob(3);/obj/item/material/butterflyhandle,\
					prob(3);/obj/item/material/wirerod,\
					prob(1);/obj/item/material/butterfly/switchblade,\
					prob(1);/obj/item/reagent_containers/syringe/drugs)


/obj/random/energy
	name = "Random Energy Weapon"
	desc = "This is a random energy weapon."
	icon = 'icons/obj/gun.dmi'
	icon_state = "energykill100"
	item_to_spawn()
		return pick(/obj/item/gun/composite/premade/taser_pistol,/obj/item/gun/composite/premade/laser_smg,/obj/item/gun/composite/premade/laser_assault)

/obj/random/projectile
	name = "Random Projectile Weapon"
	desc = "This is a random projectile weapon."
	icon = 'icons/obj/gun.dmi'
	icon_state = "revolver"
	item_to_spawn()
		return pick(typesof(/obj/item/gun/composite/premade)-/obj/item/gun/composite/premade)
/obj/random/handgun
	name = "Random Handgun"
	desc = "This is a random sidearm."
	icon = 'icons/obj/gun.dmi'
	icon_state = "secgundark"
	item_to_spawn()
		return pick(typesof(/obj/item/gun/composite/premade/pistol))


/obj/random/ammo
	name = "Random Ammunition"
	desc = "This is random ammunition."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "45-10"
	item_to_spawn()
		return pick(typesof(/obj/item/ammo_magazine)-/obj/item/ammo_magazine)


/obj/random/action_figure
	name = "random action figure"
	desc = "This is a random action figure."
	icon = 'icons/obj/toy.dmi'
	icon_state = "assistant"
	item_to_spawn()
		return pick(/obj/item/toy/figure/cmo,\
					/obj/item/toy/figure/assistant,\
					/obj/item/toy/figure/atmos,\
					/obj/item/toy/figure/bartender,\
					/obj/item/toy/figure/borg,\
					/obj/item/toy/figure/gardener,\
					/obj/item/toy/figure/captain,\
					/obj/item/toy/figure/cargotech,\
					/obj/item/toy/figure/ce,\
					/obj/item/toy/figure/chaplain,\
					/obj/item/toy/figure/chef,\
					/obj/item/toy/figure/chemist,\
					/obj/item/toy/figure/clown,\
					/obj/item/toy/figure/corgi,\
					/obj/item/toy/figure/detective,\
					/obj/item/toy/figure/dsquad,\
					/obj/item/toy/figure/engineer,\
					/obj/item/toy/figure/geneticist,\
					/obj/item/toy/figure/hop,\
					/obj/item/toy/figure/hos,\
					/obj/item/toy/figure/qm,\
					/obj/item/toy/figure/janitor,\
					/obj/item/toy/figure/agent,\
					/obj/item/toy/figure/librarian,\
					/obj/item/toy/figure/md,\
					/obj/item/toy/figure/mime,\
					/obj/item/toy/figure/miner,\
					/obj/item/toy/figure/ninja,\
					/obj/item/toy/figure/wizard,\
					/obj/item/toy/figure/rd,\
					/obj/item/toy/figure/roboticist,\
					/obj/item/toy/figure/scientist,\
					/obj/item/toy/figure/syndie,\
					/obj/item/toy/figure/secofficer,\
					/obj/item/toy/figure/warden,\
					/obj/item/toy/figure/psychologist,\
					/obj/item/toy/figure/paramedic,\
					/obj/item/toy/figure/ert)


/obj/random/plushie
	name = "random plushie"
	desc = "This is a random plushie."
	icon = 'icons/obj/toy.dmi'
	icon_state = "nymphplushie"
	item_to_spawn()
		return pick(/obj/structure/plushie/ian,\
					/obj/structure/plushie/drone,\
					/obj/structure/plushie/carp,\
					/obj/structure/plushie/beepsky,\
					/obj/item/toy/plushie/nymph,\
					/obj/item/toy/plushie/mouse,\
					/obj/item/toy/plushie/kitten,\
					/obj/item/toy/plushie/lizard)

/obj/random/junk //Broken items, or stuff that could be picked up
	name = "random junk"
	desc = "This is some random junk."
	icon = 'icons/obj/trash.dmi'
	icon_state = "trashbag3"
	item_to_spawn()
		return pick(/obj/item/material/shard,\
					/obj/item/material/shard/shrapnel,\
					/obj/item/stack/material/cardboard,\
					/obj/item/storage/box/lights/mixed,\
					/obj/item/trash/raisins,\
					/obj/item/trash/candy,\
					/obj/item/trash/cheesie,\
					/obj/item/trash/chips,\
					/obj/item/trash/popcorn,\
					/obj/item/trash/sosjerky,\
					/obj/item/trash/syndi_cakes,\
					/obj/item/trash/waffles,\
					/obj/item/trash/plate,\
					/obj/item/trash/snack_bowl,\
					/obj/item/trash/pistachios,\
					/obj/item/trash/semki,\
					/obj/item/trash/tray,\
					/obj/item/trash/candle,\
					/obj/item/trash/liquidfood,\
					/obj/item/trash/tastybread,\
					/obj/item/paper/crumpled,\
					/obj/item/paper/crumpled/bloody,\
					/obj/effect/decal/cleanable/molten_item,\
					/obj/item/cigbutt,\
					/obj/item/cigbutt/cigarbutt,\
					/obj/item/pen,\
					/obj/item/pen/blue,\
					/obj/item/pen/red,\
					/obj/item/pen/multi,\
					/obj/item/bananapeel,\
					/obj/item/inflatable/torn,\
					/obj/item/storage/box/matches)


/obj/random/trash //Mostly remains and cleanable decals. Stuff a janitor could clean up
	name = "random trash"
	desc = "This is some random trash."
	icon = 'icons/effects/effects.dmi'
	icon_state = "greenglow"
	item_to_spawn()
		return pick(/obj/item/remains/lizard,\
					/obj/effect/decal/cleanable/blood/gibs/robot,\
					/obj/effect/decal/cleanable/blood/oil,\
					/obj/effect/decal/cleanable/blood/oil/streak,\
					/obj/effect/decal/cleanable/spiderling_remains,\
					/obj/item/remains/mouse,\
					/obj/effect/decal/cleanable/vomit,\
					/obj/effect/decal/cleanable/blood/splatter,\
					/obj/effect/decal/cleanable/ash,\
					/obj/effect/decal/cleanable/generic,\
					/obj/effect/decal/cleanable/flour,\
					/obj/effect/decal/cleanable/dirt,\
					/obj/item/remains/robot)


obj/random/closet //A couple of random closets to spice up maint
	name = "random closet"
	desc = "This is a random closet."
	icon = 'icons/obj/closet.dmi'
	icon_state = "syndicate1"
	item_to_spawn()
		return pick(/obj/structure/closet,\
					/obj/structure/closet/firecloset,\
					/obj/structure/closet/firecloset/full,\
					/obj/structure/closet/emcloset,\
					/obj/structure/closet/jcloset,\
					/obj/structure/closet/athletic_mixed,\
					/obj/structure/closet/toolcloset,\
					/obj/structure/closet/l3closet/general,\
					/obj/structure/closet/cabinet,\
					/obj/structure/closet/crate,\
					/obj/structure/closet/crate/freezer,\
					/obj/structure/closet/crate/freezer/rations,\
					/obj/structure/closet/crate/internals,\
					/obj/structure/closet/crate/trashcart,\
					/obj/structure/closet/crate/medical,\
					/obj/structure/closet/boxinggloves,\
					/obj/structure/largecrate,\
					/obj/structure/closet/wardrobe/orange)

obj/random/obstruction //Large objects to block things off in maintenance
	name = "random obstruction"
	desc = "This is a random obstruction."
	icon = 'icons/obj/cult.dmi'
	icon_state = "cultgirder"
	item_to_spawn()
		return pick(/obj/structure/barricade,\
					/obj/structure/girder,\
					/obj/structure/girder/displaced,\
					/obj/structure/grille,\
					/obj/structure/grille/broken,\
					/obj/structure/inflatable/wall,\
					/obj/structure/inflatable/door)


obj/random/material //Random materials for building stuff
	name = "random material"
	desc = "This is a random material."
	icon = 'icons/obj/items.dmi'
	icon_state = "sheet-metal"
	item_to_spawn()
		return pick(/obj/item/stack/material/steel{amount = 10},\
					/obj/item/stack/material/glass{amount = 10},\
					/obj/item/stack/material/plastic{amount = 10},\
					/obj/item/stack/material/wood{amount = 10},\
					/obj/item/stack/material/cardboard{amount = 10},\
					/obj/item/stack/rods{amount = 10},\
					/obj/item/stack/material/plasteel{amount = 10})


/obj/random/coin
	name = "random coin"
	desc = "This is a random coin."
	icon = 'icons/obj/items.dmi'
	icon_state = "coin"
	item_to_spawn()
		return pick(prob(3);/obj/item/coin/gold,\
					prob(4);/obj/item/coin/silver,\
					prob(2);/obj/item/coin/diamond,\
					prob(4);/obj/item/coin/iron,\
					prob(3);/obj/item/coin/uranium,\
					prob(1);/obj/item/coin/platinum)


/obj/random/toy
	name = "random toy"
	desc = "This is a random toy."
	icon = 'icons/obj/toy.dmi'
	icon_state = "ship"
	item_to_spawn()
		return pick(/obj/item/toy/bosunwhistle,\
					/obj/item/toy/therapy_red,\
					/obj/item/toy/therapy_purple,\
					/obj/item/toy/therapy_blue,\
					/obj/item/toy/therapy_yellow,\
					/obj/item/toy/therapy_orange,\
					/obj/item/toy/therapy_green,\
					/obj/item/toy/katana,\
					/obj/item/toy/snappop,\
					/obj/item/toy/sword,\
					/obj/item/toy/balloon,\
					/obj/item/toy/crossbow,\
					/obj/item/toy/blink,\
					/obj/item/toy/waterflower,\
					/obj/item/toy/prize/ripley,\
					/obj/item/toy/prize/fireripley,\
					/obj/item/toy/prize/deathripley,\
					/obj/item/toy/prize/gygax,\
					/obj/item/toy/prize/durand,\
					/obj/item/toy/prize/honk,\
					/obj/item/toy/prize/marauder,\
					/obj/item/toy/prize/seraph,\
					/obj/item/toy/prize/mauler,\
					/obj/item/toy/prize/odysseus,\
					/obj/item/toy/prize/phazon)


/obj/random/tank
	name = "random tank"
	desc = "This is a tank."
	icon = 'icons/obj/tank.dmi'
	icon_state = "canister"
	item_to_spawn()
		return pick(prob(5);/obj/item/tank/oxygen,\
					prob(4);/obj/item/tank/oxygen/yellow,\
					prob(4);/obj/item/tank/oxygen/red,\
					prob(3);/obj/item/tank/air,\
					prob(4);/obj/item/tank/emergency/oxygen,\
					prob(3);/obj/item/tank/emergency/oxygen/engi,\
					prob(2);/obj/item/tank/emergency/oxygen/double,\
					prob(1);/obj/item/tank/nitrogen)


/obj/random/maintenance //Clutter and loot for maintenance and away missions, if you add something, make sure it's not in one of the other lists
	name = "random maintenance item"
	desc = "This is a random maintenance item."
	icon = 'icons/obj/items.dmi'
	icon_state = "gift1"
	item_to_spawn()
		return pick(prob(5);/obj/random/tech_supply,\
					prob(4);/obj/random/medical,\
					prob(3);/obj/random/firstaid,\
					prob(1);/obj/random/contraband,\
					prob(5);/obj/random/action_figure,\
					prob(5);/obj/random/plushie,\
					prob(5);/obj/random/junk,\
					prob(5);/obj/random/trash,\
					prob(4);/obj/random/material,\
					prob(3);/obj/random/coin,\
					prob(5);/obj/random/toy,\
					prob(3);/obj/random/tank,\
					prob(3);/obj/item/flashlight/lantern,\
					prob(5);/obj/item/storage/fancy/cigarettes,\
					prob(4);/obj/item/storage/fancy/cigarettes/dromedaryco,\
					prob(3);/obj/item/storage/fancy/cigarettes/killthroat,\
					prob(1);/obj/item/storage/fancy/cigar,\
					prob(3);/obj/item/clothing/mask/gas,\
					prob(4);/obj/item/clothing/mask/breath,\
					prob(2);/obj/item/clothing/mask/balaclava,\
					prob(2);/obj/item/reagent_containers/glass/rag ,\
					prob(2);/obj/item/storage/secure/briefcase,\
					prob(4);/obj/item/storage/briefcase,\
					prob(4);/obj/item/storage/briefcase/inflatable,\
					prob(5);/obj/item/storage/backpack,\
					prob(5);/obj/item/storage/backpack/satchel,\
					prob(3);/obj/item/storage/backpack/dufflebag,\
					prob(5);/obj/item/storage/box,\
					prob(3);/obj/item/storage/box/donkpockets,\
					prob(2);/obj/item/storage/box/sinpockets,\
					prob(1);/obj/item/storage/box/cups,\
					prob(4);/obj/item/storage/box/mousetraps,\
					prob(3);/obj/item/storage/box/engineer,\
					prob(3);/obj/item/storage/wallet,\
					prob(2);/obj/item/storage/belt/utility/full,\
					prob(2);/obj/item/storage/belt/medical/emt,\
					prob(4);/obj/item/toner,\
					prob(1);/obj/item/paicard,\
					prob(3);/obj/item/clothing/shoes/workboots,\
					prob(3);/obj/item/clothing/shoes/jackboots,\
					prob(1);/obj/item/clothing/shoes/swat,\
					prob(1);/obj/item/clothing/shoes/combat,\
					prob(2);/obj/item/clothing/shoes/galoshes,\
					prob(1);/obj/item/clothing/shoes/magboots,\
					prob(4);/obj/item/clothing/shoes/laceup,\
					prob(1);/obj/item/clothing/gloves/insulated,\
					prob(4);/obj/item/clothing/gloves/thick,\
					prob(2);/obj/item/clothing/gloves/latex,\
					prob(1);/obj/item/clothing/gloves/thick/swat,\
					prob(1);/obj/item/clothing/gloves/thick/combat,\
					prob(5);/obj/item/clothing/gloves,\
					prob(5);/obj/item/clothing/gloves/rainbow,\
					prob(1);/obj/item/clothing/glasses/sunglasses,\
					prob(3);/obj/item/clothing/glasses/meson,\
					prob(2);/obj/item/clothing/glasses/meson/prescription,\
					prob(4);/obj/item/clothing/glasses/science,\
					prob(3);/obj/item/clothing/glasses/material,\
					prob(1);/obj/item/clothing/glasses/welding,\
					prob(2);/obj/item/weldingtool/largetank,\
					prob(2);/obj/item/clothing/head/helmet,\
					prob(4);/obj/item/clothing/head/hardhat,\
					prob(4);/obj/item/clothing/head/hardhat,\
					prob(4);/obj/item/clothing/head/hardhat/red,\
					prob(4);/obj/item/clothing/head/hardhat,\
					prob(2);/obj/item/clothing/head/welding,\
					prob(4);/obj/item/clothing/suit/storage/hazardvest,\
					prob(2);/obj/item/clothing/suit/armour,\
					prob(4);/obj/item/clothing/suit/storage/toggle/labcoat,\
					prob(1);/obj/item/beartrap,\
					prob(2);/obj/item/handcuffs,\
					prob(3);/obj/item/camera_assembly,\
					prob(4);/obj/item/caution,\
					prob(4);/obj/item/caution/cone,\
					prob(1);/obj/random/loot,\
					prob(3);/obj/item/radio/headset)


/obj/random/loot /*Better loot for away missions and salvage */
	name = "random loot"
	desc = "This is some random loot."
	icon = 'icons/obj/items.dmi'
	icon_state = "gift2"
	item_to_spawn()
		return pick(prob(4);/obj/random/powercell,\
					prob(4);/obj/random/technology_scanner,\
					prob(4);/obj/random/bomb_supply,\
					prob(4);/obj/item/stack/cable_coil,\
					prob(3);/obj/random/toolbox,\
					prob(4);/obj/random/tool,\
					prob(4);/obj/item/tape_roll,\
					prob(4);/obj/random/medical,\
					prob(3);/obj/random/firstaid,\
					prob(2);/obj/random/contraband,\
					prob(4);/obj/random/material,\
					prob(3);/obj/random/coin,\
					prob(3);/obj/random/tank,\
					prob(1);/obj/random/energy,\
					prob(1);/obj/random/projectile,\
					prob(4);/obj/item/flashlight/lantern,\
					prob(4);/obj/item/storage/fancy/cigarettes/dromedaryco,\
					prob(3);/obj/item/storage/fancy/cigarettes/killthroat,\
					prob(2);/obj/item/storage/fancy/cigar,\
					prob(4);/obj/item/clothing/mask/gas,\
					prob(3);/obj/item/clothing/mask/gas/swat,\
					prob(2);/obj/item/clothing/mask/balaclava,\
					prob(2);/obj/item/reagent_containers/glass/rag ,\
					prob(5);/obj/item/storage/box,\
					prob(3);/obj/item/storage/box/donkpockets,\
					prob(2);/obj/item/storage/box/sinpockets,\
					prob(2);/obj/item/storage/belt/utility/full,\
					prob(1);/obj/item/clothing/shoes/swat,\
					prob(1);/obj/item/clothing/shoes/combat,\
					prob(2);/obj/item/clothing/shoes/galoshes,\
					prob(1);/obj/item/clothing/shoes/magboots,\
					prob(4);/obj/item/clothing/shoes/laceup,\
					prob(4);/obj/item/clothing/gloves/thick,\
					prob(2);/obj/item/clothing/gloves/latex,\
					prob(1);/obj/item/clothing/gloves/thick/swat,\
					prob(1);/obj/item/clothing/gloves/thick/combat,\
					prob(1);/obj/item/clothing/gloves/insulated,\
					prob(1);/obj/item/clothing/glasses/sunglasses,\
					prob(3);/obj/item/clothing/glasses/meson,\
					prob(2);/obj/item/clothing/glasses/meson/prescription,\
					prob(4);/obj/item/clothing/glasses/science,\
					prob(3);/obj/item/clothing/glasses/material,\
					prob(2);/obj/item/clothing/glasses/welding,\
					prob(1);/obj/item/clothing/glasses/night,\
					prob(1);/obj/item/clothing/glasses/thermal,\
					prob(3);/obj/item/weldingtool/largetank,\
					prob(4);/obj/item/clothing/head/helmet,\
					prob(2);/obj/item/clothing/head/welding,\
					prob(4);/obj/item/clothing/suit/storage/hazardvest,\
					prob(4);/obj/item/clothing/suit/armour,\
					prob(4);/obj/item/clothing/suit/storage/toggle/labcoat,\
					prob(2);/obj/item/handcuffs,\
					prob(2);/obj/item/circular_saw,\
					prob(2);/obj/item/scalpel,\
					prob(2);/obj/item/stack/material/diamond{amount = 10},\
					prob(2);/obj/item/stack/material/glass/phoronrglass{amount = 10},\
					prob(3);/obj/item/stack/material/marble{amount = 10},\
					prob(2);/obj/item/stack/material/gold{amount = 10},\
					prob(2);/obj/item/stack/material/silver{amount = 10},\
					prob(2);/obj/item/stack/material/osmium{amount = 10},\
					prob(3);/obj/item/stack/material/platinum{amount = 10},\
					prob(2);/obj/item/stack/material/tritium{amount = 10},\
					prob(2);/obj/item/stack/material/mhydrogen{amount = 10},\
					prob(3);/obj/item/stack/material/plasteel{amount = 10},\
					prob(2);/obj/item/multitool/hacktool,\
					prob(3);/obj/item/radio/headset)

/obj/random/voidhelmet
	name = "Random Pressure Suit Helmet"
	desc = "This is a random suit helmet."
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "void"
	item_to_spawn()
		return pick(/obj/item/clothing/head/helmet/space/void,\
					/obj/item/clothing/head/helmet/space/void,\
					/obj/item/clothing/head/helmet/space/void/industrial,\
					/obj/item/clothing/head/helmet/space/void/merc,\
					/obj/item/clothing/head/helmet/space/void/armoured \
					)

/obj/random/voidsuit
	name = "Random Pressure Suit"
	desc = "This is a random suit."
	icon = 'icons/obj/clothing/suits.dmi'
	icon_state = "void"
	item_to_spawn()
		return pick(/obj/item/clothing/suit/space/void,\
					/obj/item/clothing/suit/space/void/industrial,\
					/obj/item/clothing/suit/space/void/armoured,\
					/obj/item/clothing/suit/space/void/merc)

/obj/random/hardsuit
	name = "Random Hardsuit"
	desc = "This is a random hardsuit control module."
	icon = 'icons/obj/rig_modules.dmi'
	icon_state = "generic"
	item_to_spawn()
		return pick(/obj/item/rig/industrial,\
					/obj/item/rig/eva,\
					/obj/item/rig/light/hacker,\
					)

/*
	Selects one spawn point out of a group of points with the same ID and asks it to generate its items
*/
var/list/multi_point_spawns

/obj/random_multi
	name = "random object spawn point"
	desc = "This item type is used to spawn random objects at round-start. Only one spawn point for a given group id is selected."
	icon = 'icons/misc/mark.dmi'
	icon_state = "x3"
	invisibility = INVISIBILITY_MAXIMUM
	auto_init = TRUE
	var/id     // Group id
	var/weight // Probability weight for this spawn point

/obj/random_multi/initialize()
	..()
	weight = max(1, round(weight))

	if(!multi_point_spawns)
		multi_point_spawns = list()
	var/list/spawnpoints = multi_point_spawns[id]
	if(!spawnpoints)
		spawnpoints = list()
		multi_point_spawns[id] = spawnpoints
	spawnpoints[src] = weight

/obj/random_multi/Destroy()
	var/list/spawnpoints = multi_point_spawns[id]
	spawnpoints -= src
	if(!spawnpoints.len)
		multi_point_spawns -= id
	. = ..()

/obj/random_multi/proc/generate_items()
	return

/obj/random_multi/single_item
	var/item_path  // Item type to spawn

/obj/random_multi/single_item/generate_items()
	new item_path(loc)

/hook/roundstart/proc/generate_multi_spawn_items()
	for(var/id in multi_point_spawns)
		var/list/spawn_points = multi_point_spawns[id]
		var/obj/random_multi/rm = pickweight(spawn_points)
		rm.generate_items()
		for(var/entry in spawn_points)
			qdel(entry)
	return 1

/obj/random_multi/single_item/captains_spare_id
	name = "Multi Point - Captain's Spare"
	id = "Captain's spare id"
	item_path = /obj/item/card/id/captains_spare
