//These are meant for spawning on maps, namely Away Missions.

//If someone can do this in a neater way, be my guest-Kor

//To do: Allow corpses to appear mangled, bloody, etc. Allow customizing the bodies appearance (they're all bald and white right now).

/obj/effect/landmark/corpse
	name = "Unknown"
	var/mobname = "Unknown"  //Unused now but it'd fuck up maps to remove it now
	var/corpseuniform = null //Set this to an object path to have the slot filled with said object on the corpse.
	var/corpsesuit = null
	var/corpseshoes = null
	var/corpsegloves = null
	var/corpseradio = null
	var/corpseglasses = null
	var/corpsemask = null
	var/corpsehelmet = null
	var/corpsebelt = null
	var/corpsepocket1 = null
	var/corpsepocket2 = null
	var/corpseback = null
	var/corpseid = 0     //Just set to 1 if you want them to have an ID
	var/corpseidjob = null // Needs to be in quotes, such as "Clown" or "Chef." This just determines what the ID reads as, not their access
	var/corpseidaccess = null //This is for access. See access.dm for which jobs give what access. Again, put in quotes. Use "Commanding Officer" if you want it to be all access.
	var/corpseidicon = null //For setting it to be a gold, silver, centcomm etc ID
	var/species = DEFAULT_SPECIES

/obj/effect/landmark/corpse/initialize()
	createCorpse()

/obj/effect/landmark/corpse/proc/createCorpse() //Creates a mob and checks for gear in each slot before attempting to equip it.
	var/mob/living/carbon/human/M = new /mob/living/carbon/human (src.loc)
	M.set_species(species)
	M.real_name = src.name
	M.death(1) //Kills the new mob
	if(src.corpseuniform)
		M.equip_to_slot_or_del(new src.corpseuniform(M), slot_w_uniform)
	if(src.corpsesuit)
		M.equip_to_slot_or_del(new src.corpsesuit(M), slot_wear_suit)
	if(src.corpseshoes)
		M.equip_to_slot_or_del(new src.corpseshoes(M), slot_shoes)
	if(src.corpsegloves)
		M.equip_to_slot_or_del(new src.corpsegloves(M), slot_gloves)
	if(src.corpseradio)
		M.equip_to_slot_or_del(new src.corpseradio(M), slot_l_ear)
	if(src.corpseglasses)
		M.equip_to_slot_or_del(new src.corpseglasses(M), slot_glasses)
	if(src.corpsemask)
		M.equip_to_slot_or_del(new src.corpsemask(M), slot_wear_mask)
	if(src.corpsehelmet)
		M.equip_to_slot_or_del(new src.corpsehelmet(M), slot_head)
	if(src.corpsebelt)
		M.equip_to_slot_or_del(new src.corpsebelt(M), slot_belt)
	if(src.corpsepocket1)
		M.equip_to_slot_or_del(new src.corpsepocket1(M), slot_r_store)
	if(src.corpsepocket2)
		M.equip_to_slot_or_del(new src.corpsepocket2(M), slot_l_store)
	if(src.corpseback)
		M.equip_to_slot_or_del(new src.corpseback(M), slot_back)
	if(src.corpseid == 1)
		var/obj/item/card/id/W = new(M)
		var/datum/job/jobdatum
		for(var/jobtype in typesof(/datum/job))
			var/datum/job/J = new jobtype
			if(J.title == corpseidaccess)
				jobdatum = J
				break
		if(src.corpseidicon)
			W.icon_state = corpseidicon
		if(src.corpseidaccess)
			if(jobdatum)
				W.access = jobdatum.get_access()
			else
				W.access = list()
		if(corpseidjob)
			W.assignment = corpseidjob
		M.set_id_info(W)
		M.equip_to_slot_or_del(W, slot_wear_id)
	qdel(src)


/obj/effect/landmark/corpse/syndicatecommando
	name = "Syndicate Commando"
	corpseuniform = /obj/item/clothing/under/jumpsuit/black
	corpsesuit = /obj/item/clothing/suit/space/void/merc
	corpseshoes = /obj/item/clothing/shoes/swat
	corpsegloves = /obj/item/clothing/gloves/thick/swat
	corpseradio = /obj/item/radio/headset
	corpsemask = /obj/item/clothing/mask/gas/syndicate
	corpsehelmet = /obj/item/clothing/head/helmet/space/void/merc
	corpseback = /obj/item/tank/jetpack/oxygen
	corpsepocket1 = /obj/item/tank/emergency/oxygen
	corpseid = 1
	corpseidjob = "Operative"
	corpseidaccess = "Syndicate"



///////////Civilians//////////////////////

/obj/effect/landmark/corpse/chef
	name = "Cook"
	corpseuniform = /obj/item/clothing/under/jumpsuit/white
	corpsesuit = /obj/item/clothing/suit/chef
	corpseshoes = /obj/item/clothing/shoes/black
	corpsehelmet = /obj/item/clothing/head/chefhat
	corpseback = /obj/item/storage/backpack
	corpseradio = /obj/item/radio/headset
	corpseid = 1
	corpseidjob = "Cook"
	corpseidaccess = "Cook"


/obj/effect/landmark/corpse/doctor
	name = "Doctor"
	corpseuniform = /obj/item/clothing/under/jumpsuit/white
	corpsesuit = /obj/item/clothing/suit/storage/toggle/labcoat
	corpseback = /obj/item/storage/backpack/medic
	corpsepocket1 = /obj/item/flashlight/pen
	corpseshoes = /obj/item/clothing/shoes/black
	corpseid = 1
	corpseidjob = "Medical Officer"
	corpseidaccess = "Medical Officer"

/obj/effect/landmark/corpse/engineer
	name = "Engineer"
	corpseuniform = /obj/item/clothing/under/jumpsuit/hazard
	corpseback = /obj/item/storage/backpack/industrial
	corpseshoes = /obj/item/clothing/shoes/orange
	corpsebelt = /obj/item/storage/belt/utility/full
	corpsegloves = /obj/item/clothing/gloves/insulated
	corpsehelmet = /obj/item/clothing/head/hardhat
	corpseid = 1
	corpseidjob = "Civil Engineer"
	corpseidaccess = "Civil Engineer"

/obj/effect/landmark/corpse/clown
	name = "Clown"
	corpseuniform = /obj/item/clothing/under/clown
	corpseshoes = /obj/item/clothing/shoes/clown_shoes
	corpseradio = /obj/item/radio/headset
	corpsemask = /obj/item/clothing/mask/gas/clown_hat
	corpsepocket1 = /obj/item/bikehorn
	corpseback = /obj/item/storage/backpack/clown
	corpseid = 1
	corpseidjob = "Clown"
	corpseidaccess = "Clown"

/obj/effect/landmark/corpse/miner/rig
	corpsesuit = /obj/item/clothing/suit/space/void/industrial
	corpsemask = /obj/item/clothing/mask/breath
	corpsehelmet = /obj/item/clothing/head/helmet/space/void/industrial
