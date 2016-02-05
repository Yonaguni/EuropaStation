/obj/item/device/encryptionkey
	name = "radio encryption key"
	desc = "An encryption key for a radio headset. Contains cypherkeys."
	icon = 'icons/obj/radio.dmi'
	icon_state = "cypherkey"
	item_state = null
	w_class = 1
	slot_flags = SLOT_EARS

	var/translate_binary = 0
	var/translate_hive = 0
	var/list/channels = list(CHANNEL_SECURE)