/decl/aspect/psi
	name = ASPECT_PSI_ROOT
	desc = "Sometimes, before you sleep, you hear the whispering of other minds."
	category = "Psychic Operancy"
	aspect_flags = ASPECTS_MENTAL

	var/assoc_faculty
	var/assoc_rank = 0

/decl/aspect/psi/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(. && assoc_faculty && assoc_rank)
		holder.set_psi_rank(assoc_faculty, assoc_rank, take_larger = TRUE, defer_update = TRUE)

// COERCIVE
/decl/aspect/psi/coercion
	name = ASPECT_PSI_COERCION_L
	desc = "You possess latent coercive powers."
	parent_name =   ASPECT_PSI_ROOT
	assoc_faculty = PSI_COERCION
	assoc_rank =    PSI_RANK_LATENT

/decl/aspect/psi/coercion_operant
	name = ASPECT_PSI_COERCION_O
	desc = "Your coercive faculty is fully awakened."
	parent_name = ASPECT_PSI_COERCION_L
	assoc_rank =  PSI_RANK_OPERANT
	aspect_cost = 2

/decl/aspect/psi/coercion_master
	name = ASPECT_PSI_COERCION_MC
	desc = "You have trained extensively in mastering your coercive faculty."
	parent_name = ASPECT_PSI_COERCION_O
	assoc_rank =  PSI_RANK_MASTER
	aspect_cost = 2

/decl/aspect/psi/coercion_grandmaster
	name = ASPECT_PSI_COERCION_GMC
	desc = "You are a recognised and gifted grand master of the coercive faculty."
	parent_name = ASPECT_PSI_COERCION_MC
	assoc_rank =  PSI_RANK_GRANDMASTER
	aspect_cost = 3

// CREATIVE
/decl/aspect/psi/creative
	name = ASPECT_PSI_CREATIVE_L
	desc = "You possess latent energistic powers."
	parent_name =   ASPECT_PSI_ROOT
	assoc_faculty = PSI_ENERGISTICS
	assoc_rank =    PSI_RANK_LATENT

/decl/aspect/psi/creative_operant
	name = ASPECT_PSI_CREATIVE_O
	desc = "Your energistic faculty is fully awakened."
	parent_name = ASPECT_PSI_CREATIVE_L
	assoc_rank =  PSI_RANK_OPERANT
	aspect_cost = 2

/decl/aspect/psi/creative_master
	name = ASPECT_PSI_CREATIVE_MC
	desc = "You have trained extensively in mastering your energistic faculty."
	parent_name = ASPECT_PSI_CREATIVE_O
	assoc_rank =  PSI_RANK_MASTER
	aspect_cost = 2

/decl/aspect/psi/creative_grandmaster
	name = ASPECT_PSI_CREATIVE_GMC
	desc = "You are a recognised and gifted grand master of the energistic faculty."
	parent_name = ASPECT_PSI_CREATIVE_MC
	assoc_rank =  PSI_RANK_GRANDMASTER
	aspect_cost = 3

// PSYCHOKINETIC
/decl/aspect/psi/psychokinesis
	name = ASPECT_PSI_PKINESIS_L
	desc = "You possess latent psychokinetic powers."
	parent_name =   ASPECT_PSI_ROOT
	assoc_faculty = PSI_PSYCHOKINESIS
	assoc_rank =    PSI_RANK_LATENT

/decl/aspect/psi/psychokinesis_operant
	name = ASPECT_PSI_PKINESIS_O
	desc = "Your psychokinetic faculty is fully awakened."
	parent_name = ASPECT_PSI_PKINESIS_L
	assoc_rank =  PSI_RANK_OPERANT
	aspect_cost = 2

/decl/aspect/psi/psychokinesis_master
	name = ASPECT_PSI_PKINESIS_MC
	desc = "You have trained extensively in mastering your psychokinetic faculty."
	parent_name = ASPECT_PSI_PKINESIS_O
	assoc_rank =  PSI_RANK_MASTER
	aspect_cost = 2

/decl/aspect/psi/psychokinesis_grandmaster
	name = ASPECT_PSI_PKINESIS_GMC
	desc = "You are a recognised and gifted grand master of the psychokinetic faculty."
	parent_name = ASPECT_PSI_PKINESIS_MC
	assoc_rank =  PSI_RANK_GRANDMASTER
	aspect_cost = 3

// REDACTIVE
/decl/aspect/psi/redaction
	name = ASPECT_PSI_REDACTOR_L
	desc = "You possess latent biokinetic powers."
	parent_name =   ASPECT_PSI_ROOT
	assoc_faculty = PSI_REDACTION
	assoc_rank =    PSI_RANK_LATENT

/decl/aspect/psi/redaction_operant
	name = ASPECT_PSI_REDACTOR_O
	desc = "Your biokinetic faculty is fully awakened."
	parent_name = ASPECT_PSI_REDACTOR_L
	assoc_rank =  PSI_RANK_OPERANT
	aspect_cost = 2

/decl/aspect/psi/redaction_master
	name = ASPECT_PSI_REDACTOR_MC
	desc = "You have trained extensively in mastering your biokinetic faculty."
	parent_name = ASPECT_PSI_REDACTOR_O
	assoc_rank =  PSI_RANK_MASTER
	aspect_cost = 2

/decl/aspect/psi/redaction_grandmaster
	name = ASPECT_PSI_REDACTOR_GMC
	desc = "You are a recognised and gifted grand master of the biokinetic faculty."
	parent_name = ASPECT_PSI_REDACTOR_MC
	assoc_rank =  PSI_RANK_GRANDMASTER
	aspect_cost = 3
