
/obj/item/weapon/grab/proc/inspect_organ(mob/living/human/H, mob/user, var/target_zone)

	var/obj/item/organ/external/E = H.get_organ(target_zone)

	if(!E || E.is_stump())
		user << "<span class='warning'>\The [H] is missing that bodypart.</span>"
		return

	user.visible_message("<span class='notice'>\The [user] starts inspecting [affecting]'s [E.name] carefully.</span>")

	// Prosthetics and robolimbs.
	if(E.status & ORGAN_ROBOT)
		if(!do_mob(user,H, 20))
			user << "<span class='notice'>You must stand still to inspect \the [E] for damage.</span>"
			return
		else if(E.wounds.len)
			user << "<span class='warning'>You find [E.get_wounds_desc()]</span>"
		else
			user << "<span class='notice'>You find no apparent damage.</span>"
		return

	// General trauma.
	if(!do_mob(user,H, 20))
		user << "<span class='notice'>You must stand still to inspect \the [E] for wounds.</span>"
		return
	else if(E.wounds.len)
		user << "<span class='warning'>You find [E.get_wounds_desc()]</span>"
		if(locate(/datum/wound/internal_bleeding) in E.wounds)
			user << "<span class='danger'>\The [E] is swollen and discoloured from internal bleeding!</span>"
		if(E.cavity)
			user << "<span class='warning'>\The [E]'s surface dips unnaturally inwards.</span>"
		if(E.implants.len)
			user << "<span class='warning'>\The [E] bulges strangely in a few places.</span>"
	else
		user << "<span class='notice'>You find no apparent wounds.</span>"

	if(!do_mob(user, H, 20)) return

	// Fractures.
	user << "<span class='notice'>You begin checking for broken bones or fractures.</span>"
	if(!do_mob(user, H, 20))
		user << "<span class='notice'>You must stand still to inspect \the [E] for fractures.</span>"
		return
	else if(E.status & ORGAN_BROKEN)
		user << "<span class='warning'>The [E.encased ? E.encased : "bone in the [E.name]"] moves slightly when you poke it!</span>"
		H.custom_pain("Your [E.name] hurts where it's poked.")
	else
		user << "<span class='notice'>The [E.encased ? E.encased : "bones in the [E.name]"] seems to be fine.</span>"

	if(!do_mob(user, H, 20)) return

	// Toxins.
	user << "<span class='notice'>You begin checking \the [H]'s skin.</span>"
	if(!do_mob(user, H, 20))
		user << "<span class='notice'>You must stand still to check \the [H]'s skin for abnormalities.</span>"
		return
	else
		var/bad = 0
		if(H.getToxLoss() >= 40)
			user << "<span class='warning'>\The [H] has an unhealthy skin discoloration.</span>"
			bad = 1
		if(H.getOxyLoss() >= 20 || H.vessel.total_volume < 400)
			user << "<span class='warning'>\The [H]'s skin is unusually pale.</span>"
			bad = 1
		if(E.status & ORGAN_DEAD)
			user << "<span class='danger'>\The [E] is rotting!</span>"
			bad = 1
		if(H.stat == 2)
			user << "<span class='danger'>\The [H] is dead!</span>"
			bad = 1
		else if(H.stat == 1)
			user << "<span class='warning'>\The [H] is unconcious but alive!</span>"
			bad = 1

		if(!bad)
			user << "<span class='notice'>\The [H]'s skin appears to be normal.</span>"

/obj/item/weapon/grab/proc/jointlock(mob/living/human/target, mob/attacker, var/target_zone)
	if(state < GRAB_AGGRESSIVE)
		attacker << "<span class='warning'>You require a better grip to do this.</span>"
		return

	var/obj/item/organ/external/organ = target.get_organ(check_zone(target_zone))
	if(!organ || organ.dislocated == -1)
		return

	attacker.visible_message("<span class='danger'>\The [attacker] [pick("bent", "twisted")] [target]'s [organ.name] into a jointlock!</span>")
	var/armor = target.run_armor_check(target, "melee")
	if(armor < 2)
		target << "<span class='danger'>You feel extreme pain!</span>"
		affecting.adjustSubdual(Clamp(0, 60-affecting.subdual, 30)) //up to 60 subdual

/obj/item/weapon/grab/proc/attack_eye(mob/living/human/target, mob/living/human/attacker)
	if(!istype(attacker))
		return

	var/datum/unarmed_attack/attack = attacker.get_unarmed_attack(target, O_EYES)

	if(!attack)
		return
	if(state < GRAB_NECK)
		attacker << "<span class='warning'>You require a better grip to do this.</span>"
		return
	for(var/obj/item/protection in list(target.head, target.wear_mask, target.glasses))
		if(protection && (protection.body_parts_covered & EYES))
			attacker << "<span class='danger'>You're going to need to remove the eye covering first.</span>"
			return
	if(!target.has_eyes())
		attacker << "<span class='danger'>You cannot locate any eyes on \the [target]!</span>"
		return

	attacker.attack_log += text("\[[time_stamp()]\] <font color='red'>Attacked [target.name]'s eyes using grab ([target.ckey])</font>")
	target.attack_log += text("\[[time_stamp()]\] <font color='orange'>Had eyes attacked by [attacker.name]'s grab ([attacker.ckey])</font>")
	msg_admin_attack("[key_name(attacker)] attacked [key_name(target)]'s eyes using a grab action.")

	attack.handle_eye_attack(attacker, target)

/obj/item/weapon/grab/proc/headbutt(mob/living/human/target, mob/living/human/attacker)
	if(!istype(attacker))
		return
	if(target.lying)
		return
	attacker.visible_message("<span class='danger'>\The [attacker] thrusts \his head into \the [target]'s skull!</span>")

	var/damage = 20
	var/obj/item/clothing/hat = attacker.head
	if(istype(hat))
		damage += hat.force * 3

	var/armor = target.run_armor_check(BP_HEAD, "melee")
	target.apply_damage(damage, BRUTE, BP_HEAD, armor)
	attacker.apply_damage(10, BRUTE, BP_HEAD, attacker.run_armor_check(BP_HEAD, "melee"))

	if(!armor && target.headcheck(BP_HEAD) && prob(damage))
		target.apply_effect(20, PARALYZE)
		target.visible_message("<span class='danger'>\The [target] [target.species.get_knockout_message(target)]</span>")

	playsound(attacker.loc, "swing_hit", 25, 1, -1)
	attacker.attack_log += text("\[[time_stamp()]\] <font color='red'>Headbutted [target.name] ([target.ckey])</font>")
	target.attack_log += text("\[[time_stamp()]\] <font color='orange'>Headbutted by [attacker.name] ([attacker.ckey])</font>")
	msg_admin_attack("[key_name(attacker)] has headbutted [key_name(target)]")

	attacker.drop_from_inventory(src)
	src.loc = null
	qdel(src)
	return

/obj/item/weapon/grab/proc/dislocate(mob/living/human/target, mob/living/attacker, var/target_zone)
	if(state < GRAB_NECK)
		attacker << "<span class='warning'>You require a better grip to do this.</span>"
		return
	if(target.grab_joint(attacker, target_zone))
		playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
		return

/obj/item/weapon/grab/proc/pin_down(mob/target, mob/attacker)
	if(state < GRAB_AGGRESSIVE)
		attacker << "<span class='warning'>You require a better grip to do this.</span>"
		return
	if(force_down)
		attacker << "<span class='warning'>You are already pinning \the [target] to the ground.</span>"

	attacker.visible_message("<span class='danger'>\The [attacker] starts forcing \the [target] to the ground!</span>")
	if(do_after(attacker, 20) && target)
		last_action = world.time
		attacker.visible_message("<span class='danger'>\The [attacker] forces \the [target] to the ground!</span>")
		apply_pinning(target, attacker)

/obj/item/weapon/grab/proc/apply_pinning(mob/target, mob/attacker)
	force_down = 1
	target.Weaken(3)
	target.lying = 1
	step_to(attacker, target)
	attacker.set_dir(EAST) //face the victim
	target.set_dir(SOUTH) //face up

/obj/item/weapon/grab/proc/devour(mob/target, mob/user)
	var/can_eat
	if((FAT in user.mutations) && issmall(target))
		can_eat = 1
	else
		var/mob/living/human/H = user
		if(istype(H) && H.species.gluttonous && (ishuman(target) || isanimal(target)))
			if(H.species.gluttonous == GLUT_TINY && (target.mob_size <= MOB_TINY) && !ishuman(target)) // Anything MOB_TINY or smaller
				can_eat = 1
			else if(H.species.gluttonous == GLUT_SMALLER && (H.mob_size > target.mob_size)) // Anything we're larger than
				can_eat = 1
			else if(H.species.gluttonous == GLUT_ANYTHING) // Eat anything ever
				can_eat = 2

	if(can_eat)
		var/mob/living/human/attacker = user
		user.visible_message("<span class='danger'>\The [user] is attempting to devour \the [target]!</span>")
		if(can_eat == 2)
			if(!do_mob(user, target, 30)) return
		else
			if(!do_mob(user, target, 100)) return
		user.visible_message("<span class='danger'>\The [user] devours \the [target]!</span>")
		admin_attack_log(attacker, target, "Devoured.", "Was devoured by.", "devoured")
		target.loc = user
		attacker.stomach_contents.Add(target)
		qdel(src)