/mob/living/silicon/robot/drone/construction
	icon_state = "constructiondrone"
	law_type = /datum/ai_laws/construction_drone
	module_type = /obj/item/weapon/robot_module/drone/construction
	can_pull_size = 5
	can_pull_mobs = 1
	hat_x_offset = 1
	hat_y_offset = -12

/mob/living/silicon/robot/drone/construction/welcome_drone()
	src << "<b>You are a construction drone, an autonomous engineering and fabrication system.</b>."
	src << "You are assigned to a Sol Central construction project. The name is irrelevant. Your task is to complete construction and subsystem integration as soon as possible."
	src << "Use <b>:d</b> to talk to other drones and <b>say</b> to speak silently to your nearby fellows."
	src << "<b>You do not follow orders from anyone; not the AI, not humans, and not other synthetics.</b>."

/mob/living/silicon/robot/drone/construction/init()
	..()
	flavor_text = "It's a bulky construction drone stamped with a Sol Central glyph."

/mob/living/silicon/robot/drone/construction/updatename()
	real_name = "construction drone ([rand(100,999)])"
	name = real_name
