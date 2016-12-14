/decl/hierarchy/supply_pack/engineering
	name = "Engineering"

/decl/hierarchy/supply_pack/engineering/lightbulbs
	name = "Replacement lights"
	contains = list(/obj/item/storage/box/lights/mixed = 3)
	cost = 10
	containername = "\improper Replacement lights"

/decl/hierarchy/supply_pack/engineering/metal50
	name = "50 steel sheets"
	contains = list(/obj/item/stack/material/steel/fifty)
	cost = 10
	containername = "\improper Steel sheets crate"

/decl/hierarchy/supply_pack/engineering/glass50
	name = "50 glass sheets"
	contains = list(/obj/item/stack/material/glass/fifty)
	cost = 10
	containername = "\improper Glass sheets crate"

/decl/hierarchy/supply_pack/engineering/wood50
	name = "50 wooden planks"
	contains = list(/obj/item/stack/material/wood/fifty)
	cost = 10
	containername = "\improper Wooden planks crate"

/decl/hierarchy/supply_pack/engineering/plastic50
	name = "50 plastic sheets"
	contains = list(/obj/item/stack/material/plastic/fifty)
	cost = 10
	containername = "\improper Plastic sheets crate"

/decl/hierarchy/supply_pack/engineering/smes_circuit
	name = "Superconducting Magnetic Energy Storage Unit Circuitry"
	contains = list(/obj/item/circuitboard/smes)
	cost = 20
	containername = "\improper Superconducting Magnetic Energy Storage Unit Circuitry"

/decl/hierarchy/supply_pack/engineering/smescoil
	name = "Superconductive Magnetic Coil"
	contains = list(/obj/item/smes_coil)
	cost = 35
	containername = "\improper Superconductive Magnetic Coil crate"

/decl/hierarchy/supply_pack/engineering/smescoil_weak
	name = "Basic Superconductive Magnetic Coil"
	contains = list(/obj/item/smes_coil/weak)
	cost = 25
	containername = "\improper Basic Superconductive Magnetic Coil crate"

/decl/hierarchy/supply_pack/engineering/smescoil_super_capacity
	name = "Superconductive Capacitance Coil"
	contains = list(/obj/item/smes_coil/super_capacity)
	cost = 45
	containername = "\improper Superconductive Capacitance Coil crate"

/decl/hierarchy/supply_pack/engineering/smescoil_super_io
	name = "Superconductive Transmission Coil"
	contains = list(/obj/item/smes_coil/super_io)
	cost = 45
	containername = "\improper Superconductive Transmission Coil crate"

/decl/hierarchy/supply_pack/engineering/electrical
	name = "Electrical maintenance crate"
	contains = list(/obj/item/storage/toolbox/electrical = 2,
					/obj/item/clothing/gloves/insulated = 2,
					/obj/item/cell = 2,
					/obj/item/cell/high = 2)
	cost = 15
	containername = "\improper Electrical maintenance crate"

/decl/hierarchy/supply_pack/engineering/mechanical
	name = "Mechanical maintenance crate"
	contains = list(/obj/item/storage/belt/utility/full = 3,
					/obj/item/clothing/suit/storage/hazardvest = 3,
					/obj/item/clothing/head/welding = 2,
					/obj/item/clothing/head/hardhat)
	cost = 10
	containername = "\improper Mechanical maintenance crate"

/decl/hierarchy/supply_pack/engineering/solar
	name = "Solar Pack crate"
	contains  = list(/obj/item/solar_assembly = 14,
					/obj/item/circuitboard/solar_control,
					/obj/item/tracker_electronics,
					/obj/item/paper/solar
					)
	cost = 15
	containername = "\improper Solar Pack crate"

/decl/hierarchy/supply_pack/engineering/solar_assembly
	name = "Solar Assembly crate"
	contains  = list(/obj/item/solar_assembly = 16)
	cost = 10
	containername = "\improper Solar Assembly crate"

/decl/hierarchy/supply_pack/engineering/pacman_parts
	name = "P.A.C.M.A.N. portable generator parts"
	contains = list(/obj/item/stock_parts/micro_laser,
					/obj/item/stock_parts/capacitor,
					/obj/item/stock_parts/matter_bin,
					/obj/item/circuitboard/pacman)
	cost = 45
	containername = "\improper P.A.C.M.A.N. Portable Generator Construction Kit"
	containertype = /obj/structure/closet/crate/secure
	access = access_tech_storage

/decl/hierarchy/supply_pack/engineering/super_pacman_parts
	name = "Super P.A.C.M.A.N. portable generator parts"
	contains = list(/obj/item/stock_parts/micro_laser,
					/obj/item/stock_parts/capacitor,
					/obj/item/stock_parts/matter_bin,
					/obj/item/circuitboard/pacman/super)
	cost = 55
	containername = "\improper Super P.A.C.M.A.N. portable generator construction kit"
	containertype = /obj/structure/closet/crate/secure
	access = access_tech_storage

/decl/hierarchy/supply_pack/engineering/teg
	name = "Mark I Thermoelectric Generator"
	contains = list(/obj/machinery/power/generator)
	cost = 75
	containertype = /obj/structure/closet/crate/secure/large
	containername = "\improper Mk1 TEG crate"
	access = access_engine

/decl/hierarchy/supply_pack/engineering/circulator
	name = "Binary atmospheric circulator"
	contains = list(/obj/machinery/atmospherics/binary/circulator)
	cost = 60
	containertype = /obj/structure/closet/crate/secure/large
	containername = "\improper Atmospheric circulator crate"
	access = access_engine

/decl/hierarchy/supply_pack/engineering/air_dispenser
	name = "Pipe Dispenser"
	contains = list(/obj/machinery/pipedispenser/orderable)
	cost = 35
	containertype = /obj/structure/closet/crate/secure/large
	containername = "\improper Pipe Dispenser Crate"
	access = access_atmospherics

/decl/hierarchy/supply_pack/engineering/disposals_dispenser
	name = "Disposals Pipe Dispenser"
	contains = list(/obj/machinery/pipedispenser/disposal/orderable)
	cost = 35
	containertype = /obj/structure/closet/crate/secure/large
	containername = "\improper Disposal Dispenser Crate"
	access = access_atmospherics

/decl/hierarchy/supply_pack/engineering/fueltank
	name = "Fuel tank crate"
	contains = list(/obj/structure/reagent_dispensers/fueltank)
	cost = 8
	containertype = /obj/structure/largecrate
	containername = "\improper fuel tank crate"

/decl/hierarchy/supply_pack/engineering/robotics
	name = "Robotics assembly crate"
	contains = list(/obj/item/assembly/prox_sensor = 3,
					/obj/item/storage/toolbox/electrical,
					/obj/item/flash = 4,
					/obj/item/cell/high = 2)
	cost = 10
	containertype = /obj/structure/closet/crate/secure/gear
	containername = "\improper Robotics assembly"
	access = access_robotics

/decl/hierarchy/supply_pack/engineering/radsuit
	name = "Radiation protection gear"
	contains = list(/obj/item/clothing/suit/radiation = 6,
			/obj/item/clothing/head/radiation = 6)
	cost = 20
	containertype = /obj/structure/closet/radiation
	containername = "\improper Radiation suit locker"

/decl/hierarchy/supply_pack/engineering/painters
	name = "Industrial Painting Supplies"
	contains = list(/obj/item/pipe_painter = 2,
					/obj/item/floor_painter = 2,
					/obj/item/cable_painter = 2)
	cost = 10
	containername = "painting supplies crate"
	containertype = /obj/structure/closet/crate

/* Remove these when mining is fixed. */
/decl/hierarchy/supply_pack/engineering/plasteel
	name = "20 plasteel crates "
	contains = list(/obj/item/stack/material/plasteel/twenty)
	cost = 100
	containername = "\improper Plasteel crate"

/decl/hierarchy/supply_pack/engineering/rglass
	name = "50 reinforced glass sheets"
	contains = list(/obj/item/stack/material/glass/reinforced)
	cost = 50
	containername = "\improper Reinforced glass crate"

/decl/hierarchy/supply_pack/engineering/borosilicate
	name = "50 borosilicate glass sheets"
	contains = list(/obj/item/stack/material/glass/phoronrglass/fifty)
	cost = 100
	containername = "\improper Borosilicate glass crate"

/decl/hierarchy/supply_pack/engineering/osmium
	name = "50 osmium ingots"
	contains = list(/obj/item/stack/material/osmium/fifty)
	cost = 80
	containername = "\improper Osmium crate"

/decl/hierarchy/supply_pack/engineering/tritium
	name = "50 tritium ingots"
	contains = list(/obj/item/stack/material/tritium/fifty)
	cost = 150
	containername = "\improper Tritium crate"

/decl/hierarchy/supply_pack/engineering/mhydrogen
	name = "5 metallic hydrogen crystals "
	contains = list(/obj/item/stack/material/mhydrogen/five)
	cost = 300
	containername = "\improper Metallic hydrogen crate"

/decl/hierarchy/supply_pack/engineering/silver
	name = "20 silver ingots"
	contains = list(/obj/item/stack/material/silver/twenty)
	cost = 180
	containername = "\improper Silver ingot crate"

/decl/hierarchy/supply_pack/engineering/gold
	name = "20 gold ingots "
	contains = list(/obj/item/stack/material/gold/twenty)
	cost = 220
	containername = "\improper Gold ingot crate"

/decl/hierarchy/supply_pack/engineering/platnium
	name = "20 platinum ingots"
	contains = list(/obj/item/stack/material/platinum/twenty)
	cost = 300
	containername = "\improper Platinum ingot crate"

/decl/hierarchy/supply_pack/engineering/uranium
	name = "20 uranium ingots"
	contains = list(/obj/item/stack/material/uranium/twenty)
	cost = 200
	containername = "\improper Uranium ingot crate"

/decl/hierarchy/supply_pack/engineering/iron
	name = "50 iron ingots"
	contains = list(/obj/item/stack/material/iron/fifty)
	cost = 50
	containername = "\improper Iron ingot crate"

/decl/hierarchy/supply_pack/engineering/sandstone
	name = "50 sandstone blocks"
	contains = list(/obj/item/stack/material/sandstone/fifty)
	cost = 180
	containername = "\improper Sandstone block crate"

/decl/hierarchy/supply_pack/engineering/marble
	name = "50 marble blocks"
	contains = list(/obj/item/stack/material/marble/fifty)
	cost = 180
	containername = "\improper Marble block crate"

/decl/hierarchy/supply_pack/engineering/diamond
	name = "5 industrial diamonds"
	contains = list(/obj/item/stack/material/diamond/five)
	cost = 300
	containername = "\improper Industrial diamond crate"
