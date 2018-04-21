/atom/movable/proc/get_mob()
	return

/obj/machinery/bot/mulebot/get_mob()
	if(load && istype(load,/mob/living))
		return load

/obj/vehicle/train/get_mob()
	return buckled_mob

/mob/get_mob()
	return src

//helper for inverting armor blocked values into a multiplier
#define blocked_mult(blocked) max(1 - (blocked/100), 0)

/proc/mobs_in_view(var/range, var/source)
	var/list/mobs = list()
	for(var/atom/movable/AM in view(range, source))
		var/M = AM.get_mob()
		if(M)
			mobs += M

	return mobs

proc/random_hair_style(gender, species = DEFAULT_SPECIES)
	var/h_style = "Bald"

	var/list/valid_hairstyles = list()
	for(var/hairstyle in hair_styles_list)
		var/datum/sprite_accessory/S = hair_styles_list[hairstyle]

		if(gender != NEUTER && gender != PLURAL)
			if(gender == MALE && S.gender == FEMALE)
				continue
			if(gender == FEMALE && S.gender == MALE)
				continue

		if( !(species in S.species_allowed))
			continue
		valid_hairstyles[hairstyle] = hair_styles_list[hairstyle]

	if(valid_hairstyles.len)
		h_style = pick(valid_hairstyles)

	return h_style

proc/random_facial_hair_style(gender, species = DEFAULT_SPECIES)
	var/f_style = "Shaved"

	var/list/valid_facialhairstyles = list()
	for(var/facialhairstyle in facial_hair_styles_list)
		var/datum/sprite_accessory/S = facial_hair_styles_list[facialhairstyle]

		if(gender != NEUTER && gender != PLURAL)
			if(gender == MALE && S.gender == FEMALE)
				continue
			if(gender == FEMALE && S.gender == MALE)
				continue

		if( !(species in S.species_allowed))
			continue

		valid_facialhairstyles[facialhairstyle] = facial_hair_styles_list[facialhairstyle]

	if(valid_facialhairstyles.len)
		f_style = pick(valid_facialhairstyles)

		return f_style

proc/sanitize_name(name, species = DEFAULT_SPECIES)
	var/datum/species/current_species
	if(species)
		current_species = all_species[species]

	return current_species ? current_species.sanitize_name(name) : sanitizeName(name)

proc/random_skin_tone()
	switch(pick(60;"caucasian", 15;"afroamerican", 10;"african", 10;"latino", 5;"albino"))
		if("caucasian")		. = -10
		if("afroamerican")	. = -115
		if("african")		. = -165
		if("latino")		. = -55
		if("albino")		. = 34
		else				. = rand(-185,34)
	return min(max( .+rand(-25, 25), -185),34)

proc/skintone2racedescription(tone)
	switch (tone)
		if(30 to INFINITY)		return "albino"
		if(20 to 30)			return "pale"
		if(5 to 15)				return "light skinned"
		if(-10 to 5)			return "white"
		if(-25 to -10)			return "tan"
		if(-45 to -25)			return "darker skinned"
		if(-65 to -45)			return "brown"
		if(-INFINITY to -65)	return "black"
		else					return "unknown"

proc/age2agedescription(age)
	switch(age)
		if(0 to 1)			return "infant"
		if(1 to 3)			return "toddler"
		if(3 to 13)			return "child"
		if(13 to 19)		return "teenager"
		if(19 to 30)		return "young adult"
		if(30 to 45)		return "adult"
		if(45 to 60)		return "middle-aged"
		if(60 to 70)		return "aging"
		if(70 to INFINITY)	return "elderly"
		else				return "unknown"

/proc/RoundHealth(health)
	var/list/icon_states = icon_states('icons/mob/hud_med.dmi')
	for(var/icon_state in icon_states)
		if(health >= text2num(icon_state))
			return icon_state
	return icon_states[icon_states.len] // If we had no match, return the last element

/*
Proc for attack log creation, because really why not
1 argument is the actor
2 argument is the target of action
3 is the description of action(like punched, throwed, or any other verb)
4 should it make adminlog note or not
5 is the tool with which the action was made(usually item)					5 and 6 are very similar(5 have "by " before it, that it) and are separated just to keep things in a bit more in order
6 is additional information, anything that needs to be added
*/

/proc/add_logs(mob/user, mob/target, what_done, var/admin=1, var/object=null, var/addition=null)
	if(user && ismob(user))
		user.attack_log += text("\[[time_stamp()]\] <font color='red'>Has [what_done] [target ? "[target.name][(ismob(target) && target.ckey) ? "([target.ckey])" : ""]" : "NON-EXISTANT SUBJECT"][object ? " with [object]" : " "][addition]</font>")
	if(target && ismob(target))
		target.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been [what_done] by [user ? "[user.name][(ismob(user) && user.ckey) ? "([user.ckey])" : ""]" : "NON-EXISTANT SUBJECT"][object ? " with [object]" : " "][addition]</font>")
	if(admin)
		log_attack("<font color='red'>[user ? "[user.name][(ismob(user) && user.ckey) ? "([user.ckey])" : ""]" : "NON-EXISTANT SUBJECT"] [what_done] [target ? "[target.name][(ismob(target) && target.ckey)? "([target.ckey])" : ""]" : "NON-EXISTANT SUBJECT"][object ? " with [object]" : " "][addition]</font>")

//checks whether this item is a module of the robot it is located in.
/proc/is_robot_module(var/obj/item/thing)
	if(!thing)
		return 0
	if(istype(thing.loc, /mob/living/heavy_vehicle))
		return 1
	if(!istype(thing.loc, /mob/living/silicon/robot))
		return 0
	var/mob/living/silicon/robot/R = thing.loc
	return (thing in R.module.modules)

/proc/get_exposed_defense_zone(var/atom/movable/target)
	var/obj/item/grab/G = locate() in target
	if(G && G.state >= GRAB_NECK) //works because mobs are currently not allowed to upgrade to NECK if they are grabbing two people.
		return pick(BP_HEAD, BP_L_HAND, BP_R_HAND, BP_L_FOOT, BP_R_FOOT, BP_L_ARM, BP_R_ARM, BP_L_LEG, BP_R_LEG)
	else
		return pick(BP_CHEST, BP_GROIN)

/proc/do_mob(mob/user , mob/target, time = 30, target_zone = 0, uninterruptible = 0, progress = 1)
	if(!user || !target)
		return 0
	var/user_loc = user.loc
	var/target_loc = target.loc

	var/holding = user.get_active_hand()
	var/datum/progressbar/progbar
	if (progress)
		progbar = new(user, time, target)

	var/endtime = world.time+time
	var/starttime = world.time
	. = 1
	while (world.time < endtime)
		sleep(1)
		if (progress)
			progbar.update(world.time - starttime)
		if(!user || !target)
			. = 0
			break
		if(uninterruptible)
			continue

		if(!user || user.incapacitated() || user.loc != user_loc)
			. = 0
			break

		if(target.loc != target_loc)
			. = 0
			break

		if(user.get_active_hand() != holding)
			. = 0
			break

		if(target_zone && user.zone_sel.selecting != target_zone)
			. = 0
			break

	if (progbar)
		qdel(progbar)

/proc/do_after(mob/user, delay, atom/target = null, needhand = 1, progress = 1, var/incapacitation_flags = INCAPACITATION_DEFAULT)
	if(!user)
		return 0
	var/atom/target_loc = null
	if(target)
		target_loc = target.loc

	var/atom/original_loc = user.loc

	var/holding = user.get_active_hand()

	var/datum/progressbar/progbar
	if (progress)
		progbar = new(user, delay, target)

	var/endtime = world.time + delay
	var/starttime = world.time
	. = 1
	while (world.time < endtime)
		sleep(1)
		if (progress)
			progbar.update(world.time - starttime)

		if(!user || user.incapacitated(incapacitation_flags) || user.loc != original_loc)
			. = 0
			break

		if(target_loc && (!target || target_loc != target.loc))
			. = 0
			break

		if(needhand)
			if(user.get_active_hand() != holding)
				. = 0
				break

	if (progbar)
		qdel(progbar)

/proc/able_mobs_in_oview(var/origin)
	var/list/mobs = list()
	for(var/mob/living/M in oview(origin)) // Only living mobs are considered able.
		if(!M.is_physically_disabled())
			mobs += M
	return mobs

// Returns true if M was not already in the dead mob list
/mob/proc/switch_from_living_to_dead_mob_list()
	remove_from_living_mob_list()
	. = add_to_dead_mob_list()

// Returns true if M was not already in the living mob list
/mob/proc/switch_from_dead_to_living_mob_list()
	remove_from_dead_mob_list()
	. = add_to_living_mob_list()

// Returns true if the mob was in neither the dead or living list
/mob/proc/add_to_living_mob_list()
	return FALSE
/mob/living/add_to_living_mob_list()
	if((src in living_mob_list_) || (src in dead_mob_list_))
		return FALSE
	living_mob_list_ += src
	return TRUE

// Returns true if the mob was removed from the living list
/mob/proc/remove_from_living_mob_list()
	return living_mob_list_.Remove(src)

// Returns true if the mob was in neither the dead or living list
/mob/proc/add_to_dead_mob_list()
	return FALSE
/mob/living/add_to_dead_mob_list()
	if((src in living_mob_list_) || (src in dead_mob_list_))
		return FALSE
	dead_mob_list_ += src
	return TRUE

// Returns true if the mob was removed form the dead list
/mob/proc/remove_from_dead_mob_list()
	return dead_mob_list_.Remove(src)

/proc/health_scan_mob(var/mob/living/M, var/mob/living/user, var/visible_msg, var/ignore_clumsiness, var/show_limb_damage = TRUE)

	if(!visible_msg)
		visible_msg = "\The [user] has analyzed \the [M]'s vitals."

	if (!(istype(usr, /mob/living/carbon/human) || ticker) && ticker.mode.name != "monkey")
		usr << "<span class='warning'>You don't have the dexterity to do this!</span>"
		return

	if (!ignore_clumsiness && HAS_ASPECT(user, ASPECT_CLUMSY) && prob(20))
		user.visible_message("<span class='notice'>\The [user] has analyzed the floor's vitals!</span>")
		user.show_message("<span class='notice'>Analyzing Results for The floor:</span>", 1)
		user.show_message("<span class='notice'>Overall Status: Healthy</span>", 1)
		user.show_message("<span class='notice'>    Damage Specifics: 0-0-0-0</span>", 1)
		user.show_message("<span class='notice'>Key: Suffocation/Toxin/Burns/Brute</span>", 1)
		user.show_message("<span class='notice'>Body Temperature: ???</span>", 1)
		return

	user.visible_message("<span class='notice'>[visible_msg]</span>")

	if (!istype(M,/mob/living/carbon/human) || M.isSynthetic())
		//these sensors are designed for organic life
		user.show_message("<span class='notice'>Analyzing Results for ERROR:\n\t Overall Status: ERROR</span>")
		user.show_message("<span class='notice'>    Key: <font color='blue'>Suffocation</font>/<font color='green'>Toxin</font>/<font color='#FFA500'>Burns</font>/<font color='red'>Brute</font></span>", 1)
		user.show_message("<span class='notice'>    Damage Specifics: <font color='blue'>?</font> - <font color='green'>?</font> - <font color='#FFA500'>?</font> - <font color='red'>?</font></span>")
		user.show_message("<span class='notice'>Body Temperature: [M.bodytemperature-T0C]&deg;C ([M.bodytemperature*1.8-459.67]&deg;F)</span>", 1)
		user.show_message("<span class='warning'>Warning: Blood Level ERROR: --% --cl.</span> <span class='notice'>Type: ERROR</span>")
		user.show_message("<span class='notice'>Subject's pulse: <font color='red'>-- bpm.</font></span>")
		return

	var/fake_oxy = max(rand(1,40), M.getOxyLoss(), (300 - (M.getToxLoss() + M.getFireLoss() + M.getBruteLoss())))
	var/OX = M.getOxyLoss() > 50 	? 	"<b>[M.getOxyLoss()]</b>" 		: M.getOxyLoss()
	var/TX = M.getToxLoss() > 50 	? 	"<b>[M.getToxLoss()]</b>" 		: M.getToxLoss()
	var/BU = M.getFireLoss() > 50 	? 	"<b>[M.getFireLoss()]</b>" 		: M.getFireLoss()
	var/BR = M.getBruteLoss() > 50 	? 	"<b>[M.getBruteLoss()]</b>" 	: M.getBruteLoss()
	if(M.status_flags & FAKEDEATH)
		OX = fake_oxy > 50 			? 	"<b>[fake_oxy]</b>" 			: fake_oxy
		user.show_message("<span class='notice'>Analyzing Results for [M]:</span>")
		user.show_message("<span class='notice'>Overall Status: dead</span>")
	else
		user.show_message("<span class='notice'>Analyzing Results for [M]:\n\t Overall Status: [M.stat > 1 ? "dead" : "[round(M.health/M.maxHealth)*100]% healthy"]</span>")
	user.show_message("<span class='notice'>    Key: <font color='blue'>Suffocation</font>/<font color='green'>Toxin</font>/<font color='#FFA500'>Burns</font>/<font color='red'>Brute</font></span>", 1)
	user.show_message("<span class='notice'>    Damage Specifics: <font color='blue'>[OX]</font> - <font color='green'>[TX]</font> - <font color='#FFA500'>[BU]</font> - <font color='red'>[BR]</font></span>")
	user.show_message("<span class='notice'>Body Temperature: [M.bodytemperature-T0C]&deg;C ([M.bodytemperature*1.8-459.67]&deg;F)</span>", 1)
	if(M.tod && (M.stat == DEAD || (M.status_flags & FAKEDEATH)))
		user.show_message("<span class='notice'>Time of Death: [M.tod]</span>")

	if(istype(M, /mob/living/carbon/human) && show_limb_damage)
		var/mob/living/carbon/human/H = M
		var/list/damaged = H.get_damaged_organs(1,1)
		user.show_message("<span class='notice'>Localized Damage, Brute/Burn:</span>",1)
		if(length(damaged)>0)
			for(var/obj/item/organ/external/org in damaged)
				user.show_message(text("<span class='notice'>     [][]: [][] - []</span>",
				capitalize(org.name),
				(org.robotic >= ORGAN_ROBOT) ? "(Cybernetic)" : "",
				(org.brute_dam > 0) ? "<span class='warning'>[org.brute_dam]</span>" : 0,
				(org.status & ORGAN_BLEEDING)?"<span class='danger'>\[Bleeding\]</span>":"",
				(org.burn_dam > 0) ? "<font color='#FFA500'>[org.burn_dam]</font>" : 0),1)
		else
			user.show_message("<span class='notice'>    Limbs are OK.</span>",1)

	OX = M.getOxyLoss() > 50 ? 	"<font color='blue'><b>Severe oxygen deprivation detected</b></font>" 		: 	"Subject bloodstream oxygen level normal"
	TX = M.getToxLoss() > 50 ? 	"<font color='green'><b>Dangerous amount of toxins detected</b></font>" 	: 	"Subject bloodstream toxin level minimal"
	BU = M.getFireLoss() > 50 ? 	"<font color='#FFA500'><b>Severe burn damage detected</b></font>" 			:	"Subject burn injury status O.K"
	BR = M.getBruteLoss() > 50 ? "<font color='red'><b>Severe anatomical damage detected</b></font>" 		: 	"Subject brute-force injury status O.K"
	if(M.status_flags & FAKEDEATH)
		OX = fake_oxy > 50 ? 		"<span class='warning'>Severe oxygen deprivation detected</span>" 	: 	"Subject bloodstream oxygen level normal"
	user.show_message("[OX] | [TX] | [BU] | [BR]")
	if(istype(M, /mob/living/carbon))
		var/mob/living/carbon/C = M
		if(C.reagents.total_volume)
			var/unknown = 0
			var/reagentdata[0]
			for(var/A in C.reagents.reagent_list)
				var/datum/reagent/R = A
				if(R.scannable)
					reagentdata["[R.id]"] = "<span class='notice'>    [round(C.reagents.get_reagent_amount(R.id), 1)]u [R.name]</span>"
				else
					unknown++
			if(reagentdata.len)
				user.show_message("<span class='notice'>Beneficial reagents detected in subject's blood:</span>")
				for(var/d in reagentdata)
					user.show_message(reagentdata[d])
			if(unknown)
				user.show_message("<span class='warning'>Warning: Unknown substance[(unknown>1)?"s":""] detected in subject's blood.</span>")

		var/datum/reagents/ingested = C.get_ingested_reagents()
		if(ingested && ingested.total_volume)
			var/unknown = 0
			for(var/datum/reagent/R in ingested.reagent_list)
				if(R.scannable)
					user << "<span class='notice'>[R.name] found in subject's stomach.</span>"
				else
					++unknown
			if(unknown)
				user << "<span class='warning'>Non-medical reagent[(unknown > 1)?"s":""] found in subject's stomach.</span>"
		if(C.virus2.len)
			for (var/ID in C.virus2)
				if (ID in virusDB)
					var/datum/data/record/V = virusDB[ID]
					user.show_message("<span class='warning'>Warning: Pathogen [V.fields["name"]] detected in subject's blood. Known antigen : [V.fields["antigen"]]</span>")
//			user.show_message(text("<span class='warning'>Warning: Unknown pathogen detected in subject's blood.</span>"))
	if (M.getCloneLoss())
		user.show_message("<span class='warning'>Subject appears to have been imperfectly cloned.</span>")

	else if (M.getBrainLoss() >= 60 || !M.has_brain())
		user.show_message("<span class='warning'>Subject is brain dead.</span>")
	else if (M.getBrainLoss() >= 25)
		user.show_message("<span class='warning'>Severe brain damage detected. Subject likely to have a traumatic brain injury.</span>")
	else if (M.getBrainLoss() >= 10)
		user.show_message("<span class='warning'>Significant brain damage detected. Subject may have had a concussion.</span>")
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		for(var/name in H.organs_by_name)
			var/obj/item/organ/external/e = H.organs_by_name[name]
			if(!e)
				continue
			var/limb = e.name
			if(e.status & ORGAN_BROKEN)
				if(((e.name == BP_L_ARM) || (e.name == BP_R_ARM) || (e.name == BP_L_LEG) || (e.name == BP_R_LEG)) && (!e.splinted))
					user << "<span class='warning'>Unsecured fracture in subject [limb]. Splinting recommended for transport.</span>"
			if(e.has_infected_wound())
				user << "<span class='warning'>Infected wound detected in subject [limb]. Disinfection recommended.</span>"

		for(var/name in H.organs_by_name)
			var/obj/item/organ/external/e = H.organs_by_name[name]
			if(e && e.status & ORGAN_BROKEN)
				user.show_message(text("<span class='warning'>Bone fractures detected. Advanced scanner required for location.</span>"), 1)
				break
		for(var/obj/item/organ/external/e in H.organs)
			if(!e)
				continue
			for(var/datum/wound/W in e.wounds) if(W.internal)
				user.show_message(text("<span class='warning'>Internal bleeding detected. Advanced scanner required for location.</span>"), 1)
				break
		if(M:vessel)
			var/blood_volume = H.vessel.get_reagent_amount("blood")
			var/blood_percent =  round((blood_volume / H.species.blood_volume)*100)
			var/blood_type = H.b_type
			if((blood_percent <= BLOOD_VOLUME_SAFE) && (blood_percent > BLOOD_VOLUME_BAD))
				user.show_message("<span class='danger'>Warning: Blood Level LOW: [blood_percent]% [blood_volume]cl.</span> <span class='notice'>Type: [blood_type]</span>")
			else if(blood_percent <= BLOOD_VOLUME_BAD)
				user.show_message("<span class='danger'><i>Warning: Blood Level CRITICAL: [blood_percent]% [blood_volume]cl.</i></span> <span class='notice'>Type: [blood_type]</span>")
			else
				user.show_message("<span class='notice'>Blood Level Normal: [blood_percent]% [blood_volume]cl. Type: [blood_type]</span>")
		user.show_message("<span class='notice'>Subject's pulse: <font color='[H.pulse() == PULSE_THREADY || H.pulse() == PULSE_NONE ? "red" : "blue"]'>[H.get_pulse(GETPULSE_TOOL)] bpm.</font></span>")

//Find a dead mob with a brain and client.
/proc/find_dead_player(var/find_key, var/include_observers = 0)
	if(isnull(find_key))
		return

	var/mob/selected = null

	if(include_observers)
		for(var/mob/M in player_list)
			if((M.stat != DEAD) || (!M.client))
				continue
			if(M.ckey == find_key)
				selected = M
				break
	else
		for(var/mob/living/M in player_list)
			//Dead people only thanks!
			if((M.stat != DEAD) || (!M.client))
				continue
			//They need a brain!
			if(istype(M, /mob/living/carbon/human))
				var/mob/living/carbon/human/H = M
				if(H.should_have_organ(BP_BRAIN) && !H.has_brain())
					continue
			if(M.ckey == find_key)
				selected = M
				break
	return selected