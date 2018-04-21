/decl/aspect/psi
	name = ASPECT_PSI_ROOT
	desc = "Sometimes, before you sleep, you hear the whispering of other minds."
	category = "Psionics"
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
	desc = "You possess latent mind control powers, known as the coercive faculty."
	parent_name =   ASPECT_PSI_ROOT
	assoc_faculty = PSI_COERCION
	assoc_rank =    PSI_RANK_LATENT

/decl/aspect/psi/coercion/operant
	name = ASPECT_PSI_COERCION_O
	desc = "Your coercive faculty is fully awakened, and you can strike people blind."
	parent_name = ASPECT_PSI_COERCION_L
	assoc_rank =  PSI_RANK_OPERANT
	aspect_cost = 2

/decl/aspect/psi/coercion/master
	name = ASPECT_PSI_COERCION_MC
	desc = "You have trained extensively in mastering your coercive faculty, and are capable of inflicting crippling agony in melee combat."
	parent_name = ASPECT_PSI_COERCION_O
	assoc_rank =  PSI_RANK_MASTER
	aspect_cost = 2

/decl/aspect/psi/coercion/grandmaster
	name = ASPECT_PSI_COERCION_GMC
	desc = "You are a recognised grandmaster of the coercive faculty, and are capable of causing muscular spasms at long range."
	parent_name = ASPECT_PSI_COERCION_MC
	assoc_rank =  PSI_RANK_GRANDMASTER
	aspect_cost = 3

// CREATIVE
/decl/aspect/psi/creative
	name = ASPECT_PSI_CREATIVE_L
	desc = "You possess latent powers in manipulating energy, known as the energistic faculty."
	parent_name =   ASPECT_PSI_ROOT
	assoc_faculty = PSI_ENERGISTICS
	assoc_rank =    PSI_RANK_LATENT

/decl/aspect/psi/creative/operant
	name = ASPECT_PSI_CREATIVE_O
	desc = "Your energistic faculty is fully awakened, allowing you to project an electrolaser at will."
	parent_name = ASPECT_PSI_CREATIVE_L
	assoc_rank =  PSI_RANK_OPERANT
	aspect_cost = 2

/decl/aspect/psi/creative/master
	name = ASPECT_PSI_CREATIVE_MC
	desc = "You have trained extensively in mastering your energistic faculty. Your mental laser is more powerful, and you can incite localized electromagnetic pulses."
	parent_name = ASPECT_PSI_CREATIVE_O
	assoc_rank =  PSI_RANK_MASTER
	aspect_cost = 2

/decl/aspect/psi/creative/grandmaster
	name = ASPECT_PSI_CREATIVE_GMC
	desc = "You are a recognised grandmaster of the energistic faculty. You are capable of inducing a deadly electrical current at a touch, and your mental laser is on par with many military weapons."
	parent_name = ASPECT_PSI_CREATIVE_MC
	assoc_rank =  PSI_RANK_GRANDMASTER
	aspect_cost = 3

// PSYCHOKINETIC
/decl/aspect/psi/psychokinesis
	name = ASPECT_PSI_PKINESIS_L
	desc = "You possess latent telekinetic powers, known as the psychokinetic faculty."
	parent_name =   ASPECT_PSI_ROOT
	assoc_faculty = PSI_PSYCHOKINESIS
	assoc_rank =    PSI_RANK_LATENT

/decl/aspect/psi/psychokinesis/operant
	name = ASPECT_PSI_PKINESIS_O
	desc = "Your psychokinetic faculty is fully awakened, allowing you to project a psionic blade."
	parent_name = ASPECT_PSI_PKINESIS_L
	assoc_rank =  PSI_RANK_OPERANT
	aspect_cost = 2

/decl/aspect/psi/psychokinesis/master
	name = ASPECT_PSI_PKINESIS_MC
	desc = "You have trained extensively in mastering your psychokinetic faculty. Your fine control is such that you rarely need physical tools, and your psiblade is more powerful."
	parent_name = ASPECT_PSI_PKINESIS_O
	assoc_rank =  PSI_RANK_MASTER
	aspect_cost = 2

/decl/aspect/psi/psychokinesis/grandmaster
	name = ASPECT_PSI_PKINESIS_GMC
	desc = "You are a recognised grandmaster of the psychokinetic faculty. Your psiblade is lethally powerful, and your telekinetic power is such that you can manipulate and throw objects at a distance."
	parent_name = ASPECT_PSI_PKINESIS_MC
	assoc_rank =  PSI_RANK_GRANDMASTER
	aspect_cost = 3

// REDACTIVE
/decl/aspect/psi/redaction
	name = ASPECT_PSI_REDACTOR_L
	desc = "You possess latent healing powers, known as biokinesis, or the redactive faculty."
	parent_name =   ASPECT_PSI_ROOT
	assoc_faculty = PSI_REDACTION
	assoc_rank =    PSI_RANK_LATENT

/decl/aspect/psi/redaction/operant
	name = ASPECT_PSI_REDACTOR_O
	desc = "Your redactive faculty is fully awakened. You can appraise damage to an organic creature with a simple touch."
	parent_name = ASPECT_PSI_REDACTOR_L
	assoc_rank =  PSI_RANK_OPERANT
	aspect_cost = 2

/decl/aspect/psi/redaction/master
	name = ASPECT_PSI_REDACTOR_MC
	desc = "You have trained extensively in mastering your redactive faculty. You are capable of mending broken bones and bleeding at will."
	parent_name = ASPECT_PSI_REDACTOR_O
	assoc_rank =  PSI_RANK_MASTER
	aspect_cost = 2

/decl/aspect/psi/redaction/grandmaster
	name = ASPECT_PSI_REDACTOR_GMC
	desc = "You are a recognised grandmaster of the redactive faculty, and are capable of cleansing organic bodies of radiation, mending genetic damage, and purging poisons."
	parent_name = ASPECT_PSI_REDACTOR_MC
	assoc_rank =  PSI_RANK_GRANDMASTER
	aspect_cost = 3

/*
#define ASPECT_PSI_TENURE_REDACTIVE     "Professor of Biokinetics"
#define ASPECT_PSI_TENURE_COERCIVE      "Professor of Neural Interdiction"
#define ASPECT_PSI_TENURE_ENERGISTIC    "Professor of High-Energy Phenomena"
#define ASPECT_PSI_TENURE_PSYCHOKINETIC "Professor of Applied Telephysics"

/decl/aspect/psi_tenure
	name = ASPECT_PSI_TENURE_REDACTIVE
	desc = "You have a tenured position with the Cuchulain Foundation in the Redactive School, and are entitled to their support."
	category = "Psionics"
	aspect_cost = 1
	parent_name = ASPECT_PSI_REDACTOR_MC
	var/assoc_faculty = PSI_REDACTION

/decl/aspect/psi_tenure/coercive
	name = ASPECT_PSI_TENURE_COERCIVE
	desc = "You have a tenured position with the Cuchulain Foundation in the Coercive School, and are entitled to their support."
	parent_name = ASPECT_PSI_COERCIVE_MC
	assoc_faculty = PSI_REDACTION

/decl/aspect/psi_tenure/energistic
	name = ASPECT_PSI_TENURE_ENERGISTIC
	desc = "You have a tenured position with the Cuchulain Foundation in the Energistic School, and are entitled to their support."
	parent_name = ASPECT_PSI_CREATIVE_MC
	assoc_faculty = PSI_ENERGISTICS

/decl/aspect/psi_tenure/psychokinetic
	name = ASPECT_PSI_TENURE_PSYCHOKINETIC
	desc = "You have a tenured position with the Cuchulain Foundation in the Psychokinetic School, and are entitled to their support."
	assoc_faculty = PSI_REDACTION
	parent_name = ASPECT_PSI_PKINETIC_MC
*/