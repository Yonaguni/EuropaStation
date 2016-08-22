/obj/structure/crate/wooden
	name = "crate"
	desc = "A box of rough slats."
	icon_state = "woodencrate"
	icon_opened = "woodencrateopen"
	icon_closed = "woodencrate"

/obj/structure/crate/wooden/New(var/newloc)
	..(newloc, "wood")

/obj/structure/crate/wooden/secure
	desc = "A crate with a lock."
	icon_state = "securewoodencrate"
	icon_opened = "securewoodencrateopen"
	icon_closed = "securewoodencrate"
	can_lock = 1