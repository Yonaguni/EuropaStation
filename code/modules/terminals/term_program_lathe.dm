#define MAX_ITEMS_PER_PRINT 20

/datum/console_program/lathe
	name = "lathe module"
	var/obj/machinery/autolathe/lathe

/datum/console_program/lathe/New(var/obj/machinery/new_owner)
	lathe = new_owner
	if(istype(lathe))
		..(new_owner)
	else
		qdel(src)

/datum/console_program/lathe/Destroy()
	lathe = null
	. = ..()

/datum/console_program/lathe/UpdateContents(var/silent = FALSE)

	html.Cut()
	html +=  "<pre class='alignCentre'>=== [capitalize(lathe.name)] Control Panel ===</pre>"
	html +=  "=========================================================="

	if(lathe.disabled)
		html += " "
		html += "<pre class='alignCentre'>=== SYSTEM DISABLED ===</pre>"
		html += " "
		..(silent)
		return

	var/second_material = FALSE
	var/current_line
	for(var/material in lathe.stored_material)

		var/material_string = "[capitalize(material)]: [lathe.stored_material[material]]/[lathe.storage_capacity[material]]"
		if(second_material)
			current_line += " "
			var/pad = 49 - (length(current_line) + length(material_string))
			while(pad > 0)
				pad--
				current_line += "-"
			current_line += " "

		current_line += material_string
		second_material = !second_material

		if(!second_material)
			html += "=== [current_line] ==="
			current_line = ""

	if(current_line && current_line != "")
		current_line += " "
		var/pad = 50 - length(current_line)
		while(pad > 0)
			pad--
			current_line += "-"
		html += "=== [current_line] ==="


	html +=  "=========================================================="
	html += "<pre class='alignCentre'>=== <a href='?src=\ref[lathe];change_category=1'>[lathe.show_category]</a> ===</pre>"

	var/index = 0
	var/list/recipes_to_display = list()
	for(var/datum/autolathe/recipe/R in lathe.machine_recipes)
		index++
		if(R.hidden && !lathe.hacked || (lathe.show_category != "All" && lathe.show_category != R.category))
			continue
		recipes_to_display[R] = index

	var/per_page = TERM_LINES - (html.len+3)
	add_page_header(recipes_to_display.len, per_page)

	for(var/i = 1 to per_page)
		var/real_index = ((screen_index-1)*per_page)+i
		if(real_index <= recipes_to_display.len)
			var/datum/autolathe/recipe/R = recipes_to_display[real_index]
			if(!istype(R))
				continue

			var/can_make = 1
			var/material_string = ""
			var/multiplier_string = ""
			var/max_sheets

			var/pad_count = 56

			if(!R.resources || !R.resources.len)
				material_string = "No resources required."
			else
				//Make sure it's buildable and list requires resources.
				for(var/material in R.resources)
					var/sheets = round(lathe.stored_material[material]/round(R.resources[material]*lathe.mat_efficiency))
					if(isnull(max_sheets) || max_sheets > sheets)
						max_sheets = sheets
					if(!isnull(lathe.stored_material[material]) && lathe.stored_material[material] < round(R.resources[material]*lathe.mat_efficiency))
						can_make = 0
					material_string += "[round(R.resources[material] * lathe.mat_efficiency)][copytext(material,1,3)] "
					max_sheets = min(max_sheets, MAX_ITEMS_PER_PRINT)

				//Build list of multipliers for sheets.
				if(R.multiple_product)
					if(max_sheets && max_sheets > 0)
						for(var/scount = 5;scount<max_sheets;scount*=2) //5,10,20,40...
							if(scount >= MAX_ITEMS_PER_PRINT)
								break
							multiplier_string  += "<a href='?src=\ref[lathe];make=[recipes_to_display[R]];multiplier=[scount]'>\[x[scount]\]</a>"
							pad_count -= length("[scount]")+3
						multiplier_string += "<a href='?src=\ref[lathe];make=[recipes_to_display[R]];multiplier=[max_sheets]'>\[x[max_sheets]\]</a>"
						pad_count -= length("[max_sheets]")+4

			pad_count -= length(material_string)

			var/adding = ""
			if(can_make)
				adding = "<a href='?src=\ref[lathe];make=[recipes_to_display[R]];multiplier=1'>[R.name]</a> [multiplier_string] "
			else
				adding = "[R.name]"

			pad_count -= length(R.name)

			if(R.hidden)
				adding = "<font color = 'red'>*</font>[adding]<font color = 'red'>*</font>"
				pad_count -= 2

			adding += " "
			while(pad_count > 0)
				pad_count--
				adding += "-"

			html += "[adding] [material_string]"

	..(silent)

#undef MAX_ITEMS_PER_PRINT