// A set of constants used to determine which type of mute an admin wishes to apply.
// Please read and understand the muting/automuting stuff before changing these. MUTE_IC_AUTO, etc. = (MUTE_IC << 1)
// Therefore there needs to be a gap between the flags for the automute flags.
#define MUTE_IC        0x1
#define MUTE_OOC       0x2
#define MUTE_PRAY      0x4
#define MUTE_ADMINHELP 0x8
#define MUTE_DEADCHAT  0x10
#define MUTE_ALL       0xFFFF

// Number of identical messages required to get the spam-prevention auto-mute thing to trigger warnings and automutes.
#define SPAM_TRIGGER_WARNING  5
#define SPAM_TRIGGER_AUTOMUTE 10

#define ROUNDSTART_LOGOUT_REPORT_TIME 6000 // Amount of time (in deciseconds) after the rounds starts, that the player disconnect report is issued.

// Admin permissions.
#define R_SPAWN         0x1
#define R_ADMIN         0x2
#define R_BAN           0x4
#define R_SOUNDS        0x8
#define R_SERVER        0x10
#define R_DEBUG         0x20
//unused 0x40 0x80 0x100 0x200 0x400 0x800 0x1000 0x2000 0x4000 0x8000, higher than this will overflow

#define R_MAXPERMISSION 0x20 // This holds the maximum value for a permission. It is used in iteration, so keep it updated.
