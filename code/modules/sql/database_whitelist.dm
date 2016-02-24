var/list/alien_whitelist

/hook/startup/proc/loadAlienWhitelist()
	if(!config.sql_enabled)
		world.log << "SQL disabled. Alien whitelisting defaulting to off."
		config.usealienwhitelist = 0
	else
		load_alien_whitelist()
	return 1

/proc/load_alien_whitelist()
	if(!config.sql_enabled)
		alien_whitelist = null
		return 0
	alien_whitelist = list()
	var/database/query/query = new("SELECT * FROM whitelist")
	query.Execute(global_db)
	if(query.ErrorMsg())
		world.log << query.ErrorMsg()
		return 0
	while(query.NextRow())
		var/list/row = query.GetRowData()
		alien_whitelist |= "[row["ckey"]]-[lowertext(row["race"])]"
	return 1

/proc/is_alien_whitelisted(var/mob/M, var/species)
	if(!M || !species)
		return 0
	if(!config.usealienwhitelist)
		return 1
	if(istype(species,/datum/species) || istype(species,/datum/language))
		species = "[species]";
	if(species == "human" || species == "Human")
		return 1
	if(check_rights(R_ADMIN, 0))
		return 1
	if(!alien_whitelist)
		load_alien_whitelist()
	if(!alien_whitelist || !alien_whitelist.len)
		return 0
	return ("[M.ckey]-[lowertext(species)]" in alien_whitelist)