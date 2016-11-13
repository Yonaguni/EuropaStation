/decl/psychic_faculty/coercion
	name = PSYCHIC_COERCION
	colour = "#3399ff"
	powers = list(
		/decl/psychic_power/latent,
		/decl/psychic_power/spasm,
		/decl/psychic_power/blindstrike,
		/decl/psychic_power/coercion_placeholder,
		/decl/psychic_power/mindream
		)

/decl/psychic_power/spasm
	name = "Spasm"
	description = "Break their hold on their tools with hand spasms."
	target_ranged = 1
	target_melee = 1
	target_mob_only = 1
	melee_power_cost = 10
	ranged_power_cost = 15
	time_cost = 50

/decl/psychic_power/spasm/do_proximity(var/mob/living/user, var/atom/target)
	if(..())
		cramp(user, target)

/decl/psychic_power/spasm/do_ranged(var/mob/living/user, var/atom/target)
	if(..())
		cramp(user, target)

/decl/psychic_power/spasm/proc/cramp(var/mob/living/user, var/mob/living/target)

	user << "<span class='danger'>You stab a lance of psipower into \the [target]'s muscles!</span>"

	if(target.stat != CONSCIOUS)
		return

	target << "<span class='danger'>The muscles in your hands cramp horrendously!</span>"
	if(prob(60)) target.emote("scream")
	if(target.l_hand && target.unEquip(target.l_hand))
		target.visible_message("<span class='danger'>\The [target] drops what they were holding as their left hand spasms!</span>")
	if(target.r_hand && target.unEquip(target.r_hand))
		target.visible_message("<span class='danger'>\The [target] drops what they were holding as their right hand spasms!</span>")

/decl/psychic_power/blindstrike
	name = "Blindstrike"
	description = "Strike them deaf and blind."
	target_ranged = 1
	target_melee = 1
	target_mob_only = 1
	melee_power_cost = 8
	ranged_power_cost = 12

/decl/psychic_power/blindstrike/do_proximity(var/mob/living/user, var/atom/target)
	if(..())
		blind(user, target)

/decl/psychic_power/blindstrike/do_ranged(var/mob/living/user, var/atom/target)
	if(..())
		blind(user, target)

/decl/psychic_power/blindstrike/proc/blind(var/mob/living/user, var/mob/living/target)

	user << "<span class='danger'>You overwhelm \the [target]'s senses with a blast of mental white noise!</span>"

	if(target.stat != CONSCIOUS)
		return

	if(prob(60))
		target.emote("scream")
	target << "<span class='danger'>Your sense are blasted into oblivion by a burst of mental static!</span>"
	target.flash_eyes()
	target.eye_blind = max(target.eye_blind,10)
	target.ear_deaf = max(target.ear_deaf,10)

/decl/psychic_power/coercion_placeholder
	name = "Coercion Placeholder"
	description = "Grandmasterclass coercive power."
	visible = 0

/decl/psychic_power/mindream
	name = "Mind Ream"
	description = "Make them belong to you, mind and soul."
	target_ranged = 0
	target_melee = 1
	target_mob_only = 1
