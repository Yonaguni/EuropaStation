var/list/medication_name_to_reagent_id = list()
var/list/reagent_id_to_medication_name = list()
var/list/medicine_name_to_color =        list()
var/list/medicine_name_to_bottle_label = list()
var/list/medicine_name_to_bottle_state = list()
var/list/medicine_name_to_pill_state =   list()
var/list/reagent_bottle_overlays =       list()
var/list/reagent_syringe_overlays =      list()

var/list/medicine_syllables = list(
	"o", "a","flu","o","me","phyto","doce","tha","facto","bena","zeco","ni",
	"me","pro","dize","da","lde","ta","to","ba","re","mbi","no","ffi",
	"niu","ven","pedi","lo","tre","pilo","paro","xeti","xyco","lio"
	)

var/list/medicine_endings = list(
	"zole","scept","ban","rone","mide","vir","max","fine","zac","trol",
	"phen","m","tam", "gen", "tol", "dine","ne","taine"
	)

/proc/get_random_medication_name_for_reagent(var/reagent_id)
	if(isnull(reagent_id_to_medication_name[reagent_id]))
		create_medication_name_for(reagent_id)
	return reagent_id_to_medication_name[reagent_id]

/proc/create_medication_name_for(var/reagent_id)
	var/result
	while(isnull(result) || !isnull(medication_name_to_reagent_id[result]))
		var/syllables = rand(2,3)
		var/last_syllable
		while(syllables)
			syllables--
			var/next_syllable = pick(medicine_syllables)
			while(last_syllable == next_syllable)
				next_syllable = pick(medicine_syllables)
			result += next_syllable
			last_syllable = next_syllable
		result = capitalize(result + pick(medicine_endings))
	medication_name_to_reagent_id[result] = reagent_id
	reagent_id_to_medication_name[reagent_id] = result
