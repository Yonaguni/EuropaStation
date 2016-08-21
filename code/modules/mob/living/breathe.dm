/mob/living/proc/handle_breathing()
	if(life_tick%2!=0 && !failed_last_breath && (health >= config.health_threshold_crit))
		return
	return !handle_drowning()


