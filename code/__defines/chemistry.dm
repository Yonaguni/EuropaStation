#define DEFAULT_HUNGER_FACTOR 0.05 // Factor of how fast mob nutrition decreases

#define REM 0.2 // Means 'Reagent Effect Multiplier'. This is how many units of reagent are consumed per tick

#define CHEM_TOUCH 1
#define CHEM_INGEST 2
#define CHEM_BLOOD 3

#define MINIMUM_CHEMICAL_VOLUME 0.01

#define SOLID 1
#define LIQUID 2
#define GAS 3

#define REAGENTS_OVERDOSE 30

#define CHEM_SYNTH_ENERGY 500 // How much energy does it take to synthesize 1 unit of chemical, in Joules.

// Some on_mob_life() procs check for nonhumans.
#define IS_CORVID 1

#define CE_STABLE           "stable" // Adrenaline
#define CE_ANTIBIOTIC       "antibiotic" // Spaceacilin
#define CE_BLOODRESTORE     "bloodrestore" // Iron/nutriment
#define CE_PAINKILLER       "painkiller"
#define CE_ALCOHOL          "alcohol" // Liver filtering
#define CE_ALCOHOL_TOXIC    "alcotoxic" // Liver damage
#define CE_SPEEDBOOST       "gofast" // jumpstart
#define CE_PULSE            "xcardic" // increases or decreases heart rate
#define CE_NOPULSE          "heartstop" // stops heartbeat
#define CE_ANTIRAD          "antirad" // Reduces radiation.
#define CE_DRUG_SUPPRESSANT "drugsuppress"
#define CE_PACIFIED         "pacified"
#define CE_THIRDEYE         "thirdeye"
#define CE_BERSERK          "berserk"

//reagent flags
#define IGNORE_MOB_SIZE 0x1
#define AFFECTS_DEAD    0x2