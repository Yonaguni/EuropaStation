/obj/item/reagent_containers/glass/bottle
	name = "bottle"
	desc = "A small bottle."
	icon = 'icons/obj/chemical.dmi'
	icon_state = null
	item_state = "atoxinbottle"
	randpixel = 7
	center_of_mass = "x=15;y=10"
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = "5;10;15;25;30;60"
	w_class = 2
	flags = 0
	volume = 60
	var/draw_contents
	var/obfuscate_contents = FALSE
	var/actual_reagent_name

/obj/item/reagent_containers/glass/bottle/get_default_codex_value(var/mob/user)
	return (HAS_ASPECT(user, ASPECT_PHARMACIST) && !isnull(actual_reagent_name)) ? "[actual_reagent_name] (chemical)" : ..()

/obj/item/reagent_containers/glass/bottle/examine(var/mob/user)
	. = ..(user, 1)
	if(!isnull(actual_reagent_name) && HAS_ASPECT(user, ASPECT_PHARMACIST))
		to_chat(user, "<span class='notice'>As far as you know, the active ingredient is <b>[actual_reagent_name]</b>.</span>")

/obj/item/reagent_containers/glass/bottle/on_reagent_change()
	..()
	update_icon()

/obj/item/reagent_containers/glass/bottle/attack_hand()
	..()
	update_icon()

/obj/item/reagent_containers/glass/bottle/Initialize()
	. = ..()
	if(reagents && reagents.total_volume && obfuscate_contents)
		var/reagent_id = reagents.get_master_reagent()
		if(reagent_id)
			var/medication_name = get_random_medication_name_for_reagent(reagent_id)
			actual_reagent_name = reagents.get_master_reagent_name()
			name = "[medication_name] bottle"
			desc = "A bottle of some sort of medicine."
			if(isnull(medicine_name_to_bottle_state[medication_name]))
				medicine_name_to_bottle_state[medication_name] = "bottle-[rand(1,4)]"
			icon_state = medicine_name_to_bottle_state[medication_name]
	if(!icon_state)
		icon_state = "bottle-[rand(1,4)]"
	if(icon_state in list("bottle-1", "bottle-2", "bottle-3", "bottle-4"))
		draw_contents = TRUE
	update_icon()

/obj/item/reagent_containers/glass/bottle/update_icon()
	cut_overlays()
	if(draw_contents)
		if(reagents.total_volume)
			var/fill_colour = reagents.get_color()
			var/fill_icon = "[icon_state]10"
			var/percent = round((reagents.total_volume / volume) * 100)
			switch(percent)
				if( 0 to  9) fill_icon = "[icon_state]--10"
				if(10 to 24) fill_icon = "[icon_state]-10"
				if(25 to 49) fill_icon = "[icon_state]-25"
				if(50 to 74) fill_icon = "[icon_state]-50"
				if(75 to 79) fill_icon = "[icon_state]-75"
				if(80 to 90) fill_icon = "[icon_state]-80"
				else         fill_icon = "[icon_state]-100"

			var/cache_key = "[fill_icon]-[fill_colour]"
			if(!reagent_bottle_overlays[cache_key])
				var/image/filling = image('icons/obj/reagentfillings.dmi', fill_icon)
				filling.color = fill_colour
				reagent_bottle_overlays[cache_key] = filling
			add_overlay(reagent_bottle_overlays[cache_key])
		if(!is_open_container())
			add_overlay("lid_bottle")
