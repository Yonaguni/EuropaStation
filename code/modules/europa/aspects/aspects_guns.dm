/decl/aspect/ballistics
	name = ASPECT_GUNPLAY
	desc = "Fastest gun on Mars."
	use_icon_state = "guns_2"
	category = "Ranged Combat"
	aspect_cost = 2
	var/has_holster = TRUE
	var/list/gun_types = list(
		/obj/item/gun/composite/premade/pistol/a9/preloaded,
		/obj/item/gun/composite/premade/pistol/a10/preloaded,
		/obj/item/gun/composite/premade/pistol/a38/preloaded,
		/obj/item/gun/composite/premade/pistol/a45/preloaded
		)

/decl/aspect/ballistics/do_post_spawn(var/mob/living/carbon/human/holder)
	if(!istype(holder))
		return
	// Already have a gun.
	if(locate(/obj/item/gun) in holder.contents)
		return
	var/gun_type = pick(gun_types)
	var/obj/item/gun = new gun_type(holder)
	if(has_holster && !(locate(/obj/item/clothing/accessory/holster) in holder.w_uniform))
		var/obj/item/clothing/accessory/holster/W = new (holder)
		holder.w_uniform.attackby(W, holder)
		W.holster(gun, holder)
		if(W.loc != holder.w_uniform)
			W.forceMove(get_turf(holder))
			holder.put_in_hands(W)
	if(!istype(gun.loc, /obj/item/clothing/accessory/holster))
		gun.forceMove(get_turf(holder))
		holder.put_in_hands(gun)
	..()

/decl/aspect/ballistics/taser
	name = ASPECT_TASER
	desc = "You have invested in a small taser."
	has_holster = FALSE
	gun_types = list(/obj/item/gun/composite/premade/taser_pistol)
