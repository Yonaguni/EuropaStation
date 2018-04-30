/obj/item/gun_maintenance_kit
	name = "gun maintenance kit"
	icon = 'icons/obj/gunkit.dmi'
	icon_state = "closed"
	var/open = FALSE

/obj/item/gun_maintenance_kit/attack_self(var/mob/user)
	open = !open
	icon_state = open ? "open" : "closed"
	to_chat(user, "<span class='notice'>You [open ? "open" : "close"] \the [src].</span>")

// Returns true if the action needs to break out of gun attackby.
/obj/item/gun_maintenance_kit/proc/try_maintain(var/obj/item/gun/composite/gun, var/mob/user)

	if(open)
		to_chat(user, "<span class='warning'>Open \the [src] first.</span>")
		return TRUE

	if(!(locate(/obj/structure/table) in gun.loc))
		to_chat(user, "<span class='warning'>\The [gun] needs to be flat on a table or rack for you to work on it.</span>")
		return  TRUE

	var/choice = input("Do you wish to clean or dismantle \the [gun]?", "Gun Maintenance") as null|anything in list("Clean", "Dismantle")
	if(!choice)
		return TRUE
	else if(choice == "Dismantle")
		return FALSE

	if(!user || !gun || !src || src.loc != user || !user.Adjacent(gun) || !(locate(/obj/structure/table) in gun.loc))
		return TRUE

	if(gun.well_maintained)
		to_chat(user, "<span class='warning'>\The [gun] is already in good condition.</span>")
		return TRUE

	to_chat(user, "<span class='notice'>You begin cleaning and maintaining \the [gun].</span>")
	if(!do_after(user, 50, src) || !user || !gun || !src || src.loc != user || gun.well_maintained || !user.Adjacent(gun) || !(locate(/obj/structure/table) in gun.loc))
		return TRUE

	gun.well_maintained = rand(5,10)
	user.visible_message("<span class='notice'>\The [user] thoroughly cleans and maintains \the [gun].</span>")
	return TRUE