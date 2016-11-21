/obj/machinery/chemical_dispenser/full
	spawn_cartridges = list(
			/obj/item/reagent_containers/chem_disp_cartridge/hydrazine,
			/obj/item/reagent_containers/chem_disp_cartridge/lithium,
			/obj/item/reagent_containers/chem_disp_cartridge/carbon,
			/obj/item/reagent_containers/chem_disp_cartridge/ammonia,
			/obj/item/reagent_containers/chem_disp_cartridge/acetone,
			/obj/item/reagent_containers/chem_disp_cartridge/sodium,
			/obj/item/reagent_containers/chem_disp_cartridge/aluminum,
			/obj/item/reagent_containers/chem_disp_cartridge/silicon,
			/obj/item/reagent_containers/chem_disp_cartridge/phosphorus,
			/obj/item/reagent_containers/chem_disp_cartridge/sulfur,
			/obj/item/reagent_containers/chem_disp_cartridge/hclacid,
			/obj/item/reagent_containers/chem_disp_cartridge/potassium,
			/obj/item/reagent_containers/chem_disp_cartridge/iron,
			/obj/item/reagent_containers/chem_disp_cartridge/copper,
			/obj/item/reagent_containers/chem_disp_cartridge/mercury,
			/obj/item/reagent_containers/chem_disp_cartridge/radium,
			/obj/item/reagent_containers/chem_disp_cartridge/water,
			/obj/item/reagent_containers/chem_disp_cartridge/ethanol,
			/obj/item/reagent_containers/chem_disp_cartridge/sugar,
			/obj/item/reagent_containers/chem_disp_cartridge/sacid,
			/obj/item/reagent_containers/chem_disp_cartridge/tungsten
		)

/obj/machinery/chemical_dispenser/ert
	name = "medicine dispenser"
	spawn_cartridges = list(
			/obj/item/reagent_containers/chem_disp_cartridge/inaprov,
			/obj/item/reagent_containers/chem_disp_cartridge/ryetalyn,
			/obj/item/reagent_containers/chem_disp_cartridge/paracetamol,
			/obj/item/reagent_containers/chem_disp_cartridge/morphine,
			/obj/item/reagent_containers/chem_disp_cartridge/oxycodone,
			/obj/item/reagent_containers/chem_disp_cartridge/sterilizine,
			/obj/item/reagent_containers/chem_disp_cartridge/leporazine,
			/obj/item/reagent_containers/chem_disp_cartridge/fotiazine,
			/obj/item/reagent_containers/chem_disp_cartridge/dexalin,
			/obj/item/reagent_containers/chem_disp_cartridge/dylovene,
			/obj/item/reagent_containers/chem_disp_cartridge/synaptizine,
			/obj/item/reagent_containers/chem_disp_cartridge/entolimod,
			/obj/item/reagent_containers/chem_disp_cartridge/arithrazine,
			/obj/item/reagent_containers/chem_disp_cartridge/alkysine,
			/obj/item/reagent_containers/chem_disp_cartridge/imidazoline,
			/obj/item/reagent_containers/chem_disp_cartridge/peridaxon,
			/obj/item/reagent_containers/chem_disp_cartridge/styptazine,
			/obj/item/reagent_containers/chem_disp_cartridge/jumpstart,
			/obj/item/reagent_containers/chem_disp_cartridge/rezadone,
			/obj/item/reagent_containers/chem_disp_cartridge/antibiotic,
			/obj/item/reagent_containers/chem_disp_cartridge/ethylredox,
			/obj/item/reagent_containers/chem_disp_cartridge/sleeptox,
			/obj/item/reagent_containers/chem_disp_cartridge/chloral,
			/obj/item/reagent_containers/chem_disp_cartridge/cryoxadone,
			/obj/item/reagent_containers/chem_disp_cartridge/clonexadone
		)

/obj/machinery/chemical_dispenser/bar_soft
	name = "soft drink dispenser"
	desc = "A soda machine."
	icon_state = "soda_dispenser"
	ui_title = "Soda Dispenser"
	accept_drinking = 1

/obj/machinery/chemical_dispenser/bar_soft/full
	spawn_cartridges = list(
			/obj/item/reagent_containers/chem_disp_cartridge/water,
			/obj/item/reagent_containers/chem_disp_cartridge/ice,
			/obj/item/reagent_containers/chem_disp_cartridge/coffee,
			/obj/item/reagent_containers/chem_disp_cartridge/cream,
			/obj/item/reagent_containers/chem_disp_cartridge/tea,
			/obj/item/reagent_containers/chem_disp_cartridge/icetea,
			/obj/item/reagent_containers/chem_disp_cartridge/cola,
			/obj/item/reagent_containers/chem_disp_cartridge/smw,
			/obj/item/reagent_containers/chem_disp_cartridge/dr_gibb,
			/obj/item/reagent_containers/chem_disp_cartridge/spaceup,
			/obj/item/reagent_containers/chem_disp_cartridge/tonic,
			/obj/item/reagent_containers/chem_disp_cartridge/sodawater,
			/obj/item/reagent_containers/chem_disp_cartridge/lemon_lime,
			/obj/item/reagent_containers/chem_disp_cartridge/sugar,
			/obj/item/reagent_containers/chem_disp_cartridge/orange,
			/obj/item/reagent_containers/chem_disp_cartridge/lime,
			/obj/item/reagent_containers/chem_disp_cartridge/watermelon
		)

/obj/machinery/chemical_dispenser/bar_alc
	name = "booze dispenser"
	desc = "A beer machine. Like a soda machine, but more fun!"
	icon_state = "booze_dispenser"
	ui_title = "Booze Dispenser"
	accept_drinking = 1

/obj/machinery/chemical_dispenser/bar_alc/full
	spawn_cartridges = list(
			/obj/item/reagent_containers/chem_disp_cartridge/lemon_lime,
			/obj/item/reagent_containers/chem_disp_cartridge/sugar,
			/obj/item/reagent_containers/chem_disp_cartridge/orange,
			/obj/item/reagent_containers/chem_disp_cartridge/lime,
			/obj/item/reagent_containers/chem_disp_cartridge/sodawater,
			/obj/item/reagent_containers/chem_disp_cartridge/tonic,
			/obj/item/reagent_containers/chem_disp_cartridge/beer,
			/obj/item/reagent_containers/chem_disp_cartridge/kahlua,
			/obj/item/reagent_containers/chem_disp_cartridge/whiskey,
			/obj/item/reagent_containers/chem_disp_cartridge/wine,
			/obj/item/reagent_containers/chem_disp_cartridge/vodka,
			/obj/item/reagent_containers/chem_disp_cartridge/gin,
			/obj/item/reagent_containers/chem_disp_cartridge/rum,
			/obj/item/reagent_containers/chem_disp_cartridge/tequila,
			/obj/item/reagent_containers/chem_disp_cartridge/vermouth,
			/obj/item/reagent_containers/chem_disp_cartridge/cognac,
			/obj/item/reagent_containers/chem_disp_cartridge/ale,
			/obj/item/reagent_containers/chem_disp_cartridge/mead
		)
