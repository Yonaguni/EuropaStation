//Weapon control and monitoring console
/obj/machinery/computer/weapons
	name = "fire control console"
	icon_keyboard = "tech_key"
	icon_screen = "engines"
	var/state = "status"
	var/obj/effect/overmap/ship/linked

/obj/machinery/computer/weapons/initialize()
	..()
	linked = map_sectors["[z]"]

/obj/machinery/computer/weapons/attack_hand(var/mob/user as mob)

	if(..())
		user.unset_machine()
		return

	if(!isAI(user))
		user.set_machine(src)

	for(var/obj/machinery/power/ship_weapon/W in linked.weapons)
		user << "[W.get_status()] <a href='?src=\ref[src];fire=\ref[W]'>\[FIRE\]</a>"

/obj/machinery/computer/weapons/Topic(href, href_list)
	if(..())
		return 1

	if(href_list["fire"])
		var/obj/machinery/power/ship_weapon/W = locate(href_list["fire"]) in linked.weapons
		W.fire()

	add_fingerprint(usr)
	updateUsrDialog()