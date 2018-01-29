/obj/item/mmi/digital/New()
	src.brainmob = new(src)
	src.brainmob.stat = CONSCIOUS
	src.brainmob.add_language("Robot Talk")
	src.brainmob.container = src
	src.brainmob.silent = 0
	PickName()
	..()

/obj/item/mmi/digital/proc/PickName()
	return

/obj/item/mmi/digital/attackby()
	return

/obj/item/mmi/digital/attack_self()
	return

/obj/item/mmi/digital/transfer_identity(var/mob/living/carbon/H)
	brainmob.timeofhostdeath = H.timeofdeath
	brainmob.stat = 0
	if(H.mind)
		H.mind.transfer_to(brainmob)
	return