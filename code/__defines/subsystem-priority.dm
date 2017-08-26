#define SS_INIT_MISC_FIRST         20
#define SS_INIT_SHUTTLE            17	// Shuttle setup.
#define SS_INIT_MACHINERY          10	// Machinery prune and powernet build.
#define SS_INIT_WIRELESS            9	// Wireless pair queue flush.
#define SS_INIT_AIR                 8	// Air setup and pre-bake.
#define SS_INIT_ICON_UPDATE         5	// Icon update queue flush. Should run before overlays.
#define SS_INIT_MISC                3	// Subsystems without an explicitly set initialization order start here.
#define SS_INIT_LOBBY              -1	// Lobby timer starts here.

// Something to remember when setting priorities: SS_TICKER runs before Normal, which runs before SS_BACKGROUND.
// Each group has its own priority bracket.
// SS_BACKGROUND handles high server load differently than Normal and SS_TICKER do.

// SS_TICKER
#define SS_PRIORITY_ICON_UPDATE    20	// Queued icon updates. Mostly used by APCs and tables.

// Normal
#define SS_PRIORITY_TICKER         200	// Gameticker.
#define SS_PRIORITY_MOB            150	// Mob Life().
#define SS_PRIORITY_NANOUI         120	// UI updates.
#define SS_PRIORITY_VOTE           110
#define SS_PRIORITY_MACHINERY      95	// Machinery + powernet ticks.
#define SS_PRIORITY_CHEMISTRY      90	// Multi-tick chemical reactions.
#define SS_PRIORITY_SHUTTLE        85	// Shuttle movement.
#define SS_PRIORITY_AIR            80	// ZAS processing.
#define SS_PRIORITY_EVENT          70
#define SS_PRIORITY_ALARMS         50
#define SS_PRIORITY_PLANTS         40	// Spreading plant effects.


// SS_BACKGROUND
#define SS_PRIORITY_PROCESSING    15	// Generic datum processor. Replaces objects processor.
#define SS_PRIORITY_OBJECTS       15	// processing_objects processing.
#define SS_PRIORITY_WIRELESS      12	// Handles pairing of wireless devices. Usually will be asleep.
#define SS_PRIORITY_SUN            3	// Sun movement & Solar tracking.
#define SS_PRIORITY_GARBAGE        2	// Garbage collection.


// Subsystem wait values. The ones defined here are only here because they are also used elsewhere.
#define SS_OBJECT_TR 2 SECONDS
#define SS_MOB_TR 2 SECONDS
