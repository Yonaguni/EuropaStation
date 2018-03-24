//Weapon control and monitoring console
/obj/machinery/computer/weapons
	name = "fire control console"
	icon_keyboard = "tech_key"
	icon_screen = "engines"

	var/datum/console_program/fire_control/control_system = /datum/console_program/fire_control
	var/obj/effect/overmap/ship/linked

/obj/machinery/computer/weapons/Initialize()
	linked = map_sectors["[z]"]
	if(ispath(control_system))
		control_system = new control_system(src)
	. = ..()

/obj/machinery/computer/weapons/attack_hand(user as mob)
	if(..(user))
		return
	if(!allowed(user))
		to_chat(user, "<span class='warning'>Access denied.</span>")
		return 1
	interact(user)

/obj/machinery/computer/weapons/interact(user)
	if(!istype(user, /mob/living/silicon))
		add_fingerprint(user)
		playsound(loc, 'sound/effects/keyboard.ogg', 50)
	control_system.Run(user)

/obj/machinery/computer/weapons/Topic(href, href_list)
	if(..())
		return 1
	if(href_list["fire"])
		var/obj/machinery/power/ship_weapon/W = locate(href_list["fire"]) in linked.weapons
		W.fire()
		. = 1
	interact(usr)
