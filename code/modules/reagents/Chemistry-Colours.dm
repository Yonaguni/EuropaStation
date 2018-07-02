/datum/reagents/proc/get_color()
	if(!volumes || !volumes.len)
		return "#ffffffff"
	if(volumes.len == 1) // It's pretty common and saves a lot of work
		var/datum/reagent/R = SSchemistry.get_reagent(volumes[1])
		return R.color

	var/list/colors = list(0, 0, 0, 0)
	var/tot_w = 0
	for(var/rid in volumes)
		var/datum/reagent/R = SSchemistry.get_reagent(rid)
		var/hex = uppertext(R.color)
		if(length(hex) == 7)
			hex += "FF"
		if(length(hex) != 9) // PANIC PANIC PANIC
			warning("Reagent [R.name] ([rid]) has an incorrect color set ([R.color])")
			hex = "#FFFFFFFF"
		var/volume = volumes[rid] * R.color_weight
		colors[1] += hex2num(copytext(hex, 2, 4))  * volume
		colors[2] += hex2num(copytext(hex, 4, 6))  * volume
		colors[3] += hex2num(copytext(hex, 6, 8))  * volume
		colors[4] += hex2num(copytext(hex, 8, 10)) * volume
		tot_w += volume

	return rgb(colors[1] / tot_w, colors[2] / tot_w, colors[3] / tot_w, colors[4] / tot_w)