/obj/item/stack/medical
	name = "medical pack"
	singular_name = "medical pack"
	icon = 'icons/obj/items.dmi'
	amount = 5
	max_amount = 5
	w_class = 2
	throw_speed = 4
	throw_range = 20
	var/heal_brute = 0
	var/heal_burn = 0

/obj/item/stack/medical/attack(mob/living/carbon/M as mob, mob/user as mob)
	if (!istype(M))
		user << "<span class='warning'>\The [src] cannot be applied to [M]!</span>"
		return 1

	if ( ! (istype(user, /mob/living/carbon/human) || \
			istype(user, /mob/living/silicon)) )
		user << "<span class='warning'>You don't have the dexterity to do this!</span>"
		return 1

	if (istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		var/obj/item/organ/external/affecting = H.get_organ(user.zone_sel.selecting)

		if(affecting.organ_tag == BP_HEAD)
			if(H.head && istype(H.head,/obj/item/clothing/head/helmet/space))
				user << "<span class='warning'>You can't apply [src] through [H.head]!</span>"
				return 1
		else
			if(H.wear_suit && istype(H.wear_suit,/obj/item/clothing/suit/space))
				user << "<span class='warning'>You can't apply [src] through [H.wear_suit]!</span>"
				return 1

		if(affecting.status & ORGAN_ROBOT)
			user << "<span class='warning'>This isn't useful at all on a robotic limb..</span>"
			return 1

		H.UpdateDamageIcon()

	else

		M.heal_organ_damage((src.heal_brute/2), (src.heal_burn/2))
		user.visible_message( \
			"<span class='notice'>[M] has been applied with [src] by [user].</span>", \
			"<span class='notice'>You apply \the [src] to [M].</span>" \
		)
		use(1)

	M.updatehealth()
/obj/item/stack/medical/bruise_pack
	name = "roll of gauze"
	singular_name = "gauze length"
	desc = "Some sterile gauze to wrap around bloody stumps."
	icon_state = "brutepack"

/obj/item/stack/medical/bruise_pack/attack(mob/living/carbon/M as mob, mob/user as mob)
	if(..())
		return 1

	if(!istype(M, /mob/living/carbon/human))
		return 1

	var/mob/living/carbon/human/H = M
	var/obj/item/organ/external/affecting = H.get_organ(user.zone_sel.selecting)

	if(affecting.is_bandaged())
		user << "<span class='warning'>\The [M]'s [affecting.name] has already been bandaged.</span>"
		return 1

	user.visible_message("<span class='notice'>\The [user] starts examining [M]'s [affecting.name].</span>")
	var/warn_too_big
	for(var/datum/wound/W in affecting.wounds)
		if(W.internal || W.bandaged || W.damage_type != CUT)
			continue
		if(W.damage >= W.autoheal_cutoff)
			if(!warn_too_big)
				warn_too_big = 1
				user << "<span class='notice'>A mere bandage is not enough to treat \the [affecting] - it will need suturing.</span>"
			continue
		if(!do_mob(user, M, W.damage/5))
			user << "<span class='notice'>You must stand still to bandage wounds.</span>"
			break
		if (W.current_stage <= W.max_bleeding_stage)
			user.visible_message("<span class='notice'>\The [user] bandages \a [W.desc] on [M]'s [affecting.name].</span>")
			W.bandage()
			affecting.update_damages()
			use(1)
		return 1
	if(!warn_too_big)
		user << "<span class='notice'>You couldn't find any wounds to bandage.</span>"
	return 1

/obj/item/stack/medical/ointment
	name = "ointment"
	desc = "Used to treat those nasty burns."
	gender = PLURAL
	singular_name = "ointment"
	icon_state = "ointment"
	heal_burn = 1

/obj/item/stack/medical/ointment/attack(mob/living/carbon/M as mob, mob/user as mob)
	if(..())
		return 1

	if (istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		var/obj/item/organ/external/affecting = H.get_organ(user.zone_sel.selecting)

		if(affecting.is_open() == 0)
			if(affecting.is_salved())
				user << "<span class='warning'>The wounds on [M]'s [affecting.name] have already been salved.</span>"
				return 1
			else
				user.visible_message("<span class='notice'>\The [user] starts salving wounds on [M]'s [affecting.name].</span>", \
						             "<span class='notice'>You start salving the wounds on [M]'s [affecting.name].</span>" )
				if(!do_mob(user, M, 10))
					user << "<span class='notice'>You must stand still to salve wounds.</span>"
					return 1
				user.visible_message("<span class='notice'>[user] salved wounds on [M]'s [affecting.name].</span>", \
				                         "<span class='notice'>You salved wounds on [M]'s [affecting.name].</span>" )
				use(1)
				affecting.salve()


/obj/item/stack/medical/splint
	name = "medical splints"
	singular_name = "medical splint"
	icon_state = "splint"
	amount = 5
	max_amount = 5

/obj/item/stack/medical/splint/attack(mob/living/carbon/M as mob, mob/user as mob)
	if(..())
		return 1

	if (istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		var/obj/item/organ/external/affecting = H.get_organ(user.zone_sel.selecting)
		var/limb = affecting.name
		if(!(affecting.organ_tag in list(BP_L_ARM, BP_R_ARM, BP_L_LEG, BP_R_LEG)))
			user << "<span class='danger'>You can't apply a splint there!</span>"
			return
		if(affecting.status & ORGAN_SPLINTED)
			user << "<span class='danger'>[M]'s [limb] is already splinted!</span>"
			return
		if (M != user)
			user.visible_message("<span class='danger'>[user] starts to apply \the [src] to [M]'s [limb].</span>", "<span class='danger'>You start to apply \the [src] to [M]'s [limb].</span>", "<span class='danger'>You hear something being wrapped.</span>")
		else
			if((!user.hand && affecting.organ_tag == BP_R_ARM) || (user.hand && affecting.organ_tag == BP_L_ARM))
				user << "<span class='danger'>You can't apply a splint to the arm you're using!</span>"
				return
			user.visible_message("<span class='danger'>[user] starts to apply \the [src] to their [limb].</span>", "<span class='danger'>You start to apply \the [src] to your [limb].</span>", "<span class='danger'>You hear something being wrapped.</span>")
		if(do_after(user, 50))
			if (M != user)
				user.visible_message("<span class='danger'>[user] finishes applying \the [src] to [M]'s [limb].</span>", "<span class='danger'>You finish applying \the [src] to [M]'s [limb].</span>", "<span class='danger'>You hear something being wrapped.</span>")
			else
				if(prob(25))
					user.visible_message("<span class='danger'>[user] successfully applies \the [src] to their [limb].</span>", "<span class='danger'>You successfully apply \the [src] to your [limb].</span>", "<span class='danger'>You hear something being wrapped.</span>")
				else
					user.visible_message("<span class='danger'>[user] fumbles \the [src].</span>", "<span class='danger'>You fumble \the [src].</span>", "<span class='danger'>You hear something being wrapped.</span>")
					return
			affecting.status |= ORGAN_SPLINTED
			use(1)
		return
