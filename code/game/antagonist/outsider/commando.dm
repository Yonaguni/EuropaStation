var/datum/antagonist/deathsquad/mercenary/commandos

/obj/effect/landmark/start/navy
	name = "Syndicate-Commando"

/datum/antagonist/deathsquad/mercenary
	id = MODE_COMMANDO
	landmark_id = "Syndicate-Commando"
	role_text = "Navy Commando"
	role_text_plural = "Navy Commandos"
	welcome_text = "You are a highly trained commando in the employ of the Sol navy."
	id_type = /obj/item/card/id/centcom/ERT

	hard_cap = 4
	hard_cap_round = 8
	initial_spawn_req = 4
	initial_spawn_target = 6


/datum/antagonist/deathsquad/mercenary/New()
	..(1)
	commandos = src

/datum/antagonist/deathsquad/mercenary/equip(var/mob/living/carbon/human/player)

	player.equip_to_slot_or_del(new /obj/item/clothing/under/syndicate(player), slot_w_uniform)
	player.equip_to_slot_or_del(new /obj/item/gun/composite/premade/pistol/a9/silenced(player), slot_belt)
	player.equip_to_slot_or_del(new /obj/item/clothing/shoes/swat(player), slot_shoes)
	player.equip_to_slot_or_del(new /obj/item/clothing/glasses/thermal(player), slot_glasses)
	player.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/syndicate(player), slot_wear_mask)
	player.equip_to_slot_or_del(new /obj/item/storage/box(player), slot_in_backpack)
	player.equip_to_slot_or_del(new /obj/item/rig/merc(player), slot_back)
	player.equip_to_slot_or_del(new /obj/item/gun/composite/premade/assault_rifle(player), slot_r_hand)
	player.equip_to_slot_or_del(new /obj/item/melee/energy/sword(player), slot_l_hand)

	create_id("Navy Commando", player)
	create_radio(SYND_FREQ, player)
	return 1
