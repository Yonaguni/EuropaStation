// Huge, huge, immense thanks to Nandrew of the BYOND forums for posting their demo of the new lighting methods, upon which
// this is being built! Thread can be found at the following address: // http://www.byond.com/forum/?post=2033630 (hopefully).
// Additional thanks to Mloc, whose previous work a lot of this draws on, PJ and ErikHanson, for advice and assistance,
// BordListian on Reddit for more advice and discussion, and whoever else was involved that I have forgotten.
// Also thanks to Lummox for BYOND 510's awesome new features.

#define	MASTER_PLANE	0

#define	DARK_PLANE		MASTER_PLANE - 1

#define	GUI_PLANE		MASTER_PLANE + 1


//Light colour presets

//common lights
#define	LIGHT_CANDLE	"#ff9329"	//warm
#define	LIGHT_40WBULB	"#ffc58f"	// ^
#define	LIGHT_100WBULB	"#ffd6aa"	// |
#define	LIGHT_HALOGEN	"#fff1e0"	// |
#define	LIGHT_CARBONARC	"#fffaf4"	// |
#define	LIGHT_MIDDAYSUN	"#fffffb"	// v
#define	LIGHT_SUNLIGHT	"#ffffff"	//white

//Flourescent lights
#define LIGHT_F_WARM	"#fff4e5"	//warm
#define LIGHT_F_STD		"#f4fffa"	//white
#define LIGHT_F_COOL	"#d4ebff"	//cool
