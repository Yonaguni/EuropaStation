/decl/aspect/ballistics
	name = ASPECT_GUNPLAY
	desc = "Fastest gun on Mars."
	use_icon_state = "guns_2"
	category = "Ranged Combat"

/decl/aspect/ballistics/do_post_spawn(var/mob/living/human/holder)
	// Already have a gun.
	if(locate(/obj/item/weapon/gun) in holder.contents)
		return
	// Already have a holster
	if(locate(/obj/item/clothing/accessory/holster) in holder.w_uniform)
		return
	var/gun_type = pick(list(
		/obj/item/weapon/gun/composite/premade/pistol/a9/preloaded,
		/obj/item/weapon/gun/composite/premade/pistol/a10/preloaded,
		/obj/item/weapon/gun/composite/premade/pistol/a38/preloaded,
		/obj/item/weapon/gun/composite/premade/pistol/a45/preloaded
		))
	var/obj/item/clothing/accessory/holster/waist/W = new (holder)
	holder.w_uniform.attackby(W, holder)
	W.holster(new gun_type(holder), holder)
	..()
