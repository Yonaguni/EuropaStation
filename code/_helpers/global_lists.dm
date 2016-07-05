var/list/clients = list()							//list of all clients
var/list/admins = list()							//list of all clients whom are admins
var/list/directory = list()							//list of all ckeys with associated client

//Since it didn't really belong in any other category, I'm putting this here
//This is for procs to replace all the goddamn 'in world's that are chilling around the code

var/global/list/player_list = list()				//List of all mobs **with clients attached**. Excludes /mob/new_player
var/global/list/mob_list = list()					//List of all mobs, including clientless
var/global/list/human_mob_list = list()				//List of all human mobs and sub-types, including c
var/global/list/living_mob_list = list()			//List of all alive mobs, including clientless. Excludes /mob/new_player
var/global/list/dead_mob_list = list()				//List of all dead mobs, including clientless. Excludes /mob/new_player

var/global/list/cable_list = list()					//Index for all cables, so that powernets don't have to look through the entire world all the time
var/global/list/landmarks_list = list()				//list of all landmarks created
var/global/list/surgery_steps = list()				//list of all surgery steps  |BS12
var/global/list/side_effects = list()				//list of all medical sideeffects types by thier names |BS12
var/global/list/mechas_list = list()				//list of all mechs. Used by hostile mobs target tracking.

var/global/list/turfs = list()						//list of all turfs

//Languages/species/whitelist.
var/global/list/all_species[0]
var/global/list/all_languages[0]
var/global/list/language_keys[0]					// Table of say codes for all languages
var/global/list/whitelisted_species = list("Human") // Species that require a whitelist check.
var/global/list/playable_species = list("Human")    // A list of ALL playable species, whitelisted, latejoin or otherwise.

var/list/mannequins_

// Posters
var/global/list/poster_designs = list()

// Uplinks
var/list/obj/item/device/uplink/world_uplinks = list()

//Preferences stuff
	//Hairstyles
var/global/list/hair_styles_list = list()			//stores /datum/sprite_accessory/hair indexed by name
var/global/list/hair_styles_male_list = list()
var/global/list/hair_styles_female_list = list()
var/global/list/facial_hair_styles_list = list()	//stores /datum/sprite_accessory/facial_hair indexed by name
var/global/list/facial_hair_styles_male_list = list()
var/global/list/facial_hair_styles_female_list = list()
var/global/list/skin_styles_female_list = list()		//unused
//Underwear
var/global/list/underwear_m = list("White" = "m1", "Grey" = "m2", "Green" = "m3", "Blue" = "m4", "Black" = "m5", "Mankini" = "m6", "None") //Curse whoever made male/female underwear diffrent colours
var/global/list/underwear_f = list("Red" = "f1", "White" = "f2", "Yellow" = "f3", "Blue" = "f4", "Black" = "f5", "Thong" = "f6", "Black Sports" = "f7","White Sports" = "f8","None")
//Backpacks
var/global/list/backbaglist = list("Nothing", "Backpack", "Satchel", "Satchel Alt")

// Music.
var/global/list/ambient_tracks = list(
	'sound/music/europa/Chronox_-_03_-_In_Orbit.ogg',
	'sound/music/europa/Chronox_-_04_-_Juno.ogg',
	'sound/music/europa/Macamoto_-_05_-_Torn.ogg',
	'sound/music/europa/Pulse_Emitter_-_04_-_Nebula.ogg',
	'sound/music/europa/Six_Umbrellas_-_05_-_Monument.ogg',
	'sound/music/europa/Six_Umbrellas_-_07_-_The_And_Of_The_World.ogg',
	'sound/music/europa/Martian Cowboy.ogg',
	)

// Runes
var/global/list/rune_list = new()
var/global/list/escape_list = list()
var/global/list/endgame_exits = list()
var/global/list/endgame_safespawns = list()

var/global/list/syndicate_access = list(access_maint_tunnels, access_syndicate, access_external_airlocks)

// Strings which corraspond to bodypart covering flags, useful for outputting what something covers.
var/global/list/string_part_flags = list(
	"head" = HEAD,
	"face" = FACE,
	"eyes" = EYES,
	"upper body" = UPPER_TORSO,
	"lower body" = LOWER_TORSO,
	"legs" = LEGS,
	"feet" = FEET,
	"arms" = ARMS,
	"hands" = HANDS
)

// Strings which corraspond to slot flags, useful for outputting what slot something is.
var/global/list/string_slot_flags = list(
	"back" = SLOT_BACK,
	"face" = SLOT_MASK,
	"waist" = SLOT_BELT,
	"ID slot" = SLOT_ID,
	"ears" = SLOT_EARS,
	"eyes" = SLOT_EYES,
	"hands" = SLOT_GLOVES,
	"head" = SLOT_HEAD,
	"feet" = SLOT_FEET,
	"exo slot" = SLOT_OCLOTHING,
	"body" = SLOT_ICLOTHING,
	"uniform" = SLOT_TIE,
	"holster" = SLOT_HOLSTER
)

//////////////////////////
/////Initial Building/////
//////////////////////////

/proc/makeDatumRefLists()

	var/list/paths

	//Hair - Initialise all /datum/sprite_accessory/hair into an list indexed by hair-style name
	paths = typesof(/datum/sprite_accessory/hair) - /datum/sprite_accessory/hair
	for(var/path in paths)
		var/datum/sprite_accessory/hair/H = new path()
		hair_styles_list[H.name] = H
		switch(H.gender)
			if(MALE)	hair_styles_male_list += H.name
			if(FEMALE)	hair_styles_female_list += H.name
			else
				hair_styles_male_list += H.name
				hair_styles_female_list += H.name

	//Facial Hair - Initialise all /datum/sprite_accessory/facial_hair into an list indexed by facialhair-style name
	paths = typesof(/datum/sprite_accessory/facial_hair) - /datum/sprite_accessory/facial_hair
	for(var/path in paths)
		var/datum/sprite_accessory/facial_hair/H = new path()
		facial_hair_styles_list[H.name] = H
		switch(H.gender)
			if(MALE)	facial_hair_styles_male_list += H.name
			if(FEMALE)	facial_hair_styles_female_list += H.name
			else
				facial_hair_styles_male_list += H.name
				facial_hair_styles_female_list += H.name

	//Surgery Steps - Initialize all /datum/surgery_step into a list
	paths = typesof(/datum/surgery_step)-/datum/surgery_step
	for(var/T in paths)
		var/datum/surgery_step/S = new T
		surgery_steps += S
	sort_surgeries()

	//Languages and species.
	paths = typesof(/datum/language)-/datum/language
	for(var/T in paths)
		var/datum/language/L = new T
		all_languages[L.name] = L

	for (var/language_name in all_languages)
		var/datum/language/L = all_languages[language_name]
		if(!(L.flags & NONGLOBAL))
			language_keys[lowertext(L.key)] = L

	var/rkey = 0
	paths = typesof(/datum/species)-/datum/species
	for(var/T in paths)
		rkey++
		var/datum/species/S = new T
		S.race_key = rkey //Used in mob icon caching.
		all_species[S.name] = S

		if(!(S.spawn_flags & IS_RESTRICTED))
			playable_species += S.name
		if(S.spawn_flags & IS_WHITELISTED)
			whitelisted_species += S.name

	//Posters
	paths = typesof(/datum/poster) - /datum/poster
	for(var/T in paths)
		var/datum/poster/P = new T
		poster_designs += P

	return 1

/proc/get_mannequin(var/ckey)
	if(!mannequins_)
		mannequins_ = new()

	. = mannequins_[ckey]
	if(!.)
		. = new/mob/living/human/dummy/mannequin()
		mannequins_[ckey] = .
