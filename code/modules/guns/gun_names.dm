/proc/get_gun_name(var/obj/item/assembly, var/dam_type, var/gun_type)

	var/auto
	var/revolver
	var/decl/weapon_caliber/caliber
	var/sniper
	var/override_type_name

	if(assembly)
		sniper = (locate(/obj/item/gun_component/accessory/body/scope) in assembly)
		if(istype(assembly, /obj/item/gun_assembly))
			var/obj/item/gun_assembly/GA = assembly
			if(istype(GA.chamber))
				if(GA.chamber.automatic)
					auto = 1
				if(GA.chamber.revolver)
					revolver = 1
			if(GA.barrel)
				caliber = GA.barrel.design_caliber
				if(GA.barrel.override_name)
					override_type_name = GA.barrel.override_name
				else if(GA.barrel.design_caliber.specific_gun_name)
					override_type_name  = GA.barrel.design_caliber.specific_gun_name
		else if(istype(assembly, /obj/item/gun/composite))
			var/obj/item/gun/composite/CG = assembly
			caliber = CG.barrel.design_caliber
			dam_type = CG.dam_type
			gun_type = CG.gun_type
			if(CG.chamber.automatic)
				auto = 1
			if(CG.chamber.revolver)
				revolver = 1
			if(CG.barrel.override_name)
				override_type_name = CG.barrel.override_name
			else if(CG.barrel.design_caliber.specific_gun_name)
				override_type_name  = CG.barrel.design_caliber.specific_gun_name

	var/type_name
	if(override_type_name)
		type_name = override_type_name
	else if(caliber)
		type_name = caliber.name

	var/gun_name = "gun"
	switch(gun_type)
		if(GUN_PISTOL)
			gun_name = (revolver ? "revolver" : "pistol")
		if(GUN_SMG)
			gun_name = "submachine gun"
		if(GUN_RIFLE)
			gun_name = (sniper ? "sniper rifle" : "rifle")
		if(GUN_CANNON)
			gun_name = (auto ? "autocannon" : "launcher")
		if(GUN_ASSAULT)
			gun_name = "assault rifle"
		if(GUN_SHOTGUN)
			gun_name = "shotgun"


	var/result = gun_name
	if(type_name)
		result = "[type_name] [result]"

	if(sniper && gun_type != GUN_RIFLE)
		result = "scoped [result]"
	if(auto && gun_type != GUN_ASSAULT && gun_type != GUN_SMG && gun_type != GUN_CANNON)
		result = "automatic [result]"
	return result
