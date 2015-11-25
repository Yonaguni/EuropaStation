/obj/item/stack/material/europa/structure_parts
	name = "bed parts"
	desc = "All the parts needed to make a bed."
	max_amount = 5
	icon = 'icons/obj/europa/items/parts.dmi'
	icon_state = "tableparts"

	var/build_time = 30
	var/build_path = /obj/structure/bed
	var/one_per_turf = 1

/obj/item/stack/material/europa/structure_parts/update_strings()
	name = "[material.use_name] [initial(name)]"

/obj/item/stack/material/europa/structure_parts/attack_self(var/mob/user)

	if((locate(build_path) in get_turf(user)) && one_per_turf)
		user << "<span class='warning'>There is already something occupying this space.</span>"
		return

	user.visible_message("<span class='notice'>\The [user] begins assembling \the [src].</span>")
	if(do_after(user, build_time))
		if(!src || get_amount() < 1)
			return
		var/obj/thing = new build_path(get_turf(src), material.name)
		user.visible_message("<span class='notice'>\The [user] has assembled \a [thing].</span>")
		use(1)
		return

/obj/item/stack/material/europa/structure_parts/bookshelf
	name = "bookshelf parts"
	desc = "All the parts needed to make a bookshelf."
	build_path = /obj/structure/bookcase
	default_type = "wood"

/obj/item/stack/material/europa/structure_parts/table
	name = "table parts"
	desc = "All the parts needed to make a table."
	build_path = /obj/structure/table

/obj/item/stack/material/europa/structure_parts/table/plastic
	default_type = "plastic"

/obj/item/stack/material/europa/structure_parts/rack
	name = "rack parts"
	desc = "All the parts needed to make a rack."
	build_path = /obj/structure/table/rack

/obj/item/stack/material/europa/structure_parts/chair
	name = "chair parts"
	desc = "All the parts needed to make a chair."
	icon_state = "chairparts"
	build_path = /obj/structure/bed/chair

/obj/item/stack/material/europa/structure_parts/chair/wood
	default_type = "wood"

/obj/item/stack/material/europa/structure_parts/door
	name = "door parts"
	desc = "All the parts needed to make a door."
	icon_state = "chairparts"
	build_path = /obj/structure/simple_door
