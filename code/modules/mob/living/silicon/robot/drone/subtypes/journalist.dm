/mob/living/silicon/robot/drone/journalist
	icon_state = "culturedrone"
	law_type = /datum/ai_laws/journalist_drone
	module_type = /obj/item/weapon/robot_module/journalist
	idcard_type = /obj/item/weapon/card/id

	can_pull_size = 0
	can_pull_mobs = 0
	hat_x_offset = 1
	hat_y_offset = -24
	local_transmit = 0

	var/obj/machinery/newscaster/integrated_newscaster

/mob/living/silicon/robot/drone/journalist/New()
	..()
	integrated_newscaster = new(src)

/mob/living/silicon/robot/drone/journalist/welcome_drone()
	src << "<b>You are a camera drone and mobile newscaster link.</b>."
	src << "You are assigned to a journalist and exist only for their purposes."

/mob/living/silicon/robot/drone/journalist/init()
	..()
	flavor_text = "It's a small, floating drone with a large camera lens."
	remove_language("Robot Talk")
	remove_language("Drone Talk")

/mob/living/silicon/robot/drone/journalist/updatename()
	real_name = "camera drone ([rand(100,999)])"
	name = real_name

/mob/living/silicon/robot/drone/journalist/attack_ai(var/mob/user)
	if(user == src && integrated_newscaster)
		integrated_newscaster.attack_ai(user)
	return

/mob/living/silicon/robot/drone/journalist/attack_hand(var/mob/user)

	if(master && user == master)
		integrated_newscaster.attack_hand(user)
		return
	else
		user << "<span class='warning'>Unauthorized user. Access denied.</span>"
		return ..()
