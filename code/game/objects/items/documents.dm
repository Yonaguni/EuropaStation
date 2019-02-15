/obj/item/documents
	name = "secret documents"
	desc = "\"Top Secret\" documents."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "docs_generic"
	item_state = "paper"
	throwforce = 0
	w_class = ITEM_SIZE_TINY
	throw_range = 1
	var/description_antag

/obj/item/documents/examine(var/mob/user)
	. = ..()
	if(. && description_antag)
		to_chat(user, description_antag)
