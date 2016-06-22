/mob/living/animal/cat
	name = "cat"
	desc = "A small feline. It has a tendency to adopt colonists."
	icon_state = "cat"
	icon_living = "cat"
	icon_dead = "cat_dead"
	icon_asleep = "cat_rest"
	attacktext = "mauled"
	meat_amount = 2
	animal_move_delay = 4
	melee_damage_lower = 3
	melee_damage_upper = 6
	mob_ai_type = /datum/ai_mob/animal/hostile/cat
	alert_offset = 4
	speech_verbs = list("meows","mews")
	holder_type = /obj/item/weapon/holder
	maxHealth = 15

/mob/living/animal/cat/verb/friend()
	set name = "Become Friends"
	set category = "IC"
	set src in view(1)

	if(client)
		usr << "<span class='warning'>\The [src] is too self-willed to make friends that easily.</span>"
		return

	var/datum/ai_mob/animal/hostile/cat/cat_ai = mob_ai
	if(!istype(cat_ai))
		usr << "<span class='warning'>Something seems very off about this [src]...</span>"
		return

	if(cat_ai.friend && usr == cat_ai.friend)
		set_dir(get_dir(src, cat_ai.friend))
		say("Meow!")
		return

	if (!ishuman(usr) || (cat_ai.befriend_job && cat_ai.friend.job != cat_ai.befriend_job))
		usr << "<span class='warning'>\The [src] ignores you.</span>"
		return

	cat_ai.friend = usr
	set_dir(get_dir(src, cat_ai.friend))
	say("Meow!")