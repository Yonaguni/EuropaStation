/obj/structure/closet/secure_closet/captains
	name = "captain's locker"
	req_access = list(access_captain)
	icon_state = "capsecure1"
	icon_closed = "capsecure"
	icon_locked = "capsecure1"
	icon_opened = "capsecureopen"
	icon_broken = "capsecurebroken"
	icon_off = "capsecureoff"

	New()
		..()
		if(prob(50))
			new /obj/item/storage/backpack/captain(src)
		else
			new /obj/item/storage/backpack/satchel_cap(src)
		if(prob(50))
			new /obj/item/storage/backpack/dufflebag/captain(src)
		new /obj/item/clothing/suit/captunic(src)
		new /obj/item/clothing/suit/captunic/capjacket(src)
		new /obj/item/clothing/head/caphat/cap(src)
		new /obj/item/clothing/under/rank/captain(src)
		new /obj/item/clothing/suit/armor/vest/nt(src)
		new /obj/item/cartridge/captain(src)
		new /obj/item/clothing/head/helmet(src)
		new /obj/item/clothing/shoes/brown(src)
		new /obj/item/clothing/gloves/captain(src)
		new /obj/item/clothing/suit/armor/captain(src)
		new /obj/item/melee/telebaton(src)
		new /obj/item/clothing/under/dress/dress_cap(src)
		new /obj/item/clothing/head/caphat/formal(src)
		new /obj/item/clothing/under/captainformal(src)
		return



/obj/structure/closet/secure_closet/hop
	name = "head of personnel's locker"
	req_access = list(access_hop)
	icon_state = "hopsecure1"
	icon_closed = "hopsecure"
	icon_locked = "hopsecure1"
	icon_opened = "hopsecureopen"
	icon_broken = "hopsecurebroken"
	icon_off = "hopsecureoff"

	New()
		..()
		new /obj/item/clothing/glasses/sunglasses(src)
		new /obj/item/clothing/suit/armor/vest/nt(src)
		new /obj/item/clothing/head/helmet(src)
		new /obj/item/cartridge/hop(src)
		new /obj/item/storage/box/ids(src)
		new /obj/item/storage/box/ids( src )
		new /obj/item/flash(src)
		return

/obj/structure/closet/secure_closet/hop2
	name = "head of personnel's attire"
	req_access = list(access_hop)
	icon_state = "hopsecure1"
	icon_closed = "hopsecure"
	icon_locked = "hopsecure1"
	icon_opened = "hopsecureopen"
	icon_broken = "hopsecurebroken"
	icon_off = "hopsecureoff"

	New()
		..()
		new /obj/item/clothing/under/rank/head_of_personnel(src)
		new /obj/item/clothing/under/dress/dress_hop(src)
		new /obj/item/clothing/under/dress/dress_hr(src)
		new /obj/item/clothing/under/lawyer/female(src)
		new /obj/item/clothing/under/lawyer/black(src)
		new /obj/item/clothing/under/lawyer/red(src)
		new /obj/item/clothing/under/lawyer/oldman(src)
		new /obj/item/clothing/shoes/brown(src)
		new /obj/item/clothing/shoes/black(src)
		new /obj/item/clothing/shoes/leather(src)
		new /obj/item/clothing/shoes/white(src)
		new /obj/item/clothing/under/rank/head_of_personnel_whimsy(src)
		new /obj/item/clothing/head/caphat/hop(src)
		return



/obj/structure/closet/secure_closet/hos
	name = "head of security's locker"
	req_access = list(access_hos)
	icon_state = "hossecure1"
	icon_closed = "hossecure"
	icon_locked = "hossecure1"
	icon_opened = "hossecureopen"
	icon_broken = "hossecurebroken"
	icon_off = "hossecureoff"

	New()
		..()
		if(prob(50))
			new /obj/item/storage/backpack/security(src)
		else
			new /obj/item/storage/backpack/satchel_sec(src)
		new /obj/item/clothing/head/HoS(src)
		new /obj/item/clothing/suit/armor/vest/nt(src)
		new /obj/item/clothing/suit/storage/vest/nt/hos(src)
		new /obj/item/clothing/under/rank/head_of_security/jensen(src)
		new /obj/item/clothing/under/rank/head_of_security/corp(src)
		new /obj/item/clothing/suit/armor/hos/jensen(src)
		new /obj/item/clothing/suit/armor/hos(src)
		new /obj/item/clothing/head/HoS/dermal(src)
		new /obj/item/cartridge/hos(src)
		new /obj/item/clothing/glasses/sunglasses/sechud(src)
		new /obj/item/taperoll/police(src)
		new /obj/item/shield/riot(src)
		new /obj/item/storage/box/flashbangs(src)
		new /obj/item/storage/belt/security(src)
		new /obj/item/flash(src)
		new /obj/item/melee/baton/loaded(src)
		new /obj/item/clothing/accessory/holster/waist(src)
		new /obj/item/melee/telebaton(src)
		new /obj/item/clothing/head/beret/sec/corporate/hos(src)
		return



/obj/structure/closet/secure_closet/warden
	name = "warden's locker"
	req_access = list(access_armory)
	icon_state = "wardensecure1"
	icon_closed = "wardensecure"
	icon_locked = "wardensecure1"
	icon_opened = "wardensecureopen"
	icon_broken = "wardensecurebroken"
	icon_off = "wardensecureoff"


	New()
		..()
		if(prob(50))
			new /obj/item/storage/backpack/security(src)
		else
			new /obj/item/storage/backpack/satchel_sec(src)
		if(prob(50))
			new /obj/item/storage/backpack/dufflebag/sec(src)
		new /obj/item/clothing/suit/armor/vest/nt(src)
		new /obj/item/clothing/suit/storage/vest/nt/warden(src)
		new /obj/item/clothing/under/rank/warden(src)
		new /obj/item/clothing/under/rank/warden/corp(src)
		new /obj/item/clothing/suit/armor/vest/warden(src)
		new /obj/item/clothing/head/warden(src)
		new /obj/item/cartridge/security(src)
		new /obj/item/clothing/glasses/sunglasses/sechud(src)
		new /obj/item/taperoll/police(src)
		new /obj/item/storage/box/flashbangs(src)
		new /obj/item/storage/box/teargas(src)
		new /obj/item/storage/belt/security(src)
		new /obj/item/reagent_containers/spray/pepper(src)
		new /obj/item/melee/baton/loaded(src)
		new /obj/item/storage/box/holobadge(src)
		new /obj/item/clothing/head/beret/sec/corporate/warden(src)
		return



/obj/structure/closet/secure_closet/security
	name = "security officer's locker"
	req_access = list(access_brig)
	icon_state = "sec1"
	icon_closed = "sec"
	icon_locked = "sec1"
	icon_opened = "secopen"
	icon_broken = "secbroken"
	icon_off = "secoff"

	New()
		..()
		if(prob(50))
			new /obj/item/storage/backpack/security(src)
		else
			new /obj/item/storage/backpack/satchel_sec(src)
		if(prob(50))
			new /obj/item/storage/backpack/dufflebag/sec(src)
		new /obj/item/clothing/suit/armor/vest/nt(src)
		new /obj/item/clothing/head/helmet(src)
		new /obj/item/storage/belt/security(src)
		new /obj/item/flash(src)
		new /obj/item/reagent_containers/spray/pepper(src)
		new /obj/item/grenade/chem_grenade/teargas(src)
		new /obj/item/melee/baton/loaded(src)
		new /obj/item/clothing/glasses/sunglasses/sechud(src)
		new /obj/item/taperoll/police(src)
		new /obj/item/hailer(src)
		new /obj/item/clothing/accessory/storage/black_vest(src)
		new /obj/item/clothing/head/soft/sec/corp(src)
		new /obj/item/clothing/under/rank/security/corp(src)
		return


/obj/structure/closet/secure_closet/security/cargo

	New()
		..()
		new /obj/item/clothing/accessory/armband/cargo(src)
		new /obj/item/encryptionkey/headset_cargo(src)
		return

/obj/structure/closet/secure_closet/security/engine

	New()
		..()
		new /obj/item/clothing/accessory/armband/engine(src)
		new /obj/item/encryptionkey/headset_eng(src)
		return

/obj/structure/closet/secure_closet/security/science

	New()
		..()
		new /obj/item/clothing/accessory/armband/science(src)
		new /obj/item/encryptionkey/headset_sci(src)
		return

/obj/structure/closet/secure_closet/security/med

	New()
		..()
		new /obj/item/clothing/accessory/armband/medgreen(src)
		new /obj/item/encryptionkey/headset_med(src)
		return


/obj/structure/closet/secure_closet/detective
	name = "detective's cabinet"
	req_access = list(access_forensics_lockers)
	icon_state = "cabinetdetective_locked"
	icon_closed = "cabinetdetective"
	icon_locked = "cabinetdetective_locked"
	icon_opened = "cabinetdetective_open"
	icon_broken = "cabinetdetective_broken"
	icon_off = "cabinetdetective_broken"

	New()
		..()
		new /obj/item/clothing/under/det(src)
		new /obj/item/clothing/under/det/grey(src)
		new /obj/item/clothing/under/det/black(src)
		new /obj/item/clothing/suit/storage/det_trench(src)
		new /obj/item/clothing/suit/storage/det_trench/grey(src)
		new /obj/item/clothing/suit/storage/forensics/blue(src)
		new /obj/item/clothing/suit/storage/forensics/red(src)
		new /obj/item/clothing/gloves/thick(src)
		new /obj/item/clothing/head/det(src)
		new /obj/item/clothing/head/det/grey(src)
		new /obj/item/clothing/shoes/laceup(src)
		new /obj/item/storage/box/evidence(src)
		new /obj/item/clothing/suit/armor/vest/detective(src)
		new /obj/item/taperoll/police(src)
		new /obj/item/clothing/accessory/holster/armpit(src)
		new /obj/item/reagent_containers/food/drinks/flask/detflask(src)
		new /obj/item/storage/briefcase/crimekit(src)

/obj/structure/closet/secure_closet/detective/update_icon()
	if(broken)
		icon_state = icon_broken
	else
		if(!opened)
			if(locked)
				icon_state = icon_locked
			else
				icon_state = icon_closed
		else
			icon_state = icon_opened

/obj/structure/closet/secure_closet/injection
	name = "lethal injections locker"
	req_access = list(access_captain)


	New()
		..()
		new /obj/item/reagent_containers/syringe/ld50_syringe/choral(src)
		new /obj/item/reagent_containers/syringe/ld50_syringe/choral(src)
		return



/obj/structure/closet/secure_closet/brig
	name = "brig locker"
	req_access = list(access_brig)
	anchored = 1
	var/id = null

	New()
		..()
		new /obj/item/clothing/under/color/orange( src )
		new /obj/item/clothing/shoes/orange( src )
		return



/obj/structure/closet/secure_closet/courtroom
	name = "courtroom locker"
	req_access = list(access_lawyer)

	New()
		..()
		new /obj/item/clothing/shoes/brown(src)
		new /obj/item/paper/Court (src)
		new /obj/item/paper/Court (src)
		new /obj/item/paper/Court (src)
		new /obj/item/pen (src)
		new /obj/item/clothing/suit/judgerobe (src)
		new /obj/item/clothing/head/powdered_wig (src)
		new /obj/item/storage/briefcase(src)
		return

/obj/structure/closet/secure_closet/wall
	name = "wall locker"
	req_access = list(access_security)
	icon_state = "wall-locker1"
	density = 1
	icon_closed = "wall-locker"
	icon_locked = "wall-locker1"
	icon_opened = "wall-lockeropen"
	icon_broken = "wall-lockerbroken"
	icon_off = "wall-lockeroff"

	//too small to put a man in
	large = 0

/obj/structure/closet/secure_closet/wall/update_icon()
	if(broken)
		icon_state = icon_broken
	else
		if(!opened)
			if(locked)
				icon_state = icon_locked
			else
				icon_state = icon_closed
		else
			icon_state = icon_opened


/obj/structure/closet/secure_closet/lawyer
	name = "internal affairs secure closet"
	req_access = list(access_lawyer)

	New()
		..()
		new /obj/item/flash(src)
		new /obj/item/flash(src)
		new /obj/item/camera(src)
		new /obj/item/camera(src)
		new /obj/item/camera_film(src)
		new /obj/item/camera_film(src)
		new /obj/item/taperecorder(src)
		new /obj/item/taperecorder(src)
		new /obj/item/storage/secure/briefcase(src)
		new /obj/item/storage/secure/briefcase(src)
		return
