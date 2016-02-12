/datum/reagent/alcohol
	name = "ethanol" //Parent class for all alcoholic reagents.
	id = REAGENT_ID_ETHANOL
	color = "#404030"
	touch_met = 5
	flammable = 1
	disinfectant = 1
	nutriment_factor = 0
	hydration_factor = 1
	toxic_blood = 2
	flammable = 1
	alcoholic = 10 // This is, essentially, units between stages - the lower, the stronger. Less fine tuning, more clarity.

/datum/reagent/alcohol/whiskey
	name = "whiskey"
	id = REAGENT_ID_WHISKEY
	color = "#664300"
	alcoholic = 25

/datum/reagent/alcohol/gin
	name = "gin"
	id = REAGENT_ID_GIN
	alcoholic = 50
	color = "#664300"

/datum/reagent/alcohol/vodka
	name = "vodka"
	id = REAGENT_ID_VODKA
	alcoholic = 15
	color = "#0064C8"

/datum/reagent/alcohol/tequilla
	name = "tequilla"
	id = REAGENT_ID_TEQUILlA
	alcoholic = 25
	color = "#FFFF91"

/datum/reagent/alcohol/rum
	name = "rum"
	id = REAGENT_ID_RUM
	alcoholic = 15
	color = "#664300"

/datum/reagent/alcohol/wine
	name = "wine"
	id = REAGENT_ID_WINE
	alcoholic = 15
	color = "#7E4043"

/datum/reagent/alcohol/absinthe
	name = "absinthe"
	id = REAGENT_ID_ABSINTHE
	alcoholic = 12
	color = "#33EE00"

/datum/reagent/alcohol/beer
	name = "beer"
	id = REAGENT_ID_BEER
	alcoholic = 50
	color = "#664300"
