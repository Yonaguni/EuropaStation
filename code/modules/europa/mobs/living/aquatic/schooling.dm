/datum/fish_school
	var/list/members = list()
	var/mob/living/aquatic/leader

/datum/fish_school/proc/add(var/mob/living/aquatic/A)
	if(!leader)
		leader = A
	members |= A
	A.school = src

/datum/fish_school/proc/remove(var/mob/living/aquatic/A)
	members -= A
	A.school = null
	rebuild_school()

/datum/fish_school/proc/disperse()
	for(var/mob/living/aquatic/A in members)
		A.school = null
		A.following = null
	leader = null
	del(src)

/datum/fish_school/proc/rebuild_school()
	if(!members.len)
		disperse()
	if(!(leader in members))
		leader = null
	if(!leader)
		leader = pick(members)
	leader.set_school(src)