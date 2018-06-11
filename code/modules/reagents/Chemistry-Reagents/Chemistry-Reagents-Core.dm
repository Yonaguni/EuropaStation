/datum/reagent/blood
	name = "blood"
	metabolism = REM * 5
	color = "#C80000"
	taste_description = "iron"
	taste_mult = 1.3
	glass_name = "tomato juice"
	glass_desc = "Are you sure this is tomato juice?"

/datum/reagent/blood/touch_turf(var/turf/simulated/T, var/datum/reagents/holder)
	if(istype(T) && holder.volumes[type] >= 3)
		blood_splatter(T, src, 1)

/datum/reagent/blood/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed, var/datum/reagents/holder)
	var/dose = holder.doses[type]
	if(dose > 5)
		M.adjustToxLoss(removed)
	if(dose > 15)
		M.adjustToxLoss(removed)

/datum/reagent/blood/affect_blood(var/mob/living/carbon/M, var/alien, var/removed, var/datum/reagents/holder)
	M.inject_blood(src, holder.volumes[type])
	holder.del_reagent(type)

#define WATER_LATENT_HEAT 19000 // How much heat is removed when applied to a hot turf, in J/unit (19000 makes 120 u of water roughly equivalent to 4L)
/datum/reagent/water
	name = "water"
	color = "#0064C877"
	metabolism = REM * 10
	taste_description = "water"
	glass_name = "water"
	glass_desc = "The father of all refreshments."

/datum/reagent/water/deuterium
	name = "deuterium"
	glass_name = "heavy water" // I know this isn't accurate, but it's kinda funny.
	glass_desc = "Perfect for refreshing a heavy thirst, or performing fusion."

/datum/reagent/water/touch_turf(var/turf/simulated/T, var/datum/reagents/holder)
	if(!istype(T))
		return

	var/datum/gas_mixture/environment = T.return_air()
	var/min_temperature = T0C + 100 // 100C, the boiling point of water

	var/hotspot = (locate(/obj/fire) in T)
	if(hotspot && !istype(T, /turf/space))
		var/datum/gas_mixture/lowertemp = T.remove_air(T:air:total_moles)
		lowertemp.temperature = max(min(lowertemp.temperature-2000, lowertemp.temperature / 2), 0)
		lowertemp.react()
		T.assume_air(lowertemp)
		qdel(hotspot)

	var/volume = holder.volumes[type]
	if (environment && environment.temperature > min_temperature) // Abstracted as steam or something
		var/removed_heat = between(0, volume * WATER_LATENT_HEAT, -environment.get_thermal_energy_change(min_temperature))
		environment.add_thermal_energy(-removed_heat)
		if (prob(5))
			T.visible_message("<span class='warning'>The water sizzles as it lands on \the [T]!</span>")

	else if(volume >= 10)
		T.wet_floor(1)

/datum/reagent/water/touch_obj(var/obj/O)
	if(istype(O, /obj/item/reagent_containers/food/snacks/monkeycube))
		var/obj/item/reagent_containers/food/snacks/monkeycube/cube = O
		if(!cube.wrapped)
			cube.Expand()

/datum/reagent/water/touch_mob(var/mob/living/L, var/amount, var/datum/reagents/holder)
	if(istype(L))
		var/needed = L.fire_stacks * 10
		if(amount > needed)
			L.fire_stacks = 0
			L.ExtinguishMob()
			remove_self(needed, holder)
		else
			L.adjust_fire_stacks(-(amount / 10))
			remove_self(amount, holder)

/datum/reagent/fuel
	name = "welding fuel"
	taste_description = "gross metal"
	color = "#660000"
	touch_met = 5

	glass_name = "welder fuel"
	glass_desc = "Unless you are an industrial tool, this is probably not safe for consumption."

/datum/reagent/fuel/touch_turf(var/turf/T, var/datum/reagents/holder)
	new /obj/effect/decal/cleanable/liquid_fuel(T, holder.volumes[type])
	holder.del_reagent(type)

/datum/reagent/fuel/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.adjustToxLoss(2 * removed)

/datum/reagent/fuel/touch_mob(var/mob/living/L, var/amount)
	if(istype(L))
		L.adjust_fire_stacks(amount / 10) // Splashing people with welding fuel to make them easy to ignite!

