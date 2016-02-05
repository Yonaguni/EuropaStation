/obj/structure/europa/button
	name = "button"
	icon = 'icons/obj/europa/structures/buttons.dmi'
	icon_state = "button_on"
	var/state_on = "button_on"
	var/state_off = "button_off"
	var/global/button_delay = 15

/obj/structure/europa/button/attack_hand()
	interact()

/obj/structure/europa/button/attack_ai()
	interact()

/obj/structure/europa/button/attack_generic()
	interact()

/obj/structure/europa/button/interact()
	if(icon_state == state_off)
		return
	icon_state = state_off
	for(var/obj/structure/conduit/data/D in src.loc)
		if(!D.network) D.build_network()
		var/datum/conduit_network/data_cable/DC = D.network
		DC.pulse()
	spawn(button_delay)
		icon_state = state_on
