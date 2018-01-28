// Telepathy toggle.
/obj/screen/psi/telepathy
	name = "Telepathy"
	icon_state = "telepathy_broad"

/obj/screen/psi/telepathy/update_icon()
	..()
	if(invisibility == 0)
		icon_state = owner.psi.use_intimate_mode ? "telepathy_intimate" : "telepathy_broad"

/obj/screen/psi/telepathy/Click()

	if(!owner.psi)
		return

	owner.psi.use_intimate_mode = !owner.psi.use_intimate_mode
	if(owner.psi.use_intimate_mode)
		to_chat(owner, "<span class='notice'>You have restricted your telepathy to the <b>intimate mode</b>.</span>")
	else
		to_chat(owner, "<span class='notice'>You have widened your telepathy to the <b>declamatory mode</b>.</span>")
	update_icon()
// End telepathy toggle.

// Menu toggle.
/obj/screen/psi/toggle_psi_menu
	name = "Show/Hide Psi UI"
	icon_state = "arrow_left"
	var/obj/screen/psi/hub/controller

/obj/screen/psi/toggle_psi_menu/New(var/mob/living/_owner, var/obj/screen/psi/hub/_controller)
	controller = _controller
	..(_owner)

/obj/screen/psi/toggle_psi_menu/Click()
	var/set_hidden = !hidden
	for(var/thing in controller.components)
		var/obj/screen/psi/psi = thing
		psi.hidden = set_hidden
	controller.update_icon()

/obj/screen/psi/toggle_psi_menu/update_icon()
	if(hidden)
		icon_state = "arrow_left"
	else
		icon_state = "arrow_right"
// End menu toggle.