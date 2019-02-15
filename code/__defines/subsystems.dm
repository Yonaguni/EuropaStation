//For servers that can't do with any additional lag, set this to none in flightpacks.dm in subsystem/processing.
#define FLIGHTSUIT_PROCESSING_NONE 0
#define FLIGHTSUIT_PROCESSING_FULL 1

#define INITIALIZATION_INSSATOMS     0	//New should not call Initialize
#define INITIALIZATION_INNEW_MAPLOAD 1	//New should call Initialize(TRUE)
#define INITIALIZATION_INNEW_REGULAR 2	//New should call Initialize(FALSE)

#define INITIALIZE_HINT_NORMAL   0  //Nothing happens
#define INITIALIZE_HINT_LATELOAD 1  //Call LateInitialize
#define INITIALIZE_HINT_QDEL     2  //Call qdel on the atom

//type and all subtypes should always call Initialize in New()
#define INITIALIZE_IMMEDIATE(X) ##X/New(loc, ...){\
	..();\
	if(!(atom_flags & ATOM_FLAG_INITIALIZED)) {\
		args[1] = TRUE;\
		SSatoms.InitAtom(src, args);\
	}\
}

// Subsystem init_order, from highest priority to lowest priority
// Subsystems shutdown in the reverse of the order they initialize in
// The numbers just define the ordering, they are meaningless otherwise.

#define SS_INIT_GARBAGE          18
#define SS_INIT_CHEMISTRY        17
#define SS_INIT_MATERIALS        16
#define SS_INIT_PLANTS           15
#define SS_INIT_ANTAGS           14
#define SS_INIT_CULTURE          13
#define SS_INIT_ICON_UPDATE      12
#define SS_INIT_OVERLAY          11
#define SS_INIT_AO               10
#define SS_INIT_MISC             9
#define SS_INIT_SKYBOX           8
#define SS_INIT_MAPPING          7
#define SS_INIT_JOBS             6
#define SS_INIT_CHAR_SETUP       5
#define SS_INIT_CIRCUIT          4
#define SS_INIT_OPEN_SPACE       3
#define SS_INIT_ATOMS            2
#define SS_INIT_MACHINES         1
#define SS_INIT_DEFAULT          0
#define SS_INIT_AIR             -1
#define SS_INIT_MISC_LATE       -2
#define SS_INIT_ALARM           -3
#define SS_INIT_SHUTTLE         -4
#define SS_INIT_LIGHTING        -5
#define SS_INIT_ZCOPY           -6
#define SS_INIT_XENOARCH        -10
#define SS_INIT_BAY_LEGACY      -12
#define SS_INIT_TICKER          -20
#define SS_INIT_UNIT_TESTS      -100

// SS runlevels

#define RUNLEVEL_INIT 0
#define RUNLEVEL_LOBBY 1
#define RUNLEVEL_SETUP 2
#define RUNLEVEL_GAME 4
#define RUNLEVEL_POSTGAME 8

#define RUNLEVELS_DEFAULT (RUNLEVEL_SETUP | RUNLEVEL_GAME | RUNLEVEL_POSTGAME)

// Z-mimic (SSzcopy)
#define TURF_IS_MIMICING(T) (isturf(T) && (T:z_flags & MIMIC_BELOW))
#define CHECK_OO_EXISTENCE(OO) if (OO && !TURF_IS_MIMICING(OO.loc)) { qdel(OO); }
#define UPDATE_OO_IF_PRESENT CHECK_OO_EXISTENCE(bound_overlay); if (bound_overlay) { update_above(); }

// Turf MZ flags.
#define MIMIC_BELOW     1	// If this turf should mimic the turf on the Z below.
#define MIMIC_OVERWRITE 2	// If this turf is Z-mimicing, overwrite the turf's appearance instead of using a movable. This is faster, but means the turf cannot have an icon.
#define ALLOW_LIGHTING  4	// If this turf should permit passage of lighting.
#define ALLOW_ATMOS     8	// If this turf permits passage of air.
#define MIMIC_NO_AO    16	// If the turf shouldn't apply regular turf AO and only do Z-mimic AO.
#define MIMIC_QUEUED   32	// If the turf is currently queued for Z-mimic update.

// Convenience flag.
#define MIMIC_DEFAULTS (MIMIC_BELOW|ALLOW_LIGHTING)

// For debug purposes, should contain the above defines in ascending order.
var/list/mimic_defines = list(
	"MIMIC_BELOW",
	"MIMIC_OVERWRITE",
	"ALLOW_LIGHTING",
	"ALLOW_ATMOS",
	"MIMIC_NO_AO",
	"MIMIC_QUEUED"
)
