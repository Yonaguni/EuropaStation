var/global/datum/controller/occupations/job_master

#define GET_RANDOM_JOB 0
#define BE_ASSISTANT 1
#define RETURN_TO_LOBBY 2

/datum/controller/occupations
	var/list/occupations = list() // List of all jobs
	var/list/unassigned = list()  // Players who need jobs
	var/list/job_debug = list()   // Debug info

	proc/SetupOccupations()
		occupations = get_job_datums()
		if(!occupations.len)
			world << "<span class='warning'>Error setting up jobs, no job datums found!</span>"
			return 0
		return 1

	proc/Debug(var/text)
		if(!Debug2)	return 0
		job_debug.Add(text)
		return 1

	proc/GetJob(var/rank)
		if(!rank)	return null
		for(var/datum/job/J in occupations)
			if(!J)	continue
			if(J.title == rank)	return J
		return null

	proc/GetPlayerAltTitle(mob/new_player/player, rank)
		return player.client.prefs.get_player_alt_title(GetJob(rank))

	proc/AssignRole(var/mob/new_player/player, var/rank, var/latejoin = 0)
		Debug("Running AR, Player: [player], Rank: [rank], LJ: [latejoin]")
		if(player && player.mind && rank)
			var/datum/job/job = GetJob(rank)
			if(!job)
				return 0
			if(job.minimum_character_age && (player.client.prefs.age < job.minimum_character_age))
				return 0
			if(jobban_isbanned(player, rank))
				return 0
			if(!job.player_old_enough(player.client))
				return 0

			var/position_limit = job.total_positions
			if(!latejoin)
				position_limit = job.spawn_positions
			if((job.current_positions < position_limit) || position_limit == -1)
				Debug("Player: [player] is now Rank: [rank], JCP:[job.current_positions], JPL:[position_limit]")
				player.mind.assigned_role = rank
				player.mind.role_alt_title = GetPlayerAltTitle(player, rank)
				unassigned -= player
				job.current_positions++
				return 1
		Debug("AR has failed, Player: [player], Rank: [rank]")
		return 0

	proc/FreeRole(var/rank)	//making additional slot on the fly
		var/datum/job/job = GetJob(rank)
		if(job && job.current_positions >= job.total_positions && job.total_positions != -1)
			job.total_positions++
			return 1
		return 0

	proc/FindOccupationCandidates(datum/job/job, level, flag)
		Debug("Running FOC, Job: [job], Level: [level], Flag: [flag]")
		var/list/candidates = list()
		for(var/mob/new_player/player in unassigned)
			if(jobban_isbanned(player, job.title))
				Debug("FOC isbanned failed, Player: [player]")
				continue
			if(!job.player_old_enough(player.client))
				Debug("FOC player not old enough, Player: [player]")
				continue
			if(job.minimum_character_age && (player.client.prefs.age < job.minimum_character_age))
				Debug("FOC character not old enough, Player: [player]")
				continue
			if(flag && !(flag in player.client.prefs.be_special_role))
				Debug("FOC flag failed, Player: [player], Flag: [flag], ")
				continue
			if(player.client.prefs.job_preferences[job.title] == level)
				Debug("FOC pass, Player: [player], Level:[level]")
				candidates += player
		return candidates

	proc/GiveRandomJob(var/mob/new_player/player)
		Debug("GRJ Giving random job, Player: [player]")
		for(var/datum/job/job in shuffle(occupations))
			if(!job)
				continue

			if(job.minimum_character_age && (player.client.prefs.age < job.minimum_character_age))
				continue

			if(istype(job, world_map.default_job)) // We don't want to give him assistant, that's boring!
				continue

			if(job in head_positions) //If you want a command position, select it!
				continue

			if(jobban_isbanned(player, job.title))
				Debug("GRJ isbanned failed, Player: [player], Job: [job.title]")
				continue

			if(!job.player_old_enough(player.client))
				Debug("GRJ player not old enough, Player: [player]")
				continue

			if((job.current_positions < job.spawn_positions) || job.spawn_positions == -1)
				Debug("GRJ Random job given, Player: [player], Job: [job]")
				AssignRole(player, job.title)
				unassigned -= player
				break

	proc/ResetOccupations()
		for(var/mob/new_player/player in player_list)
			if((player) && (player.mind))
				player.mind.assigned_role = null
				player.mind.special_role = null
		SetupOccupations()
		unassigned = list()
		return


	///This proc is called before the level loop of DivideOccupations() and will try to select a head, ignoring ALL non-head preferences for every level until it locates a head or runs out of levels to check
	proc/FillHeadPosition()
		for(var/level = 1 to 3)
			for(var/command_position in head_positions)
				var/datum/job/job = GetJob(command_position)
				if(!job)	continue
				var/list/candidates = FindOccupationCandidates(job, level)
				if(!candidates.len)	continue

				// Build a weighted list, weight by age.
				var/list/weightedCandidates = list()
				for(var/mob/V in candidates)
					// Log-out during round-start? What a bad boy, no head position for you!
					if(!V.client) continue
					var/age = V.client.prefs.age

					if(age < job.minimum_character_age) // Nope.
						continue

					switch(age)
						if(job.minimum_character_age to (job.minimum_character_age+10))
							weightedCandidates[V] = 3 // Still a bit young.
						if((job.minimum_character_age+10) to (job.ideal_character_age-10))
							weightedCandidates[V] = 6 // Better.
						if((job.ideal_character_age-10) to (job.ideal_character_age+10))
							weightedCandidates[V] = 10 // Great.
						if((job.ideal_character_age+10) to (job.ideal_character_age+20))
							weightedCandidates[V] = 6 // Still good.
						if((job.ideal_character_age+20) to INFINITY)
							weightedCandidates[V] = 3 // Geezer.
						else
							// If there's ABSOLUTELY NOBODY ELSE
							if(candidates.len == 1) weightedCandidates[V] = 1


				var/mob/new_player/candidate = pickweight(weightedCandidates)
				if(AssignRole(candidate, command_position))
					return 1
		return 0


	///This proc is called at the start of the level loop of DivideOccupations() and will cause head jobs to be checked before any other jobs of the same level
	proc/CheckHeadPositions(var/level)
		for(var/command_position in head_positions)
			var/datum/job/job = GetJob(command_position)
			if(!job)	continue
			var/list/candidates = FindOccupationCandidates(job, level)
			if(!candidates.len)	continue
			var/mob/new_player/candidate = pick(candidates)
			AssignRole(candidate, command_position)
		return


/** Proc DivideOccupations
 *  fills var "assigned_role" for all ready players.
 *  This proc must not have any side effect besides of modifying "assigned_role".
 **/
	proc/DivideOccupations()
		//Setup new player list and get the jobs list
		Debug("Running DO")
		SetupOccupations()

		//Holder for Triumvirate is stored in the ticker, this just processes it
		if(ticker && ticker.triai)
			for(var/datum/job/A in occupations)
				if(A.title == "AI")
					A.spawn_positions = 3
					break

		//Get the players who are ready
		for(var/mob/new_player/player in player_list)
			if(player.ready && player.mind && !player.mind.assigned_role)
				unassigned += player

		Debug("DO, Len: [unassigned.len]")
		if(unassigned.len == 0)	return 0

		//Shuffle players and jobs
		unassigned = shuffle(unassigned)

		HandleFeedbackGathering()

		//People who wants to be assistants, sure, go on.
		Debug("DO, Running Assistant Check 1")
		var/datum/job/assist = new world_map.default_job ()
		var/list/assistant_candidates = FindOccupationCandidates(assist, 3)
		Debug("AC1, Candidates: [assistant_candidates.len]")
		for(var/mob/new_player/player in assistant_candidates)
			Debug("AC1 pass, Player: [player]")
			AssignRole(player, "[world_map.default_title]")
			assistant_candidates -= player
		Debug("DO, AC1 end")

		//Select one head
		Debug("DO, Running Head Check")
		FillHeadPosition()
		Debug("DO, Head Check end")

		//Other jobs are now checked
		Debug("DO, Running Standard Check")


		// New job giving system by Donkie
		// This will cause lots of more loops, but since it's only done once it shouldn't really matter much at all.
		// Hopefully this will add more randomness and fairness to job giving.

		// Loop through all levels from high to low
		var/list/shuffledoccupations = shuffle(occupations)
		// var/list/disabled_jobs = ticker.mode.disabled_jobs  // So we can use .Find down below without a colon.
		for(var/level = 1 to 3)
			//Check the head jobs first each level
			CheckHeadPositions(level)

			// Loop through all unassigned players
			for(var/mob/new_player/player in unassigned)

				// Loop through all jobs
				for(var/datum/job/job in shuffledoccupations) // SHUFFLE ME BABY
					if(!job || ticker.mode.disabled_jobs.Find(job.title) )
						continue

					if(jobban_isbanned(player, job.title))
						Debug("DO isbanned failed, Player: [player], Job:[job.title]")
						continue

					if(!job.player_old_enough(player.client))
						Debug("DO player not old enough, Player: [player], Job:[job.title]")
						continue

					// If the player wants that job on this level, then try give it to him.
					if(player.client.prefs.job_preferences[job.title] == level)

						// If the job isn't filled
						if((job.current_positions < job.spawn_positions) || job.spawn_positions == -1)
							Debug("DO pass, Player: [player], Level:[level], Job:[job.title]")
							AssignRole(player, job.title)
							unassigned -= player
							break

		// Hand out random jobs to the people who didn't get any in the last check
		// Also makes sure that they got their preference correct
		for(var/mob/new_player/player in unassigned)
			if(player.client.prefs.alternate_option == GET_RANDOM_JOB)
				GiveRandomJob(player)
		/*
		Old job system
		for(var/level = 1 to 3)
			for(var/datum/job/job in occupations)
				Debug("Checking job: [job]")
				if(!job)
					continue
				if(!unassigned.len)
					break
				if((job.current_positions >= job.spawn_positions) && job.spawn_positions != -1)
					continue
				var/list/candidates = FindOccupationCandidates(job, level)
				while(candidates.len && ((job.current_positions < job.spawn_positions) || job.spawn_positions == -1))
					var/mob/new_player/candidate = pick(candidates)
					Debug("Selcted: [candidate], for: [job.title]")
					AssignRole(candidate, job.title)
					candidates -= candidate*/

		Debug("DO, Standard Check end")

		Debug("DO, Running AC2")

		// For those who wanted to be assistant if their preferences were filled, here you go.
		for(var/mob/new_player/player in unassigned)
			if(player.client.prefs.alternate_option == BE_ASSISTANT)
				Debug("AC2 Assistant located, Player: [player]")
				AssignRole(player, "[world_map.default_title]")

		//For ones returning to lobby
		for(var/mob/new_player/player in unassigned)
			if(player.client.prefs.alternate_option == RETURN_TO_LOBBY)
				player.ready = 0
				player.new_player_panel_proc()
				unassigned -= player
		return 1


	proc/EquipRank(var/mob/living/carbon/human/H, var/rank, var/joined_late = 0)
		if(!H)	return null

		var/datum/job/job = GetJob(rank)
		var/list/spawn_in_storage = list()

		if(job)

			//Equip custom gear loadout.
			var/list/custom_equip_slots = list() //If more than one item takes the same slot, all after the first one spawn in storage.
			var/list/custom_equip_leftovers = list()
			if(H.client.prefs.gear && H.client.prefs.gear.len && job.title != "Cyborg" && job.title != "AI")

				for(var/thing in H.client.prefs.gear)
					var/datum/gear/G = gear_datums[thing]
					if(G)
						var/permitted
						if(G.allowed_roles)
							for(var/job_name in G.allowed_roles)
								if(job.title == job_name)
									permitted = 1
						else
							permitted = 1

						if(G.whitelisted && !is_alien_whitelisted(H, G.whitelisted))
							permitted = 0

						if(!permitted)
							H << "<span class='warning'>Your current job or whitelist status does not permit you to spawn with [thing]!</span>"
							continue

						if(G.slot && !(G.slot in custom_equip_slots))
							// This is a miserable way to fix the loadout overwrite bug, but the alternative requires
							// adding an arg to a bunch of different procs. Will look into it after this merge. ~ Z
							if(G.slot == slot_wear_mask || G.slot == slot_wear_suit || G.slot == slot_head)
								custom_equip_leftovers += thing
							else if(H.equip_to_slot_or_del(new G.path(H), G.slot))
								H << "<span class='notice'>Equipping you with [thing]!</span>"
								custom_equip_slots.Add(G.slot)
							else
								custom_equip_leftovers.Add(thing)
						else
							spawn_in_storage += thing
			//Equip job items.
			job.equip_backpack(H)	//backpack first so equip() can put things in it
			job.equip(H)
			job.setup_account(H)
			job.equip_survival(H)
			job.apply_fingerprints(H)

			//If some custom items could not be equipped before, try again now.
			for(var/thing in custom_equip_leftovers)
				var/datum/gear/G = gear_datums[thing]
				if(G.slot in custom_equip_slots)
					spawn_in_storage += thing
				else
					if(H.equip_to_slot_or_del(new G.path(H), G.slot))
						H << "<span class='notice'>Equipping you with [thing]!</span>"
						custom_equip_slots.Add(G.slot)
					else
						spawn_in_storage += thing
		else
			H << "Your job is [rank] and the game just can't handle it! Please report this bug to an administrator."

		H.job = rank

		if(!joined_late)
			var/obj/S = null
			var/list/loc_list = new()
			for(var/obj/effect/landmark/start/sloc in landmarks_list)
				if(sloc.name != rank)	continue
				if(locate(/mob/living) in sloc.loc)	continue
				loc_list += sloc
			if(loc_list.len)
				S = pick(loc_list)
			if(!S)
				S = locate("start*[rank]") // use old stype
			if(istype(S, /obj/effect/landmark/start) && istype(S.loc, /turf))
				H.loc = S.loc
			else
				LateSpawn(H, rank)

			// Moving wheelchair if they have one
			if(H.buckled && istype(H.buckled, /obj/structure/bed/chair/wheelchair))
				H.buckled.loc = H.loc
				H.buckled.set_dir(H.dir)

		var/alt_title = null
		if(H.mind)
			H.mind.assigned_role = rank
			alt_title = H.mind.role_alt_title

			switch(rank)
				if("Cyborg")
					return H.Robotize()
				if("AI")
					return H
				//if("Captain")
				//	var/sound/announce_sound = (ticker.current_state <= GAME_STATE_SETTING_UP)? null : sound('sound/misc/boatswain.ogg', volume=20)
				//	captain_announcement.Announce("All hands, Captain [H.real_name] on deck!", new_sound=announce_sound)

			//Deferred item spawning.
			if(spawn_in_storage && spawn_in_storage.len)
				var/obj/item/weapon/storage/B
				for(var/obj/item/weapon/storage/S in H.contents)
					B = S
					break

				if(!isnull(B))
					for(var/thing in spawn_in_storage)
						H << "<span class='notice'>Placing [thing] in your [B]!</span>"
						var/datum/gear/G = gear_datums[thing]
						new G.path(B)
				else
					H << "<span class='danger'>Failed to locate a storage object on your mob, either you spawned with no arms and no backpack or this is a bug.</span>"

		if(istype(H)) //give humans wheelchairs, if they need them.
			var/obj/item/organ/external/l_foot = H.get_organ("l_foot")
			var/obj/item/organ/external/r_foot = H.get_organ("r_foot")
			if(!l_foot || !r_foot)
				var/obj/structure/bed/chair/wheelchair/W = new /obj/structure/bed/chair/wheelchair(H.loc)
				H.buckled = W
				H.update_canmove()
				W.set_dir(H.dir)
				W.buckled_mob = H
				W.add_fingerprint(H)

		H << "<B>You are [job.total_positions == 1 ? "the" : "a"] [alt_title ? alt_title : rank].</B>"

		if(job.supervisors)
			H << "<b>As the [alt_title ? alt_title : rank] you answer directly to [job.supervisors]. Special circumstances may change this.</b>"

		if(job.idtype)
			spawnId(H, rank, alt_title)

		if(job.headsettype)
			H.equip_to_slot_or_del(new job.headsettype(H), slot_l_ear)
			H << "<b>To speak on your department's radio channel use :h. For the use of other channels, examine your headset.</b>"

		// Create passport.
		if(H.client && H.client.prefs && !isnull(H.client.prefs.citizenship) && H.client.prefs.citizenship != "None")
			var/obj/item/weapon/card/id/europa/passport/P = new(H)
			H.set_id_info(P)
			// If they have a wallet, great. If not, try to put it in the ID slot,
			// then pockets. If that fails, put it on the ground.
			var/obj/item/weapon/storage/wallet/W = locate() in H.contents
			if(istype(W))
				W.handle_item_insertion(P)
			else
				if(!H.equip_to_slot_if_possible(P, slot_wear_id, disable_warning = 1))
					if(!H.equip_to_slot_if_possible(P, slot_l_store, disable_warning = 1))
						if(!H.equip_to_slot_if_possible(P, slot_r_store, disable_warning = 1))
							P.loc = get_turf(H)
							H << "<span class='danger'>Your pockets and ID slot were full, so it looks like you dropped your passport. Whoops.</span>"

		if(job.req_admin_notify)
			H << "<b>You are playing a job that is important for Game Progression. If you have to disconnect, please notify the admins via adminhelp.</b>"

		//Gives glasses to the vision impaired
		if(H.disabilities & NEARSIGHTED)
			var/equipped = H.equip_to_slot_or_del(new /obj/item/clothing/glasses/regular(H), slot_glasses)
			if(equipped != 1)
				var/obj/item/clothing/glasses/G = H.glasses
				G.prescription = 1

		BITSET(H.hud_updateflag, ID_HUD)
		BITSET(H.hud_updateflag, IMPLOYAL_HUD)
		BITSET(H.hud_updateflag, SPECIALROLE_HUD)
		return H


	proc/spawnId(var/mob/living/carbon/human/H, rank, title)
		if(!H)	return 0
		var/obj/item/weapon/card/id/C = null

		var/datum/job/job = null
		for(var/datum/job/J in occupations)
			if(J.title == rank)
				job = J
				break

		if(job)
			if(job.title == "Cyborg")
				return
			else
				C = new job.idtype(H)
				C.access = job.get_access()
		else
			C = new /obj/item/weapon/card/id(H)

		if(C)
			C.rank = rank
			C.set_name(H.real_name)
			C.assignment = title ? title : rank
			H.set_id_info(C)

			//put the player's account number onto the ID
			if(H.mind && H.mind.initial_account)
				C.associated_account_number = H.mind.initial_account.account_number

			// If they have a wallet, jam their ID in there.
			var/obj/item/weapon/storage/wallet/W = locate() in H
			if(istype(W))
				W.handle_item_insertion(C)
			else
				H.equip_to_slot_or_del(C, slot_wear_id)

		if(job.pdatype)
			H.equip_to_slot_or_del(new job.pdatype(H), slot_belt)
			if(locate(/obj/item/device/pda,H))
				var/obj/item/device/pda/pda = locate(/obj/item/device/pda,H)
				pda.owner = H.real_name
				pda.ownjob = C.assignment
				pda.ownrank = C.rank
				pda.name = "PDA-[H.real_name] ([pda.ownjob])"

		return 1


	proc/HandleFeedbackGathering()
		for(var/datum/job/job in occupations)
			var/tmp_str = "|[job.title]|"

			var/level1 = 0 //high
			var/level2 = 0 //medium
			var/level3 = 0 //low
			var/level4 = 0 //never
			var/level5 = 0 //banned
			var/level6 = 0 //account too young
			for(var/mob/new_player/player in player_list)
				if(!(player.ready && player.mind && !player.mind.assigned_role))
					continue //This player is not ready
				if(jobban_isbanned(player, job.title))
					level5++
					continue
				if(!job.player_old_enough(player.client))
					level6++
					continue

				if(!player.client.prefs.job_preferences[job.title])
					level4++ //not selected
				else if(player.client.prefs.job_preferences[job.title] == JOB_LOW)
					level1++
				else if(player.client.prefs.job_preferences[job.title] == JOB_MED)
					level2++
				else if(player.client.prefs.job_preferences[job.title] == JOB_HIGH)
					level3++

			tmp_str += "HIGH=[level1]|MEDIUM=[level2]|LOW=[level3]|NEVER=[level4]|BANNED=[level5]|YOUNG=[level6]|-"
			feedback_add_details("job_preferences",tmp_str)

/datum/controller/occupations/proc/LateSpawn(var/mob/living/carbon/human/H, var/rank)
	//spawn at one of the latespawn locations

	var/datum/spawnpoint/spawnpos

	if(H.client.prefs.spawnpoint)
		spawnpos = spawntypes[H.client.prefs.spawnpoint]

	if(spawnpos && istype(spawnpos))
		if(spawnpos.check_job_spawning(rank))
			H.loc = pick(spawnpos.turfs)
			. = spawnpos.msg
		else
			H << "Your chosen spawnpoint ([spawnpos.display_name]) is unavailable for your chosen job. Spawning you at the Arrivals shuttle instead."
			H.loc = pick(latejoin)
			. = "has arrived on the station"
	else
		H.loc = pick(latejoin)
		. = "has arrived on the station"
