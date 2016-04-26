/mob/living/animal/death(gibbed, deathmessage = "dies!")
	. = ..(gibbed,deathmessage)
	if(mob_ai)
		mob_ai.stop_moving()
	else
		walk_to(src, 0)
	update_icon()
	return .

/mob/living/animal/gib()
	return ..(icon_gib,1)