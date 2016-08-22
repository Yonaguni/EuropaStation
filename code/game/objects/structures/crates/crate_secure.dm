/obj/structure/crate/secure
	name = "footlocker"
	desc = "A secure locker."
	icon_state = "securecrate"
	icon_opened = "securecrateopen"
	icon_closed = "securecrate"
	can_lock = 1

/obj/structure/crate/secure/New(var/newloc)
	..(newloc, "plasteel")