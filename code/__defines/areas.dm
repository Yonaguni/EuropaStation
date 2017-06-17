/proc/get_blueprint_special_areas()
	return list()

/proc/get_prison_break_areas()
	return list()

/proc/get_centcom_areas()
	return list(/area/centcom)

/proc/get_escape_areas()
	return list()

/proc/get_prison_areas()
	return list()

/proc/get_virology_areas()
	return list()

/proc/get_xenobiology_areas()
	return list()

/proc/get_xenoflora_areas()
	return get_xenobiology_areas() + get_prison_areas()

/proc/get_station_break_areas()
	return list()

/proc/get_escape_shuttle_area()
	return FALSE

/proc/get_heist_area()
	return FALSE

/proc/get_ai_turret_areas()
	return FALSE

/proc/get_brig_area()
	return FALSE
