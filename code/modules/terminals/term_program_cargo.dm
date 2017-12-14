#define SCREEN_MAIN     1
#define SCREEN_REQUESTS 2
#define SCREEN_PURCHASE 3

/datum/console_program/supply
	name = "supply pod control module"
	var/obj/machinery/computer/supply/owner_console
	var/screen = SCREEN_MAIN
	var/list/category_text
	var/category_current
	var/decl/hierarchy/supply_pack/show_pack_info

/datum/console_program/supply/New(var/obj/machinery/new_owner)
	..()
	if(istype(new_owner, /obj/machinery/computer/supply))
		owner_console = new_owner

/datum/console_program/supply/proc/set_screen(var/_screen)
	if(screen != _screen)
		screen = _screen
		screen_index = 1

/datum/console_program/supply/UpdateContents(var/silent = FALSE)
	html.Cut()
	html +=  "<pre class='alignCentre'>=== Supply Requisition System ==="

	if(!owner_console || !supply_controller)
		html +=  "=========================================================="
		for(var/i = 1 to round(TERM_LINES/3))
			html += " "
		html += "===== UNABLE TO CONNECT TO SUPPLY REQUISITION SYSTEM ======"
		html += "===== CONTACT SERVICE PROVIDER OR LOCAL ADMINISTRATOR ====="
		return ..(silent)

	if(!owner_console.activeterminal)
		html += "==============================================\[<a href='?src=\ref[owner];login=1'>LOG IN</a>\]===="
	else
		html += "==============================================\[<a href='?src=\ref[owner];logout=1'>LOG OUT</a>\]==="

	html += "Current balance: [supply_controller.points]"
	html += "=========================================================="

	if(show_pack_info)
		html += " "
		html += "=== [show_pack_info.name] ==="
		html += " "
		html += "Contents:"

		var/too_much_stuff
		var/contents_limit = show_pack_info.contains.len
		if(contents_limit > 8)
			contents_limit = 8
			too_much_stuff = 1
		for(var/i = 1 to contents_limit)
			var/atom/A = show_pack_info.contains[i]
			html += "- [initial(A.name)]"
		if(too_much_stuff)
			html += "- additional unlisted items"

		html += " "
		html += "Cost: $[show_pack_info.cost]"
		html += " "
		html += "==================================================\[<a href='?src=\ref[owner];show=1'>BACK</a>\]=="

	else

		switch(screen)
			if(SCREEN_MAIN)
				html += "===== \[BROWSE GOODS\] | <a href='?src=\ref[owner];changescreen=2'>VIEW REQUESTS</a> | <a href='?src=\ref[owner];changescreen=3'>SHOPPING CART</a> ====="

				if(owner_console.supplylist.len)

					if(!category_text)
						category_text = list()
						var/category_string = ""
						var/category_string_length
						for(var/thing in owner_console.supplylist)

							var/list/category_data = owner_console.supplylist[thing]
							var/namestr = category_data["name"]
							var/namelen = length(namestr)

							if((category_string_length + namelen) > 58)
								category_text += category_string
								category_string = ""
								category_string_length = 0

							else if(category_string != "")
								category_string += " | "
								category_string_length += 3

							category_string += "<a href='?src=\ref[owner];setcategory=[thing]'>[namestr]</a>"
							category_string_length += namelen

						if(category_string != "")
							category_text += category_string

						category_current = owner_console.supplylist[1]

					html += "=== Current category: [category_current]."
					html += "=========================================================="

					for(var/thing in category_text)
						html += thing

					var/list/category_contents = owner_console.supplylist[category_current]["pack"]
					add_page_header(category_contents.len, 8)
					var/i = (screen_index-1)*8
					while(html.len < (TERM_LINES-1) && i < category_contents.len)
						i++
						var/list/pack_data = category_contents[i]
						if(pack_data["available"])
							var/pack_str = "[pack_data["name"]] - $[pack_data["cost"]] "
							while(length(pack_str) < 51)
								pack_str += "-"
							html += "[pack_str] \[<a href='?src=\ref[owner];show=1;id=[pack_data["id"]]'>?</a>\]\[<a href='?src=\ref[owner];add=1;id=[pack_data["id"]]'>+</a>\]"

				else
					html += "=========================================================="
					for(var/i = 1 to round(TERM_LINES/3))
						html += " "
					html += "=== No goods available! ==="

			if(SCREEN_REQUESTS)
				html += "===== <a href='?src=\ref[owner];changescreen=1'>BROWSE GOODS</a> | \[VIEW REQUESTS\] | <a href='?src=\ref[owner];changescreen=3'>SHOPPING CART</a> ====="
				if(supply_controller.requestlist.len)

					add_page_header(supply_controller.requestlist.len, 4)

					for(var/i = 1 to 4)
						var/request_index = ((screen_index-1)*4)+i
						if(request_index <= supply_controller.requestlist.len)
							var/datum/supply_order/SO = supply_controller.requestlist[request_index]
							html += "#[SO.ordernum] - [SO.object.name] - $[SO.object.cost]"
							html += "Ordered by [SO.orderedby] for: '[SO.reason]'"
							if(owner_console.isActiveTerminal())
								html += "=========================================\[<a href='?src=\ref[owner];approve=1;id=\ref[SO]'>APPROVE</a>\]=\[<a href='?src=\ref[owner];deny=1;id=\ref[SO]'>DENY</a>\]="
							else
								html += "=========================================================="
						else
							html += " "
							html += " "
							html += " "
				else

					html += "=========================================================="

					for(var/i = 1 to round(TERM_LINES/3))
						html += " "
					html += "=== No current requests. ==="

			if(SCREEN_PURCHASE)
				html += "===== <a href='?src=\ref[owner];changescreen=1'>BROWSE GOODS</a> | <a href='?src=\ref[owner];changescreen=2'>VIEW REQUESTS</a> | \[SHOPPING CART\] ====="

				if(supply_controller.shoppinglist.len)
					if(owner_console.isActiveTerminal())
						html += "==================================\[ <a href='?src=\ref[owner];send=1'>Confirm Purchase</a> \]==="
					else
						html += "=========================================================="

					add_page_header(supply_controller.shoppinglist.len, 4)

					for(var/i = 1 to 4)
						var/request_index = ((screen_index-1)*4)+i
						if(request_index <= supply_controller.shoppinglist.len)
							var/datum/supply_order/SO = supply_controller.shoppinglist[request_index]
							html += "#[SO.ordernum] - [SO.object.name] - $[SO.object.cost]"
							html += "Ordered by [SO.orderedby] for: '[SO.reason]'"
							if(owner_console.isActiveTerminal())
								html += "===============================================\[<a href='?src=\ref[owner];remove=1;id=\ref[SO]'>REMOVE</a>\]==="
							else
								html += "=========================================================="
						else
							html += " "
				else
					html += "=========================================================="
					for(var/i = 1 to round(TERM_LINES/3))
						html += " "
					html += "=== No current orders. ==="

	..(silent)

#undef SCREEN_MAIN
#undef SCREEN_REQUESTS
#undef SCREEN_PURCHASE
#undef TERM_CARGO_ITEMS_PER_PAGE