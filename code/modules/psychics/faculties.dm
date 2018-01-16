var/const/PSI_COERCION =      "coercion"
var/const/PSI_PSYCHOKINESIS = "psychokinesis"
var/const/PSI_REDACTION =     "redaction"
var/const/PSI_ENERGISTICS =   "energistics"
//var/const/PSI_INTERROGATIVE = "interrogative"
//var/const/PSI_PROCATALEPTIC = "procataleptic"

var/const/PSI_RANK_BLUNT =       0
var/const/PSI_RANK_LATENT =      1
var/const/PSI_RANK_OPERANT =     2
var/const/PSI_RANK_MASTER =      3
var/const/PSI_RANK_GRANDMASTER = 4
var/const/PSI_RANK_PARAMOUNT =   5

var/static/list/intent_to_psi_faculty = list(
	"[I_HURT]" =   "[PSI_ENERGISTICS]",
	"[I_HELP]" =   "[PSI_REDACTION]",
	"[I_GRAB]" =   "[PSI_PSYCHOKINESIS]",
	"[I_DISARM]" = "[PSI_COERCION]",
	)

var/static/list/psychic_ranks_to_strings = list(
	"Latent",
	"Operant",
	"Masterclass",
	"Grandmasterclass",
	"Paramount"
	)

var/static/list/psychic_strings_to_ids = list(
	"Coercion" =      "[PSI_COERCION]",
	"Psychokinesis" = "[PSI_PSYCHOKINESIS]",
	"Redaction" =     "[PSI_REDACTION]",
	"Energistics" =   "[PSI_ENERGISTICS]"
//	"Interrogation" = "[PSI_INTERROGATIVE]",
//	"Procatalepsis" = "[PSI_PROCATALEPTIC]"
	)

var/static/list/psychic_ids_to_strings = list(
	"[PSI_COERCION]" =      "Coercive",
	"[PSI_PSYCHOKINESIS]" = "Psychokinetic",
	"[PSI_REDACTION]" =     "Redactive",
	"[PSI_ENERGISTICS]" =   "Energistic"
//	"[PSI_INTERROGATIVE]" = "Interrogative",
//	"[PSI_PROCATALEPTIC]" = "Procataleptic"
	)
