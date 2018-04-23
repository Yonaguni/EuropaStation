#define HAS_ASPECT(holder, check_aspect) (ismob(holder) && LAZYLEN(holder.personal_aspects_by_name) && holder.personal_aspects_by_name[check_aspect])

#define ADD_ASPECT(holder, add_aspect) \
	if(!HAS_ASPECT(holder, add_aspect)) { \
		var/decl/aspect/A = aspects_by_name[add_aspect]; \
		if(holder && istype(A)) { \
			if(!holder.personal_aspects_by_name) holder.personal_aspects_by_name = list(); \
			if(!holder.personal_aspects)         holder.personal_aspects = list(); \
			holder.personal_aspects += A; \
			holder.personal_aspects_by_name[add_aspect] = TRUE; \
			holder.need_aspect_sort = TRUE; \
			A.apply(holder); \
		} \
	}

#define ASPECTS_PHYSICAL  1
#define ASPECTS_MENTAL    2
#define ASPECTS_EQUIPMENT 4

// General aspects.
#define ASPECT_HOTSTUFF         "Hot Stuff"
#define ASPECT_HARDY            "Hardy"
#define ASPECT_THICKBONES       "Thick Bones"
#define ASPECT_SCARRED          "Scarred"
#define ASPECT_APPRAISER        "Appraiser"
#define ASPECT_SHARPEYED        "Sharp-Eyed"
#define ASPECT_RADHARDENED      "Lead Poisoning"
#define ASPECT_UNCANNY          "Uncanny"
#define ASPECT_FRAGILE          "Fragile"
#define ASPECT_GLASS_BONES      "Glass Bones"
#define ASPECT_PAPER_SKIN       "Paper Skin"
#define ASPECT_HAEMOPHILE       "Haemophile"
#define ASPECT_GROUNDBREAKER    "Groundbreaker"
#define ASPECT_HANDYMAN         "Handyman"
#define ASPECT_FIRSTAID         "First Responder"
#define ASPECT_SAWBONES         "Sawbones"
#define ASPECT_GUNSMITH         "Gunsmith"
#define ASPECT_MARKSMAN         "Marksman"
#define ASPECT_DUALWIELD        "Guns Akimbo"
#define ASPECT_BASICGUNS        "Person of Caliber"
#define ASPECT_HACKER           "Hackerman"
#define ASPECT_COMPANYMAN       "Company Man"
#define ASPECT_JUNKIE           "Junkie"
#define ASPECT_GREENTHUMB       "Green Thumb"
#define ASPECT_NINJA            "Knife Thrower"
#define ASPECT_TRIBAL           "Tribal"
#define ASPECT_MEATY            "Big Hands"
#define ASPECT_CLUMSY           "Clumsy"
#define ASPECT_EPILEPTIC        "Epileptic"
#define ASPECT_ASTHMATIC        "Asthmatic"
#define ASPECT_NEARSIGHTED      "Nearsighted"
#define ASPECT_NERVOUS          "Nervous"
#define ASPECT_DEAF             "Deaf"
#define ASPECT_BLIND            "Blind"

// Combat aspects
#define ASPECT_WRESTLER         "Wrestler"
#define ASPECT_BRAWLER          "Brawler"
#define ASPECT_GUNPLAY          "Gunslinger"
#define ASPECT_TASER            "Pacifier"

// Skill aspects.
#define ASPECT_DIAGNOSTICIAN    "Diagnostician"
#define ASPECT_BUILDER          "Construction Worker"
#define ASPECT_EXOSUIT_PILOT    "Exosuit Pilot"
#define ASPECT_EXOSUIT_TECH     "Exosuit Technician"
#define ASPECT_JOGGER           "Jogger"
#define ASPECT_DAREDEVIL        "Daredevil"
#define ASPECT_PHARMACIST       "Pharmacist"

// Psychic aspects.
#define ASPECT_PSI_ROOT         "Gifted"
#define ASPECT_PSI_COERCION_L   "Latent Coercive Faculty"
#define ASPECT_PSI_COERCION_O   "Operant Coercive Faculty"
#define ASPECT_PSI_COERCION_MC  "Master Coercor"
#define ASPECT_PSI_COERCION_GMC "Grandmaster Coercor"
#define ASPECT_PSI_CREATIVE_L   "Latent Energistic Faculty"
#define ASPECT_PSI_CREATIVE_O   "Operant Energistic Faculty"
#define ASPECT_PSI_CREATIVE_MC  "Master Energizer"
#define ASPECT_PSI_CREATIVE_GMC "Grandmaster Creator"
#define ASPECT_PSI_PKINESIS_L   "Latent Psychokinetic Faculty"
#define ASPECT_PSI_PKINESIS_O   "Operant Psychokinetic Faculty"
#define ASPECT_PSI_PKINESIS_MC  "Master Psychokinetic"
#define ASPECT_PSI_PKINESIS_GMC "Grandmaster Psychokinetic"
#define ASPECT_PSI_REDACTOR_L   "Latent Redactive Faculty"
#define ASPECT_PSI_REDACTOR_O   "Operant Redactive Faculty"
#define ASPECT_PSI_REDACTOR_MC  "Master Redactor"
#define ASPECT_PSI_REDACTOR_GMC "Grandmaster Redactor"

// Restricted aspects.
#define ASPECT_XRAY                  "X-Ray Vision"

// Body aspects.
#define ASPECT_AMPUTATED_LEFT_HAND   "Amputated Left Hand"
#define ASPECT_AMPUTATED_LEFT_ARM    "Amputated Left Arm"
#define ASPECT_AMPUTATED_LEFT_FOOT   "Amputated Left Foot"
#define ASPECT_AMPUTATED_LEFT_LEG    "Amputated Left Leg"
#define ASPECT_AMPUTATED_RIGHT_HAND  "Amputated Right Hand"
#define ASPECT_AMPUTATED_RIGHT_ARM   "Amputated Right Arm"
#define ASPECT_AMPUTATED_RIGHT_FOOT  "Amputated Right Foot"
#define ASPECT_AMPUTATED_RIGHT_LEG   "Amputated Right Leg"

#define ASPECT_PROSTHETIC_HEART      "Synthetic Heart"
#define ASPECT_PROSTHETIC_EYES       "Synthetic Eyes"
#define ASPECT_PROSTHETIC_KIDNEYS    "Synthetic Kidneys"
#define ASPECT_PROSTHETIC_LIVER      "Synthetic Liver"
#define ASPECT_PROSTHETIC_LUNGS      "Synthetic Lungs"
#define ASPECT_PROSTHETIC_STOMACH    "Synthetic Stomach"

#define ASPECT_NEURAL_INTERFACE      "Neural Interface"
#define ASPECT_IMPROVED_PROSTHETICS  "Improved Prosthetics"
#define ASPECT_EMP_HARDENING         "EMP Hardening"
#define ASPECT_EMP_HARDENING_PLUS    "Advanced EMP Hardening"
