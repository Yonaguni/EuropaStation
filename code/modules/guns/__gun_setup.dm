//Gun loading types
#define SINGLE_CASING 	1	//The gun only accepts ammo_casings. ammo_magazines should never have this as their mag_type.
#define SPEEDLOADER 	2	//Transfers casings from the mag to the gun when used.
#define MAGAZINE 		4	//The magazine item itself goes inside the gun

#define HOLD_CASINGS	0 //do not do anything after firing. Manual action, like pump shotguns, or guns that want to define custom behaviour
#define EJECT_CASINGS	1 //drop spent casings on the ground after firing
#define CYCLE_CASINGS 	2 //experimental: cycle casings, like a revolver. Also works for multibarrelled guns
#define DESTROY_CASINGS 3

#define GUN_PISTOL  "pistol"
#define GUN_SMG     "smg"
#define GUN_RIFLE   "rifle"
#define GUN_CANNON  "cannon"
#define GUN_ASSAULT "assault"
#define GUN_SHOTGUN "shotgun"

#define GUN_TYPE_LASER        "laser"
#define GUN_TYPE_BALLISTIC    "ballistic"

#define COMPONENT_BARREL    "barrel"
#define COMPONENT_BODY      "body"
#define COMPONENT_MECHANISM "chamber"
#define COMPONENT_GRIP      "grip"
#define COMPONENT_STOCK     "stock"
#define COMPONENT_ACCESSORY "accessory"

#define COLOR_SUN              "#ec8b2f"
#define COLOR_GUNMETAL         "#6b6569"
#define COLOR_WOODFINISH       "#8c6424"

/obj/item/gun/proc/reset_name()
	return initial(name)

/obj/item/gun/var/recoil = 0 //screen shake
