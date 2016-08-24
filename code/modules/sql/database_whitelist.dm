var/list/alien_whitelist

/hook/startup/proc/load_alien_whitelist_h()
	alien_whitelist = list()
	var/database/query/query = new("SELECT * FROM whitelist")
	query.Execute(global_db)
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
	if(!alien_whitelist || !alien_whitelist.len)
		return 0
	return ("[M.ckey]-[lowertext(species)]" in alien_whitelist)