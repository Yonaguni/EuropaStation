/* Food */

/datum/reagent/nutriment
	name = REAGENT_ID_NUTRIMENT
	id = REAGENT_ID_NUTRIMENT
	metabolism = REM * 4
	nutriment_factor = 30 // Per unit
	color = "#664330"

/datum/reagent/nutriment/protein // Bad for Skrell!
	name = "animal protein"
	id = REAGENT_ID_PROTEIN
	color = "#440000"

/datum/reagent/nutriment/protein/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien && alien == IS_SKRELL)
		M.adjustToxLoss(0.5 * removed)
		return
	..()

/datum/reagent/nutriment/protein/milk
	name = "milk"
	id = REAGENT_ID_MILK
	color = "#FFFFF"

/datum/reagent/nutriment/protein/milk/cream
	name = "cream"
	id = REAGENT_ID_CREAM

/datum/reagent/nutriment/protein/egg
	name = "egg yolk"
	id = REAGENT_ID_EGG
	color = "#FFFFAA"

/datum/reagent/nutriment/honey
	name = "Honey"
	id = REAGENT_ID_HONEY
	nutriment_factor = 10
	color = "#FFFF00"

/datum/reagent/nutriment/flour
	name = "flour"
	id = REAGENT_ID_FLOUR
	nutriment_factor = 1
	color = "#FFFFFF"

/datum/reagent/nutriment/flour/touch_turf(var/turf/simulated/T)
	if(!istype(T, /turf/space))
		new /obj/effect/decal/cleanable/flour(T)

/datum/reagent/nutriment/coco
	name = "Coco Powder"
	id = REAGENT_ID_COCOA
	nutriment_factor = 5
	color = "#302000"

/datum/reagent/nutriment/soysauce
	name = "Soysauce"
	id = REAGENT_ID_SOYSAUCE
	nutriment_factor = 2
	color = "#792300"

/datum/reagent/nutriment/ketchup
	name = "Ketchup"
	id = REAGENT_ID_KETCHUP
	nutriment_factor = 5
	color = "#731008"

/datum/reagent/nutriment/rice
	name = "Rice"
	id = REAGENT_ID_RICE
	nutriment_factor = 1
	color = "#FFFFFF"

/datum/reagent/sodiumchloride
	name = "Table Salt"
	id = REAGENT_ID_SALT
	color = "#FFFFFF"
	overdose = REAGENTS_OVERDOSE

/datum/reagent/blackpepper
	name = "Black Pepper"
	id = REAGENT_ID_PEPPER
	color = "#000000"

/datum/reagent/gelatine
	name = "Gelatine"
	id = REAGENT_ID_GELATINE
	color = "#365E30"
	overdose = REAGENTS_OVERDOSE

/datum/reagent/enzyme
	name = "Universal Enzyme"
	id = REAGENT_ID_ENZYME
	color = "#365E30"
	overdose = REAGENTS_OVERDOSE

/datum/reagent/sugar
	name = "Sugar"
	id = REAGENT_ID_SUGAR
	color = "#FFFFFF"

/datum/reagent/sugar/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.nutrition += removed * 3

/datum/reagent/drink/lemonade
	name = "lemonade"
	id = REAGENT_ID_LEMONADE
	color = "#202800"

/datum/reagent/drink/cola
	name = "Cola"
	id = REAGENT_ID_COLA
	color = "#100800"
