#define LIGHT_OK 0
#define LIGHT_EMPTY 1
#define LIGHT_BROKEN 2
#define LIGHT_BURNED 3

#define LIGHT_BULB_TEMPERATURE 400 //K - used value for a 60W bulb
#define LIGHTING_POWER_FACTOR 5		//5W per luminosity * range

var/global/list/light_bulb_type_cache = list()
/proc/get_light_bulb_type_instance(var/light_bulb_type)
	. = light_bulb_type_cache[light_bulb_type]
	if(!.)
		. = new light_bulb_type
		light_bulb_type_cache[light_bulb_type] = .
