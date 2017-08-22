/datum/map/borderworld
	name = "Borderworld"
	full_name = "the Borderworld"
	path = "borderworld"

	station_levels = list(1)
	contact_levels = list(1,2)
	player_levels = list(1,2)
	shallow_levels = list(1,2)

	test_x = 215
	test_y = 50
	test_z = 2

/datum/map/borderworld/show_map_info(var/user)
	user << "<b>The borderworlds</b> is a term that describes a collection of haphazardly terraformed dwarf planets scattered between \
		the Sun and the outer reaches of the Solar system, usually mixed in with the Kuiper Belt or hidden in the Oort. In the resource boom \
		following human expansion from Mars, it was relatively easy for a rich, excitable industry mogul to crash a few ice asteroids into a \
		Pluto-sized ball of shit and call it their home away from home. Due to long-term neglect and abuse, and the often horrible conditions on \
		the borderworlds, almost all of the colonies established there have long since gone dark. Sometimes, though, a ship is unfortunate enough \
		to crash on one of the desolate, abandoned planets, leaving the 'colonists' to eke out whatever existence they can manage."

/*
	title_state = "borderworld"
	motd_override = {"<h1>Welcome to the borderworlds, stranger.</h1>
	<i>This server is running the Europa Station 13 modification of <a href="http://baystation12.net/">Baystation 12's</a> SS13 code.</i><br>
	Please check over the rules and get familiar with our roleplaying expectations before you mosey over.<br>
	<b>Bugtracker:</b> <a href="https://github.com/Yonaguni/EuropaStation/issues">for posting of bugs and issues.</a>"}

/datum/map/borderworld/do_roundstart_mapgen()
	if(config.generate_asteroid)
		admin_notice("<span class='warning'>Generating caverns...</span>", R_DEBUG)
		new /datum/random_map/large_cave(null,1,1,1,255,255)
	*/

/obj/effect/landmark/map_data/borderworld
	name = "borderworld"
	desc = "The planet surface and the mining level."
	height = 2
