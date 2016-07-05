//used for pref.alternate_option
#define GET_RANDOM_JOB 0
#define BE_ASSISTANT 1
#define RETURN_TO_LOBBY 2

/datum/category_item/player_setup_item/occupation
	name = "Occupation"
	sort_order = 1

/datum/category_item/player_setup_item/occupation/load_character(var/savefile/S)
	S["alternate_option"]	>> pref.alternate_option
	S["job_preferences"]    >> pref.job_preferences
	S["player_alt_titles"]	>> pref.player_alt_titles

/datum/category_item/player_setup_item/occupation/save_character(var/savefile/S)
	S["alternate_option"]	<< pref.alternate_option
	S["job_preferences"]    << pref.job_preferences
	S["player_alt_titles"]	<< pref.player_alt_titles

/datum/category_item/player_setup_item/occupation/sanitize_character()
	pref.alternate_option	= sanitize_integer(pref.alternate_option, 0, 2, initial(pref.alternate_option))
	for(var/title in pref.job_preferences) // Make sure job prefs are within bounds.
		pref.job_preferences[title] = max(0,min(JOB_HIGH, pref.job_preferences[title]))
	if(!pref.player_alt_titles)       pref.player_alt_titles = new()
	if(!islist(pref.job_preferences)) pref.job_preferences = list()

	if(!job_master)
		return
	for(var/datum/job/job in job_master.occupations)
		var/alt_title = pref.player_alt_titles[job.title]
		if(alt_title && !(alt_title in job.alt_titles))
			pref.player_alt_titles -= job.title

/datum/category_item/player_setup_item/occupation/content(mob/user, limit = 16, list/splitJobs = list("Chief Medical Officer"))
	if(!job_master)
		return

	. += "<tt><center>"
	. += "<b>Choose occupation chances</b><br>Unavailable occupations are crossed out.<br>"
	. += "<table width='100%' cellpadding='1' cellspacing='0'><tr><td width='20%'>" // Table within a table for alignment, also allows you to easily add more colomns.
	. += "<table width='100%' cellpadding='1' cellspacing='0'>"
	var/index = -1

	//The job before the current job. I only use this to get the previous jobs color when I'm filling in blank rows.
	var/datum/job/lastJob
	if (!job_master)		return
	for(var/datum/job/job in job_master.occupations)

		index += 1
		if((index >= limit) || (job.title in splitJobs))
			if((index < limit) && (lastJob != null))
				//If the cells were broken up by a job in the splitJob list then it will fill in the rest of the cells with
				//the last job's selection color. Creating a rather nice effect.
				for(var/i = 0, i < (limit - index), i += 1)
					. += "<tr bgcolor='[lastJob.selection_color]'><td width='60%' align='right'><a>&nbsp</a></td><td><a>&nbsp</a></td></tr>"
			. += "</table></td><td width='20%'><table width='100%' cellpadding='1' cellspacing='0'>"
			index = 0

		. += "<tr bgcolor='[job.selection_color]'><td width='60%' align='right'>"
		var/rank = job.title
		lastJob = job
		if(jobban_isbanned(user, rank))
			. += "<del>[rank]</del></td><td><b> \[BANNED]</b></td></tr>"
			continue

		if(!job.player_old_enough(user.client))
			var/available_in_days = job.available_in_days(user.client)
			. += "<del>[rank]</del></td><td> \[IN [(available_in_days)] DAYS]</td></tr>"
			continue
		if(job.minimum_character_age && user.client && (user.client.prefs.age < job.minimum_character_age))
			. += "<del>[rank]</del></td><td> \[MINIMUM CHARACTER AGE: [job.minimum_character_age]]</td></tr>"
			continue
		if((pref.job_preferences[using_map.default_title]) && (rank != "[using_map.default_title]"))
			. += "<font color=orange>[rank]</font></td><td></td></tr>"
			continue
		if((rank in gov_positions) || (rank == "AI"))//Bold head jobs
			. += "<b>[rank]</b>"
		else
			. += "[rank]"

		. += "</td><td width='40%'>"

		. += "<a href='?src=\ref[src];set_job=[rank]'>"

		var/jobval = pref.job_preferences[job.title]
		switch(jobval)
			if(JOB_LOW)
				. += " <font color=orange>\[Low]</font>"
			if(JOB_MED)
				. += " <font color=green>\[Medium]</font>"
			if(JOB_HIGH)
				. += " <font color=blue>\[High]</font>"
			else
				. += " <font color=red>\[NEVER]</font>"

		if(job.alt_titles)
			. += "</a></td></tr><tr bgcolor='[lastJob.selection_color]'><td width='60%' align='center'>&nbsp</td><td><a href='?src=\ref[src];select_alt_title=\ref[job]'>\[[pref.get_player_alt_title(job)]\]</a></td></tr>"
		. += "</a></td></tr>"

	. += "</td'></tr></table>"

	. += "</center></table>"

	switch(pref.alternate_option)
		if(GET_RANDOM_JOB)
			. += "<center><br><u><a href='?src=\ref[src];job_alternative=1'><font color=green>Get random job if preferences unavailable</font></a></u></center><br>"
		if(BE_ASSISTANT)
			. += "<center><br><u><a href='?src=\ref[src];job_alternative=1'><font color=red>Be [using_map.default_title] if preference unavailable</font></a></u></center><br>"
		if(RETURN_TO_LOBBY)
			. += "<center><br><u><a href='?src=\ref[src];job_alternative=1'><font color=purple>Return to lobby if preference unavailable</font></a></u></center><br>"

	. += "<center><a href='?src=\ref[src];reset_jobs=1'>\[Reset\]</a></center>"
	. += "</tt>"

/datum/category_item/player_setup_item/occupation/OnTopic(href, href_list, user)

	// Null the job preference list.
	if(href_list["reset_jobs"])
		reset_jobs()
		return TOPIC_REFRESH

	// Increment the preference for this job by 1 place.
	else if(href_list["set_job"])
		var/jobtitle = href_list["set_job"]
		var/jobval = pref.job_preferences[jobtitle]
		if(!jobval) // Either totally unset or just 0.
			pref.job_preferences[jobtitle] = JOB_LOW
		else if(jobval == JOB_HIGH) // Wrap around to 0.
			pref.job_preferences[jobtitle] = JOB_NEVER
		else // Step up by one!
			pref.job_preferences[jobtitle] += 1
			// There can only be one.
			if(pref.job_preferences[jobtitle] == JOB_HIGH)
				for(var/otherjob in (pref.job_preferences - jobtitle))
					if(pref.job_preferences[otherjob] == JOB_HIGH)
						pref.job_preferences[otherjob] = JOB_MED
		return (pref.dress_mob ? TOPIC_REFRESH_UPDATE_PREVIEW : TOPIC_REFRESH)

	// Toggle the behavior desired when failing to get a job.
	else if(href_list["job_alternative"])
		if(pref.alternate_option == GET_RANDOM_JOB || pref.alternate_option == BE_ASSISTANT)
			pref.alternate_option += 1
		else if(pref.alternate_option == RETURN_TO_LOBBY)
			pref.alternate_option = 0
		return TOPIC_REFRESH

	// Select an alt title for a job.
	else if(href_list["select_alt_title"])
		var/datum/job/job = locate(href_list["select_alt_title"])
		if (job)
			var/choices = list(job.title) + job.alt_titles
			var/choice = input("Choose an title for [job.title].", "Choose Title", pref.get_player_alt_title(job)) as anything in choices|null
			if(choice && CanUseTopic(user))
				set_player_alt_title(job, choice)
				return (pref.dress_mob ? TOPIC_REFRESH_UPDATE_PREVIEW : TOPIC_REFRESH)

	return ..()

/datum/category_item/player_setup_item/occupation/proc/reset_jobs()
	pref.job_preferences.Cut()
	pref.player_alt_titles.Cut()

/datum/category_item/player_setup_item/occupation/proc/set_player_alt_title(datum/job/job, new_title)
	// remove existing entry
	pref.player_alt_titles -= job.title
	// add one if it's not default
	if(job.title != new_title)
		pref.player_alt_titles[job.title] = new_title

/datum/preferences/proc/get_player_alt_title(datum/job/job)
	return (job.title in player_alt_titles) ? player_alt_titles[job.title] : job.title

