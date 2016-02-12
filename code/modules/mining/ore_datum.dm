var/global/list/ore_data = list()

/ore
	var/name
	var/display_name
	var/alloy
	var/smelts_to
	var/compresses_to
	var/result_amount     // How much ore?
	var/spread = 1	      // Does this type of deposit spread?
	var/spread_chance     // Chance of spreading in any direction
	var/ore	              // Path to the ore produced when tile is mined.
	var/scan_icon         // Overlay for ore scanners.
	// Xenoarch stuff. No idea what it's for, just refactored it to be less awful.
	var/list/xarch_ages = list(
		"thousand" = 999,
		"million" = 999
		)
	var/xarch_source_mineral = "iron"

/ore/New()
	. = ..()
	if(!display_name)
		display_name = name

/ore/uranium
	name = "uranium"
	display_name = "pitchblende"
	smelts_to = /material/uranium
	result_amount = 5
	spread_chance = 10
	ore = /obj/item/weapon/ore/uranium
	scan_icon = "mineral_uncommon"
	xarch_ages = list(
		"thousand" = 999,
		"million" = 704
		)
	xarch_source_mineral = "potassium"

/ore/hematite
	name = "hematite"
	display_name = "hematite"
	smelts_to = /material/iron
	alloy = 1
	result_amount = 5
	spread_chance = 25
	ore = /obj/item/weapon/ore/iron
	scan_icon = "mineral_common"

/ore/coal
	name = "carbon"
	display_name = "raw carbon"
	smelts_to = /material/plastic
	alloy = 1
	result_amount = 5
	spread_chance = 25
	ore = /obj/item/weapon/ore/coal
	scan_icon = "mineral_common"

/ore/glass
	name = "sand"
	display_name = "sand"
	smelts_to = /material/glass
	compresses_to = /material/stone

/ore/silver
	name = "silver"
	display_name = "native silver"
	smelts_to = /material/silver
	result_amount = 5
	spread_chance = 10
	ore = /obj/item/weapon/ore/silver
	scan_icon = "mineral_uncommon"

/ore/gold
	smelts_to = /material/gold
	name = "gold"
	display_name = "native gold"
	result_amount = 5
	spread_chance = 10
	ore = /obj/item/weapon/ore/gold
	scan_icon = "mineral_uncommon"
	xarch_ages = list(
		"thousand" = 999,
		"million" = 999,
		"billion" = 4,
		"billion_lower" = 3
		)

/ore/diamond
	name = "diamond"
	display_name = "diamond"
	compresses_to = /material/diamond
	result_amount = 5
	spread_chance = 10
	ore = /obj/item/weapon/ore/diamond
	scan_icon = "mineral_rare"
	xarch_source_mineral = REAGENT_ID_NITROGEN

/ore/platinum
	name = "platinum"
	display_name = "raw platinum"
	smelts_to = /material/platinum
	compresses_to = /material/osmium
	alloy = 1
	result_amount = 5
	spread_chance = 10
	ore = /obj/item/weapon/ore/osmium
	scan_icon = "mineral_rare"

/ore/hydrogen
	name = "mhydrogen"
	display_name = "metallic hydrogen"
	smelts_to = /material/tritium
	compresses_to = /material/mhydrogen
	scan_icon = "mineral_rare"