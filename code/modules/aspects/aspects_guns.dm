/decl/aspect/ranged
	name = "Thrown Weapons"
	desc = "Be they darts, half-bricks or shuriken, you're spot-on with a thrown weapon."
	use_icon_state = "guns_1"
	category = "Ranged Weapons"

/decl/aspect/ranged/ballistics
	name = "Gunslinger"
	desc = "You know how to fire a gun without spraining your wrist."
	use_icon_state = "guns_2"

/decl/aspect/ranged/ballistics/do_post_spawn(var/mob/living/carbon/human/holder)
	if(name == "Gunslinger")
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

/decl/aspect/ranged/ballistics/maintenance
	name = "Ballistic Maintenance"
	desc = "You can field-strip or repair almost anything with a barrel and firing mechanism."
	parent_name = "Gunslinger"
	use_icon_state = "guns_3"

/decl/aspect/ranged/ballistics/expert
	name = "Deadeye"
	desc = "This is your rifle, this is your gun. You know ballistics better than most."
	parent_name = "Gunslinger"
	use_icon_state = "guns_4"

/decl/aspect/ranged/energy
	name = "C.R.E.W.S"
	desc = "You are familiar with the use of most energy weapons."
	use_icon_state = "guns_5"

/decl/aspect/ranged/energy/maintenance
	name = "C.R.E.W.S Maintenance"
	desc = "You can field-strip and rebuild a lasgun in under a minute."
	parent_name = "C.R.E.W.S"
	use_icon_state = "guns_6"

/decl/aspect/ranged/energy/expert
	name = "Laser Technician"
	desc = "You are an expert in the field of wide-spectrum death."
	parent_name = "C.R.E.W.S"
	use_icon_state = "guns_7"

/decl/aspect/ranged/exotic
	name = "Exotic Weapons"
	desc = "You are familiar with the use of crossbows, pneumatic cannons, and other, stranger devices."
	use_icon_state = "guns_8"

/decl/aspect/ranged/exotic/maintainence
	name = "Exotic Weapon Maintenance"
	desc = "You can build and maintain all kinds of bizarre crossbows and scrap-cannons."
	parent_name = "Exotic Weapons"
	use_icon_state = "guns_9"
