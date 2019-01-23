/obj/item/clothing/mask/gas
	name = "gas mask"
	desc = "A face-covering mask that can be connected to an air supply. Filters harmful gases from the air."
	icon_state = "fullgas"
	item_state = "fullgas"
	item_flags = ITEM_FLAG_BLOCK_GAS_SMOKE_EFFECT | ITEM_FLAG_AIRTIGHT
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE
	body_parts_covered = FACE|EYES
	w_class = ITEM_SIZE_NORMAL
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	siemens_coefficient = 0.9
	armor = list(melee = 5, bullet = 5, laser = 5, energy = 0, bomb = 0, bio = 75, rad = 0)
	var/clogged
	var/filter_water
	var/gas_filter_strength = 1			//For gas mask filters
	var/list/filtered_gases = list("phoron","sleeping_agent","chlorine","ammonia","carbon_monoxide","methyl_bromide")

/obj/item/clothing/mask/gas/examine(var/mob/user)
	. = ..()
	if(clogged)
		to_chat(user, "<span class='warning'>The intakes are clogged with [clogged]!</span>")

/obj/item/clothing/mask/gas/filters_water()
	return (filter_water && !clogged)

/obj/item/clothing/mask/gas/attack_self(var/mob/user)
	if(clogged)
		user.visible_message("<span class='notice'>\The [user] begins unclogging the intakes of \the [src].</span>")
		if(do_after(user, 100, progress = 1) && clogged)
			user.visible_message("<span class='notice'>\The [user] has unclogged \the [src].</span>")
			clogged = FALSE
		return
	. = ..()

/obj/item/clothing/mask/gas/filter_air(datum/gas_mixture/air)
	var/datum/gas_mixture/filtered = new
	for(var/g in filtered_gases)
		if(air.gas[g])
			filtered.gas[g] = air.gas[g] * gas_filter_strength
			air.gas[g] -= filtered.gas[g]
	air.update_values()
	filtered.update_values()
	return filtered
