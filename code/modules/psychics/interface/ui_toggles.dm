// Telekinesis toggle.
/obj/screen/psi/tk
	name = "Toggle Telekinesis"
	icon_state = "tk_disabled"

/obj/screen/psi/tk/Click(var/location, var/control, var/params)

	if(!owner.psi)
		return

	if(owner.psi.telekinesis_suppressed)
		if(owner.psi.get_rank(PSI_PSYCHOKINESIS) < PSI_RANK_GRANDMASTER || !owner.psi.spend_power(3))
			return

	if(owner.psi.telekinesis_suppressed && (owner.psi.stun || owner.psi.suppressed))
		to_chat(owner, "<span class='warning'>You are dazed and reeling, and cannot muster enough focus to do that!</span>")
		return

	owner.psi.telekinesis_suppressed = !owner.psi.telekinesis_suppressed
	/*
	if(owner.psi.telekinesis_suppressed)
		to_chat(owner, "<span class='notice'>You have <b>suppressed your telekinesis</b>.</span>")
		owner.mutations &= ~TK
	else
		to_chat(owner, "<span class='notice'>You are <b>no longer suppressing</b> your telekinesis.</span>")
		owner.mutations |= TK
	*/
	update_icon()

/obj/screen/psi/tk/update_icon()
	if(owner.psi.get_rank(PSI_PSYCHOKINESIS) < PSI_RANK_GRANDMASTER)
		invisibility = 101
		owner.psi.telekinesis_suppressed = TRUE
		//owner.mutations &= ~TK
	else
		if(owner.psi.telekinesis_suppressed)
			icon_state = "tk_disabled"
		else
			icon_state = "tk_enabled"
		..()
// End telekinesis toggle.

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