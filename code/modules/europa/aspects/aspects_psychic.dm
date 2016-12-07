/decl/aspect/psi
	name = ASPECT_PSI_ROOT
	desc = "Sometimes, before you sleep, you hear the whispering of other minds."
	category = "Psychic Operancy"

	var/assoc_faculty
	var/assoc_rank = 0

/decl/aspect/psi/do_post_spawn(var/mob/living/carbon/human/holder)
	if(!istype(holder))
		return
	if(assoc_faculty && assoc_rank && holder.mind)
		var/datum/psychic_power_assay/assay = holder.mind.psychic_faculties[assoc_faculty]
		if(!assay)
			assay = new(holder.mind, all_psychic_faculties[assoc_faculty])
			holder.mind.psychic_faculties[assoc_faculty] = assay
		if(assoc_rank > assay.rank)
			assay.set_rank(assoc_rank, silent=1)

// COERCIVE
/decl/aspect/psi/coercion
	name = ASPECT_PSI_COERCION_L
	desc = "You possess latent coercive powers."
	parent_name = ASPECT_PSI_ROOT
	assoc_faculty = PSYCHIC_COERCION
	assoc_rank = 1

/decl/aspect/psi/coercion/operant
	name = ASPECT_PSI_COERCION_O
	desc = "Your coercive faculty is fully awakened."
	parent_name = ASPECT_PSI_COERCION_L
	assoc_rank = 2
	aspect_cost = 2

/decl/aspect/psi/coercion/master
	name = ASPECT_PSI_COERCION_MC
	desc = "You have trained extensively in mastering your coercive faculty."
	parent_name = ASPECT_PSI_COERCION_O
	assoc_rank = 3
	aspect_cost = 2

/decl/aspect/psi/coercion/grandmaster
	name = ASPECT_PSI_COERCION_GMC
	desc = "You are a recognised and gifted grand master of the coercive faculty."
	parent_name = ASPECT_PSI_COERCION_MC
	assoc_rank = 4
	aspect_cost = 3

// FARSENSE
/decl/aspect/psi/farsensing
	name = ASPECT_PSI_FARSENSE_L
	desc = "You possess latent farsensing powers."
	parent_name = ASPECT_PSI_ROOT
	assoc_faculty = PSYCHIC_FARSENSE
	assoc_rank = 1

/decl/aspect/psi/farsensing/operant
	name = ASPECT_PSI_FARSENSE_O
	desc = "Your farsensing faculty is fully awakened."
	parent_name = ASPECT_PSI_FARSENSE_L
	assoc_rank = 2
	aspect_cost = 2

/decl/aspect/psi/farsensing/master
	name = ASPECT_PSI_FARSENSE_MC
	desc = "You have trained extensively in mastering your farsensing faculty."
	parent_name = ASPECT_PSI_FARSENSE_O
	assoc_rank = 3
	aspect_cost = 2

/decl/aspect/psi/farsensing/grandmaster
	name = ASPECT_PSI_FARSENSE_GMC
	desc = "You are a recognised and gifted grand master of the farsensing faculty."
	parent_name = ASPECT_PSI_FARSENSE_MC
	assoc_rank = 4
	aspect_cost = 3

// CREATIVE
/decl/aspect/psi/creative
	name = ASPECT_PSI_CREATIVE_L
	desc = "You possess latent creative powers."
	parent_name = ASPECT_PSI_ROOT
	assoc_faculty = PSYCHIC_CREATIVITY
	assoc_rank = 1

/decl/aspect/psi/creative/operant
	name = ASPECT_PSI_CREATIVE_O
	desc = "Your creative faculty is fully awakened."
	parent_name = ASPECT_PSI_CREATIVE_L
	assoc_rank = 2
	aspect_cost = 2

/decl/aspect/psi/creative/master
	name = ASPECT_PSI_CREATIVE_MC
	desc = "You have trained extensively in mastering your creative faculty."
	parent_name = ASPECT_PSI_CREATIVE_O
	assoc_rank = 3
	aspect_cost = 2

/decl/aspect/psi/creative/grandmaster
	name = ASPECT_PSI_CREATIVE_GMC
	desc = "You are a recognised and gifted grand master of the creative faculty."
	parent_name = ASPECT_PSI_CREATIVE_MC
	assoc_rank = 4
	aspect_cost = 3

// PSYCHOKINETIC
/decl/aspect/psi/psychokinesis
	name = ASPECT_PSI_PKINESIS_L
	desc = "You possess latent psychokinetic powers."
	parent_name = ASPECT_PSI_ROOT
	assoc_faculty = PSYCHIC_PSYCHOKINESIS
	assoc_rank = 1

/decl/aspect/psi/psychokinesis/operant
	name = ASPECT_PSI_PKINESIS_O
	desc = "Your psychokinetic faculty is fully awakened."
	parent_name = ASPECT_PSI_PKINESIS_L
	assoc_rank = 2
	aspect_cost = 2

/decl/aspect/psi/psychokinesis/master
	name = ASPECT_PSI_PKINESIS_MC
	desc = "You have trained extensively in mastering your psychokinetic faculty."
	parent_name = ASPECT_PSI_PKINESIS_O
	assoc_rank = 3
	aspect_cost = 2

/decl/aspect/psi/psychokinesis/grandmaster
	name = ASPECT_PSI_PKINESIS_GMC
	desc = "You are a recognised and gifted grand master of the psychokinetic faculty."
	parent_name = ASPECT_PSI_PKINESIS_MC
	assoc_rank = 4
	aspect_cost = 3

// REDACTIVE
/decl/aspect/psi/redaction
	name = ASPECT_PSI_REDACTOR_L
	desc = "You possess latent redactive powers."
	parent_name = ASPECT_PSI_ROOT
	assoc_faculty = PSYCHIC_REDACTION
	assoc_rank = 1

/decl/aspect/psi/redaction/operant
	name = ASPECT_PSI_REDACTOR_O
	desc = "Your redactive faculty is fully awakened."
	parent_name = ASPECT_PSI_REDACTOR_L
	assoc_rank = 2
	aspect_cost = 2

/decl/aspect/psi/redaction/master
	name = ASPECT_PSI_REDACTOR_MC
	desc = "You have trained extensively in mastering your redactive faculty."
	parent_name = ASPECT_PSI_REDACTOR_O
	assoc_rank = 3
	aspect_cost = 2

/decl/aspect/psi/redaction/grandmaster
	name = ASPECT_PSI_REDACTOR_GMC
	desc = "You are a recognised and gifted grand master of the redactive faculty."
	parent_name = ASPECT_PSI_REDACTOR_MC
	assoc_rank = 4
	aspect_cost = 3
