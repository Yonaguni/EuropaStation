/obj/item/ammo_casing
	name = "bullet casing"
	desc = "A bullet casing."
	icon = 'icons/obj/gun_components/ammo_casings.dmi'
	icon_state = "small"
	flags = CONDUCT
	slot_flags = SLOT_BELT | SLOT_EARS
	throwforce = 1
	w_class = 1

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

/obj/item/ammo_casing/grenade
	caliber = CALIBER_GRENADE
	icon_state = "rocket"
	projectile_type = /obj/item/projectile/bullet/gyro

/obj/item/ammo_casing/rocket
	caliber = CALIBER_ROCKET
	icon_state = "rocket"
	projectile_type = /obj/item/projectile/bullet/gyro
