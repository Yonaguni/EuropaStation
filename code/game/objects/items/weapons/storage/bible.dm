/obj/item/storage/bible
	name = "bible"
	desc = "Apply to head repeatedly."
	icon_state ="bible"
	throw_speed = 1
	throw_range = 5
	w_class = 3
	max_w_class = 2
	max_storage_space = 4
	var/mob/affecting = null
	var/deity_name = "Christ"

/obj/item/storage/bible/booze
	name = "bible"
	desc = "To be applied to the head repeatedly."
	icon_state ="bible"

	startswith = list(
		/obj/item/reagent_containers/food/drinks/bottle/small/beer,
		/obj/item/spacecash/bundle/c50,
		/obj/item/spacecash/bundle/c50,
		)

