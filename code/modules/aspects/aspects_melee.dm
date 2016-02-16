/decl/aspect/melee
	name = ASPECT_BRAWLER
	desc = "You are an expert at hitting them where it hurts with fists and boots."
	use_icon_state = "melee_2"
	category = "Close Combat"

/decl/aspect/melee/edged
	name = ASPECT_KNIVES
	desc = "You are right at home with knives. Calm down, Zakalwe."
	use_icon_state = "melee_4"
	var/list/spawn_weapon_types = list(
		/obj/item/weapon/material/butterfly,
		/obj/item/weapon/material/hatchet/tacknife,
		/obj/item/weapon/material/hatchet/tacknife/hunting,
		/obj/item/weapon/material/sword/trench
		)

/decl/aspect/melee/edged/sword
	name = ASPECT_SWORDS
	desc = "You are skilled with a sword. How anachronistic."
	parent_name = ASPECT_KNIVES
	use_icon_state = "melee_5"
	spawn_weapon_types = list(
		/obj/item/weapon/material/sword/sabre,
		/obj/item/weapon/material/sword/basic,
		/obj/item/weapon/material/sword/rapier
		)

/decl/aspect/melee/edged/do_post_spawn(var/mob/living/carbon/human/holder)
	var/spawning = pick(spawn_weapon_types)
	var/obj/item/thing = new spawning(get_turf(holder))
	holder.put_in_hands(thing)
