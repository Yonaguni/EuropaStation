/* TODO: post-psychic power update:
	ALZ-113 -     lethal virus in humans, triggers latencies in monkeys
	Ephemerol -   buffs to psychic powers, hallucinations.
	Nexus -       buffs metaconcerts, makes vulnerable to coercion
	Accela -      mental enhancer
	Booster -     may trigger latencies, causes hallucinations
	Soy sauce -   endgame drug (JDATE), permanent psychological effects and powers
*/

/* TODO: post-aspect update:
	Lethe -       amnesiac/calmative - removes a range of aspects
	Azrael -      Boosts aspects, causes neurological damage.
*/

/* TODO at some point:
	Pasceline D - treat bone damage
	Quietus -     suicide drug
	Allswell -    calmative
	Drive -       combat stim, lethal overdose
	Gravy -       'A nano-drug for acclimating to high-gravity environments.'
	Kamikaze -    designer amphetamine
	Powerball -   mania, feral strength
	Slab -        ammonium chloride and radium. Lethal to humans.
	Stimutacs -   99% kelp, 1% fugu tetrodotoxin
	Monocane -   'render the recipient invisible, side effect of inducing insanity.'
	Tripwire -    synthetic drugs (for robots)
	Ultrazone -   synthetic drugs (for robots)
*/

/datum/reagent/lsd
	name = "LSD"
	id = "lsd"
	description = "A powerful hallucinogen, it can cause fatal effects in users."
	taste_description = "sourness"
	reagent_state = LIQUID
	color = "#B31008"
	metabolism = REM * 0.25
	overdose = REAGENTS_OVERDOSE

/datum/reagent/lsd/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	M.hallucination = max(M.hallucination, 100)

/datum/reagent/psilocybin
	name = "Psilocybin"
	id = "psilocybin"
	description = "A strong psychotropic derived from certain species of mushroom."
	taste_description = "mushroom"
	color = "#E700E7"
	overdose = REAGENTS_OVERDOSE
	metabolism = REM * 0.5

/datum/reagent/psilocybin/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	M.druggy = max(M.druggy, 30)

	if(dose < 1)
		M.apply_effect(3, STUTTER)
		M.make_dizzy(5)
		if(prob(5))
			M.emote(pick("twitch", "giggle"))
	else if(dose < 2)
		M.apply_effect(3, STUTTER)
		M.make_jittery(5)
		M.make_dizzy(5)
		M.druggy = max(M.druggy, 35)
		if(prob(10))
			M.emote(pick("twitch", "giggle"))
	else
		M.apply_effect(3, STUTTER)
		M.make_jittery(10)
		M.make_dizzy(10)
		M.druggy = max(M.druggy, 40)
		if(prob(15))
			M.emote(pick("twitch", "giggle"))

/datum/reagent/jumpstart
	name = "Jumpstart"
	id = "jumpstart"
	description = "Jumpstart is a highly effective, highly -illegal-, long-lasting muscle stimulant."
	taste_description = "acid"
	reagent_state = LIQUID
	color = "#FF3300"
	metabolism = REM * 0.15
	overdose = REAGENTS_OVERDOSE * 0.5

/datum/reagent/jumpstart/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	if(prob(5))
		M.emote(pick("twitch", "blink_r", "shiver"))
	M.add_chemical_effect(CE_SPEEDBOOST, 1)
	M.add_chemical_effect(CE_PULSE, 2)

/datum/reagent/redeye
	name = "Red Eye"
	id = "redeye"
	description = "Red Eye, named for the bloodshot eyes of users, is a potent cocktail of banned combat stimulants."
	taste_description = "copper"
	reagent_state = LIQUID
	color = "#DD0000"
	metabolism = REM * 0.15
	overdose = REAGENTS_OVERDOSE * 0.5

/datum/reagent/glint
	name = "Glint"
	id = "glint"
	description = "An illegal chemical compound used as drug."
	taste_description = "bitterness"
	taste_mult = 0.4
	reagent_state = LIQUID
	color = "#60A584"
	metabolism = REM * 0.15
	overdose = REAGENTS_OVERDOSE

/datum/reagent/glint/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	M.druggy = max(M.druggy, 15)
	if(prob(10) && isturf(M.loc) && !istype(M.loc, /turf/space) && M.canmove && !M.restrained())
		step(M, pick(cardinal))
	if(prob(7))
		M.emote(pick("twitch", "drool", "moan", "giggle"))
	M.add_chemical_effect(CE_PULSE, -1)

/datum/reagent/pax
	name = "Pax"
	id = "pax"
	description = "A powerful aggression supressant that may cause permanent neurological damage."
	taste_description = "nothing at all"
	taste_mult = 0.4
	reagent_state = LIQUID
	color = "#CCCCCC"
	metabolism = REM * 0.15
	overdose = REAGENTS_OVERDOSE

/datum/reagent/pax/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.a_intent = I_HELP
	M.add_chemical_effect(CE_LOCK_HELP, 1)

/datum/reagent/short
	name = "Short"
	id = "short"
	description = "A broad-spectrum antichemical agent which suppresses many other drugs."
	taste_description = "wax"
	reagent_state = LIQUID
	color = "#FFCCCC"
	metabolism = REM * 0.15

/datum/reagent/ladder
	name = "Ladder"
	id = "ladder"
	description = "A highly dangerous and powerful aggression enhancer originally developed for military use. Very illegal."
	taste_description = "acid"
	reagent_state = LIQUID
	color = "#FFCC00"
	metabolism = REM * 0.5

/datum/reagent/ladder/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.a_intent = I_HURT
	M.add_chemical_effect(CE_LOCK_HARM, 1)

/datum/reagent/threeeye
	name = "Three Eye"
	id = "threeeye"
	description = "A dangerously addictive neurotoxin-neurostimulator, rumoured to be capable of opening the third eye of the mind - perhaps permanently."
	taste_description = "starlight"
	reagent_state = LIQUID
	color = "#CCCCFF"
	metabolism = REM * 0.15

/datum/reagent/threeeye/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.add_chemical_effect(CE_THIRDEYE, 1)
