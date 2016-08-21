/obj/item/stack/material/skin
	name = "hide"
	desc = "This hide was stripped of it's hair, but still needs tanning."
	singular_name = "hairless hide piece"
	icon_state = "sheet-hairlesshide"
	var/source_mob

/obj/item/stack/material/skin/proc/set_source_mob(var/new_source)
	if(new_source)
		source_mob = new_source
	if(source_mob)
		name = "[source_mob] skin"