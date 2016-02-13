/datum/admins/proc/spawn_substance(thingtype in gas_data.gases)
	set category = "Debug"
	set desc = "Spawn a volume of fluid or gas in your current turf."
	set name = "Spawn Substance"

	if(!check_rights(R_SPAWN))	return
	var/turf/T = get_turf(usr)
	if(!thingtype || !gas_data.gases[thingtype] || !istype(T))
		return
	var/tvol = input(usr, "How many moles?", "Spawn Substance", 0) as num|null
	if(!tvol || tvol < 0 || tvol > 10000)
		return
	if(gas_data.flags[thingtype] & XGM_GAS_LIQUID)
		T.assume_fluid(thingtype, tvol)
	else
		T.assume_gas(thingtype, tvol)
	log_admin("[key_name(usr)] spawned [tvol] [thingtype] at ([T.x],[T.y],[T.z])")
