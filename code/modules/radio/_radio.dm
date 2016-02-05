#define HEADSET_LOW_FREQ 1441
#define HEADSET_HIGH_FREQ 1489

#define CHANNEL_PUBIC 1459
#define CHANNEL_SECURE 1555

// Various mappings to save time/remove the necessity of using procs.
// Other spans:centradio comradio airadio secradio engradio
// sciradio medradio supradio srvradio entradio deptradio.
var/list/radio_freq_to_span = list(
	"[CHANNEL_SECURE]" = "syndradio"
	)
var/list/radio_freq_to_name = list(
	"[CHANNEL_SECURE]" = "Secure"
	)

// Entries in this list must be "string" - integer to ensure that
// :h works properly alongside the specific keys like :t.
var/list/radio_name_to_freq = list(
	"Secure" = CHANNEL_SECURE
	)
var/list/radio_name_to_key = list(
	"Secure" = ":T"
	)
var/list/radio_freq_to_key = list(
	"[CHANNEL_SECURE]" = ":T"
	)

// Channels that require a key to be picked up.
var/list/encrypted_channels = list(
	"[CHANNEL_SECURE]"
	)

var/list/key_to_name = list(
		// Utility keys; interpreted specially.
	":r" = "right ear",  ".r" = "right ear",
	":R" = "right ear",  ".R" = "right ear",
	":ê" = "right ear",  ".ê" = "right ear",
	":l" = "left ear",   ".l" = "left ear",
	":L" = "left ear",   ".L" = "left ear",
	":ä" = "left ear",   ".ä" = "left ear",
	":i" = "intercom",   ".i" = "intercom",
	":I" = "intercom",   ".I" = "intercom",
	":ø" = "intercom",   ".ø" = "intercom",
	":h" = "department", ".h" = "department",
	":H" = "department", ".H" = "department",
	":ð" = "department", ".ð" = "department",
	":+" = "special",    ".+" = "special",
	// Specific radio channels.
	":t" = "Secure",     ".t" = "Secure",
	":T" = "Secure",     ".T" = "Secure",
	":å" = "Secure",     ".å" = "Secure",
	)
