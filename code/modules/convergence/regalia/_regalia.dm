var/const/REGALIA_ORB =   "orb"
var/const/REGALIA_ROD =   "rod"
var/const/REGALIA_CROWN = "crown"

var/list/all_convergence_regalia = list()

/obj/item/convergence
	icon = 'icons/obj/regalia.dmi'
	var/mob/living/presence/sanctified_to
	var/regalia_type

/obj/item/convergence/New(var/newloc, var/mob/living/presence/_owner)
	..()
	all_convergence_regalia[src] = TRUE
	sanctified_to = _owner
	update_from_presence()

/obj/item/convergence/Destroy()
	all_convergence_regalia -= src
	sanctified_to = null
	. = ..()

/obj/item/convergence/proc/update_from_presence()
	if(regalia_type)
		w_class = sanctified_to.presence.get_regalia_size(src)
	item_state = icon_state

/obj/item/convergence/attack(var/atom/target, var/mob/user)
	if(regalia_type && godtouched.is_antagonist(user.mind, sanctified_to) && sanctified_to.presence.regalia_melee_attack_used(user, target, src))
		return TRUE
	. = ..()

/obj/item/convergence/afterattack(var/atom/target, var/mob/user, var/proximity)
	if(regalia_type && godtouched.is_antagonist(user.mind, sanctified_to) && !proximity)
		sanctified_to.presence.regalia_ranged_attack_used(user, target, src)

/obj/item/convergence/attack_self(var/mob/user)
	if(regalia_type && godtouched.is_antagonist(user.mind, sanctified_to)) sanctified_to.presence.regalia_used_in_hand(user, src)
