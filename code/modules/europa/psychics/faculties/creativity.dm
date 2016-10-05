/decl/psychic_faculty/creativity
	name = PSYCHIC_CREATIVITY
	colour = "#00cc99"
	powers = list(
		/decl/psychic_power/latent,
		/decl/psychic_power/spark,
		/decl/psychic_power/electrocute,
		/decl/psychic_power/transmute,
		/decl/psychic_power/zorch
		)

/decl/psychic_power/spark
	name = "Sparks"
	description = "Create some sparks. Pretty!"
	target_melee = 1
	target_ranged = 1
	target_self = 1

/decl/psychic_power/spark/do_ranged(var/mob/living/user, var/mob/living/target)
	if(..())
		var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
		sparks.set_up(3, 0, get_turf(target))
		sparks.start()

/decl/psychic_power/spark/do_proximity(var/mob/living/user, var/mob/living/target)
	if(..())
		var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
		sparks.set_up(3, 0, get_turf(target))
		sparks.start()

/decl/psychic_power/electrocute
	name = "Electrocution"
	description = "Zap whoever you can reach."
	target_melee = 1
	target_mob_only = 1
	melee_power_cost = 10

/decl/psychic_power/electrocute/do_proximity(var/mob/living/user, var/mob/living/target)
	if(..())
		user.visible_message("<span class='danger'>\The [user] sends a jolt of electricity arcing into \the [target]!</span>")
		target.electrocute_act(rand(15,45), user, 1, user.zone_sel.selecting)

/decl/psychic_power/transmute
	name = "Transmute"
	description = "Who needs an autolathe?"
	target_self = 1

/decl/psychic_power/zorch
	name = "Mindblast"
	description = "Your very own personal gigawatt brain laser."
	target_ranged = 1
	melee_power_cost = 15
	ranged_power_cost = 20

/decl/psychic_power/zorch/do_ranged(var/mob/living/user, var/mob/living/target)
	if(..())
		user.visible_message("<span class='danger'>\The [user]'s eyes flare with ruby light!</span>")
		var/obj/item/projectile/beam/heavylaser/pew = new(get_turf(user))
		pew.name = "gigawatt brain laser"
		playsound(pew.loc, pew.fire_sound, 25, 1)
		pew.original = target
		pew.current = target
		pew.starting = get_turf(user)
		pew.shot_from = user
		pew.yo = target.y - user.y
		pew.xo = target.x - user.x
		pew.launch(target)
