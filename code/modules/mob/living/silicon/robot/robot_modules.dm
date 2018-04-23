var/global/list/robot_modules = list(
	"Standard"		= /obj/item/robot_module/standard,
	"Service" 		= /obj/item/robot_module/clerical/butler,
	"Clerical" 		= /obj/item/robot_module/clerical/general,
	"Miner" 		= /obj/item/robot_module/miner,
	"Crisis" 		= /obj/item/robot_module/medical/crisis,
	"Surgeon" 		= /obj/item/robot_module/medical/surgeon,
	"Security" 		= /obj/item/robot_module/security/general,
	"Combat" 		= /obj/item/robot_module/security/combat,
	"Engineering"	= /obj/item/robot_module/engineering/general,
	"Janitor" 		= /obj/item/robot_module/janitor
	)

/obj/item/robot_module
	name = "robot module"
	icon = 'icons/obj/module.dmi'
	icon_state = "std_module"
	w_class = 100.0
	item_state = "electronic"
	flags = CONDUCT
	var/hide_on_manifest = 0
	var/channels = list()
	var/networks = list()
	var/languages = list(
		LANGUAGE_RUNGLISH = 1,
		LANGUAGE_EXTERIOR = 1,
		LANGUAGE_CEPHLAPODA = 0,
		LANGUAGE_CORVID = 0)
	var/sprites = list()
	var/can_be_pushed = 1
	var/no_slip = 0
	var/list/modules = list()
	var/list/datum/matter_synth/synths = list()
	var/obj/item/emag = null
	var/obj/item/borg/upgrade/jetpack = null
	var/list/subsystems = list()
	var/list/obj/item/borg/upgrade/supported_upgrades = list()

	// Bookkeeping
	var/list/original_languages = list()
	var/list/added_networks = list()

/obj/item/robot_module/New(var/mob/living/silicon/robot/R)
	..()
	R.module = src

	add_camera_networks(R)
	add_languages(R)
	add_subsystems(R)
	apply_status_flags(R)

	if(R.radio)
		R.radio.recalculateChannels()

	R.set_module_sprites(sprites)
	R.choose_icon(R.module_sprites.len + 1, R.module_sprites)

	for(var/obj/item/I in modules)
		I.canremove = 0

/obj/item/robot_module/proc/Reset(var/mob/living/silicon/robot/R)
	remove_camera_networks(R)
	remove_languages(R)
	remove_subsystems(R)
	remove_status_flags(R)

	if(R.radio)
		R.radio.recalculateChannels()
	R.choose_icon(0, R.set_module_sprites(list("Default" = "motile")))

/obj/item/robot_module/Destroy()
	for(var/module in modules)
		qdel(module)
	for(var/synth in synths)
		qdel(synth)
	modules.Cut()
	synths.Cut()
	qdel(emag)
	qdel(jetpack)
	emag = null
	jetpack = null
	return ..()

/obj/item/robot_module/emp_act(severity)
	if(modules)
		for(var/obj/O in modules)
			O.emp_act(severity)
	if(emag)
		emag.emp_act(severity)
	if(synths)
		for(var/datum/matter_synth/S in synths)
			S.emp_act(severity)
	..()
	return

/obj/item/robot_module/proc/respawn_consumable(var/mob/living/silicon/robot/R, var/rate)
	var/obj/item/flash/F = locate() in src.modules
	if(F)
		F.times_used_this_minute = 0
		if(F.broken)
			F.broken = FALSE
			F.icon_state = "flash"

	if(!synths || !synths.len)
		return

	for(var/datum/matter_synth/T in synths)
		T.add_charge(T.recharge_rate * rate)

/obj/item/robot_module/proc/rebuild()//Rebuilds the list so it's possible to add/remove items from the module
	var/list/temp_list = modules
	modules = list()
	for(var/obj/O in temp_list)
		if(O)
			modules += O

/obj/item/robot_module/proc/add_languages(var/mob/living/silicon/robot/R)
	// Stores the languages as they were before receiving the module, and whether they could be synthezized.
	for(var/datum/language/language_datum in R.languages)
		original_languages[language_datum] = (language_datum in R.speech_synthesizer_langs)

	for(var/language in languages)
		R.add_language(language, languages[language])

/obj/item/robot_module/proc/remove_languages(var/mob/living/silicon/robot/R)
	// Clear all added languages, whether or not we originally had them.
	for(var/language in languages)
		R.remove_language(language)

	// Then add back all the original languages, and the relevant synthezising ability
	for(var/original_language in original_languages)
		R.add_language(original_language, original_languages[original_language])
	original_languages.Cut()

/obj/item/robot_module/proc/add_camera_networks(var/mob/living/silicon/robot/R)
	if(R.camera && (NETWORK_ROBOTS in R.camera.network))
		for(var/network in networks)
			if(!(network in R.camera.network))
				R.camera.add_network(network)
				added_networks |= network

/obj/item/robot_module/proc/remove_camera_networks(var/mob/living/silicon/robot/R)
	if(R.camera)
		R.camera.remove_networks(added_networks)
	added_networks.Cut()

/obj/item/robot_module/proc/add_subsystems(var/mob/living/silicon/robot/R)
	for(var/subsystem_type in subsystems)
		R.init_subsystem(subsystem_type)

/obj/item/robot_module/proc/remove_subsystems(var/mob/living/silicon/robot/R)
	for(var/subsystem_type in subsystems)
		R.remove_subsystem(subsystem_type)

/obj/item/robot_module/proc/apply_status_flags(var/mob/living/silicon/robot/R)
	if(!can_be_pushed)
		R.status_flags &= ~CANPUSH

/obj/item/robot_module/proc/remove_status_flags(var/mob/living/silicon/robot/R)
	if(!can_be_pushed)
		R.status_flags |= CANPUSH

/obj/item/robot_module/standard
	name = "standard robot module"
	sprites = list(
				"Default" = "motile"
				  )

/obj/item/robot_module/standard/New()
	src.modules += new /obj/item/flash(src)
	src.modules += new /obj/item/melee/baton/loaded(src)
	src.modules += new /obj/item/extinguisher(src)
	src.modules += new /obj/item/wrench(src)
	src.modules += new /obj/item/crowbar(src)
	src.modules += new /obj/item/healthanalyzer(src)
	src.emag = new /obj/item/melee/energy/sword(src)
	..()

/obj/item/robot_module/medical
	name = "medical robot module"
	channels = list("Medical" = 1)
	networks = list(NETWORK_MEDICAL)
	subsystems = list(/datum/nano_module/crew_monitor)
	can_be_pushed = 0

/obj/item/robot_module/medical/surgeon
	name = "surgeon robot module"
	sprites = list(
					"Default" = "medicalrobot"
					)

/obj/item/robot_module/medical/surgeon/New()
	src.modules += new /obj/item/flash(src)
	src.modules += new /obj/item/healthanalyzer(src)
	src.modules += new /obj/item/reagent_containers/borghypo/surgeon(src)
	src.modules += new /obj/item/scalpel(src)
	src.modules += new /obj/item/hemostat(src)
	src.modules += new /obj/item/retractor(src)
	src.modules += new /obj/item/cautery(src)
	src.modules += new /obj/item/bonegel(src)
	src.modules += new /obj/item/suture(src)
	src.modules += new /obj/item/bonesetter(src)
	src.modules += new /obj/item/circular_saw(src)
	src.modules += new /obj/item/surgicaldrill(src)
	src.modules += new /obj/item/extinguisher/mini(src)
	src.emag = new /obj/item/reagent_containers/spray(src)
	src.emag.reagents.add_reagent("pacid", 250)
	src.emag.name = "Polyacid spray"

	var/datum/matter_synth/medicine = new /datum/matter_synth/medicine(10000)
	synths += medicine

	var/obj/item/stack/nanopaste/N = new /obj/item/stack/nanopaste(src)
	var/obj/item/stack/medical/advanced/bruise_pack/B = new /obj/item/stack/medical/advanced/bruise_pack(src)
	N.uses_charge = 1
	N.charge_costs = list(1000)
	N.synths = list(medicine)
	B.uses_charge = 1
	B.charge_costs = list(1000)
	B.synths = list(medicine)
	src.modules += N
	src.modules += B

	..()

/obj/item/robot_module/medical/surgeon/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	if(src.emag)
		var/obj/item/reagent_containers/spray/PS = src.emag
		PS.reagents.add_reagent("pacid", 2 * amount)
	..()

/obj/item/robot_module/medical/crisis
	name = "crisis robot module"
	sprites = list(
					"Default" = "medicalrobot"
					)

/obj/item/robot_module/medical/crisis/New()
	src.modules += new /obj/item/crowbar(src)
	src.modules += new /obj/item/flash(src)
	src.modules += new /obj/item/borg/sight/hud/med(src)
	src.modules += new /obj/item/healthanalyzer(src)
	src.modules += new /obj/item/reagent_scanner/adv(src)
	src.modules += new /obj/item/roller_holder(src)
	src.modules += new /obj/item/reagent_containers/borghypo/crisis(src)
	src.modules += new /obj/item/reagent_containers/dropper/industrial(src)
	src.modules += new /obj/item/reagent_containers/syringe(src)
	src.modules += new /obj/item/gripper/chemistry(src)
	src.modules += new /obj/item/extinguisher/mini(src)
	src.modules += new /obj/item/inflatable_dispenser/robot(src) // Allows usage of inflatables. Since they are basically robotic alternative to EMTs, they should probably have them.
	src.emag = new /obj/item/reagent_containers/spray(src)
	src.emag.reagents.add_reagent("pacid", 250)
	src.emag.name = "Polyacid spray"

	var/datum/matter_synth/medicine = new /datum/matter_synth/medicine(15000)
	synths += medicine

	var/obj/item/stack/medical/ointment/O = new /obj/item/stack/medical/ointment(src)
	var/obj/item/stack/medical/bruise_pack/B = new /obj/item/stack/medical/bruise_pack(src)
	var/obj/item/stack/medical/splint/S = new /obj/item/stack/medical/splint(src)
	O.uses_charge = 1
	O.charge_costs = list(1000)
	O.synths = list(medicine)
	B.uses_charge = 1
	B.charge_costs = list(1000)
	B.synths = list(medicine)
	S.uses_charge = 1
	S.charge_costs = list(1000)
	S.synths = list(medicine)
	src.modules += O
	src.modules += B
	src.modules += S

	..()

/obj/item/robot_module/medical/crisis/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	var/obj/item/reagent_containers/syringe/S = locate() in src.modules
	if(S.mode == 2)
		S.reagents.clear_reagents()
		S.mode = initial(S.mode)
		S.desc = initial(S.desc)
		S.update_icon()

	if(src.emag)
		var/obj/item/reagent_containers/spray/PS = src.emag
		PS.reagents.add_reagent("pacid", 2 * amount)

	..()


/obj/item/robot_module/engineering
	name = "engineering robot module"
	channels = list("Engineering" = 1)
	networks = list(NETWORK_ENGINEERING)
	subsystems = list(/datum/nano_module/power_monitor)
	supported_upgrades = list(/obj/item/borg/upgrade/rcd)
	sprites = list(
					"Default" = "motile-eng"
					)

/obj/item/robot_module/engineering/general/New()
	src.modules += new /obj/item/flash(src)
	src.modules += new /obj/item/borg/sight/meson(src)
	src.modules += new /obj/item/extinguisher(src)
	src.modules += new /obj/item/weldingtool/largetank(src)
	src.modules += new /obj/item/screwdriver(src)
	src.modules += new /obj/item/wrench(src)
	src.modules += new /obj/item/crowbar(src)
	src.modules += new /obj/item/wirecutters(src)
	src.modules += new /obj/item/multitool(src)
	src.modules += new /obj/item/t_scanner(src)
	src.modules += new /obj/item/analyzer(src)
	src.modules += new /obj/item/taperoll/engineering(src)
	src.modules += new /obj/item/gripper(src)
	src.modules += new /obj/item/lightreplacer(src)
	src.modules += new /obj/item/pipe_painter(src)
	src.modules += new /obj/item/floor_painter(src)
	src.modules += new /obj/item/inflatable_dispenser/robot(src)
	src.emag = new /obj/item/borg/stun(src)

	var/datum/matter_synth/metal = new /datum/matter_synth/metal(60000)
	var/datum/matter_synth/glass = new /datum/matter_synth/glass(40000)
	var/datum/matter_synth/plasteel = new /datum/matter_synth/plasteel(20000)
	var/datum/matter_synth/wire = new /datum/matter_synth/wire()
	synths += metal
	synths += glass
	synths += plasteel
	synths += wire

	var/obj/item/matter_decompiler/MD = new /obj/item/matter_decompiler(src)
	MD.metal = metal
	MD.glass = glass
	src.modules += MD

	var/obj/item/stack/material/cyborg/steel/M = new (src)
	M.synths = list(metal)
	src.modules += M

	var/obj/item/stack/material/cyborg/glass/G = new (src)
	G.synths = list(glass)
	src.modules += G

	var/obj/item/stack/rods/cyborg/R = new /obj/item/stack/rods/cyborg(src)
	R.synths = list(metal)
	src.modules += R

	var/obj/item/stack/cable_coil/cyborg/C = new /obj/item/stack/cable_coil/cyborg(src)
	C.synths = list(wire)
	src.modules += C

	var/obj/item/stack/tile/floor/cyborg/S = new /obj/item/stack/tile/floor/cyborg(src)
	S.synths = list(metal)
	src.modules += S

	var/obj/item/stack/material/cyborg/glass/reinforced/RG = new (src)
	RG.synths = list(metal, glass)
	src.modules += RG

	var/obj/item/stack/material/cyborg/plasteel/PL = new (src)
	PL.synths = list(plasteel)
	src.modules += PL

	..()

/obj/item/robot_module/security
	name = "security robot module"
	channels = list("Security" = 1)
	networks = list(NETWORK_SECURITY)
	subsystems = list(/datum/nano_module/crew_monitor)
	can_be_pushed = 0
	supported_upgrades = list()

/obj/item/robot_module/security/general
	sprites = list(
					"Default" = "motile-sec"

				)

/obj/item/robot_module/security/general/New()
	src.modules += new /obj/item/flash(src)
	src.modules += new /obj/item/borg/sight/hud/sec(src)
	src.modules += new /obj/item/handcuffs/cyborg(src)
	src.modules += new /obj/item/melee/baton/robot(src)
	src.modules += new /obj/item/taperoll/police(src)
	..()

/obj/item/robot_module/security/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	..()
	var/obj/item/melee/baton/robot/B = locate() in src.modules
	if(B && B.bcell)
		B.bcell.give(amount)

/obj/item/robot_module/janitor
	name = "janitorial robot module"
	channels = list("Service" = 1)
	sprites = list(
					"Default" = "mopgearrex"
					)

/obj/item/robot_module/janitor/New()
	src.modules += new /obj/item/flash(src)
	src.modules += new /obj/item/soap/corporate(src)
	src.modules += new /obj/item/storage/bag/trash(src)
	src.modules += new /obj/item/mop(src)
	src.modules += new /obj/item/lightreplacer(src)
	src.emag = new /obj/item/reagent_containers/spray(src)
	src.emag.reagents.add_reagent("lube", 250)
	src.emag.name = "Lube spray"
	..()

/obj/item/robot_module/janitor/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	..()
	var/obj/item/lightreplacer/LR = locate() in src.modules
	LR.Charge(R, amount)
	if(src.emag)
		var/obj/item/reagent_containers/spray/S = src.emag
		S.reagents.add_reagent("lube", 2 * amount)

/obj/item/robot_module/clerical
	name = "service robot module"
	channels = list("Service" = 1)
	sprites = list(
				"Default" = "omoikane"
				)

	languages = list(
					LANGUAGE_RUNGLISH	= 1,
					LANGUAGE_BELTER		= 1,
					LANGUAGE_LUNAR		= 1,
					LANGUAGE_EXTERIOR	= 1,
					LANGUAGE_CEPHLAPODA	= 1,
					LANGUAGE_CORVID		= 1,
					)

/obj/item/robot_module/clerical/butler/New()
	src.modules += new /obj/item/flash(src)
	src.modules += new /obj/item/gripper/service(src)
	src.modules += new /obj/item/reagent_containers/glass/bucket(src)
	src.modules += new /obj/item/material/minihoe(src)
	src.modules += new /obj/item/material/hatchet(src)
	src.modules += new /obj/item/analyzer/plant_analyzer(src)
	src.modules += new /obj/item/storage/plants(src)
	src.modules += new /obj/item/robot_harvester(src)

	var/obj/item/rsf/M = new /obj/item/rsf(src)
	M.stored_matter = 30
	src.modules += M

	src.modules += new /obj/item/reagent_containers/dropper/industrial(src)

	var/obj/item/flame/lighter/zippo/L = new /obj/item/flame/lighter/zippo(src)
	L.lit = 1
	src.modules += L

	src.modules += new /obj/item/tray/robotray(src)
	src.modules += new /obj/item/reagent_containers/borghypo/service(src)
	src.emag = new /obj/item/reagent_containers/food/drinks/bottle/small/beer(src)

	var/datum/reagents/R = new/datum/reagents(50)
	src.emag.reagents = R
	R.my_atom = src.emag
	R.add_reagent("beer2", 50)
	src.emag.name = "Mickey Finn's Special Brew"
	..()

/obj/item/robot_module/clerical/general
	name = "clerical robot module"

/obj/item/robot_module/clerical/general/New()
	src.modules += new /obj/item/flash(src)
	src.modules += new /obj/item/pen/robopen(src)
	src.modules += new /obj/item/form_printer(src)
	src.modules += new /obj/item/gripper/paperwork(src)
	src.modules += new /obj/item/hand_labeler(src)
	src.emag = new /obj/item/stamp/denied(src)
	..()

/obj/item/robot_module/general/butler/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	..()
	var/obj/item/reagent_containers/food/condiment/enzyme/E = locate() in src.modules
	E.reagents.add_reagent("enzyme", 2 * amount)
	if(src.emag)
		var/obj/item/reagent_containers/food/drinks/bottle/small/beer/B = src.emag
		B.reagents.add_reagent("beer2", 2 * amount)

/obj/item/robot_module/miner
	name = "miner robot module"
	channels = list("Supply" = 1)
	networks = list(NETWORK_EXPEDITION)
	sprites = list(
				"Default" = "miner"
				)
	supported_upgrades = list(/obj/item/borg/upgrade/jetpack)

/obj/item/robot_module/miner/New()
	src.modules += new /obj/item/flash(src)
	src.modules += new /obj/item/borg/sight/material(src)
	src.modules += new /obj/item/wrench(src)
	src.modules += new /obj/item/screwdriver(src)
	src.modules += new /obj/item/storage/ore(src)
	src.modules += new /obj/item/pickaxe/borgdrill(src)
	src.modules += new /obj/item/storage/sheetsnatcher/borg(src)
	src.modules += new /obj/item/gripper/miner(src)
	src.modules += new /obj/item/mining_scanner(src)
	src.modules += new /obj/item/crowbar(src)
	src.emag = new /obj/item/pickaxe/plasmacutter(src)
	..()

/obj/item/robot_module/syndicate
	name = "illegal robot module"
	hide_on_manifest = 1
	languages = list(
					LANGUAGE_RUNGLISH = 1,
					LANGUAGE_CEPHLAPODA = 0,
					LANGUAGE_EXTERIOR = 1
					)
	sprites = list(
					"Dread" = "securityrobot",
				)
	var/id

/obj/item/robot_module/syndicate/New(var/mob/living/silicon/robot/R)
	loc = R
	src.modules += new /obj/item/flash(src)
	src.modules += new /obj/item/melee/energy/sword(src)
	src.modules += new /obj/item/gun/composite/premade/laser_assault(src)
	src.modules += new /obj/item/card/emag(src)
	var/jetpack = new/obj/item/tank/jetpack/carbondioxide(src)
	src.modules += jetpack
	R.internals = jetpack

	id = R.idcard
	src.modules += id
	..()

/obj/item/robot_module/syndicate/Destroy()
	src.modules -= id
	id = null
	return ..()

/obj/item/robot_module/security/combat
	name = "combat robot module"
	hide_on_manifest = 1
	sprites = list("Default" = "motile-combat")

/obj/item/robot_module/security/combat/New()
	src.modules += new /obj/item/flash(src)
	src.modules += new /obj/item/borg/sight/thermal(src)
	src.modules += new /obj/item/pickaxe/plasmacutter(src)
	src.modules += new /obj/item/borg/combat/shield(src)
	src.modules += new /obj/item/borg/combat/mobility(src)
	..()

/obj/item/robot_module/drone
	name = "drone module"
	hide_on_manifest = 1
	no_slip = 1
	networks = list(NETWORK_ENGINEERING)

/obj/item/robot_module/drone/New(var/mob/living/silicon/robot/robot)
	src.modules += new /obj/item/weldingtool(src)
	src.modules += new /obj/item/screwdriver(src)
	src.modules += new /obj/item/wrench(src)
	src.modules += new /obj/item/crowbar(src)
	src.modules += new /obj/item/wirecutters(src)
	src.modules += new /obj/item/multitool(src)
	src.modules += new /obj/item/lightreplacer(src)
	src.modules += new /obj/item/gripper(src)
	src.modules += new /obj/item/soap(src)
	src.modules += new /obj/item/gripper/no_use/loader(src)
	src.modules += new /obj/item/extinguisher(src)
	src.modules += new /obj/item/pipe_painter(src)
	src.modules += new /obj/item/floor_painter(src)

	robot.internals = new/obj/item/tank/jetpack/carbondioxide(src)
	src.modules += robot.internals

	src.emag = new /obj/item/pickaxe/plasmacutter(src)
	src.emag.name = "Plasma Cutter"

	var/datum/matter_synth/metal = new /datum/matter_synth/metal(25000)
	var/datum/matter_synth/glass = new /datum/matter_synth/glass(25000)
	var/datum/matter_synth/wood = new /datum/matter_synth/wood(2000)
	var/datum/matter_synth/plastic = new /datum/matter_synth/plastic(1000)
	var/datum/matter_synth/wire = new /datum/matter_synth/wire(30)
	synths += metal
	synths += glass
	synths += wood
	synths += plastic
	synths += wire

	var/obj/item/matter_decompiler/MD = new /obj/item/matter_decompiler(src)
	MD.metal = metal
	MD.glass = glass
	MD.wood = wood
	MD.plastic = plastic
	src.modules += MD

	var/obj/item/stack/material/cyborg/steel/M = new (src)
	M.synths = list(metal)
	src.modules += M

	var/obj/item/stack/material/cyborg/glass/G = new (src)
	G.synths = list(glass)
	src.modules += G

	var/obj/item/stack/rods/cyborg/R = new /obj/item/stack/rods/cyborg(src)
	R.synths = list(metal)
	src.modules += R

	var/obj/item/stack/cable_coil/cyborg/C = new /obj/item/stack/cable_coil/cyborg(src)
	C.synths = list(wire)
	src.modules += C

	var/obj/item/stack/tile/floor/cyborg/S = new /obj/item/stack/tile/floor/cyborg(src)
	S.synths = list(metal)
	src.modules += S

	var/obj/item/stack/material/cyborg/glass/reinforced/RG = new (src)
	RG.synths = list(metal, glass)
	src.modules += RG

	var/obj/item/stack/tile/wood/cyborg/WT = new /obj/item/stack/tile/wood/cyborg(src)
	WT.synths = list(wood)
	src.modules += WT

	var/obj/item/stack/material/cyborg/wood/W = new (src)
	W.synths = list(wood)
	src.modules += W

	var/obj/item/stack/material/cyborg/plastic/P = new (src)
	P.synths = list(plastic)
	src.modules += P

	..()

/obj/item/robot_module/drone/construction
	name = "construction drone module"
	hide_on_manifest = 1
	channels = list("Engineering" = 1)
	languages = list()

/obj/item/robot_module/drone/construction/New()
	src.modules += new /obj/item/rcd/borg(src)
	..()

/obj/item/robot_module/drone/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	var/obj/item/lightreplacer/LR = locate() in src.modules
	LR.Charge(R, amount)
	..()
	return
