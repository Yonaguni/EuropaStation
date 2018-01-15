/obj/item/convergence/rod/eldergod
	name = "ritual athame"
	icon_state = "athame"
	force = 5
	edge = 1
	sharp = 1

/obj/item/convergence/rod/eldergod/charged()
	return LAZYLEN(blood_DNA) > 0

/obj/item/convergence/rod/eldergod/spend_charge()
	clean_blood()
