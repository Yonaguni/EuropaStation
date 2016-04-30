var/list/all_robolimb_data = list()
var/list/all_robolimb_datums = list()

/proc/init_robolimbs()
	for(var/mtype in typesof(/datum/robolimb))
		get_robolimb_by_path(mtype)

/proc/get_robolimb_by_name(var/model)
	for(var/mtype in typesof(/datum/robolimb))
		var/datum/robolimb/R = get_robolimb_by_path(mtype)
		if(R.company == model)
			return R
	return null

/proc/get_robolimb_by_path(var/model_path)
	if(!all_robolimb_data[model_path])
		all_robolimb_data[model_path] = new model_path
		all_robolimb_datums += all_robolimb_data[model_path]
	return all_robolimb_data[model_path]

/datum/robolimb
	var/company = "Unbranded"                               // Shown when selecting the limb.
	var/desc = "A generic unbranded robotic prosthesis."    // Seen when examining a limb.
	var/icon = 'icons/mob/human_races/cyberlimbs/basic.dmi' // Icon base to draw from.
	var/unavailable_at_chargen                              // If set, not available at chargen.
	var/unbuildable                                         // Cannot be built in a fabricator.
	var/list/species_cannot_use = list()                    // Cannot be used by this species.
	var/vip_only                                            // Must be admin or ckey in vips to use.

/datum/robolimb/bishop
	company = "Bishop"
	desc = "This limb has a white polymer casing with blue holo-displays."
	icon = 'icons/mob/human_races/cyberlimbs/bishop.dmi'

/datum/robolimb/hesphaistos
	company = "Hesphiastos"
	desc = "This limb has a militaristic black and green casing with gold stripes."
	icon = 'icons/mob/human_races/cyberlimbs/hesphaistos.dmi'

/datum/robolimb/zenghu
	company = "Zeng-Hu"
	desc = "This limb has a rubbery fleshtone covering with visible seams."
	icon = 'icons/mob/human_races/cyberlimbs/zenghu.dmi'

/datum/robolimb/xion
	company = "Xion"
	desc = "This limb has a minimalist black and red casing."
	icon = 'icons/mob/human_races/cyberlimbs/xion.dmi'

/datum/robolimb/ipc
	company = "Morpheus"
	desc = "This limb is simple and functional; no effort has been made to make it look human."
	icon = 'icons/mob/human_races/cyberlimbs/ipc.dmi'

/datum/robolimb/wardtakahashi
	company = "Ward-Takahashi"
	desc = "This limb features sleek black and white polymers."
	icon = 'icons/mob/human_races/cyberlimbs/wardtakahashi.dmi'