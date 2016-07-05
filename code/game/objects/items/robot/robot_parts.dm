/obj/item/robot_parts
	name = "robot parts"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	icon = 'icons/obj/robot_parts.dmi'
	item_state = "buildpipe"
	icon_state = "blank"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	var/list/part = null // Order of args is important for installing robolimbs.
	var/sabotaged = 0 //Emagging limbs can have repercussions when installed as prosthetics.
	var/model_info
	dir = SOUTH

/obj/item/robot_parts/set_dir()
	return

/obj/item/robot_parts/New(var/newloc, var/model)
	..(newloc)
	if(model_info && model)
		model_info = model
		var/datum/robolimb/R = get_robolimb_by_name(model)
		if(R)
			name = "[R.company] [initial(name)]"
			desc = "[R.desc]"
			if(icon_state in icon_states(R.icon))
				icon = R.icon
	else
		name = "robot [initial(name)]"

/obj/item/robot_parts/l_arm
	name = "left arm"
	icon_state = "l_arm"
	part = list(BP_L_ARM, BP_L_HAND)
	model_info = 1

/obj/item/robot_parts/r_arm
	name = "right arm"
	icon_state = "r_arm"
	part = list(BP_R_ARM, BP_R_HAND)
	model_info = 1

/obj/item/robot_parts/l_leg
	name = "left leg"
	icon_state = "l_leg"
	part = list(BP_L_LEG, BP_L_FOOT)
	model_info = 1

/obj/item/robot_parts/r_leg
	name = "right leg"
	icon_state = "r_leg"
	part = list(BP_R_LEG, BP_R_FOOT)
	model_info = 1

/obj/item/robot_parts/chest
	name = "chest"
	desc = "A heavily reinforced case containing cyborg logic boards, with space for a standard power cell."
	icon_state = "chest"
	part = list(BP_GROIN,BP_CHEST)
	var/wires = 0.0
	var/obj/item/weapon/cell/cell = null

/obj/item/robot_parts/head
	name = "head"
	desc = "A standard reinforced braincase, with spine-plugged neural socket and sensor gimbals."
	icon_state = "head"
	part = list(BP_HEAD)
	var/obj/item/device/flash/flash1 = null
	var/obj/item/device/flash/flash2 = null

/obj/item/robot_parts/head/proc/add_flashes(obj/item/W as obj, mob/user as mob) //Made into a seperate proc to avoid copypasta
	if(src.flash1 && src.flash2)
		user << "<span class='notice'>You have already inserted the eyes!</span>"
		return
	else if(src.flash1)
		user.drop_item()
		W.loc = src
		src.flash2 = W
		user << "<span class='notice'>You insert the flash into the eye socket!</span>"
	else
		user.drop_item()
		W.loc = src
		src.flash1 = W
		user << "<span class='notice'>You insert the flash into the eye socket!</span>"


/obj/item/robot_parts/emag_act(var/remaining_charges, var/mob/user)
	if(sabotaged)
		user << "<span class='warning'>[src] is already sabotaged!</span>"
	else
		user << "<span class='warning'>You short out the safeties.</span>"
		sabotaged = 1
		return 1
