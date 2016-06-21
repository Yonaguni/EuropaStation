/datum/reagent/proc/affect_touch(var/mob/living/human/M, var/alien, var/removed)

	if(!istype(M))
		return

	if(disinfectant > 0)
		M.germ_level -= min(removed*20, M.germ_level)
		for(var/obj/item/I in M.contents)
			I.was_bloodied = null
		M.was_bloodied = null

	if(ishuman(M))
		var/mob/living/human/H = M
		if(acid && acid_melt_threshold)
			if(volume >= acid_melt_threshold)
				var/update_mob
				for(var/obj/item/I in list(H.head, H.wear_mask, H.glasses))
					if(!I)
						continue
					if(I.unacidable)
						H << "<span class='danger'>Your [H.head] protects you from the acid.</span>"
						remove_self(volume)
						return
					else if(removed > acid_melt_threshold)
						H << "<span class='danger'>Your [H.head] melts away!</span>"
						qdel(I)
						removed -= acid_melt_threshold
						update_mob = 1
				if(update_mob)
					H.update_inv_glasses(1)
					H.update_inv_wear_mask(1)
					H.update_inv_head(1)
					H.update_hair(1)
				if(removed <= 0)
					return
			else
				M.take_organ_damage(0, removed * acid * 0.2) //burn damage, since it causes chemical burns. Acid doesn't make bones shatter, like brute trauma would.
				return
			if(!M.unacidable && removed > 0)
				var/obj/item/organ/external/affecting = H.get_organ(BP_HEAD)
				if(affecting)
					if(affecting.take_damage(0, removed * acid * 0.1))
						H.UpdateDamageIcon()
					if(prob(100 * removed / acid_melt_threshold)) // Applies disfigurement
						if (affecting.can_feel_pain())
							H.emote("scream")
						H.status_flags |= DISFIGURED
			else
				M.take_organ_damage(0, removed * acid * 0.1)
	else
		M.take_organ_damage(0, removed * acid * 0.1)
	return

// This doesn't apply to skin contact - this is for, e.g. extinguishers and sprays. The difference is that reagent is not directly on the mob's skin - it might just be on their clothing.
/datum/reagent/proc/touch_mob(var/mob/living/M, var/amount)
	if(!istype(M))
		return
	if(flammable > 0)
		M.adjust_fire_stacks(amount / 15)
	if(hydration_factor && hydration_factor > 0)
		var/needed = M.fire_stacks * 10
		if(amount > needed)
			M.fire_stacks = 0
			M.ExtinguishMob()
			remove_self(needed)
		else
			M.adjust_fire_stacks(-(amount / 10))
			remove_self(amount)
	return

/datum/reagent/proc/touch_obj(var/obj/O, var/amount) // Acid melting, cleaner cleaning, etc

	if(disinfectant > 0)
		O.germ_level -= min(volume*20, O.germ_level)
		O.was_bloodied = null

	if(acid && acid_melt_threshold)
		if(O.unacidable)
			return
		if((istype(O, /obj/item) || istype(O, /obj/effect/plant)) && (volume > acid_melt_threshold))
			var/obj/effect/decal/cleanable/molten_item/I = new/obj/effect/decal/cleanable/molten_item(O.loc)
			I.desc = "Looks like this was \an [O] some time ago."
			O.visible_message("<span class='warning'>\The [O] melts.</span>")
			qdel(O)
			remove_self(acid_melt_threshold)
			return
	if(alcoholic)
		if(istype(O, /obj/item/weapon/paper))
			var/obj/item/weapon/paper/paperaffected = O
			paperaffected.clearpaper()
			usr << "The solution dissolves the ink on the paper."
	return

/datum/reagent/proc/touch_turf(var/turf/T, var/amount) // Cleaner cleaning, lube lubbing, etc, all go here
	if(!istype(T))
		return

	if(disinfectant > 0)
		T.germ_level -= min(volume*20, T.germ_level)
		for(var/obj/item/I in T.contents)
			I.was_bloodied = null
		for(var/obj/effect/decal/cleanable/blood/B in T)
			qdel(B)

	if(hydration_factor > 0)
		var/datum/gas_mixture/environment = T.return_air()
		if(environment)
			var/min_temperature = T0C + 100 // 100C, the boiling point of water
			// TODO: quench fires.
			if (environment && environment.temperature > min_temperature) // Abstracted as steam or something
				var/removed_heat = between(0, volume * 1000, -environment.get_thermal_energy_change(min_temperature))
				environment.add_thermal_energy(-removed_heat)
				if (prob(5))
					T.visible_message("<span class='warning'>The [name] sizzles as it lands on \the [T]!</span>")
			else if(volume >= 10)
				T.wet_floor(1)
	return