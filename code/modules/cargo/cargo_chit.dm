/obj/item/cargo_chit
	name = "cargo supply chit"
	desc = "It's a cargo chit. Load it into a supply beacon to recieve a cargo order."
	icon = 'icons/obj/chit.dmi'
	icon_state = "chit"
	w_class = 1

	var/order_id
	var/list/purchased_atoms = list()

/obj/item/cargo_chit/examine(var/mob/user)
	. = ..(user)
	if(.)
		to_chat(user, "It is valid for a drop of the following purchases:")
		for(var/thing in purchased_atoms)
			to_chat(user, "- \the [thing]")

/obj/item/cargo_chit/Destroy()
	purchased_atoms.Cut()
	. = ..()

/obj/item/cargo_chit/New(var/newloc, var/list/_purchased = list(), var/_order_id)
	..(newloc)
	order_id = _order_id
	name = "cargo chit #[order_id]"
	purchased_atoms = _purchased

/obj/item/paper/manifest
	name = "supply manifest"
	var/is_copy = 1

/datum/supply_order
	var/ordernum
	var/decl/hierarchy/supply_pack/object = null
	var/orderedby = null
	var/comment = null
	var/reason = null
	var/orderedrank = null //used for supply console printing