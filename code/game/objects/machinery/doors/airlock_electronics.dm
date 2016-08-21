//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:31

/obj/item/airlock_electronics
	name = "airlock electronics"
	w_class = 2.0 //It should be tiny! -Agouri

	matter = list(DEFAULT_WALL_MATERIAL = 50,"glass" = 50)

	req_access = list(access_engine)

	var/secure = 0 //if set, then wires will be randomized and bolts will drop if the door is broken
	var/list/conf_access = null
	var/one_access = 0 //if set to 1, door would receive req_one_access instead of req_access
	var/last_configurator = null
	var/locked = 1

/obj/item/airlock_electronics/secure
	name = "secure airlock electronics"
	desc = "designed to be somewhat more resistant to hacking than standard electronics."
	secure = 1
