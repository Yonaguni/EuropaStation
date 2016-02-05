/* Food */

/datum/reagent/nutriment
	name = "Nutriment"
	id = "nutriment"
	description = "All the vitamins, minerals, and carbohydrates the body needs in pure form."
	reagent_state = SOLID
	metabolism = REM * 4
	var/nutriment_factor = 30 // Per unit
	var/injectable = 0
	color = "#664330"

/datum/reagent/nutriment/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(!injectable)
		M.adjustToxLoss(0.1 * removed)
		return
	affect_ingest(M, alien, removed)

/datum/reagent/nutriment/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	M.nutrition += nutriment_factor * removed
	M.add_chemical_effect(CE_BLOODRESTORE, 4 * removed)

/datum/reagent/nutriment/protein // Bad for Skrell!
	name = "animal protein"
	id = "protein"
	color = "#440000"

/datum/reagent/nutriment/protein/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien && alien == IS_SKRELL)
		M.adjustToxLoss(0.5 * removed)
		return
	..()

/datum/reagent/nutriment/protein/egg
	name = "egg yolk"
	id = "egg"
	color = "#FFFFAA"

/datum/reagent/nutriment/honey
	name = "Honey"
	id = "honey"
	description = "A golden yellow syrup, loaded with sugary sweetness."
	nutriment_factor = 10
	color = "#FFFF00"

/datum/reagent/nutriment/flour
	name = "flour"
	id = "flour"
	description = "This is what you rub all over yourself to pretend to be a ghost."
	reagent_state = SOLID
	nutriment_factor = 1
	color = "#FFFFFF"

/datum/reagent/nutriment/flour/touch_turf(var/turf/simulated/T)
	if(!istype(T, /turf/space))
		new /obj/effect/decal/cleanable/flour(T)

/datum/reagent/nutriment/coco
	name = "Coco Powder"
	id = "coco"
	description = "A fatty, bitter paste made from coco beans."
	reagent_state = SOLID
	nutriment_factor = 5
	color = "#302000"

/datum/reagent/nutriment/soysauce
	name = "Soysauce"
	id = "soysauce"
	description = "A salty sauce made from the soy plant."
	reagent_state = LIQUID
	nutriment_factor = 2
	color = "#792300"

/datum/reagent/nutriment/ketchup
	name = "Ketchup"
	id = "ketchup"
	description = "Ketchup, catsup, whatever. It's tomato paste."
	reagent_state = LIQUID
	nutriment_factor = 5
	color = "#731008"

/datum/reagent/nutriment/rice
	name = "Rice"
	id = "rice"
	description = "Enjoy the great taste of nothing."
	reagent_state = SOLID
	nutriment_factor = 1
	color = "#FFFFFF"

/datum/reagent/nutriment/sprinkles
	name = "Sprinkles"
	id = "sprinkles"
	description = "Multi-colored little bits of sugar, commonly found on donuts. Loved by cops."
	nutriment_factor = 1
	color = "#FF00FF"

/datum/reagent/nutriment/mint
	name = "Mint"
	id = "mint"
	description = "Also known as Mentha."
	reagent_state = LIQUID
	color = "#CF3600"


/datum/reagent/sodiumchloride
	name = "Table Salt"
	id = "sodiumchloride"
	description = "A salt made of sodium chloride. Commonly used to season food."
	reagent_state = SOLID
	color = "#FFFFFF"
	overdose = REAGENTS_OVERDOSE

/datum/reagent/blackpepper
	name = "Black Pepper"
	id = "blackpepper"
	description = "A powder ground from peppercorns. *AAAACHOOO*"
	reagent_state = SOLID
	color = "#000000"

/datum/reagent/enzyme
	name = "Universal Enzyme"
	id = "enzyme"
	description = "A universal enzyme used in the preperation of certain chemicals and foods."
	reagent_state = LIQUID
	color = "#365E30"
	overdose = REAGENTS_OVERDOSE

/datum/reagent/sugar
	name = "Sugar"
	id = "sugar"
	description = "The organic compound commonly known as table sugar and sometimes called saccharose. This white, odorless, crystalline powder has a pleasing, sweet taste."
	reagent_state = SOLID
	color = "#FFFFFF"
	glass_icon_state = "iceglass"
	glass_name = "glass of sugar"
	glass_desc = "The organic compound commonly known as table sugar and sometimes called saccharose. This white, odorless, crystalline powder has a pleasing, sweet taste."

/datum/reagent/sugar/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.nutrition += removed * 3

/datum/reagent/drink/dry_ramen
	name = "Dry Ramen"
	id = "dry_ramen"
	description = "Space age food, since August 25, 1958. Contains dried noodles, vegetables, and chemicals that boil in contact with water."
	reagent_state = SOLID
	nutrition = 1
	color = "#302000"

/datum/reagent/drink/hot_ramen
	name = "Hot Ramen"
	id = "hot_ramen"
	description = "The noodles are boiled, the flavors are artificial, just like being back in school."
	reagent_state = LIQUID
	color = "#302000"
	nutrition = 5
	adj_temp = 5

