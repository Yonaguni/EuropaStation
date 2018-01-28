var/list/psychokinetic_faculty = list(
	new /decl/psipower/psychokinesis/psiblade(),
	new /decl/psipower/psychokinesis/tinker()
	)

/decl/psipower/psychokinesis
	faculty = PSI_PSYCHOKINESIS
	use_manifest = TRUE

/decl/psipower/psychokinesis/psiblade
	name =            "Psiblade"
	cost =            20
	cooldown =        200
	min_rank =        PSI_RANK_OPERANT
	use_description = "Click on or otherwise activate an empty hand while on harm intent to manifest a psychokinetic cutting blade. The power the blade will vary based on your mastery of the faculty."
	admin_log = FALSE

/decl/psipower/psychokinesis/psiblade/invoke(var/mob/living/user, var/mob/living/target)
	if((target && user != target) || user.a_intent != I_HURT)
		return FALSE
	. = ..()
	if(.)
		switch(user.psi.get_rank(faculty))
			if(PSI_RANK_PARAMOUNT)
				return new /obj/item/psychic_power/psiblade/master/grand/paramount(user, user)
			if(PSI_RANK_GRANDMASTER)
				return new /obj/item/psychic_power/psiblade/master/grand(user, user)
			if(PSI_RANK_MASTER)
				return new /obj/item/psychic_power/psiblade/master(user, user)
			else
				return new /obj/item/psychic_power/psiblade(user, user)

/decl/psipower/psychokinesis/tinker
	name =            "Tinker"
	cost =            5
	cooldown =        50
	min_rank =        PSI_RANK_MASTER
	use_description = "Click on or otherwise activate an empty hand while on help intent to manifest a psychokinetic tool. Use it in-hand to switch between tool types."
	admin_log = FALSE

/decl/psipower/psychokinesis/tinker/invoke(var/mob/living/user, var/mob/living/target)
	if((target && user != target) || user.a_intent != I_HELP)
		return FALSE
	. = ..()
	if(.)
		return new /obj/item/psychic_power/tinker(user)
