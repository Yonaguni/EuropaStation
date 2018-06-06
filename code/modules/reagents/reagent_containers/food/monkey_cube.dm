/obj/item/reagent_containers/food/snacks/monkeycube
	name = "monkey cube"
	desc = "Just add water!"
	flags = OPENCONTAINER
	icon_state = "monkeycube"
	bitesize = 12
	filling_color = "#ADAC7F"
	center_of_mass = "x=16;y=14"
	protein_amt = 10

	var/wrapped = 0
	var/monkey_type = "Monkey"

/obj/item/reagent_containers/food/snacks/monkeycube/attack_self(var/mob/user)
	if(wrapped) Unwrap(user)

/obj/item/reagent_containers/food/snacks/monkeycube/proc/Expand()
	visible_message("<span class='notice'>\The [src] expands!</span>")
	new /mob/living/carbon/human(get_turf(src), monkey_type)
	qdel(src)
	return 1

/obj/item/reagent_containers/food/snacks/monkeycube/proc/Unwrap(var/mob/user)
	icon_state = "monkeycube"
	desc = "Just add water!"
	to_chat(user, "<span class='notice'>You unwrap the cube.</span>")
	wrapped = 0
	flags |= OPENCONTAINER

/obj/item/reagent_containers/food/snacks/monkeycube/on_reagent_change()
	if(reagents.has_reagent(REAGENT_WATER)) Expand()

/obj/item/reagent_containers/food/snacks/monkeycube/wrapped
	desc = "Still wrapped in some paper."
	icon_state = "monkeycubewrap"
	flags = 0
	wrapped = 1
