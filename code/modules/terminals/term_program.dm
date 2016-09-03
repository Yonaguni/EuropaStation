/datum/console_program
	var/name
	var/html[22]
	var/main_menu_hide
	var/mob/cur_user
	var/html_template = 'html/templates/terminal_template.html'
	var/obj/machinery/console/owner

/datum/console_program/New(var/obj/machinery/console/new_owner)
	if(!istype(new_owner))
		qdel(src)
		return 1
	owner = new_owner

/datum/console_program/proc/initialize()
	return

/datum/console_program/Destroy()
	cur_user = null
	if(owner)
		owner.installed_software[name] = null
		owner.installed_software -= name
		owner = null
	return ..()

/datum/console_program/proc/Run(mob/user)

/datum/console_program/proc/HandleTopic(var/list/href_list)
	if(!href_list)
		return 1
