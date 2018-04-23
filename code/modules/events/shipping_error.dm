/datum/event/shipping_error/start()
	var/datum/supply_order/O = new /datum/supply_order()
	var/datum/faction/F = get_faction(using_map.default_faction)
	O.ordernum = supply_controller.ordernum
	O.object = pick(cargo_supply_packs)
	O.orderedby = F.get_random_name(pick(MALE,FEMALE), species = DEFAULT_SPECIES)
	supply_controller.shoppinglist += O
