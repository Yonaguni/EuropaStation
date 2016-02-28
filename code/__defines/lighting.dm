#define FOR_DVIEW(type, range, center, invis_flags) \
	dview_mob.loc = center; \
	dview_mob.see_invisible = invis_flags; \
	for(type in view(range, dview_mob))

#define END_FOR_DVIEW dview_mob.loc = null

#define LIGHT_SOFT             "soft"
#define LIGHT_SOFT_FLICKER     "soft-flicker"
#define LIGHT_DIRECTIONAL      "directional"
