var/const/CIVILIAN		=(1<<0)

var/const/CITIZEN		=(1<<0)
var/const/LIAISON		=(1<<1)
var/const/ENGINEER		=(1<<2)
var/const/AI			=(1<<3)
var/const/CYBORG		=(1<<4)

var/const/GOVERNMENT	=(1<<1)

var/const/MARSHAL		=(1<<0)
var/const/OFFICER		=(1<<1)


var/const/INDUSTRY		=(1<<2)

var/const/CCO			=(1<<0)
var/const/WORKER		=(1<<1)
var/const/SCIENTIST		=(1<<2)

var/list/europa_head_positions = list(
	"Colony Liaison",
	"Marshal",
	"Corporate Contract Officer"
)

var/list/europa_civ_positions = list(
	"Citizen",
	"Civil Engineer"
)

var/list/europa_gov_positions = list(
	"Petty Officer"
)

var/list/europa_ind_positions = list(
	"Factory Worker",
	"Scientist"
)


var/list/nonhuman_positions = list(
	"AI",
	"Cyborg",
	"pAI"
)


/proc/guest_jobbans(var/job)
	return ((job in europa_head_positions) || (job in nonhuman_positions) || (job in europa_gov_positions))

/proc/get_job_datums()
	var/list/occupations = list()
	var/list/all_jobs = typesof(/datum/job)

	for(var/A in all_jobs)
		var/datum/job/job = new A()
		if(!job)	continue
		occupations += job

	return occupations

/proc/get_alternate_titles(var/job)
	var/list/jobs = get_job_datums()
	var/list/titles = list()

	for(var/datum/job/J in jobs)
		if(J.title == job)
			titles = J.alt_titles

	return titles
