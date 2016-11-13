/client/verb/check_stellar_location()

	set name = "Check Stellar Location"
	set desc = "Get info on current location."
	set category = "IC"

	var/datum/map/katydid/mapdata = using_map
	usr << "The <b>[mapdata.full_name]</b> is currently on stopover in <b>[mapdata.stellar_location.name]</b>."
	usr << "<hr>[mapdata.stellar_location.description]<hr>"

/client/verb/check_stellar_destination()

	set name = "Check Destination Location"
	set desc = "Get info on destination location."
	set category = "IC"

	var/datum/map/katydid/mapdata = using_map
	usr << "The <b>[mapdata.full_name]</b> is preparing to depart for <b>[mapdata.destination_location.name]</b>."
	usr << "<hr>[mapdata.destination_location.description]<hr>"
