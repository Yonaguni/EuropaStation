/obj/structure/conduit/gas
	name = "atmosphere pipeline"
	icon_state = "pipe"
	color = "#0000FF"
	feed_icon = "pipe"
	feed_type = "gas_pipe"
	network_type = /datum/conduit_network/gas
	deconstruct_path = /obj/item/stack/conduit/gas

/obj/structure/conduit/gas/update_icon()
	. = ..()
	switch(feed_layer)
		if(0)
			color = "#FF0000"
		if(1)
			color = "#0000FF"
		if(2)
			color = "#00FF00"
		if(3)
			color = "#990000"
		if(4)
			color = "#009900"
		if(5)
			color = "#000099"
		if(6)
			color = "#999999"
		else
			color = null

/obj/item/stack/conduit/gas
	name = "pipe bundle"
	singular_name = "gas pipe"
	build_path = /obj/structure/conduit/gas

/obj/item/stack/conduit/gas/can_build_on(var/mob/user, var/turf/target)
	. = ..()
	if(. && (locate(/obj/machinery/atmos) in target))
		to_chat(user, "<span class='warning'>There is already atmospherics machinery taking up that area.</span>")
		return 0

/obj/item/stack/conduit/gas/update_icon()
	. = ..()
	switch(place_row)
		if(0)
			color = "#FF0000"
		if(1)
			color = "#0000FF"
		if(2)
			color = "#00FF00"
		if(3)
			color = "#990000"
		if(4)
			color = "#009900"
		if(5)
			color = "#000099"
		if(6)
			color = "#999999"
		else
			color = null

// Map stubs.
/obj/structure/conduit/gas/one
	color = "#FF0000"
	feed_layer = 0
	pixel_x = -10
	pixel_y = -10
/obj/structure/conduit/gas/two
	color = "#0000FF"
	feed_layer = 1
	pixel_x = -6
	pixel_y = -6
/obj/structure/conduit/gas/three
	color = "#00FF00"
	feed_layer = 2
	pixel_x = -2
	pixel_y = -2
/obj/structure/conduit/gas/four
	color = "#990000"
	feed_layer = 3
	pixel_x = 2
	pixel_y = 2
/obj/structure/conduit/gas/five
	color = "#009900"
	feed_layer = 4
	pixel_x = 6
	pixel_y = 6
/obj/structure/conduit/gas/six
	color = "#000099"
	feed_layer = 5
	pixel_x = 10
	pixel_y = 10
/obj/structure/conduit/gas/seven
	color = "#999999"
	feed_layer = 6
	pixel_x = 14
	pixel_y = 14
