// Screen objects hereon out.
/obj/screen/movable/snap/mecha
	name = "hardpoint"
	icon = 'icons/mecha/mecha_hud.dmi'
	icon_state = "hardpoint"
	var/mob/living/mecha/owner

/obj/screen/movable/snap/mecha/New(var/mob/living/mecha/newowner)
	if(!istype(newowner))
		return qdel(src)
	owner = newowner

/obj/screen/movable/snap/mecha/Click()
	return (!usr.incapacitated() && (usr == owner || usr.loc == owner))

/obj/screen/movable/snap/mecha/hardpoint
	name = "hardpoint"
	var/hardpoint_tag
	var/obj/item/holding

	maptext_x = 34
	maptext_y = 3
	maptext_width = 64

/obj/screen/movable/snap/mecha/hardpoint/MouseDrop()
	..()
	if(holding) holding.screen_loc = screen_loc

/obj/screen/movable/snap/mecha/hardpoint/proc/update_system_info()

	// No point drawing it if we have no item to use or nobody to see it.
	if(!holding || !owner || (!owner.client && (!owner.pilot || !owner.pilot.client)))
		return

	overlays.Cut()

	if(!owner.body.cell || (owner.body.cell.charge <= 0))
		return

	var/value = round(holding.get_hardpoint_status_value() * BAR_CAP)

	if(isnull(value))
		return

	// Draw background.
	if(!default_hardpoint_background)
		default_hardpoint_background = image(icon = 'icons/mecha/mecha_hud.dmi', icon_state = "bar_bkg")
		default_hardpoint_background.pixel_x = 34
	overlays |= default_hardpoint_background

	if(!owner.body.diagnostics || !owner.body.diagnostics.is_functional())
		value = -1
		maptext = null
	else
		maptext = holding.get_hardpoint_maptext()

	if(value == 0)
		if(!hardpoint_bar_empty)
			hardpoint_bar_empty = image(icon='icons/mecha/mecha_hud.dmi',icon_state="bar_flash")
			hardpoint_bar_empty.pixel_x = 24
			hardpoint_bar_empty.color = "#FF0000"
		overlays |= hardpoint_bar_empty
	else if(value < 0)
		if(!hardpoint_error_icon)
			hardpoint_error_icon = image(icon='icons/mecha/mecha_hud.dmi',icon_state="bar_error")
			hardpoint_error_icon.pixel_x = 34
		overlays |= hardpoint_error_icon
	else
		value = min(value, BAR_CAP)
		// Draw statbar.
		if(!hardpoint_bar_cache.len)
			for(var/i=0;i<BAR_CAP;i++)
				var/image/bar = image(icon='icons/mecha/mecha_hud.dmi',icon_state="bar")
				bar.pixel_x = 24+(i*2)
				if(i>5)
					bar.color = "#00FF00"
				else if(i>1)
					bar.color = "#FFFF00"
				else
					bar.color = "#FF0000"
				hardpoint_bar_cache += bar
		for(var/i=i;i<=value;i++)
			overlays |= hardpoint_bar_cache[i]

/obj/screen/movable/snap/mecha/hardpoint/New(var/newloc, var/newtag)
	..(newloc)
	hardpoint_tag = newtag
	name = "hardpoint ([hardpoint_tag])"

/obj/screen/movable/snap/mecha/hardpoint/Click(var/location, var/control, var/params)

	if(!(..()))
		return

	var/modifiers = params2list(params)
	if(modifiers["ctrl"])
		if(owner.hardpoints_locked)
			usr << "<span class='warning'>Hardpoint ejection system is locked.</span>"
			return
		if(owner.remove_system(hardpoint_tag))
			usr << "<span class='notice'>You disengage and discard the system mounted to your [hardpoint_tag] hardpoint.</span>"
		else
			usr << "<span class='danger'>You fail to remove the system mounted to your [hardpoint_tag] hardpoint.</span>"
		return

	if(owner.selected_hardpoint == hardpoint_tag)
		icon_state = "hardpoint"
		owner.clear_selected_hardpoint()
	else
		if(owner.set_hardpoint(hardpoint_tag))
			icon_state = "hardpoint_selected"

/obj/screen/movable/snap/mecha/eject
	name = "eject"
	icon_state = "eject"

/obj/screen/movable/snap/mecha/eject/Click()
	if(..())
		owner.eject(usr)

/obj/screen/movable/snap/mecha/toggle
	name = "toggle"
	var/toggled

/obj/screen/movable/snap/mecha/toggle/Click()
	if(..()) toggled()

/obj/screen/movable/snap/mecha/toggle/proc/toggled()
	toggled = !toggled
	icon_state = "[initial(icon_state)][toggled ? "_enabled" : ""]"
	return toggled

/obj/screen/movable/snap/mecha/toggle/maint
	name = "toggle maintenance protocol"
	icon_state = "maint"

/obj/screen/movable/snap/mecha/toggle/maint/toggled()
	owner.maintenance_protocols = ..()
	usr << "<span class='notice'>Maintenance protocols [owner.maintenance_protocols ? "enabled" : "disabled"].</span>"

/obj/screen/movable/snap/mecha/toggle/hardpoint
	name = "toggle hardpoint lock"
	icon_state = "hardpoint_lock"

/obj/screen/movable/snap/mecha/toggle/hardpoint/toggled()
	owner.hardpoints_locked = ..()
	usr << "<span class='notice'>Hardpoint system access is now [owner.hardpoints_locked ? "disabled" : "enabled"].</span>"

/obj/screen/movable/snap/mecha/toggle/hatch
	name = "toggle hatch lock"
	icon_state = "hatch_lock"

/obj/screen/movable/snap/mecha/toggle/hatch/toggled()
	if(!owner.hatch_locked && !owner.hatch_closed)
		usr << "<span class='warning'>You cannot lock the hatch while it is open.</span>"
		return
	owner.hatch_locked = ..()
	usr << "<span class='notice'>The [owner.body.hatch_descriptor] is [owner.hatch_locked ? "now" : "no longer" ] locked.</span>"

/obj/screen/movable/snap/mecha/toggle/hatch_open
	name = "open or close hatch"
	icon_state = "hatch_status"

/obj/screen/movable/snap/mecha/toggle/hatch_open/update_icon()
	toggled = owner.hatch_closed
	icon_state = "hatch_status[owner.hatch_closed ? "" : "_enabled"]"

/obj/screen/movable/snap/mecha/toggle/hatch_open/toggled()
	if(owner.hatch_locked && owner.hatch_closed)
		usr << "<span class='warning'>You cannot open the hatch while it is locked.</span>"
		return
	owner.hatch_closed = ..()
	usr << "<span class='notice'>The [owner.body.hatch_descriptor] is now [owner.hatch_closed ? "closed" : "open" ].</span>"
	owner.update_icon()

// This is basically just a holder for the updates the mech does.
/obj/screen/movable/snap/mecha/health
	name = "mech integrity"
	icon_state = "health"
	var/display_internals
	var/list/internal_components = list()

/obj/screen/movable/snap/mecha/health/Click()
	display_internals = !display_internals
	usr << "<span class='notice'>[display_internals ? "Now" : "No longer"] displaying data on internal system status.</span>"
	owner.handle_hud_icons_health()
	owner.refresh_hud()

/obj/screen/movable/snap/mecha/health/MouseDrop()
	..()
	var/i = 1
	for(var/obj/O in internal_components)
		O.screen_loc = screen_loc
		O.pixel_y = (i*(-32))

/obj/screen/movable/snap/mecha/internal_system
	name = "internal system"
	icon_state = "hardpoint"

#undef BAR_CAP