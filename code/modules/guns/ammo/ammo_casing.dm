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

	var/leaves_residue = 1
	var/decl/weapon_caliber/caliber     // Which kind of guns it can be loaded into
	var/obj/item/projectile/projectile  // The loaded bullet - make it so that the projectiles are created only when needed?
	var/spent_icon = null
	var/special_projectile_type

/obj/item/ammo_casing/New()
	..()
	caliber = get_caliber_from_path(caliber)
	if(special_projectile_type)
		projectile = new special_projectile_type(src)
		name = "[initial(name)] ([projectile.name])"
	else
		projectile = new caliber.projectile_type(src)
		name = "[initial(name)] ([caliber.name])"

	pixel_x = rand(-10, 10)
	pixel_y = rand(-10, 10)

/obj/item/ammo_casing/Destroy()
	if(projectile)
		qdel(projectile)
		projectile = null
	caliber = null
	. = ..()

//removes the projectile from the ammo casing
/obj/item/ammo_casing/proc/expend()
	. = projectile
	projectile = null
	set_dir(pick(cardinal)) //spin spent casings
	if(spent_icon)
		icon_state = spent_icon
	name = "spent [name]"

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
		if(bullet.caliber.projectile_size <= mag.caliber.projectile_size && bullet.simulated && !bullet.anchored)
			bullet.forceMove(mag)
			mag.stored_ammo += bullet
			load_amt++
	if(load_amt)
		user.visible_message("<span class='notice'>\The [user] pushes [load_amt] round\s into \the [mag].</span>")
	else
		user.visible_message("<span class='notice'>\The [mag] is full!</span>")

