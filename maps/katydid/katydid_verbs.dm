/client/verb/check_stellar_destination()

	set name = "Check Destination Location"
	set desc = "Get info on destination location."
	set category = "IC"

	var/datum/map/katydid/mapdata = using_map
	if(!istype(mapdata) || !mapdata.destination_location)
		usr << "The <b>[mapdata.full_name]</b> has no destination! Please report this on the bug tracker."
		return

	usr << "The <b>[mapdata.full_name]</b> is preparing to depart for <b>[mapdata.destination_location.name]</b>."
	usr << "<hr>[mapdata.destination_location.description]<hr>"
