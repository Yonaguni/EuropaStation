/obj/machinery/mineral/unloading_machine
	name = "unloading machine"
	icon_state = "unloader"
	input_turf =  SOUTH
	output_turf = NORTH

/obj/machinery/mineral/unloading_machine/process()
	if(input_turf && output_turf)
		var/ore_this_tick = 25
		for(var/obj/structure/ore_box/unloading in input_turf)
			for(var/obj/item/ore/_ore in unloading)
				_ore.forceMove(output_turf)
				if(--ore_this_tick<=0) return
		for(var/obj/item/_ore in input_turf)
			_ore.forceMove(output_turf)
			if(--ore_this_tick<=0) return