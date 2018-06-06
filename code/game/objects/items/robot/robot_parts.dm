/obj/item/robot_parts
	name = "robot parts"
	icon = 'icons/obj/robot_parts.dmi'
	item_state = "buildpipe"
	icon_state = "blank"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	dir = SOUTH
	matter = list(MATERIAL_STEEL = 5000, MATERIAL_GLASS = 1000, MATERIAL_PLASTIC = 1000, MATERIAL_OSMIUM = 100)

	var/list/part = null // Order of args is important for installing robolimbs.
	var/sabotaged = 0 //Emagging limbs can have repercussions when installed as prosthetics.
	var/model_info

/obj/item/robot_parts/set_dir()
	return

/obj/item/robot_parts/New(var/newloc, var/model)
	..(newloc)
	if(model_info && model)
		model_info = model
		var/datum/robolimb/R = all_robolimbs[model]
		if(R)
			name = "[R.company] [initial(name)]"
			desc = "[R.desc]"
			if(icon_state in icon_states(R.icon))
				icon = R.icon
	else
		name = "robot [initial(name)]"

/obj/item/robot_parts/l_arm
	name = "left arm"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	icon_state = "l_arm"
	part = list(BP_L_ARM, BP_L_HAND)
	model_info = 1

/obj/item/robot_parts/r_arm
	name = "right arm"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	icon_state = "r_arm"
	part = list(BP_R_ARM, BP_R_HAND)
	model_info = 1

/obj/item/robot_parts/l_leg
	name = "left leg"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	icon_state = "l_leg"
	part = list(BP_L_LEG, BP_L_FOOT)
	model_info = 1

/obj/item/robot_parts/r_leg
	name = "right leg"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	icon_state = "r_leg"
	part = list(BP_R_LEG, BP_R_FOOT)
	model_info = 1

/obj/item/robot_parts/chest
	name = "torso"
	desc = "A heavily reinforced case containing robot logic boards, with space for a standard power cell."
	icon_state = "chest"
	part = list(BP_GROIN,BP_CHEST)
	var/wires = 0.0
	var/obj/item/cell/cell = null

/obj/item/robot_parts/head
	name = "head"
	desc = "A standard reinforced braincase, with spine-plugged neural socket and sensor gimbals."
	icon_state = "head"
	part = list(BP_HEAD)
	var/obj/item/robot_parts/robot_component/camera/camera

/obj/item/robot_parts/robot_suit
	name = "endoskeleton"
	desc = "A complex metal backbone with standard limb sockets and pseudomuscle anchors."
	icon_state = "robo_suit"
	matter = list(MATERIAL_STEEL = 25000, MATERIAL_GLASS = 7500, MATERIAL_PLASTIC = 3000, MATERIAL_OSMIUM = 1500)

	var/obj/item/robot_parts/l_arm/l_arm = null
	var/obj/item/robot_parts/r_arm/r_arm = null
	var/obj/item/robot_parts/l_leg/l_leg = null
	var/obj/item/robot_parts/r_leg/r_leg = null
	var/obj/item/robot_parts/chest/chest = null
	var/obj/item/robot_parts/head/head = null
	var/created_name = ""

/obj/item/robot_parts/robot_suit/New()
	..()
	src.updateicon()

/obj/item/robot_parts/robot_suit/proc/updateicon()
	src.overlays.Cut()
	if(src.l_arm)
		src.overlays += "l_arm+o"
	if(src.r_arm)
		src.overlays += "r_arm+o"
	if(src.chest)
		src.overlays += "chest+o"
	if(src.l_leg)
		src.overlays += "l_leg+o"
	if(src.r_leg)
		src.overlays += "r_leg+o"
	if(src.head)
		src.overlays += "head+o"

/obj/item/robot_parts/robot_suit/proc/check_completion()
	if(src.l_arm && src.r_arm)
		if(src.l_leg && src.r_leg)
			if(src.chest && src.head)
				feedback_inc("cyborg_frames_built",1)
				return 1
	return 0

/obj/item/robot_parts/robot_suit/attackby(obj/item/W, var/mob/user)
	..()
	if(istype(W, /obj/item/stack/material) && W.get_material_name() == MATERIAL_STEEL && !l_arm && !r_arm && !l_leg && !r_leg && !chest && !head)
		var/obj/item/stack/material/M = W
		if (M.use(1))
			var/obj/item/secbot_assembly/ed209_assembly/B = new /obj/item/secbot_assembly/ed209_assembly
			B.forceMove(get_turf(src))
			to_chat(user, "<span class='notice'>You armed the robot frame.</span>")
			if (user.get_inactive_hand()==src)
				user.remove_from_mob(src)
				user.put_in_inactive_hand(B)
			qdel(src)
		else
			to_chat(user, "<span class='warning'>You need one sheet of metal to arm the robot frame.</span>")
	if(istype(W, /obj/item/robot_parts/l_leg))
		if(src.l_leg)	return
		user.drop_item()
		W.forceMove(src)
		src.l_leg = W
		src.updateicon()

	if(istype(W, /obj/item/robot_parts/r_leg))
		if(src.r_leg)	return
		user.drop_item()
		W.forceMove(src)
		src.r_leg = W
		src.updateicon()

	if(istype(W, /obj/item/robot_parts/l_arm))
		if(src.l_arm)	return
		user.drop_item()
		W.forceMove(src)
		src.l_arm = W
		src.updateicon()

	if(istype(W, /obj/item/robot_parts/r_arm))
		if(src.r_arm)	return
		user.drop_item()
		W.forceMove(src)
		src.r_arm = W
		src.updateicon()

	if(istype(W, /obj/item/robot_parts/chest))
		if(src.chest)	return
		if(W:wires && W:cell)
			user.drop_item()
			W.forceMove(src)
			src.chest = W
			src.updateicon()
		else if(!W:wires)
			to_chat(user, "<span class='warning'>You need to attach wires to it first!</span>")
		else
			to_chat(user, "<span class='warning'>You need to attach a cell to it first!</span>")

	if(istype(W, /obj/item/robot_parts/head))
		if(src.head)	return
		if(W:camera)
			user.drop_item()
			W.forceMove(src)
			src.head = W
			src.updateicon()
		else
			to_chat(user, "<span class='warning'>You need to attach a camera to it first!</span>")

	if(istype(W, /obj/item/mmi))
		var/obj/item/mmi/M = W
		if(check_completion())
			if(!istype(loc,/turf))
				to_chat(user, "<span class='warning'>You can't put \the [W] in, the frame has to be standing on the ground to be perfectly precise.</span>")
				return
			if(!M.brainmob)
				to_chat(user, "<span class='warning'>Sticking an empty [W] into the frame would sort of defeat the purpose.</span>")
				return
			if(!M.brainmob.key)
				var/ghost_can_reenter = 0
				if(M.brainmob.mind)
					for(var/mob/observer/ghost/G in player_list)
						if(G.can_reenter_corpse && G.mind == M.brainmob.mind)
							ghost_can_reenter = 1
							break
				if(!ghost_can_reenter)
					to_chat(user, "<span class='notice'>\The [W] is completely unresponsive; there's no point.</span>")
					return

			if(M.brainmob.stat == DEAD)
				to_chat(user, "<span class='warning'>Sticking a dead [W] into the frame would sort of defeat the purpose.</span>")
				return

			if(jobban_isbanned(M.brainmob, "Robot"))
				to_chat(user, "<span class='warning'>This [W] does not seem to fit.</span>")
				return

			var/mob/living/silicon/robot/O = new /mob/living/silicon/robot(get_turf(loc), unfinished = 1)
			if(!O)	return

			user.drop_item()

			O.mmi = W
			O.invisibility = 0
			O.custom_name = created_name
			O.updatename("Default")

			M.brainmob.mind.transfer_to(O)

			if(O.mind && O.mind.special_role)
				O.mind.store_memory("In case you look at this after being borged, the objectives are only here until I find a way to make them not show up for you, as I can't simply delete them without screwing up round-end reporting. --NeoFite")

			O.job = "Robot"

			O.cell = chest.cell
			O.cell.forceMove(O)
			W.forceMove(O)//Should fix cybros run time erroring when blown up. It got deleted before, along with the frame.

			// Since we "magically" installed a cell, we also have to update the correct component.
			if(O.cell)
				var/datum/robot_component/cell_component = O.components["power cell"]
				cell_component.wrapped = O.cell
				cell_component.installed = 1

			feedback_inc("cyborg_birth",1)
			callHook("borgify", list(O))
			O.Namepick()

			qdel(src)
		else
			to_chat(user, "<span class='warning'>The MMI must go in after everything else!</span>")

	if (istype(W, /obj/item/pen))
		var/t = sanitizeSafe(input(user, "Enter new robot name", src.name, src.created_name), MAX_NAME_LEN)
		if (!t)
			return
		if (!in_range(src, usr) && src.loc != usr)
			return

		src.created_name = t

	return

/obj/item/robot_parts/chest/attackby(obj/item/W, var/mob/user)
	..()
	if(istype(W, /obj/item/cell))
		if(src.cell)
			to_chat(user, "<span class='warning'>You have already inserted a cell!</span>")
			return
		else
			user.drop_item()
			W.forceMove(src)
			src.cell = W
			to_chat(user, "<span class='notice'>You insert the cell!</span>")
	if(W.iscoil())
		if(src.wires)
			to_chat(user, "<span class='warning'>You have already inserted wire!</span>")
			return
		else
			var/obj/item/stack/cable_coil/coil = W
			coil.use(1)
			src.wires = 1.0
			to_chat(user, "<span class='notice'>You insert the wire!</span>")
	return

/obj/item/robot_parts/head/attackby(obj/item/W, var/mob/user)
	..()
	if(istype(W, /obj/item/robot_parts/robot_component/camera))
		if(istype(user,/mob/living/silicon/robot))
			to_chat(user, "<span class='warning'>How do you propose to do that?</span>")
			return
		if(camera)
			to_chat(user, "<span class='warning'>There is already a camera installed in \the [src].</span>")
			return
		user.drop_from_inventory(W)
		camera = W
		W.forceMove(src)
		to_chat(user, "<span class='notice'>You install \the [W] into \the [src]!</span>")
	else if(istype(W, /obj/item/stock_parts/manipulator))
		to_chat(user, "<span class='notice'>You install some manipulators and modify the head, creating a functional spider-bot!</span>")
		new /mob/living/simple_animal/spiderbot(get_turf(loc))
		user.drop_item()
		qdel(W)
		qdel(src)

/obj/item/robot_parts/emag_act(var/remaining_charges, var/mob/user)
	if(sabotaged)
		to_chat(user, "<span class='warning'>[src] is already sabotaged!</span>")
	else
		to_chat(user, "<span class='warning'>You short out the safeties.</span>")
		sabotaged = 1
		return 1
