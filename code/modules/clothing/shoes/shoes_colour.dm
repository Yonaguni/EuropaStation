POPULATE_COLOURED_VARIANTS_OF(/obj/item/clothing/shoes, "shoes")

/obj/item/clothing/shoes/leather
	name = "leather shoes"
	desc = "A sturdy pair of leather shoes."
	icon_state = "leather"

/obj/item/clothing/shoes/rainbow
	name = "rainbow shoes"
	desc = "Very gay shoes."
	icon_state = "rain_bow"

/obj/item/clothing/shoes/orange
	name = "orange shoes"
	icon_state = "orange"
	var/obj/item/handcuffs/chained = null

/obj/item/clothing/shoes/orange/proc/attach_cuffs(var/obj/item/handcuffs/cuffs, var/mob/user)
	if (src.chained) return

	user.drop_item()
	cuffs.loc = src
	src.chained = cuffs
	src.slowdown_per_slot[slot_shoes] += 15
	src.icon_state = "orange1"

/obj/item/clothing/shoes/orange/proc/remove_cuffs(var/mob/user)
	if (!src.chained) return

	user.put_in_hands(src.chained)
	src.chained.add_fingerprint(user)

	src.slowdown_per_slot[slot_shoes] -= 15
	src.icon_state = "orange"
	src.chained = null

/obj/item/clothing/shoes/orange/attack_self(var/mob/user)
	..()
	remove_cuffs(user)

/obj/item/clothing/shoes/orange/attackby(H as obj, var/mob/user)
	..()
	if (istype(H, /obj/item/handcuffs))
		attach_cuffs(H, user)


