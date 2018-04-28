#define SS_INIT_CHEMISTRY          12   // Init reagent lists.
#define SS_INIT_MATERIALS          11	// Initial material list building.
#define SS_INIT_SEEDS              10
#define SS_INIT_PERSISTENCE         9	// Initialize round-start map objects from previous rounds.
#define SS_INIT_MISC_FIRST          8
#define SS_INIT_ATOMS               7
#define SS_INIT_WIRELESS            6	// Wireless pair queue flush.
#define SS_INIT_AIR                 5	// Air setup and pre-bake.
#define SS_INIT_ICON_UPDATE         4	// Icon update queue flush. Should run before overlays.
#define SS_INIT_OVERLAY             3	// Overlay flush.
#define SS_INIT_AO                  2
#define SS_INIT_MISC                1	// Subsystems without an explicitly set initialization order start here.
#define SS_INIT_OPENTURF            0	// Openturf flush. Should run after SSoverlay & SSicon_smooth so it copies the smoothed sprites.
#define SS_INIT_LOBBY              -1	// Lobby timer starts here.

// Something to remember when setting priorities: SS_TICKER runs before Normal, which runs before SS_BACKGROUND.
// Each group has its own priority bracket.
// SS_BACKGROUND handles high server load differently than Normal and SS_TICKER do.

// SS_TICKER
#define SS_PRIORITY_OVERLAY        500	// Applies overlays. May cause overlay pop-in if it gets behind.

// Normal
#define SS_PRIORITY_TICKER         200	// Gameticker.
#define SS_PRIORITY_MOB            150	// Mob Life().
#define SS_PRIORITY_NANOUI         120	// UI updates.
#define SS_PRIORITY_TGUI           120
#define SS_PRIORITY_VOTE           110
#define SS_PRIORITY_MACHINERY      95	// Machinery + powernet ticks.
#define SS_PRIORITY_CHEMISTRY      90	// Multi-tick chemical reactions.
#define SS_PRIORITY_AIR            80	// ZAS processing.
#define SS_PRIORITY_EVENT          70
#define SS_PRIORITY_ALARMS         50
#define SS_PRIORITY_PLANTS         40	// Spreading plant effects.
#define SS_PRIORITY_ICON_UPDATE    20	// Queued icon updates. Mostly used by APCs and tables.
#define SS_PRIORITY_AIRFLOW        15	// Object movement from ZAS airflow.
#define SS_PRIORITY_OPENTURF       10	// Open turf icon generation/updates.

// SS_BACKGROUND
#define SS_PRIORITY_PSYCHICS      15	// Psychic complexus processing.
#define SS_PRIORITY_PROCESSING    15	// Generic datum processor. Replaces objects processor.
#define SS_PRIORITY_OBJECTS       15	// processing_objects processing.
#define SS_PRIORITY_WIRELESS      12	// Handles pairing of wireless devices. Usually will be asleep.
#define SS_PRIORITY_SUN            3	// Sun movement & Solar tracking.
#define SS_PRIORITY_GARBAGE        2	// Garbage collection.


// Subsystem wait values. The ones defined here are only here because they are also used elsewhere. These should be considered legacy; don't add more of these unless you REALLY need to.
#define SS_OBJECT_TR 2 SECONDS
#define SS_MOB_TR 2 SECONDS
