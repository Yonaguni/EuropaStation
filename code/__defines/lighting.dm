#define FOR_DVIEW(type, range, center, invis_flags) \
	dview_mob.loc = center; \
	dview_mob.see_invisible = invis_flags; \
	for(type in view(range, dview_mob))

#define END_FOR_DVIEW dview_mob.loc = null

// Lighting temperatures.
#define COLOUR_LTEMP_CANDLE        rgb(255, 147, 41)
#define COLOUR_LTEMP_40W_TUNGSTEN  rgb(255, 197, 143)
#define COLOUR_LTEMP_100W_TUNGSTEN rgb(255, 214, 170)
#define COLOUR_LTEMP_HALOGEN       rgb(255, 241, 224)
#define COLOUR_LTEMP_CARBON_ARC    rgb(255, 250, 244)
#define COLOUR_LTEMP_HIGHNOON      rgb(255, 255, 251)
#define COLOUR_LTEMP_SUNLIGHT      rgb(255, 255, 255)
#define COLOUR_LTEMP_SKY_OVERCAST  rgb(201, 226, 255)
#define COLOUR_LTEMP_SKY_CLEAR     rgb(64, 156, 255)
#define COLOUR_LTEMP_FLURO_WARM    rgb(255, 244, 229)
#define COLOUR_LTEMP_FLURO         rgb(244, 255, 250)
#define COLOUR_LTEMP_FLURO_COOL    rgb(212, 235, 255)
#define COLOUR_LTEMP_FLURO_FULL    rgb(255, 244, 242)
#define COLOUR_LTEMP_FLURO_GROW    rgb(255, 239, 247)
#define COLOUR_LTEMP_BLACKLIGHT    rgb(167, 0, 255)