var/datum/antagonist/commando/commandos

/obj/effect/landmark/start/navy
	name = "NavyCommando"

/datum/antagonist/commando
	id = MODE_COMMANDO
	landmark_id = "NavyCommando"
	role_text = "Navy Commando"
	role_text_plural = "Navy Commandos"
	welcome_text = "You are a highly trained special forces soldier in the employ of the Central Solar Authority. To speak on the team's private channel use :t."
	leader_welcome_text = "You are the leader of a CSA Navy strike team. Use :t to speak to your soldiers."
	id_type = /obj/item/card/id/centcom/ERT
	hard_cap = 4
	hard_cap_round = 8
	initial_spawn_req = 4
	initial_spawn_target = 6
	flags = ANTAG_VOTABLE | ANTAG_OVERRIDE_JOB | ANTAG_CLEAR_EQUIPMENT | ANTAG_CHOOSE_NAME | ANTAG_SET_APPEARANCE | ANTAG_HAS_LEADER

/datum/antagonist/commando/New()
	..()
	commandos = src

/datum/antagonist/commando/equip(var/mob/living/carbon/human/player)

	player.equip_to_slot_or_del(new /obj/item/clothing/under/lower/camo/tacticool(player), slot_w_uniform)
	player.equip_to_slot_or_del(new /obj/item/gun/composite/premade/pistol/a9/preloaded/grand_tack(player), slot_belt)
	player.equip_to_slot_or_del(new /obj/item/clothing/shoes/swat(player), slot_shoes)
	player.equip_to_slot_or_del(new /obj/item/clothing/glasses/thermal(player), slot_glasses)
	player.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/swat(player), slot_wear_mask)
	player.equip_to_slot_or_del(new /obj/item/rig/combat/navy(player), slot_back)
	var/gun_type = pick( \
		/obj/item/gun/composite/premade/assault_rifle/preloaded/grand_tack, \
		/obj/item/gun/composite/premade/assault_rifle/a762/preloaded/grand_tack, \
		/obj/item/gun/composite/premade/shotgun/combat/preloaded/grand_tack, \
		/obj/item/gun/composite/premade/smg/a10/preloaded/grand_tack \
		)
	player.equip_to_slot_or_del(new gun_type(player), slot_r_hand)
	create_id("Navy Commando", player)
	create_radio(SYND_FREQ, player)
	return 1

// TODO, we don't have objectives enabled anyway.
/datum/antagonist/commando/create_global_objectives()
	if(!..())
		return 0
	global_objectives = list()
	global_objectives += new /datum/objective/nuclear
	return 1
