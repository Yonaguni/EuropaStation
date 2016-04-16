var/list/head_positions = list()
var/list/civ_positions = list()
var/list/gov_positions = list()
var/list/ind_positions = list()
var/list/nonhuman_positions = list()

var/list/all_used_jobs
var/list/job_titles = list()
var/list/all_excluded_jobs = list()

/proc/guest_jobbans(var/job)
	return ((job in head_positions) || (job in nonhuman_positions) || (job in gov_positions))

/proc/get_job_datums(var/exclude)
	if(!all_used_jobs)
		all_used_jobs = list()
		for(var/jobtype in using_map.use_jobs)
			var/datum/job/job = new jobtype()
			// Should we keep track of this job for exclusionary purposes?
			if(jobtype in using_map.exclude_jobs)
				all_excluded_jobs += job
			else
				job_titles += job.title

			// Update job categories while we're at it!
			switch(job.job_category)
				if(IS_HEAD)
					head_positions |= job.title
				if(IS_CIVIL)
					civ_positions |= job.title
				if(IS_GOVERNMENT)
					gov_positions |= job.title
				if(IS_INDUSTRY)
					ind_positions |= job.title
				if(IS_NONHUMAN)
					nonhuman_positions |= job.title
			all_used_jobs += job

	return (exclude ? (all_used_jobs - all_excluded_jobs) : all_used_jobs)

/proc/get_job_titles()
	get_job_datums()
	return job_titles

/proc/get_alternate_titles(var/job)
	var/list/jobs = get_job_datums()
	var/list/titles = list()

	for(var/datum/job/J in jobs)
		if(J.title == job)
			titles = J.alt_titles

	return titles
