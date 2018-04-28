var/list/mining_overlays = list()
#define ADD_MINING_OVERLAY(_adding, _overlay_key, _direction, _colour) \
	if(TRUE) { \
		var/use_col = "#FFFFFF"; \
		var/use_dir = 0; \
		if(!isnull(_direction)) use_dir = _direction; \
		if(!isnull(_colour))    use_col = _colour; \
		var/cache_key = "[_overlay_key]-[use_dir]-[use_col]"; \
		if(!mining_overlays[cache_key]) { \
			var/image/I = image(icon = 'icons/turf/mining_decals.dmi', icon_state = _overlay_key, dir = use_dir); \
			I.color = use_col; \
			mining_overlays[cache_key] = I; \
		} \
		_adding.add_overlay(mining_overlays[cache_key]); \
	}

#define MAKE_FLOOR(_turf) \
	if(_turf.density) { \
		_turf.density = FALSE; \
		_turf.set_opacity(FALSE); \
		_turf.accept_lattice = TRUE; \
		_turf.explosion_resistance = 2; \
		_turf.mineral = null; \
		_turf.update_icon(1); \
	}

#define MAKE_WALL(_turf) \
	if(!_turf.density) { \
		_turf.density = TRUE; \
		_turf.set_opacity(TRUE); \
		_turf.accept_lattice = null; \
		_turf.update_icon(1); \
	}

#define DROP_SAND(_turf) \
	if(!sand_dug) { \
		for(var/sand = 1 to rand(3,5)) { \
			new /obj/item/ore(_turf, MATERIAL_GLASS); \
		} \
		_turf.sand_dug = TRUE; \
		_turf.update_icon(); \
	}

#define DROP_ORE(_turf) \
	if(_turf.mineral) { \
		for(var/i= 1 to _turf.mineral.ore_result_amount) { \
			new /obj/item/ore(_turf, _turf.mineral.name); \
		} \
		_turf.mineral = null; \
		_turf.update_icon(); \
	}