/obj/item/clothing/suit/chef
	name = "chef's apron"
	desc = "An apron used by a high class chef."
	icon_state = "chef"
	item_state = "chef"
	gas_transfer_coefficient = 0.90
	permeability_coefficient = 0.50
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	allowed = list (/obj/item/material/knife)

/obj/item/clothing/suit/storage/hazardvest
	name = "hazard vest"
	desc = "A high-visibility vest used in work zones."
	icon_state = "hazard"
	item_state = "hazard"
	blood_overlay_type = "armor"
	allowed = list (/obj/item/analyzer, /obj/item/flashlight, /obj/item/multitool, /obj/item/pipe_painter, /obj/item/radio, /obj/item/t_scanner, \
	/obj/item/crowbar, /obj/item/screwdriver, /obj/item/weldingtool, /obj/item/wirecutters, /obj/item/wrench, /obj/item/tank/emergency, \
	/obj/item/clothing/mask/gas, /obj/item/taperoll/engineering)
	body_parts_covered = UPPER_TORSO

/obj/item/clothing/suit/storage/hazardvest/police
	name = "police hazard vest"
	desc = "A high-visibility vest used by police."
	icon_state = "police_hazard"

/obj/item/clothing/suit/storage/waiter_vest
	name = "waiter's vest"
	desc = "It has a special pocket for tips."
	icon_state = "waiter"

/obj/item/clothing/suit/factory_vest
	name = "factory vest"
	desc = "A factory worker's vest."
	icon_state = "factoryworker-vest"

/obj/item/clothing/suit/det_vest
	name = "hard-bitten vest"
	desc = "It smells faintly of cigarettes."
	icon_state = "det-vest"

/obj/item/clothing/suit/overalls_acc
	name = "overalls"
	desc = "Some plain overalls."
	icon_state = "overalls_acc"

/obj/item/clothing/suit/overalls_electrician
	name = "electrician overalls"
	desc = "Never stick your hand into an open electrical panel without these."
	icon_state = "electrician-overalls"

/obj/item/clothing/suit/overalls_emergency
	name = "emergency overalls"
	desc = "Just the thing for responding to a car crash."
	icon_state = "emergency-overalls"

/obj/item/clothing/suit/factory_apron
	name = "factory apron"
	desc = "A factory worker's apron."
	icon_state = "factoryworker-apron"