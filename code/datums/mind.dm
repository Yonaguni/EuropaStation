/*	Note from Carnie:
		The way datum/mind stuff works has been changed a lot.
		Minds now represent IC characters rather than following a client around constantly.

	Guidelines for using minds properly:

	-	Never mind.transfer_to(ghost). The var/current and var/original of a mind must always be of type mob/living!
		ghost.mind is however used as a reference to the ghost's corpse

	-	When creating a new mob for an existing IC character (e.g. cloning a dead guy or borging a brain of a human)
		the existing mind of the old mob should be transfered to the new mob like so:

			mind.transfer_to(new_mob)

	-	You must not assign key= or ckey= after transfer_to() since the transfer_to transfers the client for you.
		By setting key or ckey explicitly after transfering the mind with transfer_to you will cause bugs like DCing
		the player.

	-	IMPORTANT NOTE 2, if you want a player to become a ghost, use mob.ghostize() It does all the hard work for you.

	-	When creating a new mob which will be a new IC character (e.g. putting a shade in a construct or randomly selecting
		a ghost to become a xeno during an event). Simply assign the key or ckey like you've always done.

			new_mob.key = key

		The Login proc will handle making a new mob for that mobtype (including setting up stuff like mind.name). Simple!
		However if you want that mind to have any special properties like being a traitor etc you will have to do that
		yourself.

*/

/datum/mind
	var/key
	var/name
	var/mob/living/current
	var/mob/living/original
	var/active = 0
	var/memory
	var/assigned_role
	var/special_role
	var/role_alt_title
	var/datum/job/assigned_job
	var/list/objectives = list()
	var/list/special_verbs = list()
	var/faction_conversion_cooldown = 0

/datum/mind/New(var/key)
	src.key = key
	..()

/datum/mind/proc/transfer_to(mob/living/new_character)
	if(!istype(new_character))
		world.log << "## DEBUG: transfer_to(): Some idiot has tried to transfer_to() a non mob/living mob. Please inform Carn"
	if(current)					//remove ourself from our old body's mind variable
		current.mind = null
		tguiProcess.on_transfer(current, new_character) // transfer active NanoUI instances to new user

	if(new_character.mind)		//remove any mind currently in our new body's mind variable
		new_character.mind.current = null

	current = new_character		//link ourself to our new body
	new_character.mind = src	//and link our new body to ourself

	if(active)
		new_character.key = key		//now transfer the key to link the client to our new body

/datum/mind/proc/store_memory(new_text)
	memory += "[new_text]<BR>"

/datum/mind/proc/show_memory(mob/recipient)
	var/output = "<B>[current.real_name]'s Memory</B><HR>"
	output += memory

	if(objectives.len>0)
		output += "<HR><B>Objectives:</B>"

		var/obj_count = 1
		for(var/datum/objective/objective in objectives)
			output += "<B>Objective #[obj_count]</B>: [objective.explanation_text]"
			obj_count++

	recipient << browse(output,"window=memory")

/datum/mind/proc/edit_memory()
	if(!ticker || !ticker.mode)
		alert("Not before round-start!", "Alert")
		return

	var/out = "<B>[name]</B>[(current&&(current.real_name!=name))?" (as [current.real_name])":""]<br>"
	out += "Mind currently owned by key: [key] [active?"(synced)":"(not synced)"]<br>"
	out += "Assigned role: [assigned_role]. <a href='?src=\ref[src];role_edit=1'>Edit</a><br>"
	out += "<hr>"
	out += "Factions and special roles:<br><table>"
	for(var/antag_type in all_antag_types)
		var/datum/antagonist/antag = all_antag_types[antag_type]
		out += "[antag.get_panel_entry(src)]"
	out += "</table><hr>"
	out += "<b>Objectives</b></br>"

	if(objectives && objectives.len)
		var/num = 1
		for(var/datum/objective/O in objectives)
			out += "<b>Objective #[num]:</b> [O.explanation_text] "
			if(O.completed)
				out += "(<font color='green'>complete</font>)"
			else
				out += "(<font color='red'>incomplete</font>)"
			out += " <a href='?src=\ref[src];obj_completed=\ref[O]'>\[toggle\]</a>"
			out += " <a href='?src=\ref[src];obj_delete=\ref[O]'>\[remove\]</a><br>"
			num++
		out += "<br><a href='?src=\ref[src];obj_announce=1'>\[announce objectives\]</a>"

	else
		out += "None."
	usr << browse(out, "window=edit_memory[src]")

/datum/mind/Topic(href, href_list)
	if(!check_rights(R_ADMIN))	return
	if(href_list["add_antagonist"])
		var/datum/antagonist/antag = all_antag_types[href_list["add_antagonist"]]
		if(antag)
			if(antag.add_antagonist(src, 1, 1, 0, 1, 1)) // Ignore equipment and role type for this.
				log_admin("[key_name_admin(usr)] made [key_name(src)] into a [antag.role_text].")
			else
				usr << "<span class='warning'>[src] could not be made into a [antag.role_text]!</span>"
	else if(href_list["remove_antagonist"])
		var/datum/antagonist/antag = all_antag_types[href_list["remove_antagonist"]]
		if(antag) antag.remove_antagonist(src)
	else if(href_list["equip_antagonist"])
		var/datum/antagonist/antag = all_antag_types[href_list["equip_antagonist"]]
		if(antag) antag.equip(src.current)
	else if(href_list["unequip_antagonist"])
		var/datum/antagonist/antag = all_antag_types[href_list["unequip_antagonist"]]
		if(antag) antag.unequip(src.current)
	else if(href_list["move_antag_to_spawn"])
		var/datum/antagonist/antag = all_antag_types[href_list["move_antag_to_spawn"]]
		if(antag) antag.place_mob(src.current)
	else if (href_list["role_edit"])
		var/new_role = input("Select new role", "Assigned role", assigned_role) as null|anything in get_job_titles()
		if (!new_role) return
		assigned_role = new_role
	else if (href_list["memory_edit"])
		var/new_memo = sanitize(input("Write new memory", "Memory", memory) as null|message)
		if (isnull(new_memo)) return
		memory = new_memo
	else if (href_list["obj_delete"])
		var/datum/objective/objective = locate(href_list["obj_delete"])
		if(!istype(objective))	return
		objectives -= objective
	else if(href_list["obj_completed"])
		var/datum/objective/objective = locate(href_list["obj_completed"])
		if(!istype(objective))	return
		objective.completed = !objective.completed
	else if (href_list["obj_announce"])
		var/obj_count = 1
		current << "\blue Your current objectives:"
		for(var/datum/objective/objective in objectives)
			current << "<B>Objective #[obj_count]</B>: [objective.explanation_text]"
			obj_count++
	edit_memory()

/datum/mind/proc/reset()
	assigned_role =   null
	special_role =    null
	role_alt_title =  null
	assigned_job =    null
	objectives =      list()
	special_verbs =   list()

//Antagonist role check
/mob/living/proc/check_special_role(role)
	if(mind)
		if(!role)
			return mind.special_role
		else
			return (mind.special_role == role) ? 1 : 0
	else
		return 0

//Initialisation procs
/mob/living/proc/mind_initialize()
	if(mind)
		mind.key = key
	else
		mind = new /datum/mind(key)
		mind.original = src
		if(ticker)
			ticker.minds += mind
		else
			world.log << "## DEBUG: mind_initialize(): No ticker ready yet! Please inform Carn"
	if(!mind.name)	mind.name = real_name
	mind.current = src

//HUMAN
/mob/living/human/mind_initialize()
	..()
	if(!mind.assigned_role)
		mind.assigned_role = "[using_map.default_title]"

//Animals
/mob/living/animal/mind_initialize()
	..()
	mind.assigned_role = "Animal"
