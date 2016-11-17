/client
	var/list/psi_hud = list()
	var/list/psychic_hud_elements = list()
	var/obj/screen/psi/toggle/psi_toggle
	var/hide_psi_powers = FALSE

/obj/screen/psi
	icon = 'icons/effects/screen/psi.dmi'

/obj/screen/psi/toggle
	name = "Show/Hide Powers"
	icon_state = "arrow_right"
	screen_loc = "10,14"

/obj/screen/psi/toggle/Click(var/location, var/control, var/params)
	if(usr && usr.client)
		usr.client.hide_psi_powers = !usr.client.hide_psi_powers
		update_state(usr)

/obj/screen/psi/toggle/proc/update_state(var/mob/user)
	if(!user || !user.mind)
		return
	if(user.client && user.client.hide_psi_powers)
		icon_state = "arrow_left"
		if(user.client)
			user.client.screen -= user.client.psi_hud
		screen_loc = "15,14"
	else
		icon_state = "arrow_right"
		if(user.client)
			user.client.screen |= user.client.psi_hud
		screen_loc = "[15-user.mind.psychic_faculties.len],14"

/obj/screen/psi/power
	name = "psychic power"
	icon = 'icons/effects/screen/psi.dmi'
	icon_state = "base"
	var/datum/psychic_power/power

/obj/screen/psi/power/New(var/datum/psychic_power/_power)
	..()
	power = _power
	name = power.name
	power.hud_element = src
	screen_loc = "[16-power.owner.psychic_faculties.Find(power.associated_faculty.name)],[16-power.rank]"
	update_from_power()

/obj/screen/psi/power/Destroy()
	power = null
	. = ..()

/obj/screen/psi/power/proc/update_from_power()
	overlays.Cut()
	color = "#FFFFFF"
	var/list/overlays_to_add = list()
	var/image/I = image(icon, "[power.rank]")
	overlays_to_add += I
	if(power.active)
		I = image(icon, icon_state="active")
		I.color = power.associated_faculty.colour
		overlays_to_add += I
	if(world.time < power.next_psy)
		color = "#AAAAAA"
		I = image(icon, "cooldown")
		overlays_to_add += I
	overlays = overlays_to_add

/obj/screen/psi/power/Click(var/location, var/control, var/params)
	if(power.active)
		power.cancelled(usr)
	else
		power.evoke(usr)
