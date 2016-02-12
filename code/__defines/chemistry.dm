#define HUNGER_FACTOR              0.05 // Factor of how fast mob nutrition decreases
#define THIRST_FACTOR              0.05

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

// Some on_mob_life() procs check for alien races.
#define IS_SKRELL  1
#define IS_XENOS   2

#define CE_STABLE                "stable" // Adrenaline
#define CE_ANTIBIOTIC            "antibiotic" // Spaceacilin
#define CE_BLOODRESTORE          "bloodrestore" // Iron/nutriment
#define CE_PAINKILLER            "painkiller"
#define CE_ALCOHOL               "alcohol" // Liver filtering
#define CE_ALCOHOL_TOXIC         "alcotoxic" // Liver damage
#define CE_SPEEDBOOST            "gofast" // jumpstart

// Food
#define REAGENT_ID_NUTRIMENT     "nutriment"
#define REAGENT_ID_PROTEIN       "protein"
#define REAGENT_ID_EGG           "egg"
#define REAGENT_ID_HONEY         "honey"
#define REAGENT_ID_FLOUR         "flour"
#define REAGENT_ID_COCOA         "cocoa"
#define REAGENT_ID_SOYSAUCE      "soysauce"
#define REAGENT_ID_KETCHUP       "ketchup"
#define REAGENT_ID_RICE          "rice"
#define REAGENT_ID_SALT          "sodiumchloride"
#define REAGENT_ID_PEPPER        "blackpepper"
#define REAGENT_ID_ENZYME        "enzyme"
#define REAGENT_ID_SUGAR         "sugar"
#define REAGENT_ID_MILK          "milk"
#define REAGENT_ID_GELATINE      "gelatine"
#define REAGENT_ID_CREAM         "cream"
#define REAGENT_ID_GIN           "gin"
#define REAGENT_ID_WHISKEY       "whiskey"
#define REAGENT_ID_VODKA         "vodka"
#define REAGENT_ID_TEQUILlA      "tequilla"
#define REAGENT_ID_RUM           "rum"
#define REAGENT_ID_WINE          "wine"
#define REAGENT_ID_ABSINTHE      "absinthe"
#define REAGENT_ID_BEER          "beer"
#define REAGENT_ID_LEMONADE      "lemonade"
#define REAGENT_ID_COLA          "cola"

// Drugs
#define REAGENT_ID_ADRENALINE    "adrenaline"
#define REAGENT_ID_SLEEPTOX      "stoxin"
#define REAGENT_ID_MORPHINE      "morphine"
#define REAGENT_ID_ANTITOX       "anti_toxin"
#define REAGENT_ID_JUMPSTART     "jumpstart"
#define REAGENT_ID_ETHANOL       "ethanol"
#define REAGENT_ID_ANTIRAD       "antirad"
#define REAGENT_ID_ANTIBIOTIC    "antibiotic"
#define REAGENT_ID_TOXIN         "toxin"
#define REAGENT_ID_NICOTINE      "nicotine"

// Other
#define REAGENT_ID_WATER         "water"
#define REAGENT_ID_CRAYON        "crayon_dust"
#define REAGENT_ID_CRAYON_RED    "crayon_dust_red"
#define REAGENT_ID_CRAYON_ORANGE "crayon_dust_orange"
#define REAGENT_ID_CRAYON_YELLOW "crayon_dust_yellow"
#define REAGENT_ID_CRAYON_GREEN  "crayon_dust_green"
#define REAGENT_ID_CRAYON_BLUE   "crayon_dust_blue"
#define REAGENT_ID_CRAYON_PURPLE "crayon_dust_purple"
#define REAGENT_ID_CRAYON_GREY   "crayon_dust_grey"
#define REAGENT_ID_CRAYON_BROWN  "crayon_dust_brown"
#define REAGENT_ID_CARBON        "carbon"
#define REAGENT_ID_FUEL          "fuel"
#define REAGENT_ID_LUMINOL       "luminol"
#define REAGENT_ID_THERMITE      "thermite"
#define REAGENT_ID_CLEANER       "cleaner"
#define REAGENT_ID_PAINT         "paint"
#define REAGENT_ID_BLOOD         "blood"
#define REAGENT_ID_ACID          "sacid"
#define REAGENT_ID_ANTISEPTIC    "antiseptic"
#define REAGENT_ID_WOOD          "woodpulp"
#define REAGENT_ID_OXYGEN         "oxygen"
#define REAGENT_ID_CARBONDIOXIDE  "carbon_dioxide"
#define REAGENT_ID_NITROGEN       "nitrogen"
#define REAGENT_ID_N2O            "sleeping_agent"

// Chemistry lists.
var/list/tachycardics  = list(REAGENT_ID_ADRENALINE, REAGENT_ID_JUMPSTART, REAGENT_ID_NICOTINE) // Increase heart rate.
var/list/bradycardics  = list(REAGENT_ID_SLEEPTOX, REAGENT_ID_MORPHINE)                 // Decrease heart rate.
