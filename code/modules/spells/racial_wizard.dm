//this file is full of all the racial spells/artifacts/etc that each species has.

/obj/item/weapon/magic_rock
	name = "magical rock"
	desc = "Legends say that this rock will unlock the true potential of anyone who touches it."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "magic rock"
	w_class = 2
	throw_speed = 1
	throw_range = 3
	force = 15
	var/list/potentials = list("Resomi" = /spell/aoe_turf/conjure/summon/resomi, "Human" = /obj/item/weapon/storage/bag/cash/infinite,
		"Diona" = /spell/aoe_turf/conjure/grove/gestalt, "Skrell" = /obj/item/weapon/contract/apprentice/skrell)

/obj/item/weapon/magic_rock/attack_self(mob/user)
	if(!istype(user,/mob/living/carbon/human))
		user << "\The [src] can do nothing for such a simple being."
		return
	var/mob/living/carbon/human/H = user
	var/reward = potentials[H.species.get_bodytype()] //we get body type because that lets us ignore subspecies.
	if(!reward)
		user << "\The [src] does not know what to make of you."
		return
	for(var/spell/S in user.spell_list)
		if(istype(S,reward))
			user << "\The [src] can do no more for you."
			return
	user.drop_from_inventory(src)
	var/a = new reward()
	if(ispath(reward,/spell))
		H.add_spell(a)
	else if(ispath(reward,/obj))
		H.put_in_hands(a)
	user << "\The [src] crumbles in your hands."
	qdel(src)

//RESOMI
/spell/aoe_turf/conjure/summon/resomi
	name = "Summon Nano Machines"
	desc = "This spell summons nano machines from the wizard's body to help them."

	school = "racial"
	spell_flags = Z2NOCAST
	invocation_type = SpI_EMOTE
	invocation = "spasms a moment as nanomachines come out of a port on their back!"

	level_max = list(Sp_TOTAL = 0, Sp_SPEED = 0, Sp_POWER = 0)

	name_summon = 1

	charge_type = Sp_HOLDVAR
	holder_var_type = "shock_stage"
	holder_var_amount = 15

	hud_state = "wiz_resomi"

	summon_amt = 1
	summon_type = list(/mob/living/simple_animal/hostile/commanded/nanomachine)

/spell/aoe_turf/conjure/summon/resomi/before_cast()
	..()
	newVars["master"] = holder

/spell/aoe_turf/conjure/summon/resomi/take_charge(mob/user = user, var/skipcharge)
	. = ..()
	var/mob/living/carbon/human/H = user
	if(H && H.shock_stage >= 30)
		H.visible_message("<b>[user]</b> drops to the floor, thrashing wildly while foam comes from their mouth.")
		H.Paralyse(20)
		H.adjustBrainLoss(10)

/obj/item/weapon/storage/bag/cash/infinite
	startswith = list(/obj/item/weapon/spacecash/bundle/c1000 = 1)


//HUMAN
/obj/item/weapon/storage/bag/cash/infinite/remove_from_storage(obj/item/W as obj, atom/new_location)
	. = ..()
	if(.)
		if(istype(W,/obj/item/weapon/spacecash)) //only matters if its spacecash.
			var/obj/item/I = new /obj/item/weapon/spacecash/bundle/c1000()
			src.handle_item_insertion(I,1)

//DIONA
/spell/aoe_turf/conjure/grove/gestalt
	name = "Convert Gestalt"
	desc = "Converts the surrounding area into a Dionaea gestalt."

	school = "racial"
	spell_flags = 0
	invocation_type = SpI_EMOTE
	invocation = "rumbles as green alien plants grow quickly along the floor."

	charge_type = Sp_HOLDVAR
	holder_var_type = "bruteloss"
	holder_var_amount = 20

	spell_flags = Z2NOCAST | IGNOREPREV | IGNOREDENSE
	summon_type = list(/turf/simulated/floor/diona)
	seed_type = /datum/seed/diona

	hud_state = "wiz_diona"

//SKRELL
/obj/item/weapon/contract/apprentice/skrell
	name = "skrellian apprenticeship contract"
	var/obj/item/weapon/spellbook/linked
	color = "#3366ff"
	contract_spells = list(/spell/contract/return_master) //somewhat of a necessity due to how many spells they would have after a while.

/obj/item/weapon/contract/apprentice/skrell/New(var/newloc,var/spellbook, var/owner)
	..()
	if(istype(spellbook,/obj/item/weapon/spellbook))
		linked = spellbook
	if(istype(owner,/mob))
		contract_master = owner

/obj/item/weapon/contract/apprentice/skrell/attack_self(mob/user as mob)
	if(!linked)
		user << "<span class='warning'>This contract requires a link to a spellbook.</span>"
		return
	..()

/obj/item/weapon/contract/apprentice/skrell/afterattack(atom/A, mob/user as mob, proximity)
	if(!linked && istype(A,/obj/item/weapon/spellbook))
		linked = A
		user << "<span class='notice'>You've linked \the [A] to \the [src]</span>"
		return
	..()

/obj/item/weapon/contract/apprentice/skrell/contract_effect(mob/user as mob)
	. = ..()
	if(.)
		linked.uses += 0.5
		var/obj/item/I = new /obj/item/weapon/contract/apprentice/skrell(get_turf(src),linked,contract_master)
		user.put_in_hands(I)
		new /obj/item/weapon/contract/apprentice/skrell(get_turf(src),linked,contract_master)

/mob/observer/eye/wizard_eye
	name_sufix = "Wizard Eye"

/mob/observer/eye/wizard_eye/New() //we dont use the Ai one because it has AI specific procs imbedded in it.
	..()
	visualnet = cameranet

/mob/living/proc/release_eye()
	set name = "Release Vision"
	set desc = "Return your sight to your body."
	set category = "Abilities"

	verbs -= /mob/living/proc/release_eye //regardless of if we have an eye or not we want to get rid of this verb.

	if(!eyeobj)
		return
	eyeobj.release(src)
