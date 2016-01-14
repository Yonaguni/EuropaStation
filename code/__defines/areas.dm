//Area flags.
#define RAD_SHIELDED           1 // Shielded from radiation storms.
#define DENY_APC               2 // Cannot build an APC in this area.
#define IGNORE_ENDGAME         4 // Ignores the effects of endgame universe states.
#define IGNORE_ALERTS          8 // Does not apply the visual effects of alerts.
#define DENY_TELEPORT         16 // Cannot be teleported to by a wizard.
#define DENY_GHOST_TELEPORT   32 // As above, for ghosts.
#define INFESTATION_TARGET    64 // Vermin can spawn here.
#define IGNORE_BLACKOUTS     128 // Power won't randomly fail here.
#define SHOW_EVAC_ALERT      256 // Evacuation will cause flashing alert lights in these areas.
#define SECURE_AREA          512 // This area counts as the brig for the sake of objectives.
#define HIDE_DEATH_LOCATION 1024 // Death alarms do not reveal deaths in these areas.