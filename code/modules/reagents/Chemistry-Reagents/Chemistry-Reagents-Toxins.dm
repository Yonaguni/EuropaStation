/* Toxins, poisons, venoms */

/datum/reagent/toxin
	name = "toxin"
	id = "toxin"
	taste_description = "bitterness"
	taste_mult = 1.2
	reagent_state = LIQUID
	color = "#CF3600"
	metabolism = REM * 0.25 // 0.05 by default. They last a while and slowly kill you.
	var/strength = 4 // How much damage it deals per unit

/datum/reagent/toxin/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(strength)
		M.adjustToxLoss(strength * removed)

/datum/reagent/toxin/plasticide
	name = "Plasticide"
	id = "plasticide"
	taste_description = "plastic"
	reagent_state = LIQUID
	color = "#CF3600"
	strength = 5

/datum/reagent/toxin/amatoxin
	name = "Amatoxin"
	id = "amatoxin"
	taste_description = "mushroom"
	reagent_state = LIQUID
	color = "#792300"
	strength = 10

/datum/reagent/toxin/carpotoxin
	name = "Carpotoxin"
	id = "carpotoxin"
	taste_description = "fish"
	reagent_state = LIQUID
	color = "#003333"
	strength = 10

/datum/reagent/toxin/cyanide //Fast and Lethal
	name = "Cyanide"
	id = "cyanide"
	taste_mult = 0.6
	reagent_state = LIQUID
	color = "#CF3600"
	strength = 20
	metabolism = REM * 2

/datum/reagent/toxin/cyanide/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	..()
	M.adjustOxyLoss(20 * removed)
	M.sleeping += 1

/datum/reagent/toxin/potassium_chloride
	name = "Potassium Chloride"
	id = "potassium_chloride"
	taste_description = "salt"
	reagent_state = SOLID
	color = "#FFFFFF"
	strength = 0
	overdose = REAGENTS_OVERDOSE

/datum/reagent/toxin/potassium_chloride/overdose(var/mob/living/carbon/M, var/alien)
	..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.stat != 1)
			if(H.losebreath >= 10)
				H.losebreath = max(10, H.losebreath - 10)
			H.adjustOxyLoss(2)
			H.Weaken(10)
		M.add_chemical_effect(CE_NOPULSE, 1)


/datum/reagent/toxin/potassium_chlorophoride
	name = "Potassium Chlorophoride"
	id = "potassium_chlorophoride"
	taste_description = "salt"
	reagent_state = SOLID
	color = "#FFFFFF"
	strength = 10
	overdose = 20

/datum/reagent/toxin/potassium_chlorophoride/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.stat != 1)
			if(H.losebreath >= 10)
				H.losebreath = max(10, M.losebreath-10)
			H.adjustOxyLoss(2)
			H.Weaken(10)
		M.add_chemical_effect(CE_NOPULSE, 1)

/datum/reagent/toxin/byphodine
	name = "Byphodine"
	id = "byphodine"
	taste_description = "death"
	reagent_state = SOLID
	color = "#669900"
	metabolism = REM
	strength = 3

/datum/reagent/toxin/byphodine/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	..()
	M.status_flags |= FAKEDEATH
	M.adjustOxyLoss(3 * removed)
	M.Weaken(10)
	M.silent = max(M.silent, 10)
	M.tod = stationtime2text()
	M.add_chemical_effect(CE_NOPULSE, 1)

/datum/reagent/toxin/byphodine/Destroy()
	if(holder && holder.my_atom && ismob(holder.my_atom))
		var/mob/M = holder.my_atom
		M.status_flags &= ~FAKEDEATH
	return ..()

/datum/reagent/toxin/fertilizer //Reagents used for plant fertilizers.
	name = "fertilizer"
	id = "fertilizer"
	taste_description = "plant food"
	taste_mult = 0.5
	reagent_state = LIQUID
	strength = 0.5 // It's not THAT poisonous.
	color = "#664330"

/datum/reagent/toxin/fertilizer/eznutrient
	name = "EZ Nutrient"
	id = "eznutrient"

/datum/reagent/toxin/fertilizer/left4zed
	name = "Left-4-Zed"
	id = "left4zed"

/datum/reagent/toxin/fertilizer/robustharvest
	name = "Robust Harvest"
	id = "robustharvest"

/datum/reagent/toxin/weedkiller
	name = "Weed Killer"
	id = "weedkiller"
	taste_mult = 1
	reagent_state = LIQUID
	color = "#49002E"
	strength = 4

/datum/reagent/toxin/weedkiller/touch_turf(var/turf/T)
	if(istype(T, /turf/simulated/wall))
		var/turf/simulated/wall/W = T
		if(locate(/obj/effect/overlay/wallrot) in W)
			for(var/obj/effect/overlay/wallrot/E in W)
				qdel(E)
			W.visible_message("<span class='notice'>The fungi are completely dissolved by the solution!</span>")

/datum/reagent/toxin/weedkiller/touch_obj(var/obj/O, var/volume)
	if(istype(O, /obj/effect/plant))
		qdel(O)

/datum/reagent/acid/polyacid
	name = "Polytrinic acid"
	id = "pacid"
	taste_description = "acid"
	reagent_state = LIQUID
	color = "#8E18A9"
	power = 10
	meltdose = 4

/datum/reagent/lexorin
	name = "Lexorin"
	id = "lexorin"
	taste_description = "acid"
	reagent_state = LIQUID
	color = "#C8A5DC"
	overdose = REAGENTS_OVERDOSE

/datum/reagent/lexorin/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.take_organ_damage(3 * removed, 0)
	if(M.losebreath < 15)
		M.losebreath++

/datum/reagent/gc161
	name = "GC-161"
	id = "gc161"
	taste_description = "slime"
	taste_mult = 0.9
	reagent_state = LIQUID
	color = "#13BC5E"

/datum/reagent/gc161/affect_touch(var/mob/living/carbon/M, var/alien, var/removed)
	if(prob(33))
		affect_blood(M, alien, removed)

/datum/reagent/gc161/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	if(prob(67))
		affect_blood(M, alien, removed)

/datum/reagent/gc161/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)

	if(M.isSynthetic())
		return

	var/mob/living/carbon/human/H = M
	if(istype(H) && (H.species.flags & NO_SCAN))
		return

	if(M.dna)
		if(prob(removed * 0.1)) // Approx. one mutation per 10 injected/20 ingested/30 touching units
			randmuti(M)
			if(prob(98))
				randmutb(M)
			else
				randmutg(M)
			domutcheck(M, null)
			M.UpdateAppearance()
	M.apply_effect(10 * removed, IRRADIATE, blocked = 0)

/datum/reagent/slimejelly
	name = "Slime Jelly"
	id = "slimejelly"
	taste_description = "slime"
	taste_mult = 1.3
	reagent_state = LIQUID
	color = "#801E28"

/datum/reagent/slimejelly/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(prob(10))
		M << "<span class='danger'>Your insides are burning!</span>"
		M.adjustToxLoss(rand(100, 300) * removed)
	else if(prob(40))
		M.heal_organ_damage(25 * removed, 0)

/datum/reagent/soporific
	name = "Soporific"
	id = "stoxin"
	taste_description = "bitterness"
	reagent_state = LIQUID
	color = "#009CA8"
	metabolism = REM * 0.5
	overdose = REAGENTS_OVERDOSE

/datum/reagent/soporific/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)

	if(dose < 1)
		if(dose == metabolism * 2 || prob(5))
			M.emote("yawn")
	else if(dose < 1.5)
		M.eye_blurry = max(M.eye_blurry, 10)
	else if(dose < 5)
		if(prob(50))
			M.Weaken(2)
		M.drowsyness = max(M.drowsyness, 20)
	else
		M.sleeping = max(M.sleeping, 20)
		M.drowsyness = max(M.drowsyness, 60)
	M.add_chemical_effect(CE_PULSE, -1)

/datum/reagent/chloralhydrate
	name = "Chloral Hydrate"
	id = "chloralhydrate"
	taste_description = "bitterness"
	reagent_state = SOLID
	color = "#000067"
	metabolism = REM * 0.5
	overdose = REAGENTS_OVERDOSE * 0.5

/datum/reagent/chloralhydrate/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)

	if(dose == metabolism)
		M.confused += 2
		M.drowsyness += 2
	else if(dose < 2)
		M.Weaken(30)
		M.eye_blurry = max(M.eye_blurry, 10)
	else
		M.sleeping = max(M.sleeping, 30)

	if(dose > 1)
		M.adjustToxLoss(removed)

/datum/reagent/chloralhydrate/beer2 //disguised as normal beer for use by emagged brobots
	name = "Beer"
	id = "beer2"
	taste_description = "shitty piss water"
	reagent_state = LIQUID
	color = "#FFD300"

	glass_name = "beer"
	glass_desc = "A freezing pint of beer"

/datum/reagent/serotrotium
	name = "Serotrotium"
	id = "serotrotium"
	taste_description = "bitterness"
	reagent_state = LIQUID
	color = "#202040"
	metabolism = REM * 0.25
	overdose = REAGENTS_OVERDOSE

/datum/reagent/serotrotium/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(prob(7))
		M.emote(pick("twitch", "drool", "moan", "gasp"))
	return

/datum/reagent/cryptobiolin
	name = "Cryptobiolin"
	id = "cryptobiolin"
	taste_description = "sourness"
	reagent_state = LIQUID
	color = "#000055"
	metabolism = REM * 0.5
	overdose = REAGENTS_OVERDOSE

/datum/reagent/cryptobiolin/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.make_dizzy(4)
	M.confused = max(M.confused, 20)

/datum/reagent/impedrezene
	name = "Impedrezene"
	id = "impedrezene"
	taste_description = "numbness"
	reagent_state = LIQUID
	color = "#C8A5DC"
	overdose = REAGENTS_OVERDOSE

/datum/reagent/impedrezene/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.jitteriness = max(M.jitteriness - 5, 0)
	if(prob(80))
		M.adjustBrainLoss(0.1 * removed)
	if(prob(50))
		M.drowsyness = max(M.drowsyness, 3)
	if(prob(10))
		M.emote("drool")

/* Transformations */

/datum/reagent/slimetoxin
	name = "Mutation Toxin"
	id = "mutationtoxin"
	taste_description = "sludge"
	reagent_state = LIQUID
	color = "#13BC5E"

/datum/reagent/slimetoxin/affect_blood(var/mob/living/carbon/M, var/alien, var/removed) // TODO: check if there's similar code anywhere else
	if(M.transforming || isslime(M))
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.species.name == "Promethean")
			return

	M << "<span class='danger'>Your flesh rapidly mutates!</span>"
	M.transforming = 1
	M.canmove = 0
	M.icon = null
	M.overlays.Cut()
	M.invisibility = 101
	for(var/obj/item/W in M)
		if(istype(W, /obj/item/implant)) //TODO: Carn. give implants a dropped() or something
			qdel(W)
			continue
		M.drop_from_inventory(W)
	var/mob/living/carbon/slime/new_mob = new /mob/living/carbon/slime(M.loc)
	new_mob.a_intent = "hurt"
	new_mob.universal_speak = 1
	if(M.mind)
		M.mind.transfer_to(new_mob)
	else
		new_mob.key = M.key
	new_mob.request_player()
	qdel(M)

/datum/reagent/prometheanserum
	name = "Promethean Serum"
	id = "prometheanserum"
	taste_description = "sludge"
	reagent_state = LIQUID
	color = "#13BC5E"


/datum/reagent/prometheanserum/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(M.transforming)
		return
	if(ishuman(M))
		M.reagents.add_reagent("mutationtoxin", removed)
	else if(isslime(M))
		var/mob/living/carbon/slime/S = M
		S.start_promethean_evolution()

/datum/reagent/slimecrystal
	name = "Crystallizing Agent"
	id = "slimecrystal"
	taste_description = "sharpness"
	reagent_state = LIQUID
	color = "#13BC5E"

/datum/reagent/slimecrystal/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(M.transforming || istype(M.loc, /obj/structure/closet/statue))
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.species.name == "Golem")
			return
		if(H.species.name == "Promethean")
			H.visible_message("<span class='notice'>\The [H]'s flesh begins to crystallize!</span>")
			H.set_species("Golem")
			return
		else // It is VERY BAD for humans.
			if(prob(5))
				var/obj/item/organ/external/E = pick(H.organs)
				if(E && !E.is_stump() && !E.robotic && E.organ_tag != BP_CHEST && E.organ_tag != BP_GROIN)
					H << "<span class='danger'>Your [E.name] is being lacerated from within!</span>"
					if(H.can_feel_pain())
						H.emote("scream")
					for(var/i = 1 to rand(3,5))
						new /obj/item/material/shard(get_turf(E), "nullglass")
					E.droplimb(0, DROPLIMB_BLUNT)
					return
	else if(isslime(M))
		M.visible_message("<span class='danger'>\The [M] rapidly crystallizes!</span>")
		new /obj/structure/closet/statue(get_turf(M), M)
		return

	M << "<span class='danger'>Your flesh is being lacerated from within!</span>"
	M.adjustBruteLoss(rand(3,6))
	if(prob(10))
		new /obj/item/material/shard(get_turf(M), "nullglass")

/datum/reagent/nanites
	name = "Nanomachines"
	id = "nanites"
	taste_description = "slimy metal"
	reagent_state = LIQUID
	color = "#535E66"

/datum/reagent/xenomicrobes
	name = "Xenomicrobes"
	id = "xenomicrobes"
	taste_description = "sludge"
	reagent_state = LIQUID
	color = "#535E66"
