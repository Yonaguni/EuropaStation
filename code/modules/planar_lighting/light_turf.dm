/turf/var/blocks_light = -1

/turf/set_opacity()
	..()
	blocks_light = -1

/turf/proc/check_blocks_light()
	if(blocks_light == -1)
		blocks_light = 0
		if(opacity)
			blocks_light = 1
		else
			for(var/atom/movable/AM in contents)
				if(AM.opacity)
					blocks_light = 1
					break
	return blocks_light
