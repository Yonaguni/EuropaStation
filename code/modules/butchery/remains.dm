/obj/item/bone
	icon = 'icons/obj/butchery.dmi'
	var/bone_amt = 1

/obj/item/bone/single
	name = "bone"
	desc = "Looks like someone went out on a limb."
	icon_state = "bone"

/obj/item/bone/single/Initialize()
	. = ..()
	var/matrix/M = matrix()
	M.Turn(rand(1,360))
	transform = M

/obj/item/bone/skull
	name = "skull"
	desc = "Looks like someone lost their head."
	bone_amt = 3

/obj/item/bone/skull/deer
	name = "deer skull"
	icon_state = "deer_skull"
