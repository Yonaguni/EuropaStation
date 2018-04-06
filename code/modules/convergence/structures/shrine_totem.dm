/obj/structure/shrine/totem
	name = "totem"
	icon_state = "totem"
	unfinished = FALSE

/obj/structure/shrine/totem/New()
	..()
	LAZYADD(sanctified_to.totems, src)

/obj/structure/shrine/totem/update_strings()
	name = sanctified_to.presence.totem_name
	desc = sanctified_to.presence.totem_desc
	icon_state = sanctified_to.presence.totem_icon
