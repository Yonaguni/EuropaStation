var/list/autolathe_recipes
var/list/autolathe_categories

var/list/autolathe_generic =  list()
var/list/autolathe_robotics = list()
var/list/autolathe_circuits = list()
var/list/autolathe_advanced = list()
var/list/autolathe_heavy =    list()

/proc/populate_lathe_recipes()

	if(autolathe_recipes && autolathe_recipes.len)
		return

	//Create global autolathe recipe lists if they hasn't been made already.
	autolathe_recipes = list()
	autolathe_categories = list()
	for(var/R in typesof(/datum/autolathe/recipe)-/datum/autolathe/recipe)
		var/datum/autolathe/recipe/recipe = new R
		autolathe_recipes += recipe
		autolathe_categories |= recipe.category

		switch(recipe.lathe_type)
			if(LATHE_TYPE_ROBOTICS)
				autolathe_robotics += recipe
			if(LATHE_TYPE_CIRCUIT)
				autolathe_circuits += recipe
			if(LATHE_TYPE_ADVANCED)
				autolathe_advanced += recipe
			if(LATHE_TYPE_HEAVY)
				autolathe_heavy += recipe
			else
				autolathe_generic += recipe

		var/obj/item/I = new recipe.path
		if(I.matter && !recipe.resources) //This can be overidden in the datums.
			recipe.resources = list()
			for(var/material in I.matter)
				recipe.resources[material] = I.matter[material]*1.25 // More expensive to produce than they are to recycle.
		qdel(I)

/datum/autolathe/recipe
	var/name = "object"
	var/path
	var/list/resources
	var/hidden
	var/category
	var/power_use = 0
	var/is_stack
	var/lathe_type = LATHE_TYPE_GENERIC

/datum/autolathe/recipe/bucket
	name = "bucket"
	path = /obj/item/reagent_containers/glass/bucket
	category = "General"

/datum/autolathe/recipe/drinkingglass
	name = "drinking glass"
	path = /obj/item/reagent_containers/food/drinks/glass2/square
	category = "General"
	New()
		..()
		var/obj/O = path
		name = initial(O.name) // generic recipes yay

/datum/autolathe/recipe/drinkingglass/rocks
	path = /obj/item/reagent_containers/food/drinks/glass2/rocks

/datum/autolathe/recipe/drinkingglass/shake
	path = /obj/item/reagent_containers/food/drinks/glass2/shake

/datum/autolathe/recipe/drinkingglass/cocktail
	path = /obj/item/reagent_containers/food/drinks/glass2/cocktail

/datum/autolathe/recipe/drinkingglass/shot
	path = /obj/item/reagent_containers/food/drinks/glass2/shot

/datum/autolathe/recipe/drinkingglass/pint
	path = /obj/item/reagent_containers/food/drinks/glass2/pint

/datum/autolathe/recipe/drinkingglass/mug
	path = /obj/item/reagent_containers/food/drinks/glass2/mug

/datum/autolathe/recipe/drinkingglass/wine
	path = /obj/item/reagent_containers/food/drinks/glass2/wine

/datum/autolathe/recipe/flashlight
	name = "flashlight"
	path = /obj/item/flashlight
	category = "General"

/datum/autolathe/recipe/floor_light
	name = "floor light"
	path = /obj/machinery/floor_light
	category = "General"

/datum/autolathe/recipe/extinguisher
	name = "extinguisher"
	path = /obj/item/extinguisher
	category = "General"

/datum/autolathe/recipe/jar
	name = "jar"
	path = /obj/item/glass_jar
	category = "General"

/datum/autolathe/recipe/crowbar
	name = "crowbar"
	path = /obj/item/crowbar
	category = "Tools"

/datum/autolathe/recipe/multitool
	name = "multitool"
	path = /obj/item/multitool
	category = "Tools"

/datum/autolathe/recipe/t_scanner
	name = "T-ray scanner"
	path = /obj/item/t_scanner
	category = "Tools"

/datum/autolathe/recipe/weldertool
	name = "welding tool"
	path = /obj/item/weldingtool
	category = "Tools"

/datum/autolathe/recipe/screwdriver
	name = "screwdriver"
	path = /obj/item/screwdriver
	category = "Tools"

/datum/autolathe/recipe/wirecutters
	name = "wirecutters"
	path = /obj/item/wirecutters
	category = "Tools"

/datum/autolathe/recipe/wrench
	name = "wrench"
	path = /obj/item/wrench
	category = "Tools"

/datum/autolathe/recipe/hatchet
	name = "hatchet"
	path = /obj/item/material/hatchet
	category = "Tools"

/datum/autolathe/recipe/minihoe
	name = "mini hoe"
	path = /obj/item/material/minihoe
	category = "Tools"

/datum/autolathe/recipe/radio_headset
	name = "radio headset"
	path = /obj/item/radio/headset
	category = "General"

/datum/autolathe/recipe/radio_bounced
	name = "bounced radio"
	path = /obj/item/radio/off
	category = "General"

/datum/autolathe/recipe/suit_cooler
	name = "suit cooling unit"
	path = /obj/item/suit_cooling_unit
	category = "General"

/datum/autolathe/recipe/weldermask
	name = "welding mask"
	path = /obj/item/clothing/head/welding
	category = "General"

/datum/autolathe/recipe/metal
	name = "steel sheets"
	path = /obj/item/stack/material/steel
	category = "General"
	is_stack = 1

/datum/autolathe/recipe/glass
	name = "glass sheets"
	path = /obj/item/stack/material/glass
	category = "General"
	is_stack = 1

/datum/autolathe/recipe/rglass
	name = "reinforced glass sheets"
	path = /obj/item/stack/material/glass/reinforced
	category = "General"
	is_stack = 1

/datum/autolathe/recipe/rods
	name = "metal rods"
	path = /obj/item/stack/rods
	category = "General"
	is_stack = 1

/datum/autolathe/recipe/knife
	name = "kitchen knife"
	path = /obj/item/material/knife
	category = "General"

/datum/autolathe/recipe/taperecorder
	name = "tape recorder"
	path = /obj/item/taperecorder/empty
	category = "General"

/datum/autolathe/recipe/tape
	name = "tape"
	path = /obj/item/tape
	category = "General"

/datum/autolathe/recipe/airlockmodule
	name = "airlock electronics"
	path = /obj/item/airlock_electronics
	category = "Engineering"

/datum/autolathe/recipe/airalarm
	name = "air alarm electronics"
	path = /obj/item/airalarm_electronics
	category = "Engineering"

/datum/autolathe/recipe/firealarm
	name = "fire alarm electronics"
	path = /obj/item/firealarm_electronics
	category = "Engineering"

/datum/autolathe/recipe/powermodule
	name = "power control module"
	path = /obj/item/module/power_control
	category = "Engineering"

/datum/autolathe/recipe/rcd_ammo
	name = "matter cartridge"
	path = /obj/item/rcd_ammo
	category = "Engineering"

/datum/autolathe/recipe/scalpel
	name = "scalpel"
	path = /obj/item/scalpel
	category = "Medical"

/datum/autolathe/recipe/circularsaw
	name = "circular saw"
	path = /obj/item/circular_saw
	category = "Medical"

/datum/autolathe/recipe/surgicaldrill
	name = "surgical drill"
	path = /obj/item/surgicaldrill
	category = "Medical"

/datum/autolathe/recipe/retractor
	name = "retractor"
	path = /obj/item/retractor
	category = "Medical"

/datum/autolathe/recipe/cautery
	name = "cautery"
	path = /obj/item/cautery
	category = "Medical"

/datum/autolathe/recipe/hemostat
	name = "hemostat"
	path = /obj/item/hemostat
	category = "Medical"

/datum/autolathe/recipe/beaker
	name = "glass beaker"
	path = /obj/item/reagent_containers/glass/beaker
	category = "Medical"

/datum/autolathe/recipe/beaker_large
	name = "large glass beaker"
	path = /obj/item/reagent_containers/glass/beaker/large
	category = "Medical"

/datum/autolathe/recipe/vial
	name = "glass vial"
	path = /obj/item/reagent_containers/glass/beaker/vial
	category = "Medical"

/datum/autolathe/recipe/syringe
	name = "syringe"
	path = /obj/item/reagent_containers/syringe
	category = "Medical"

/datum/autolathe/recipe/syringegun_ammo
	name = "syringe gun cartridge"
	path = /obj/item/syringe_cartridge
	category = "Arms and Ammunition"

/datum/autolathe/recipe/consolescreen
	name = "console screen"
	path = /obj/item/stock_parts/console_screen
	category = "Devices and Components"

/datum/autolathe/recipe/igniter
	name = "igniter"
	path = /obj/item/assembly/igniter
	category = "Devices and Components"

/datum/autolathe/recipe/signaler
	name = "signaler"
	path = /obj/item/assembly/signaler
	category = "Devices and Components"

/datum/autolathe/recipe/sensor_infra
	name = "infrared sensor"
	path = /obj/item/assembly/infra
	category = "Devices and Components"

/datum/autolathe/recipe/timer
	name = "timer"
	path = /obj/item/assembly/timer
	category = "Devices and Components"

/datum/autolathe/recipe/sensor_prox
	name = "proximity sensor"
	path = /obj/item/assembly/prox_sensor
	category = "Devices and Components"

/datum/autolathe/recipe/tube
	name = "light tube"
	path = /obj/item/light/tube
	category = "General"

/datum/autolathe/recipe/bulb
	name = "light bulb"
	path = /obj/item/light/bulb
	category = "General"

/datum/autolathe/recipe/ashtray_glass
	name = "glass ashtray"
	path = /obj/item/material/ashtray/glass
	category = "General"

/datum/autolathe/recipe/camera_assembly
	name = "camera assembly"
	path = /obj/item/camera_assembly
	category = "Engineering"

/datum/autolathe/recipe/weldinggoggles
	name = "welding goggles"
	path = /obj/item/clothing/glasses/welding
	category = "General"

/datum/autolathe/recipe/flamethrower
	name = "flamethrower"
	path = /obj/item/flamethrower/full
	hidden = 1
	category = "Arms and Ammunition"

/datum/autolathe/recipe/shotgun
	name = "ammunition (slug, shotgun)"
	path = /obj/item/ammo_casing/shotgun
	hidden = 1
	category = "Arms and Ammunition"

/datum/autolathe/recipe/tacknife
	name = "tactical knife"
	path = /obj/item/material/hatchet/tacknife
	hidden = 1
	category = "Arms and Ammunition"

/datum/autolathe/recipe/rcd
	name = "rapid construction device"
	path = /obj/item/rcd
	hidden = 1
	category = "Engineering"

/datum/autolathe/recipe/electropack
	name = "electropack"
	path = /obj/item/radio/electropack
	hidden = 1
	category = "Devices and Components"

/datum/autolathe/recipe/beartrap
	name = "mechanical trap"
	path = /obj/item/beartrap
	hidden = 1
	category = "Devices and Components"

/datum/autolathe/recipe/welder_industrial
	name = "industrial welding tool"
	path = /obj/item/weldingtool/largetank
	hidden = 1
	category = "Tools"

/datum/autolathe/recipe/handcuffs
	name = "handcuffs"
	path = /obj/item/handcuffs
	hidden = 1
	category = "General"
