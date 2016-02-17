var/list/necklace_icon_cache = list()

/obj/item/jewelry/necklace
	name = "necklace"
	desc = "A necklace. Very pretty."
	color = "#805500"
	icon_state = "base"
	icon = 'icons/obj/clothing/necklace_parts.dmi'
	slot_flags = SLOT_MASK | SLOT_POCKET
	value_mod = 100
	var/max_pendants = 1

/obj/item/jewelry/necklace/platinum/New(var/newloc)
	..(newloc, /material/platinum)

/obj/item/jewelry/necklace/get_value()
	var/result = ..()
	for(var/obj/item/jewelry/pendant/P in contents)
		result += P.get_value()
	return result

/obj/item/jewelry/necklace/attack_self(var/mob/living/user)
	if(!contents.len)
		return ..()
	var/obj/item/removing = contents[1]
	removing.forceMove(get_turf(src))
	update_icon()
	user.put_in_hands(removing)
	user << "<span class='notice'>You remove \the [removing] from \the [src].</span>"

/obj/item/jewelry/necklace/attackby(var/obj/item/thing, var/mob/living/user)
	if(istype(thing, /obj/item/jewelry/pendant))
		if(contents.len >= max_pendants)
			user << "<span class='warning'>You cannot fit another pendant onto \the [src].</span>"
			return
		user.unEquip(thing)
		thing.forceMove(src)
		update_icon()
		user << "<span class='notice'>You add \the [thing] to \the [src].</span>"
		return
	return ..()

/obj/item/jewelry/necklace/update_icon()

	// Clear mapping aid data.
	icon = null
	icon_state = ""
	color = null
	overlays.Cut()

	// Build inventory icon.
	var/cache_key = "necklace-[material.icon_colour]"
	var/image/I = image('icons/obj/clothing/necklace_parts.dmi', "base")
	I.color = material.icon_colour
	overlays += I

	for(var/obj/item/jewelry/pendant/P in contents)
		cache_key = "[cache_key]-[P.icon_state]-[P.material.icon_colour]"
		I = image(P.icon, P.icon_state)
		I.color = P.material.icon_colour
		overlays += I

	// Generate and cache mob icon.
	if(!necklace_icon_cache[cache_key])
		var/icon/tmp_icon = icon('icons/mob/clothing/necklace_parts.dmi', "blank")
		var/icon/base_icon = icon('icons/mob/clothing/necklace_parts.dmi', "base")
		base_icon.Blend(material.icon_colour, ICON_MULTIPLY)
		tmp_icon.Blend(base_icon, ICON_OVERLAY)

		for(var/obj/item/jewelry/pendant/P in contents)
			var/icon/pendant_icon = icon('icons/mob/clothing/necklace_parts.dmi', P.icon_state)
			pendant_icon.Blend(P.material.icon_colour, ICON_MULTIPLY)
			tmp_icon.Blend(pendant_icon, ICON_OVERLAY)

		necklace_icon_cache[cache_key] = tmp_icon

	item_icons[slot_wear_mask_str] = necklace_icon_cache[cache_key]

	var/mob/M = loc
	if(istype(M))
		M.update_inv_wear_mask()