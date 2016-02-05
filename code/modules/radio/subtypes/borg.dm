/obj/item/device/radio/borg
	var/mob/living/silicon/robot/myborg = null // Cyborg which owns this radio. Used for power checks
	var/obj/item/device/encryptionkey/keyslot = null//Borg radios can handle a single encryption key
	var/shut_up = 1
	icon = 'icons/obj/robot_component.dmi' // Cyborgs radio icons should look like the component.
	icon_state = "radio"
	canhear_range = 0

/obj/item/device/radio/borg/Destroy()
	myborg = null
	return ..()

/obj/item/device/radio/borg/talk_into()
	. = ..()
	if (isrobot(src.loc))
		var/mob/living/silicon/robot/R = src.loc
		var/datum/robot_component/C = R.components["radio"]
		R.cell_use_power(C.active_usage)
