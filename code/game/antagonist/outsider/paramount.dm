var/datum/antagonist/paramount/paramounts

/obj/effect/landmark/start/paramount
	name = "paramountstart"

/datum/antagonist/paramount
	id = MODE_WIZARD
	role_text = "Paramount Grandmaster"
	role_text_plural = "Paramount Grandmasters"
	landmark_id = "paramountstart"
	welcome_text = "<span class='info'>You are one of the finest minds of Sol, blessed with latent psychic faculties that defy understanding. Using your CE rig, advance your agenda in human space.</span>"
	flags = ANTAG_OVERRIDE_JOB | ANTAG_CLEAR_EQUIPMENT | ANTAG_CHOOSE_NAME | ANTAG_RANDSPAWN | ANTAG_VOTABLE | ANTAG_SET_APPEARANCE
	antaghud_indicator = "hudwizard"
	initial_spawn_req = 1
	initial_spawn_target = 1
	hard_cap = 1
	hard_cap_round = 3
	min_player_age = 18
	id_type = /obj/item/card/id/syndicate
	faction = "paramount"

/datum/antagonist/paramount/create_id(var/assignment, var/mob/living/carbon/human/player, var/equip = 1)
	var/obj/item/card/id/W = ..(assignment, player, equip = 0)
	if(!W) return
	var/obj/item/device/radio/headset/pda/command/pda = new(get_turf(player))
	pda.id = W
	player.drop_from_inventory(W)
	W.forceMove(pda)
	if(equip) player.equip_to_slot_or_del(pda, slot_wear_id)
	return pda

/datum/antagonist/paramount/equip(var/mob/living/carbon/human/player)

	if(!..())
		return 0

	player.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/space/paramount(player), slot_head)
	player.equip_to_slot_or_del(new /obj/item/clothing/under/psysuit(player), slot_w_uniform)
	player.equip_to_slot_or_del(new /obj/item/clothing/suit/wizrobe/psypurple(player), slot_wear_suit)
	player.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(player), slot_shoes)
	player.equip_to_slot_or_del(new /obj/item/clothing/gloves/color/black(player), slot_gloves)
	player.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel(player), slot_back)

	return 1

/datum/antagonist/paramount/create_objectives(var/datum/mind/player)

	if(!..())
		return
	// Copied from ninja for now.
	var/objective_list = list(1,2,3)
	for(var/i=rand(2,3),i>0,i--)
		switch(pick(objective_list))
			if(1)//Kill
				var/datum/objective/assassinate/objective = new
				objective.owner = player
				objective.target = objective.find_target()
				if(objective.target != "Free Objective")
					player.objectives += objective
				else
					i++
				objective_list -= 1 // No more than one kill objective
			if(2)//Protect
				var/datum/objective/protect/objective = new
				objective.owner = player
				objective.target = objective.find_target()
				if(objective.target != "Free Objective")
					player.objectives += objective
				else
					i++
					objective_list -= 3
			if(3)//Harm
				var/datum/objective/harm/objective = new
				objective.owner = player
				objective.target = objective.find_target()
				if(objective.target != "Free Objective")
					player.objectives += objective
				else
					i++
					objective_list -= 4

	var/datum/objective/survive/objective = new
	objective.owner = player
	player.objectives += objective
