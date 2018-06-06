//helper that ensures the reaction rate holds after iterating
//Ex. REACTION_RATE(0.3) means that 30% of the reagents will react each chemistry tick (~2 seconds by default).
#define REACTION_RATE(rate) (1.0 - (1.0-rate)**(1.0/PROCESS_REACTION_ITER))

//helper to define reaction rate in terms of half-life
//Ex.
//HALF_LIFE(0) -> Reaction completes immediately (default chems)
//HALF_LIFE(1) -> Half of the reagents react immediately, the rest over the following ticks.
//HALF_LIFE(2) -> Half of the reagents are consumed after 2 chemistry ticks.
//HALF_LIFE(3) -> Half of the reagents are consumed after 3 chemistry ticks.
#define HALF_LIFE(ticks) (ticks? 1.0 - (0.5)**(1.0/(ticks*PROCESS_REACTION_ITER)) : 1.0)

/datum/chemical_reaction
	var/result = null
	var/list/required_reagents = list()
	var/list/catalysts = list()
	var/list/inhibitors = list()
	var/result_amount = 0
	var/loaded_at_runtime = FALSE // TODO
	var/product_name
 
	//how far the reaction proceeds each time it is processed. Used with either REACTION_RATE or HALF_LIFE macros.
	var/reaction_rate = HALF_LIFE(1)

	//if less than 1, the reaction will be inhibited if the ratio of products/reagents is too high.
	//0.5 = 50% yield -> reaction will only proceed halfway until products are removed.
	var/yield = 1.0

	//If limits on reaction rate would leave less than this amount of any reagent (adjusted by the reaction ratios),
	//the reaction goes to completion. This is to prevent reactions from going on forever with tiny reagent amounts.
	var/min_reaction = 2

	var/mix_message = "The solution begins to bubble."
	var/reaction_sound = 'sound/effects/bubbles.ogg'

	var/log_is_important = 0 // If this reaction should be considered important for logging. Important recipes message admins when mixed, non-important ones just log to file.

/datum/chemical_reaction/proc/can_happen(var/datum/reagents/holder)
	//check that all the required reagents are present
	if(!holder.has_all_reagents(required_reagents))
		return 0

	//check that all the required catalysts are present in the required amount
	if(!holder.has_all_reagents(catalysts))
		return 0

	//check that none of the inhibitors are present in the required amount
	if(holder.has_any_reagent(inhibitors))
		return 0

	return 1

/datum/chemical_reaction/proc/calc_reaction_progress(var/datum/reagents/holder, var/reaction_limit)
	var/progress = reaction_limit * reaction_rate //simple exponential progression

	//calculate yield
	if(1-yield > 0.001) //if yield ratio is big enough just assume it goes to completion
		/*
			Determine the max amount of product by applying the yield condition:
			(max_product/result_amount) / reaction_limit == yield/(1-yield)

			We make use of the fact that:
			reaction_limit = (holder.get_reagent_amount(reactant) / required_reagents[reactant]) of the limiting reagent.
		*/
		var/yield_ratio = yield/(1-yield)
		var/max_product = yield_ratio * reaction_limit * result_amount //rearrange to obtain max_product
		var/yield_limit = max(0, max_product - holder.get_reagent_amount(result))/result_amount

		progress = min(progress, yield_limit) //apply yield limit

	//apply min reaction progress - wasn't sure if this should go before or after applying yield
	//I guess people can just have their miniscule reactions go to completion regardless of yield.
	for(var/reactant in required_reagents)
		var/remainder = holder.get_reagent_amount(reactant) - progress*required_reagents[reactant]
		if(remainder <= min_reaction*required_reagents[reactant])
			progress = reaction_limit
			break

	return progress

/datum/chemical_reaction/process(var/datum/reagents/holder)
	//determine how far the reaction can proceed
	var/list/reaction_limits = list()
	for(var/reactant in required_reagents)
		reaction_limits += holder.get_reagent_amount(reactant) / required_reagents[reactant]

	//determine how far the reaction proceeds
	var/reaction_limit = min(reaction_limits)
	var/progress_limit = calc_reaction_progress(holder, reaction_limit)

	var/reaction_progress = min(reaction_limit, progress_limit) //no matter what, the reaction progress cannot exceed the stoichiometric limit.

	//need to obtain the new reagent's data before anything is altered
	var/data = send_data(holder, reaction_progress)

	//remove the reactants
	for(var/reactant in required_reagents)
		var/amt_used = required_reagents[reactant] * reaction_progress
		holder.remove_reagent(reactant, amt_used, safety = 1)

	//add the product
	var/amt_produced = result_amount * reaction_progress
	if(result)
		holder.add_reagent(result, amt_produced, data, safety = 1)

	on_reaction(holder, amt_produced)

	return reaction_progress

//called when a reaction processes
/datum/chemical_reaction/proc/on_reaction(var/datum/reagents/holder, var/created_volume)
	return

//called after processing reactions, if they occurred
/datum/chemical_reaction/proc/post_reaction(var/datum/reagents/holder)
	var/atom/container = holder.my_atom
	if(mix_message && container && !ismob(container))
		var/turf/T = get_turf(container)
		var/list/seen = viewers(4, T)
		for(var/mob/M in seen)
			M.show_message("<span class='notice'>\icon[container] [mix_message]</span>", 1)
		playsound(T, reaction_sound, 80, 1)

//obtains any special data that will be provided to the reaction products
//this is called just before reactants are removed.
/datum/chemical_reaction/proc/send_data(var/datum/reagents/holder, var/reaction_limit)
	return null

/* Common reactions */

/datum/chemical_reaction/adrenaline
	result = REAGENT_ADRENALINE
	required_reagents = list(REAGENT_ACETONE = 1, REAGENT_CARBON = 1, REAGENT_SUGAR = 1)
	result_amount = 3

/datum/chemical_reaction/dylovene
	result = REAGENT_ANTITOXIN
	required_reagents = list(REAGENT_SILICON = 1, REAGENT_POTASSIUM = 1, REAGENT_AMMONIA = 1)
	result_amount = 3

/datum/chemical_reaction/morphine
	result = REAGENT_MORPHINE
	required_reagents = list(REAGENT_ADRENALINE = 1, REAGENT_ETHANOL = 1, REAGENT_ACETONE = 1)
	result_amount = 3

/datum/chemical_reaction/paracetamol
	result = REAGENT_PARACETAMOL
	required_reagents = list(REAGENT_MORPHINE = 1, REAGENT_SUGAR = 1, REAGENT_WATER = 1)
	result_amount = 3

/datum/chemical_reaction/oxycodone
	result = REAGENT_OXYCODONE
	required_reagents = list(REAGENT_ETHANOL = 1, REAGENT_MORPHINE = 1)
	catalysts = list(REAGENT_ENZYME = 5)
	result_amount = 1

/datum/chemical_reaction/antiseptic
	result = REAGENT_ANTISEPTIC
	required_reagents = list(REAGENT_ETHANOL = 1, REAGENT_ANTITOXIN = 1, REAGENT_HCLACID = 1)
	result_amount = 3

/datum/chemical_reaction/silicate
	result = REAGENT_SILICATE
	required_reagents = list(REAGENT_ALUMINIUM = 1, REAGENT_SILICON = 1, REAGENT_ACETONE = 1)
	result_amount = 3

/datum/chemical_reaction/gc161
	result = REAGENT_GC161
	required_reagents = list(REAGENT_RADIUM = 1, REAGENT_PHOSPHORUS = 1, REAGENT_HCLACID = 1)
	result_amount = 3

/datum/chemical_reaction/thermite
	result = REAGENT_THERMITE
	required_reagents = list(REAGENT_ALUMINIUM = 1, REAGENT_IRON = 1, REAGENT_ACETONE = 1)
	result_amount = 3

/datum/chemical_reaction/glint
	result = REAGENT_GLINT
	required_reagents = list(REAGENT_MERCURY = 1, REAGENT_SUGAR = 1, REAGENT_LITHIUM = 1)
	result_amount = 3

/datum/chemical_reaction/lube
	result = REAGENT_LUBE
	required_reagents = list(REAGENT_WATER = 1, REAGENT_SILICON = 1, REAGENT_ACETONE = 1)
	result_amount = 4

/datum/chemical_reaction/pacid
	result = REAGENT_POLYACID
	required_reagents = list(REAGENT_SULFURIC_ACID = 1, REAGENT_HCLACID = 1, REAGENT_POTASSIUM = 1)
	result_amount = 3

/datum/chemical_reaction/synaptizine
	result = REAGENT_SYNAPTIZINE
	required_reagents = list(REAGENT_SUGAR = 1, REAGENT_LITHIUM = 1, REAGENT_WATER = 1)
	result_amount = 3

/datum/chemical_reaction/entolimod
	result = REAGENT_ENTOLIMOD
	required_reagents = list(REAGENT_RADIUM = 1, REAGENT_ANTITOXIN = 1)
	result_amount = 2

/datum/chemical_reaction/arithrazine
	result = REAGENT_ARITHRAZINE
	required_reagents = list(REAGENT_ENTOLIMOD = 1, REAGENT_HYDRAZINE = 1)
	result_amount = 2

/datum/chemical_reaction/impedrezene
	result = REAGENT_IMPEDREZENE
	required_reagents = list(REAGENT_MERCURY = 1, REAGENT_ACETONE = 1, REAGENT_SUGAR = 1)
	result_amount = 2

/datum/chemical_reaction/fotiazine
	result = REAGENT_FOTIAZINE
	required_reagents = list(REAGENT_SILICON = 1, REAGENT_CARBON = 1)
	result_amount = 2
	log_is_important = 1

/datum/chemical_reaction/peridaxon
	result = REAGENT_PERIDAXON
	required_reagents = list(REAGENT_STYPTAZINE = 2, REAGENT_CLONEXADONE = 2)
	catalysts = list(REAGENT_ENZYME = 5)
	result_amount = 2

/datum/chemical_reaction/virus_food
	result = REAGENT_VIRUSFOOD
	required_reagents = list(REAGENT_WATER = 1, REAGENT_MILK = 1)
	result_amount = 5

/datum/chemical_reaction/leporazine
	result = REAGENT_LEPORAZINE
	required_reagents = list(REAGENT_SILICON = 1, REAGENT_COPPER = 1)
	catalysts = list(REAGENT_ENZYME = 5)
	result_amount = 2

/datum/chemical_reaction/cryptobiolin
	result = REAGENT_CRYPTOBIOLIN
	required_reagents = list(REAGENT_POTASSIUM = 1, REAGENT_ACETONE = 1, REAGENT_SUGAR = 1)
	result_amount = 3

/datum/chemical_reaction/alkysine
	result = REAGENT_ALKYSINE
	required_reagents = list(REAGENT_HCLACID = 1, REAGENT_AMMONIA = 1, REAGENT_ANTITOXIN = 1)
	result_amount = 2

/datum/chemical_reaction/dexalin
	result = REAGENT_DEXALIN
	required_reagents = list(REAGENT_ACETONE = 2, REAGENT_ENZYME = 0.1)
	catalysts = list(REAGENT_ENZYME = 1)
	inhibitors = list(REAGENT_WATER = 1) // Messes with cryox
	result_amount = 1

/datum/chemical_reaction/styptazine
	result = REAGENT_STYPTAZINE
	required_reagents = list(REAGENT_ADRENALINE = 1, REAGENT_CARBON = 1)
	inhibitors = list(REAGENT_SUGAR = 1) // Messes up with adrenaline
	result_amount = 2

/datum/chemical_reaction/jumpstart
	result = REAGENT_JUMPSTART
	required_reagents = list(REAGENT_SUGAR = 1, REAGENT_PHOSPHORUS = 1, REAGENT_SULFUR = 1)
	result_amount = 3

/datum/chemical_reaction/cryoxadone
	result = REAGENT_CRYOXADONE
	required_reagents = list(REAGENT_DEXALIN = 1, REAGENT_WATER = 1, REAGENT_ACETONE = 1)
	result_amount = 3

/datum/chemical_reaction/clonexadone
	result = REAGENT_CLONEXADONE
	required_reagents = list(REAGENT_CRYOXADONE = 1, REAGENT_SODIUM = 1, REAGENT_ENZYME = 0.1)
	catalysts = list(REAGENT_ENZYME = 5)
	result_amount = 2

/datum/chemical_reaction/antibiotic
	result = REAGENT_ANTIBIOTICS
	required_reagents = list(REAGENT_CRYPTOBIOLIN = 1, REAGENT_ADRENALINE = 1)
	result_amount = 2

/datum/chemical_reaction/imidazoline
	result = REAGENT_IMIDAZOLINE
	required_reagents = list(REAGENT_CARBON = 1, REAGENT_HYDRAZINE = 1, REAGENT_ANTITOXIN = 1)
	result_amount = 2

/datum/chemical_reaction/ethylredoxrazine
	result = REAGENT_ETHYLREDOXRAZINE
	required_reagents = list(REAGENT_ACETONE = 1, REAGENT_ANTITOXIN = 1, REAGENT_CARBON = 1)
	result_amount = 3

/datum/chemical_reaction/soporific
	result = REAGENT_SLEEPTOXIN
	required_reagents = list(REAGENT_CHLORALHYDRATE = 1, REAGENT_SUGAR = 4)
	inhibitors = list(REAGENT_PHOSPHORUS) // Messes with the smoke
	result_amount = 5

/datum/chemical_reaction/chloralhydrate
	result = REAGENT_CHLORALHYDRATE
	required_reagents = list(REAGENT_ETHANOL = 1, REAGENT_HCLACID = 3, REAGENT_WATER = 1)
	result_amount = 1

/datum/chemical_reaction/potassium_chloride
	result = REAGENT_P_CHLORIDE
	required_reagents = list(REAGENT_SALT = 1, REAGENT_POTASSIUM = 1)
	result_amount = 2

/datum/chemical_reaction/potassium_chlorophoride
	result = REAGENT_P_CHLOROPHORIDE
	required_reagents = list(REAGENT_P_CHLORIDE = 1, REAGENT_ENZYME = 1, REAGENT_CHLORALHYDRATE = 1)
	result_amount = 4

/datum/chemical_reaction/byphodine
	result = REAGENT_BYPHODINE
	required_reagents = list(REAGENT_CARPOTOXIN = 5, REAGENT_SLEEPTOXIN = 5, REAGENT_COPPER = 5)
	result_amount = 2

/datum/chemical_reaction/lsd
	result = REAGENT_LSD
	required_reagents = list(REAGENT_SILICON = 1, REAGENT_HYDRAZINE = 1, REAGENT_ANTITOXIN = 1)
	result_amount = 3

/datum/chemical_reaction/lipozine
	result = REAGENT_LIPOZINE
	required_reagents = list(REAGENT_SALT = 1, REAGENT_ETHANOL = 1, REAGENT_RADIUM = 1)
	result_amount = 3

/datum/chemical_reaction/surfactant
	result = REAGENT_SURFACTANT
	required_reagents = list(REAGENT_HYDRAZINE = 2, REAGENT_CARBON = 2, REAGENT_SULFURIC_ACID = 1)
	result_amount = 5

/datum/chemical_reaction/diethylamine
	result = REAGENT_DIETHYLAMINE
	required_reagents = list (REAGENT_AMMONIA = 1, REAGENT_ETHANOL = 1)
	result_amount = 2

/datum/chemical_reaction/space_cleaner
	result = REAGENT_CLEANER
	required_reagents = list(REAGENT_AMMONIA = 1, REAGENT_WATER = 1)
	result_amount = 2

/datum/chemical_reaction/weedkiller
	result = REAGENT_WEEDKILLER
	required_reagents = list(REAGENT_TOXIN = 1, REAGENT_WATER = 4)
	result_amount = 5

/datum/chemical_reaction/foaming_agent
	result = REAGENT_FOAMING
	required_reagents = list(REAGENT_LITHIUM = 1, REAGENT_HYDRAZINE = 1)
	result_amount = 1

/datum/chemical_reaction/glycerol
	result = REAGENT_GLYCEROL
	required_reagents = list(REAGENT_CORNOIL = 3, REAGENT_SULFURIC_ACID = 1)
	result_amount = 1

/datum/chemical_reaction/sodiumchloride
	result = REAGENT_SALT
	required_reagents = list(REAGENT_SODIUM = 1, REAGENT_HCLACID = 1)
	result_amount = 2

/datum/chemical_reaction/condensedcapsaicin
	result = REAGENT_CAPSAICINPLUS
	required_reagents = list(REAGENT_CAPSAICIN = 2)
	catalysts = list(REAGENT_ENZYME = 5)
	result_amount = 1

/datum/chemical_reaction/coolant
	result = REAGENT_COOLANT
	required_reagents = list(REAGENT_TUNGSTEN = 1, REAGENT_ACETONE = 1, REAGENT_WATER = 1)
	result_amount = 3
	log_is_important = 1

/datum/chemical_reaction/rezadone
	result = REAGENT_REZADONE
	required_reagents = list(REAGENT_CARPOTOXIN = 1, REAGENT_CRYPTOBIOLIN = 1, REAGENT_COPPER = 1)
	result_amount = 3

/datum/chemical_reaction/lexorin
	result = REAGENT_LEXORIN
	required_reagents = list(REAGENT_ENZYME = 1, REAGENT_HYDRAZINE = 1, REAGENT_AMMONIA = 1)
	result_amount = 3

/datum/chemical_reaction/methylphenidate
	result = REAGENT_METHYLPHENIDATE
	required_reagents = list(REAGENT_LSD = 1, REAGENT_HYDRAZINE = 1)
	result_amount = 3

/datum/chemical_reaction/citalopram
	result = REAGENT_CITALOPRAM
	required_reagents = list(REAGENT_LSD = 1, REAGENT_CARBON = 1)
	result_amount = 3


/datum/chemical_reaction/paroxetine
	result = REAGENT_PAROXETINE
	required_reagents = list(REAGENT_LSD = 1, REAGENT_ACETONE = 1, REAGENT_ADRENALINE = 1)
	result_amount = 3

/* Solidification */
/datum/chemical_reaction/plastication
	result = null
	required_reagents = list(REAGENT_POLYACID = 1, REAGENT_PLASTICIDE = 2)
	result_amount = 1
	product_name = "Plastic"

/datum/chemical_reaction/plastication/on_reaction(var/datum/reagents/holder, var/created_volume)
	new /obj/item/stack/material/plastic(get_turf(holder.my_atom), created_volume)
	return

/* Grenade reactions */

/datum/chemical_reaction/explosion_potassium
	result = null
	required_reagents = list(REAGENT_WATER = 1, REAGENT_POTASSIUM = 1)
	result_amount = 2
	mix_message = null
	reaction_rate = HALF_LIFE(0)
	product_name = "Potassium-Water Explosion"

/datum/chemical_reaction/explosion_potassium/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/datum/effect/system/reagents_explosion/e = new()
	e.set_up(round (created_volume/10, 1), holder.my_atom, 0, 0)
	if(isliving(holder.my_atom))
		e.amount *= 0.5
		var/mob/living/L = holder.my_atom
		if(L.stat != DEAD)
			e.amount *= 0.5
	e.start()
	holder.clear_reagents()
	return

/datum/chemical_reaction/flash_powder
	result = null
	required_reagents = list(REAGENT_ALUMINIUM = 1, REAGENT_POTASSIUM = 1, REAGENT_SULFUR = 1 )
	result_amount = null
	reaction_rate = HALF_LIFE(0)
	product_name = "Flash Powder"

/datum/chemical_reaction/flash_powder/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/location = get_turf(holder.my_atom)
	var/datum/effect/system/spark_spread/s = new /datum/effect/system/spark_spread
	s.set_up(2, 1, location)
	s.start()
	for(var/mob/living/carbon/M in viewers(world.view, location))
		switch(get_dist(M, location))
			if(0 to 3)
				if(hasvar(M, "glasses"))
					if(istype(M:glasses, /obj/item/clothing/glasses/sunglasses))
						continue

				M.flash_eyes()
				M.Weaken(15)

			if(4 to 5)
				if(hasvar(M, "glasses"))
					if(istype(M:glasses, /obj/item/clothing/glasses/sunglasses))
						continue

				M.flash_eyes()
				M.Stun(5)

/datum/chemical_reaction/emp_pulse
	result = null
	required_reagents = list(REAGENT_URANIUM = 1, REAGENT_IRON = 1) // Yes, laugh, it's the best recipe I could think of that makes a little bit of sense
	result_amount = 2
	product_name = "Electromagnetic Pulse"

/datum/chemical_reaction/emp_pulse/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/location = get_turf(holder.my_atom)
	// 100 created volume = 4 heavy range & 7 light range. A few tiles smaller than traitor EMP grandes.
	// 200 created volume = 8 heavy range & 14 light range. 4 tiles larger than traitor EMP grenades.
	empulse(location, round(created_volume / 24), round(created_volume / 14), 1)
	holder.clear_reagents()
	return

/datum/chemical_reaction/nitroglycerin
	result = REAGENT_NITROGLYCERIN
	required_reagents = list(REAGENT_GLYCEROL = 1, REAGENT_POLYACID = 1, REAGENT_SULFURIC_ACID = 1)
	result_amount = 2
	log_is_important = 1
	reaction_rate = HALF_LIFE(0)

/datum/chemical_reaction/nitroglycerin/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/datum/effect/system/reagents_explosion/e = new()
	e.set_up(round (created_volume/2, 1), holder.my_atom, 0, 0)
	if(isliving(holder.my_atom))
		e.amount *= 0.5
		var/mob/living/L = holder.my_atom
		if(L.stat!=DEAD)
			e.amount *= 0.5
	e.start()

	holder.clear_reagents()
	return

/datum/chemical_reaction/napalm
	result = null
	required_reagents = list(REAGENT_ALUMINIUM = 1, REAGENT_ENZYME = 1, REAGENT_SULFURIC_ACID = 1 )
	result_amount = 1
	product_name = "Napalm"

/datum/chemical_reaction/napalm/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/turf/location = get_turf(holder.my_atom.loc)
	for(var/turf/simulated/floor/target_tile in range(0,location))
		target_tile.assume_gas(MATERIAL_FUEL, created_volume, 400+T0C)
		spawn (0) target_tile.hotspot_expose(700, 400)
	return

/datum/chemical_reaction/chemsmoke
	result = null
	required_reagents = list(REAGENT_POTASSIUM = 1, REAGENT_SUGAR = 1, REAGENT_PHOSPHORUS = 1)
	result_amount = 0.4
	reaction_rate = HALF_LIFE(0) //need to process everything at once for the smoke strength calculation to work
	product_name = "Chemical Smoke"

/datum/chemical_reaction/chemsmoke/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/location = get_turf(holder.my_atom)
	var/datum/effect/system/smoke_spread/chem/S = new /datum/effect/system/smoke_spread/chem
	S.attach(location)
	S.set_up(holder, created_volume, 0, location)
	playsound(location, 'sound/effects/smoke.ogg', 50, 1, -3)
	spawn(0)
		S.start()
	holder.clear_reagents()
	return

/datum/chemical_reaction/foam
	result = null
	required_reagents = list(REAGENT_SURFACTANT = 1, REAGENT_WATER = 1)
	result_amount = 2
	mix_message = "The solution violently bubbles!"
	reaction_rate = HALF_LIFE(0)
	product_name = "Foam"

/datum/chemical_reaction/foam/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/location = get_turf(holder.my_atom)

	for(var/mob/M in viewers(5, location))
		M << "<span class='warning'>The solution spews out foam!</span>"

	var/datum/effect/system/foam_spread/s = new()
	s.set_up(n = created_volume, loc = location, carry = holder, metalfoam = 0)
	s.start()
	holder.clear_reagents()
	return

/datum/chemical_reaction/metalfoam
	result = null
	required_reagents = list(REAGENT_ALUMINIUM = 3, REAGENT_FOAMING = 1, REAGENT_POLYACID = 1)
	result_amount = 5
	reaction_rate = HALF_LIFE(0)
	product_name = "Metal Foam"

/datum/chemical_reaction/metalfoam/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/location = get_turf(holder.my_atom)

	for(var/mob/M in viewers(5, location))
		M << "<span class='warning'>The solution spews out a metalic foam!</span>"

	var/datum/effect/system/foam_spread/s = new()
	s.set_up(n = created_volume, loc = location, carry = holder, metalfoam = 1)
	s.start()
	return

/datum/chemical_reaction/ironfoam
	result = null
	required_reagents = list(REAGENT_IRON = 3, REAGENT_FOAMING = 1, REAGENT_POLYACID = 1)
	result_amount = 5
	reaction_rate = HALF_LIFE(0)
	product_name = "Iron Foam"

/datum/chemical_reaction/ironfoam/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/location = get_turf(holder.my_atom)

	for(var/mob/M in viewers(5, location))
		M << "<span class='warning'>The solution spews out a metalic foam!</span>"

	var/datum/effect/system/foam_spread/s = new()
	s.set_up(n = created_volume, loc = location, carry = holder, metalfoam = 2)
	s.start()
	return

/* Paint */

/datum/chemical_reaction/red_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_CRAYON_D_RED = 1)
	result_amount = 5

/datum/chemical_reaction/red_paint/send_data()
	return "#FE191A"

/datum/chemical_reaction/orange_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_CRAYON_D_ORANGE = 1)
	result_amount = 5

/datum/chemical_reaction/orange_paint/send_data()
	return "#FFBE4F"

/datum/chemical_reaction/yellow_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_CRAYON_D_YELLOW = 1)
	result_amount = 5

/datum/chemical_reaction/yellow_paint/send_data()
	return "#FDFE7D"

/datum/chemical_reaction/green_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_CRAYON_D_GREEN = 1)
	result_amount = 5

/datum/chemical_reaction/green_paint/send_data()
	return "#18A31A"

/datum/chemical_reaction/blue_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_CRAYON_D_BLUE = 1)
	result_amount = 5

/datum/chemical_reaction/blue_paint/send_data()
	return "#247CFF"

/datum/chemical_reaction/purple_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_CRAYON_D_PURPLE = 1)
	result_amount = 5

/datum/chemical_reaction/purple_paint/send_data()
	return "#CC0099"

/datum/chemical_reaction/grey_paint //mime
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_CRAYON_D_GREY = 1)
	result_amount = 5

/datum/chemical_reaction/grey_paint/send_data()
	return "#808080"

/datum/chemical_reaction/brown_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_CRAYON_D_BROWN = 1)
	result_amount = 5

/datum/chemical_reaction/brown_paint/send_data()
	return "#846F35"

/datum/chemical_reaction/blood_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_BLOOD = 2)
	result_amount = 5

/datum/chemical_reaction/blood_paint/send_data(var/datum/reagents/T)
	var/t = T.get_data(REAGENT_BLOOD)
	if(t && t["blood_colour"])
		return t["blood_colour"]
	return "#FE191A" // Probably red

/datum/chemical_reaction/milk_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_MILK = 5)
	result_amount = 5

/datum/chemical_reaction/milk_paint/send_data()
	return "#F0F8FF"

/datum/chemical_reaction/orange_juice_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_ORANGE_JUICE = 5)
	result_amount = 5

/datum/chemical_reaction/orange_juice_paint/send_data()
	return "#E78108"

/datum/chemical_reaction/tomato_juice_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_TOMATO_JUICE = 5)
	result_amount = 5

/datum/chemical_reaction/tomato_juice_paint/send_data()
	return "#731008"

/datum/chemical_reaction/lime_juice_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_LIME_JUICE = 5)
	result_amount = 5

/datum/chemical_reaction/lime_juice_paint/send_data()
	return "#365E30"

/datum/chemical_reaction/carrot_juice_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_CARROT_JUICE = 5)
	result_amount = 5

/datum/chemical_reaction/carrot_juice_paint/send_data()
	return "#973800"

/datum/chemical_reaction/berry_juice_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_BERRY_JUICE = 5)
	result_amount = 5

/datum/chemical_reaction/berry_juice_paint/send_data()
	return "#990066"

/datum/chemical_reaction/grape_juice_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_GRAPE_JUICE = 5)
	result_amount = 5

/datum/chemical_reaction/grape_juice_paint/send_data()
	return "#863333"

/datum/chemical_reaction/poisonberry_juice_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_POISON_BERRY = 5)
	result_amount = 5

/datum/chemical_reaction/poisonberry_juice_paint/send_data()
	return "#863353"

/datum/chemical_reaction/watermelon_juice_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_WATERMELONJUICE = 5)
	result_amount = 5

/datum/chemical_reaction/watermelon_juice_paint/send_data()
	return "#B83333"

/datum/chemical_reaction/lemon_juice_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_LEMON_JUICE = 5)
	result_amount = 5

/datum/chemical_reaction/lemon_juice_paint/send_data()
	return "#AFAF00"

/datum/chemical_reaction/banana_juice_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_BANANA = 5)
	result_amount = 5

/datum/chemical_reaction/banana_juice_paint/send_data()
	return "#C3AF00"

/datum/chemical_reaction/potato_juice_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, "potatojuice" = 5)
	result_amount = 5

/datum/chemical_reaction/potato_juice_paint/send_data()
	return "#302000"

/datum/chemical_reaction/carbon_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_CARBON = 1)
	result_amount = 5

/datum/chemical_reaction/carbon_paint/send_data()
	return "#333333"

/datum/chemical_reaction/aluminum_paint
	result = REAGENT_PAINT
	required_reagents = list(REAGENT_PLASTICIDE = 1, REAGENT_WATER = 3, REAGENT_ALUMINIUM = 1)
	result_amount = 5

/datum/chemical_reaction/aluminum_paint/send_data()
	return "#F0F8FF"

/datum/chemical_reaction/soap_key
	result = null
	required_reagents = list(REAGENT_FROSTOIL = 2, REAGENT_CLEANER = 5)
	var/strength = 3
	product_name = "Soap Key"

/datum/chemical_reaction/soap_key/can_happen(var/datum/reagents/holder)
	if(holder.my_atom && istype(holder.my_atom, /obj/item/soap))
		return ..()
	return 0

/datum/chemical_reaction/soap_key/on_reaction(var/datum/reagents/holder)
	var/obj/item/soap/S = holder.my_atom
	if(S.key_data)
		var/obj/item/key/soap/key = new(get_turf(holder.my_atom), S.key_data)
		key.uses = strength
	..()

/* Food */

/datum/chemical_reaction/tofu
	result = null
	required_reagents = list(REAGENT_SOYMILK = 10)
	catalysts = list(REAGENT_ENZYME = 5)
	result_amount = 1
	product_name = "Tofu"

/datum/chemical_reaction/tofu/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/reagent_containers/food/snacks/tofu(location)
	return

/datum/chemical_reaction/chocolate_bar
	result = null
	required_reagents = list(REAGENT_SOYMILK = 2, REAGENT_COCOA = 2, REAGENT_SUGAR = 2)
	result_amount = 1
	product_name = "Soy Chocolate"

/datum/chemical_reaction/chocolate_bar/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/reagent_containers/food/snacks/chocolatebar(location)
	return

/datum/chemical_reaction/chocolate_bar2
	result = null
	required_reagents = list(REAGENT_MILK = 2, REAGENT_COCOA = 2, REAGENT_SUGAR = 2)
	result_amount = 1
	product_name = "Dairy Chocolate"

/datum/chemical_reaction/chocolate_bar2/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/reagent_containers/food/snacks/chocolatebar(location)
	return

/datum/chemical_reaction/hot_coco
	result = REAGENT_HOT_COCOA
	required_reagents = list(REAGENT_WATER = 5, REAGENT_COCOA = 1)
	result_amount = 5

/datum/chemical_reaction/soysauce
	result = REAGENT_SOYSAUCE
	required_reagents = list(REAGENT_SOYMILK = 4, REAGENT_SULFURIC_ACID = 1)
	result_amount = 5

/datum/chemical_reaction/ketchup
	result = REAGENT_KETCHUP
	required_reagents = list(REAGENT_TOMATO_JUICE = 2, REAGENT_WATER = 1, REAGENT_SUGAR = 1)
	result_amount = 4

/datum/chemical_reaction/cheesewheel
	result = null
	required_reagents = list(REAGENT_MILK = 40)
	catalysts = list(REAGENT_ENZYME = 5)
	result_amount = 1
	product_name = "Cheese Wheel"

/datum/chemical_reaction/cheesewheel/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/reagent_containers/food/snacks/sliceable/cheesewheel(location)
	return

/datum/chemical_reaction/meatball
	result = null
	required_reagents = list(REAGENT_PROTEIN = 3, REAGENT_FLOUR = 5)
	result_amount = 3
	product_name = "Meatball"

/datum/chemical_reaction/meatball/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/reagent_containers/food/snacks/meatball(location)
	return

/datum/chemical_reaction/dough
	result = null
	required_reagents = list(REAGENT_EGG = 3, REAGENT_FLOUR = 10, REAGENT_WATER = 5)
	result_amount = 1
	product_name = "Dough"

/datum/chemical_reaction/dough/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/reagent_containers/food/snacks/dough(location)
	return

/datum/chemical_reaction/syntiflesh
	result = null
	required_reagents = list(REAGENT_BLOOD = 5, REAGENT_CLONEXADONE = 1)
	result_amount = 1
	product_name = "Synthiflesh"

/datum/chemical_reaction/syntiflesh/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/reagent_containers/food/snacks/meat/syntiflesh(location)
	return

/datum/chemical_reaction/hot_ramen
	result = REAGENT_HOT_RAMEN
	required_reagents = list(REAGENT_WATER = 1, REAGENT_DRY_RAMEN = 3)
	result_amount = 3

/datum/chemical_reaction/hell_ramen
	result = REAGENT_HELL_RAMEN
	required_reagents = list(REAGENT_CAPSAICIN = 1, REAGENT_HOT_RAMEN = 6)
	result_amount = 6

/* Alcohol */

/datum/chemical_reaction/goldschlager
	result = REAGENT_GOLDSCHLAGER
	required_reagents = list(REAGENT_VODKA = 10, REAGENT_GOLD = 1)
	result_amount = 10

/datum/chemical_reaction/patron
	result = REAGENT_PATRON
	required_reagents = list(REAGENT_TEQUILLA = 10, REAGENT_SILVER = 1)
	result_amount = 10

/datum/chemical_reaction/bilk
	result = REAGENT_BILK
	required_reagents = list(REAGENT_MILK = 1, REAGENT_BEER = 1)
	result_amount = 2

/datum/chemical_reaction/icetea
	result = REAGENT_ICETEA
	required_reagents = list(REAGENT_ICE = 1, REAGENT_TEA = 2)
	result_amount = 3

/datum/chemical_reaction/icecoffee
	result = REAGENT_ICED_COFFEE
	required_reagents = list(REAGENT_ICE = 1, REAGENT_COFFEE = 2)
	result_amount = 3

/datum/chemical_reaction/nuka_cola
	result = REAGENT_NUKA_COLA
	required_reagents = list(REAGENT_URANIUM = 1, REAGENT_COLA = 5)
	result_amount = 5

/datum/chemical_reaction/moonshine
	result = REAGENT_MOONSHINE
	required_reagents = list(REAGENT_NUTRIMENT = 10)
	catalysts = list(REAGENT_ENZYME = 5)
	result_amount = 10

/datum/chemical_reaction/grenadine
	result = REAGENT_GRENADINE
	required_reagents = list(REAGENT_BERRY_JUICE = 10)
	catalysts = list(REAGENT_ENZYME = 5)
	result_amount = 10

/datum/chemical_reaction/wine
	result = REAGENT_WINE
	required_reagents = list(REAGENT_GRAPE_JUICE = 10)
	catalysts = list(REAGENT_ENZYME = 5)
	result_amount = 10

/datum/chemical_reaction/pwine
	result = REAGENT_POISON_WINE
	required_reagents = list(REAGENT_POISON_BERRY = 10)
	catalysts = list(REAGENT_ENZYME = 5)
	result_amount = 10

/datum/chemical_reaction/melonliquor
	result = REAGENT_MELON_LIQUOR
	required_reagents = list(REAGENT_WATERMELONJUICE = 10)
	catalysts = list(REAGENT_ENZYME = 5)
	result_amount = 10

/datum/chemical_reaction/bluecuracao
	result = REAGENT_BLUE_CURACAO
	required_reagents = list(REAGENT_ORANGE_JUICE = 10)
	catalysts = list(REAGENT_ENZYME = 5)
	result_amount = 10

/datum/chemical_reaction/spacebeer
	result = REAGENT_BEER
	required_reagents = list(REAGENT_CORNOIL = 10)
	catalysts = list(REAGENT_ENZYME = 5)
	result_amount = 10

/datum/chemical_reaction/vodka
	result = REAGENT_VODKA
	required_reagents = list(REAGENT_POTATO = 10)
	catalysts = list(REAGENT_ENZYME = 5)
	result_amount = 10

/datum/chemical_reaction/sake
	result = REAGENT_SAKE
	required_reagents = list(REAGENT_RICE = 10)
	catalysts = list(REAGENT_ENZYME = 5)
	result_amount = 10

/datum/chemical_reaction/kahlua
	result = REAGENT_KAHLUA
	required_reagents = list(REAGENT_COFFEE = 5, REAGENT_SUGAR = 5)
	catalysts = list(REAGENT_ENZYME = 5)
	result_amount = 5

/datum/chemical_reaction/gin_tonic
	result = REAGENT_GIN_TONIC
	required_reagents = list(REAGENT_GIN = 2, REAGENT_TONIC = 1)
	result_amount = 3

/datum/chemical_reaction/cuba_libre
	result = REAGENT_CUBA_LIBRE
	required_reagents = list(REAGENT_RUM = 2, REAGENT_COLA = 1)
	result_amount = 3

/datum/chemical_reaction/martini
	result = REAGENT_MARTINI
	required_reagents = list(REAGENT_GIN = 2, REAGENT_VERMOUTH = 1)
	result_amount = 3

/datum/chemical_reaction/vodkamartini
	result = REAGENT_VODKA_MARTINI
	required_reagents = list(REAGENT_VODKA = 2, REAGENT_VERMOUTH = 1)
	result_amount = 3

/datum/chemical_reaction/white_russian
	result = REAGENT_WHITE_RUSSIAN
	required_reagents = list(REAGENT_BLACK_RUSSIAN = 2, REAGENT_CREAM = 1)
	result_amount = 3

/datum/chemical_reaction/whiskey_cola
	result = REAGENT_WHISKEY_COLA
	required_reagents = list(REAGENT_WHISKEY = 2, REAGENT_COLA = 1)
	result_amount = 3

/datum/chemical_reaction/screwdriver
	result = REAGENT_SCREWDRIVER
	required_reagents = list(REAGENT_VODKA = 2, REAGENT_ORANGE_JUICE = 1)
	result_amount = 3

/datum/chemical_reaction/bloody_mary
	result = REAGENT_BLOODY_MARY
	required_reagents = list(REAGENT_VODKA = 2, REAGENT_TOMATO_JUICE = 3, REAGENT_LIME_JUICE = 1)
	result_amount = 6

/datum/chemical_reaction/gargle_blaster
	result = REAGENT_GARGLEBLASTER
	required_reagents = list(REAGENT_VODKA = 2, REAGENT_GIN = 1, REAGENT_WHISKEY = 1, REAGENT_COGNAC = 1, REAGENT_LIME_JUICE = 1)
	result_amount = 6

/datum/chemical_reaction/brave_bull
	result = REAGENT_BRAVE_BULL
	required_reagents = list(REAGENT_TEQUILLA = 2, REAGENT_KAHLUA = 1)
	result_amount = 3

/datum/chemical_reaction/tequilla_sunrise
	result = REAGENT_TEQUILLA_SUNRISE
	required_reagents = list(REAGENT_TEQUILLA = 2, REAGENT_ORANGE_JUICE = 1)
	result_amount = 3

/datum/chemical_reaction/toxins_special
	result = REAGENT_TOXINS_SPECIAL
	required_reagents = list(REAGENT_RUM = 2, REAGENT_VERMOUTH = 2, REAGENT_FUEL = 2)
	result_amount = 6

/datum/chemical_reaction/beepsky_smash
	result = REAGENT_BEEPSKY_SMASH
	required_reagents = list(REAGENT_LIME_JUICE = 1, REAGENT_WHISKEY = 1, REAGENT_IRON = 1)
	result_amount = 2

/datum/chemical_reaction/irish_cream
	result = REAGENT_IRISH_CREAM
	required_reagents = list(REAGENT_WHISKEY = 2, REAGENT_CREAM = 1)
	result_amount = 3

/datum/chemical_reaction/manly_dorf
	result = REAGENT_MANLY_DORF
	required_reagents = list (REAGENT_BEER = 1, REAGENT_ALE = 2)
	result_amount = 3

/datum/chemical_reaction/hooch
	result = REAGENT_HOOCH
	required_reagents = list (REAGENT_SUGAR = 1, REAGENT_ETHANOL = 2, REAGENT_FUEL = 1)
	result_amount = 3

/datum/chemical_reaction/irish_coffee
	result = REAGENT_IRISH_COFFEE
	required_reagents = list(REAGENT_IRISH_CREAM = 1, REAGENT_COFFEE = 1)
	result_amount = 2

/datum/chemical_reaction/b52
	result = REAGENT_B52
	required_reagents = list(REAGENT_IRISH_CREAM = 1, REAGENT_KAHLUA = 1, REAGENT_COGNAC = 1)
	result_amount = 3

/datum/chemical_reaction/atomicbomb
	result = REAGENT_ATOMIC_BOMB
	required_reagents = list(REAGENT_B52 = 10, REAGENT_URANIUM = 1)
	result_amount = 10

/datum/chemical_reaction/margarita
	result = REAGENT_MARGARITA
	required_reagents = list(REAGENT_TEQUILLA = 2, REAGENT_LIME_JUICE = 1)
	result_amount = 3

/datum/chemical_reaction/icedtea
	result = REAGENT_LONG_ISLAND
	required_reagents = list(REAGENT_VODKA = 1, REAGENT_GIN = 1, REAGENT_TEQUILLA = 1, REAGENT_CUBA_LIBRE = 3)
	result_amount = 6

/datum/chemical_reaction/threemileisland
	result = REAGENT_THREE_MILE_ISLAND
	required_reagents = list(REAGENT_LONG_ISLAND = 10, REAGENT_URANIUM = 1)
	result_amount = 10

/datum/chemical_reaction/whiskeysoda
	result = REAGENT_WHISKEY_SODA
	required_reagents = list(REAGENT_WHISKEY = 2, REAGENT_SODAWATER = 1)
	result_amount = 3

/datum/chemical_reaction/black_russian
	result = REAGENT_BLACK_RUSSIAN
	required_reagents = list(REAGENT_VODKA = 2, REAGENT_KAHLUA = 1)
	result_amount = 3

/datum/chemical_reaction/manhattan
	result = REAGENT_MANHATTAN
	required_reagents = list(REAGENT_WHISKEY = 2, REAGENT_VERMOUTH = 1)
	result_amount = 3

/datum/chemical_reaction/manhattan_proj
	result = REAGENT_MANHATTAN_PROJECT
	required_reagents = list(REAGENT_MANHATTAN = 10, REAGENT_URANIUM = 1)
	result_amount = 10

/datum/chemical_reaction/vodka_tonic
	result = REAGENT_VODKA_TONIC
	required_reagents = list(REAGENT_VODKA = 2, REAGENT_TONIC = 1)
	result_amount = 3

/datum/chemical_reaction/gin_fizz
	result = REAGENT_GIN_FIZZ
	required_reagents = list(REAGENT_GIN = 1, REAGENT_SODAWATER = 1, REAGENT_LIME_JUICE = 1)
	result_amount = 3

/datum/chemical_reaction/bahama_mama
	result = REAGENT_BAHAMA_MAMA
	required_reagents = list(REAGENT_RUM = 2, REAGENT_ORANGE_JUICE = 2, REAGENT_LIME_JUICE = 1, REAGENT_ICE = 1)
	result_amount = 6

/datum/chemical_reaction/singulo
	result = REAGENT_SINGULO
	required_reagents = list(REAGENT_VODKA = 5, REAGENT_RADIUM = 1, REAGENT_WINE = 5)
	result_amount = 10

/datum/chemical_reaction/alliescocktail
	result = REAGENT_ALLIES_COCKTAIL
	required_reagents = list(REAGENT_VODKA_MARTINI = 1, REAGENT_VODKA = 1)
	result_amount = 2

/datum/chemical_reaction/demonsblood
	result = REAGENT_DEMONS_BLOOD
	required_reagents = list(REAGENT_RUM = 3, REAGENT_CITRUS_SODA = 1, REAGENT_BLOOD = 1, REAGENT_CHERRY_COLA = 1)
	result_amount = 6

/datum/chemical_reaction/booger
	result = REAGENT_BOOGER
	required_reagents = list(REAGENT_CREAM = 2, REAGENT_BANANA = 1, REAGENT_RUM = 1, REAGENT_WATERMELONJUICE = 1)
	result_amount = 5

/datum/chemical_reaction/antifreeze
	result = REAGENT_ANTIFREEZE
	required_reagents = list(REAGENT_VODKA = 1, REAGENT_CREAM = 1, REAGENT_ICE = 1)
	result_amount = 3

/datum/chemical_reaction/grapesoda
	result = REAGENT_GRAPE_SODA
	required_reagents = list(REAGENT_GRAPE_JUICE = 2, REAGENT_COLA = 1)
	result_amount = 3

/datum/chemical_reaction/sbiten
	result = REAGENT_SBITEN
	required_reagents = list(REAGENT_MEAD = 10, REAGENT_CAPSAICIN = 1)
	result_amount = 10

/datum/chemical_reaction/red_mead
	result = REAGENT_RED_MEAD
	required_reagents = list(REAGENT_BLOOD = 1, REAGENT_MEAD = 1)
	result_amount = 2

/datum/chemical_reaction/mead
	result = REAGENT_MEAD
	required_reagents = list(REAGENT_SUGAR = 1, REAGENT_WATER = 1)
	catalysts = list(REAGENT_ENZYME = 5)
	result_amount = 2

/datum/chemical_reaction/iced_beer
	result = REAGENT_ICED_BEER
	required_reagents = list(REAGENT_BEER = 5, REAGENT_ICE = 1)
	result_amount = 6

/datum/chemical_reaction/grog
	result = REAGENT_GROG
	required_reagents = list(REAGENT_RUM = 1, REAGENT_WATER = 1)
	result_amount = 2

/datum/chemical_reaction/soy_latte
	result = REAGENT_SOY_LATTE
	required_reagents = list(REAGENT_COFFEE = 1, REAGENT_SOYMILK = 1)
	result_amount = 2

/datum/chemical_reaction/cafe_latte
	result = REAGENT_CAFE_LATTE
	required_reagents = list(REAGENT_COFFEE = 1, REAGENT_MILK = 1)
	result_amount = 2

/datum/chemical_reaction/acidspit
	result = REAGENT_ACID_SPIT
	required_reagents = list(REAGENT_SULFURIC_ACID = 1, REAGENT_WINE = 5)
	result_amount = 6

/datum/chemical_reaction/amasec
	result = REAGENT_AMASEC
	required_reagents = list(REAGENT_IRON = 1, REAGENT_WINE = 5, REAGENT_VODKA = 5)
	result_amount = 10

/datum/chemical_reaction/changelingsting
	result = REAGENT_CHANGELING_STING
	required_reagents = list(REAGENT_SCREWDRIVER = 1, REAGENT_LIME_JUICE = 1, REAGENT_LEMON_JUICE = 1)
	result_amount = 3

/datum/chemical_reaction/aloe
	result = REAGENT_ALOE
	required_reagents = list(REAGENT_CREAM = 1, REAGENT_WHISKEY = 1, REAGENT_WATERMELONJUICE = 1)
	result_amount = 3

/datum/chemical_reaction/andalusia
	result = REAGENT_ANDALUSIA
	required_reagents = list(REAGENT_RUM = 1, REAGENT_WHISKEY = 1, REAGENT_LEMON_JUICE = 1)
	result_amount = 3

/datum/chemical_reaction/neurotoxin
	result = REAGENT_NEUROTOXIN
	required_reagents = list(REAGENT_GARGLEBLASTER = 1, REAGENT_SLEEPTOXIN = 1)
	result_amount = 2

/datum/chemical_reaction/snowwhite
	result = REAGENT_SNOW_WHITE
	required_reagents = list(REAGENT_BEER = 1, REAGENT_LEMON_LIME = 1)
	result_amount = 2

/datum/chemical_reaction/irishcarbomb
	result = REAGENT_IRISH_CAR_BOMB
	required_reagents = list(REAGENT_ALE = 1, REAGENT_IRISH_CREAM = 1)
	result_amount = 2

/datum/chemical_reaction/syndicatebomb
	result = REAGENT_SYNDICATE_BOMB
	required_reagents = list(REAGENT_BEER = 1, REAGENT_WHISKEY_COLA = 1)
	result_amount = 2

/datum/chemical_reaction/erikasurprise
	result = REAGENT_ERIKA_SURPRISE
	required_reagents = list(REAGENT_ALE = 2, REAGENT_LIME_JUICE = 1, REAGENT_WHISKEY = 1, REAGENT_BANANA = 1, REAGENT_ICE = 1)
	result_amount = 6

/datum/chemical_reaction/devilskiss
	result = REAGENT_DEVILS_KISS
	required_reagents = list(REAGENT_BLOOD = 1, REAGENT_KAHLUA = 1, REAGENT_RUM = 1)
	result_amount = 3

/datum/chemical_reaction/hippiesdelight
	result = REAGENT_HIPPIES_DELIGHT
	required_reagents = list(REAGENT_PSYLOCYBIN = 1, REAGENT_GARGLEBLASTER = 1)
	result_amount = 2

/datum/chemical_reaction/bananahonk
	result = REAGENT_BANANA_HONK
	required_reagents = list(REAGENT_BANANA = 1, REAGENT_CREAM = 1, REAGENT_SUGAR = 1)
	result_amount = 3

/datum/chemical_reaction/lemonade
	result = REAGENT_LEMONADE
	required_reagents = list(REAGENT_LEMON_JUICE = 1, REAGENT_SUGAR = 1, REAGENT_WATER = 1)
	result_amount = 3

/datum/chemical_reaction/kiraspecial
	result = REAGENT_KIRA_SPECIAL
	required_reagents = list(REAGENT_ORANGE_JUICE = 1, REAGENT_LIME_JUICE = 1, REAGENT_SODAWATER = 1)
	result_amount = 3

/datum/chemical_reaction/brownstar
	result = REAGENT_BROWN_STAR
	required_reagents = list(REAGENT_ORANGE_JUICE = 2, REAGENT_COLA = 1)
	result_amount = 3

/datum/chemical_reaction/milkshake
	result = REAGENT_MILKSHAKE
	required_reagents = list(REAGENT_CREAM = 1, REAGENT_ICE = 2, REAGENT_MILK = 2)
	result_amount = 5

/datum/chemical_reaction/rewriter
	result = REAGENT_REWRITER
	required_reagents = list(REAGENT_CITRUS_SODA = 1, REAGENT_COFFEE = 1)
	result_amount = 2

/datum/chemical_reaction/suidream
	result = REAGENT_SUI_DREAM
	required_reagents = list(REAGENT_LEMONADE = 1, REAGENT_BLUE_CURACAO = 1, REAGENT_MELON_LIQUOR = 1)
	result_amount = 3

/datum/chemical_reaction/luminol
	result = REAGENT_LUMINOL
	required_reagents = list(REAGENT_HYDRAZINE = 2, REAGENT_CARBON = 2, REAGENT_AMMONIA = 2)
	result_amount = 6

/datum/chemical_reaction/eggnog
	result = REAGENT_EGGNOG
	required_reagents = list(REAGENT_MILK = 2, REAGENT_CREAM = 2, REAGENT_EGG = 3, REAGENT_SUGAR = 1)
	result_amount = 8
