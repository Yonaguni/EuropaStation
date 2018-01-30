/obj/item/ammo_casing
	name = "bullet casing"
	desc = "A bullet casing."
	icon = 'icons/obj/gun_components/ammo_casings.dmi'
	icon_state = "small"
	flags = CONDUCT
	slot_flags = SLOT_BELT | SLOT_EARS
	throwforce = 1
	w_class = 1
	matter = list("steel" = 100)
	auto_init = TRUE

	var/leaves_residue = 1
	var/caliber	                        // Which kind of guns it can be loaded into
	var/projectile_type                 // The bullet type to create when New() is called
	var/obj/item/projectile/projectile  // The loaded bullet - make it so that the projectiles are created only when needed?
	var/spent_icon = null

/obj/item/ammo_casing/initialize()
	name = "[initial(name)] ([caliber])"

/obj/item/ammo_casing/New()
	..()
	if(ispath(projectile_type))
		projectile = new projectile_type(src)
	pixel_x = rand(-10, 10)
	pixel_y = rand(-10, 10)

//removes the projectile from the ammo casing
/obj/item/ammo_casing/proc/expend()
	. = projectile
	projectile = null
	set_dir(pick(cardinal)) //spin spent casings
	if(spent_icon)
		icon_state = spent_icon
	name = "spent [name]"

// Predefines.
/obj/item/ammo_casing/gyrojet
	caliber = CALIBER_CANNON
	icon_state = "rocket"
	spent_icon = "rocket-spent"
	projectile_type = /obj/item/projectile/bullet/gyro
	matter = list("steel" = 500)

/obj/item/ammo_casing/grenade
	caliber = CALIBER_GRENADE
	icon_state = "rocket"
	projectile_type = /obj/item/projectile/bullet/gyro
	matter = list("steel" = 500)

/obj/item/ammo_casing/rocket
	caliber = CALIBER_ROCKET
	icon_state = "rocket"
	projectile_type = /obj/item/projectile/bullet/gyro
	matter = list("steel" = 500)

// Quickload.
/obj/item/ammo_casing/attackby(var/obj/item/thing, var/mob/user)
	if(!loc || !istype(loc, /turf) || !istype(thing, /obj/item/ammo_magazine))
		return ..()
	var/obj/item/ammo_magazine/mag = thing
	if(caliber != mag.caliber)
		return
	var/turf/T = loc
	var/load_amt = 0
	for(var/obj/item/ammo_casing/bullet in T.contents)
		if(mag.stored_ammo.len >= mag.max_ammo)
			break
		if(bullet.caliber == mag.caliber && bullet.simulated && !bullet.anchored)
			bullet.forceMove(mag)
			mag.stored_ammo += bullet
			load_amt++
	if(load_amt)
		user.visible_message("<span class='notice'>\The [user] pushes [load_amt] round\s into \the [mag].</span>")
	else
		user.visible_message("<span class='notice'>\The [mag] is full!</span>")

