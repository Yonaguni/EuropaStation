var/datum/admin_secrets/admin_secrets = new()

/datum/admins/proc/Secrets()
	if(!check_rights(0))	return

	var/dat = "<B>The first rule of adminbuse is: you don't talk about the adminbuse.</B><HR>"
	for(var/datum/admin_secret_category/category in admin_secrets.categories)
		if(!category.can_view(usr))
			continue
		dat += "<B>[category.name]</B><br>"
		if(category.desc)
			dat += "<I>[category.desc]</I><BR>"
		for(var/datum/admin_secret_item/item in category.items)
			if(!item.can_view(usr))
				continue
			dat += "<A href='?src=\ref[src];admin_secrets=\ref[item]'>[item.name()]</A><BR>"
		dat += "<BR>"
	usr << browse(dat, "window=secrets")
	return

/datum/admin_secrets
	var/list/datum/admin_secret_category/categories
	var/list/datum/admin_secret_item/items

/datum/admin_secrets/New()
	..()
	categories = init_subtypes(/datum/admin_secret_category)
	items = list()
	var/list/category_assoc = list()
	for(var/datum/admin_secret_category/category in categories)
		category_assoc[category.type] = category

	for(var/item_type in (typesof(/datum/admin_secret_item) - /datum/admin_secret_item))
		var/datum/admin_secret_item/secret_item = item_type
		if(!initial(secret_item.name))
			continue

		var/datum/admin_secret_item/item = new item_type()
		var/datum/admin_secret_category/category = category_assoc[item.category]
		dd_insertObjectList(category.items, item)
		items += item

/datum/admin_secret_category
	var/name = ""
	var/desc = ""
	var/list/datum/admin_secret_item/items

/datum/admin_secret_category
	..()
	items = list()

/datum/admin_secret_category/proc/can_view(var/mob/user)
	for(var/datum/admin_secret_item/item in items)
		if(item.can_view(user))
			return 1
	return 0

/datum/admin_secret_item
	var/name = ""
	var/category = null
	var/log = 1
	var/permissions = R_HOST
	var/warn_before_use = 0

/datum/admin_secret_item/dd_SortValue()
	return "[name]"

/datum/admin_secret_item/proc/name()
	return name

/datum/admin_secret_item/proc/can_view(var/mob/user)
	return check_rights(permissions, 0, user)

/datum/admin_secret_item/proc/can_execute(var/mob/user)
	if(can_view(user))
		if(!warn_before_use || alert("Execute the command '[name]'?", name, "No","Yes") == "Yes")
			return 1
	return 0

/datum/admin_secret_item/proc/execute(var/mob/user)
	if(!can_execute(user))
		return 0
	if(log)
		log_and_message_admins("used secret '[name]'", user)
	return 1

/*************************
* Pre-defined categories *
*************************/
/datum/admin_secret_category/admin_secrets
	name = "Admin Secrets"

/datum/admin_secret_category/random_events
	name = "'Random' Events"

/datum/admin_secret_category/fun_secrets
	name = "Fun Secrets"

/datum/admin_secret_category/endgame
	name = "Endgame"
	desc = "(Warning, these will end the round!)"

/*************************
* Pre-defined base items *
*************************/
/datum/admin_secret_item/admin_secret
	category = /datum/admin_secret_category/admin_secrets
	log = 0
	permissions = R_ADMIN

/datum/admin_secret_item/random_event
	category = /datum/admin_secret_category/random_events
	permissions = R_SPAWN
	warn_before_use = 1

/datum/admin_secret_item/fun_secret
	category = /datum/admin_secret_category/fun_secrets
	permissions = R_SPAWN
	warn_before_use = 1

/datum/admin_secret_item/endgame
	category = /datum/admin_secret_category/endgame
	permissions = R_SPAWN|R_SERVER|R_ADMIN
