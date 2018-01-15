/datum/presence_power
	var/name
	var/description
	var/list/children
	var/purchase_cost = 1
	var/use_cost = 0
	var/header_text
	var/passive = FALSE
	var/sigil_del_after_use = FALSE

/datum/presence_power/New()
	..()
	if(LAZYLEN(children))
		var/list/child_types = children.Copy()
		children.Cut()
		for(var/child in child_types)
			children += new child

/datum/presence_power/proc/purchased(var/mob/living/presence/purchased_by)
	to_chat(purchased_by, "<span class='notice'>You have unlocked <b>[name]</b>.</span>")

/datum/presence_power/proc/invoke(var/mob/invoker, var/mob/living/presence/patron, var/atom/target)
	if(use_cost > 0 && patron.mojo >= use_cost)
		patron.mojo -= use_cost
		if(invoker != patron && world.time >= patron.next_invocation_message)
			patron.next_invocation_message = world.time + 10
			to_chat(patron, "<span class='notice'>You feel a faint drawing sensation as <b>\the [invoker]</b> invokes <b>[name]</b>, costing you [use_cost] [patron.presence.unit_name]\s.</span>")
		return TRUE
	return FALSE

/datum/presence_power/proc/get_print_data(var/recursion_level, var/mob/living/presence/owner)
	var/dat = ""
	if(header_text)
		dat = "<tr><td colspan = 2><h2>[header_text]</h2></td></tr>"
	var/use_name = "<b>[name]</b>: [description]"
	if(recursion_level)
		for(var/x = 1 to recursion_level)
			use_name = "&nbsp;&nbsp;&nbsp;&nbsp;[use_name]"
	if(owner.purchased_powers[src])
		if(passive)
			dat += "<tr><td>[use_name]</td><td></td></tr>"
		else
			if(owner.mojo >= use_cost)
				dat += "<tr><td>[use_name]</td><td align='right'><a href='?src=\ref[owner];select_power=\ref[src]'>Select - [use_cost] [owner.presence.unit_name]\s.</a></td></tr>"
			else
				dat += "<tr><td>[use_name]</td><td align='right'><font color = '#FF0000'><b>Insufficient [owner.presence.unit_name]s - requires [use_cost].</b></font></td></tr>"

		for(var/datum/presence_power/power in children)
			dat += power.get_print_data(recursion_level+1, owner)
	else
		if(owner.mojo >= purchase_cost)
			dat += "<tr><td><font color='#666666'>[use_name]</font></td><td align='right'><a href='?src=\ref[owner];purchase=\ref[src]'>Purchase for [purchase_cost] [owner.presence.unit_name]\s.</td></tr>"
		else
			dat += "<tr><td><font color='#666666'>[use_name]</font></td><td align='right'><font color ='#FF0000'><b>Costs [purchase_cost] [owner.presence.unit_name]\s.</b></font></td></tr>"
	return dat
