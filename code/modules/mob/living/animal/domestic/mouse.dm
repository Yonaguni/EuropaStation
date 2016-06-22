/mob/living/animal/mouse
	name = "mouse"
	desc = "Squeak!"
	icon_state = "mouse_brown"
	icon_living = "mouse_brown"
	icon_dead = "mouse_brown_dead"
	icon_asleep = "mouse_brown_sleep"
	attacktext = "bitten"
	maxHealth = 5

	meat_amount = 1
	animal_move_delay = 4
	mob_ai_type = /datum/ai_mob/animal/herd/mouse
	melee_damage_lower = 1
	melee_damage_upper = 2
	faction = "mice"
	alert_offset = 2
	speech_verbs = list("squeeks","squeaks","squiks")
	holder_type = /obj/item/weapon/holder

	var/body_colour = "brown"

/mob/living/animal/mouse/initialize()
	..()
	body_colour = pick(list("brown","white","gray"))
	icon_living = "mouse_[body_colour]"
	icon_dead = "mouse_[body_colour]_dead"
	icon_asleep = "mouse_[body_colour]_sleep"
	update_icon()
