//TODO syllables
/datum/language/runglish
	name = LANGUAGE_RUNGLISH
	desc = "The official language of space, first pioneered on the International Space Station in days of yore. A combination of English and Russian."
	key = "1"
	colour = "runglish"
	syllables = list("al", "an", "ar", "as", "at", "ea", "ed", "en", "er", "es", "ha", "he", "hi", "in", "is", "it",
	"le", "me", "nd", "ne", "ng", "nt", "on", "or", "ou", "re", "se", "st", "te", "th", "ti", "to",
	"ve", "wa", "all", "and", "are", "but", "ent", "era", "ere", "eve", "for", "had", "hat", "hen", "her", "hin",
	"his", "ing", "ion", "ith", "not", "ome", "oul", "our", "sho", "ted", "ter", "tha", "the", "thi",
	"rus","zem","ave","groz","ski","ska","ven","konst","pol","lin","svy",
	"danya","da","mied","zan","das","krem","muka","kom","rad","to","st","no","na","ni",
	"ko","ne","en","po","ra","li","on","byl","sto","eni","ost","ol","ego","ver","pro")

/datum/language/lunar
	name = LANGUAGE_LUNAR
	desc = "A carefully curated, formal language first used by the dynasties of Luna when conducting business affairs."
	key = "2"
	speech_verb = "enunciates"
	ask_verb = "demands"
	exclaim_verb = "declaims"
	colour = "lunar"
	syllables = list("a","e","i","o","u","a","e","i","o","u",
	"nu","du","tnu","ku","knu","su","snu","ru","pu","chu","fku","pru","plu","smu","sku","kvu","mu",
	"ra","ka","ak","ag","af","an","at","ad","al","re","ke","ek","age","afe","ane","ate","ade","ale",
	"a","e","i","o","u","a","e","i","o","u",
	"nu","du","tnu","ku","knu","su","snu","ru","pu","chu","fku","pru","plu","smu","sku","kvu","mu",
	"ra","ka","ak","ag","af","an","at","ad","al","re","ke","ek","age","afe","ane","ate","ade","ale",
	"me","ma","am","em","em","em","mea","mae",
	"ab","am","ap","as","av","spa","tsa","mra","fke","tle",
	"kla","ksa","sfa","psa","fna","tna","kva","kle","kse","sfe","pse","fne","tne","kve",
	"ven","dov","ter","far","kel","gab","chep","lok","nif","dis","is","is","am","em","em","em","ip","om","erl","olt","olt",
	"or","ort","stu","in","an","u","u") //based one Blue Language (Bolak)

/datum/language/exterior
	name = LANGUAGE_EXTERIOR
	desc = "A curt, efficient language developed to make best use of limited bandwidth in ship-to-ship transmissions. The common language of the outer solar system."
	key = "3"
	colour = "exterior"
	speech_verb = "babbles"
	ask_verb = "inquires"
	syllables = list("cy","ber","spes","hy","per","drive","sup","er","lum","in","al","spe","ed","la","ne",
	"loop","shut","tle","re","ver","se","po","la","ri","ti","ex","tra","so","lar","mer",
	"cu","ri","al","ve","nus","ian","ter","res","tial","lu","nar","mar","ha","lo","jo","vi","sa","turn",
	"ian","nep","tun","ur","nex","us","ort","kui","per","belt","al","i","ens","lens","ser","plas","ma","ion","ray","rail",
	"gun","po","wer","sor","ce","re","ver","se","po","lar","i","tee","hy","per","spess","flux","ca","pa",
	"ci","tor","ti","me","tra","vel","en","gi","ne","mi","les","per","ho","ur","qu","an","tum","en","tang","le","ment",
	"quant","um","a","ta","im","pro","ba","bi","li","tee","su","pos","it","ion","rad","at","ion","sing","ring","u","ri",
	"fis","fus","ion","qu","ark","ti","po","si","tron","pro","ton","neu","tron",
	"plu","to","ni","um","un","obt","ain","ium","ro","bot","dro","oid","qua","si","nor","mal",
	"feed","ba","ack","at","me","tal","ma","te","ri","al","ul","tra","den","se","mi","cro","na","no",
	"bots","blod","oid","stre","am","po","si","ti","ne","ga","ti","ec","to","do","pla","sma","chro","no","jar","gon"
	)

/datum/language/belter
	name = LANGUAGE_BELTER
	desc = "An informal Runglish-derived pidgin language used in the Halo asteroid belt."
	key = "4"
	colour = "belter"
	speech_verb = "butchers"
	exclaim_verb = "shouts"
	syllables = list("ayel", "ayen", "aye", "ayes", "ayeh", "aye", "ed", "en", "ah", "es", "haye", "he", "hoi", "in", "is", "it",
	"le", "me", "nd", "ne", "ng", "nh", "on", "or", "oo", "re", "re","roi", "se", "sh", "te", "th", "toi", "to",
	"ve", "way", "ayell", "ayend", "ayere", "buh", "enh", "ereh", "ere", "eve", "for", "hehd", "heht", "hen", "hah", "hin",
	"his", "in", "ion", "ith", "noh", "ome", "oul", "our", "sho", "ted", "tah", "theh", "the", "thi","mayet","belt",
	"rus","zem","ehve","groz","skoi","skaye","ven","konsh","pol","loin","svy",
	"daye","nya","mied","zehn","dehs","krem","sukay","blyeh","sukeh","blyeh","to","sh","no","nay","ni",
	"ne","en","ray","loi","on","byl","sto","eni","osh","ol","ego","vah","st","pro",
	"chuj","sraye","poi","zdaye","de","rayes","mu","dehk","kay","zo","paye","oi","bayet","doir","mo")
	
/datum/language/belter/scramble(var/input) //mate
    . = ..()
    var/input_size = length(.)
    if(copytext(., input_size) in list("!","?","."))
        . = "[copytext(.,1,input_size)], mayet[copytext(.,input_size)]"
    else 
        . += ", mayet"
