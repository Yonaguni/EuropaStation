/mob/living/animal/chicken
	name = "chicken"
	desc = "Hopefully the egss will be good this year."
	icon_state = "chicken_brown"
	icon_living = "chicken_brown"
	icon_dead = "chicken_brown_dead"
	attacktext = "pecked"
	maxHealth = 15
	meat_amount = 3
	animal_move_delay = 8
	mob_ai_type = /datum/ai_mob/animal/herd/chicken
	melee_damage_lower = 1
	melee_damage_upper = 2
	faction = "chickens"
	alert_offset = 2
	speech_verbs = list("clucks")

	var/body_colour = "brown"

/mob/living/animal/chicken/initialize()
	..()
	body_colour = pick(list("brown","white","black"))
	icon_living = "chicken_[body_colour]"
	icon_dead = "chicken_[body_colour]_dead"
	update_icon()
