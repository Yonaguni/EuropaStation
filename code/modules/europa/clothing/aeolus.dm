/obj/item/clothing/accessory/medal/aeolus
	name = "ensign's insignia"
	desc = "A set of ensign's pips."
	icon_state = "aeolus_insignia_ensign"

/obj/item/clothing/accessory/medal/aeolus/lieutenant
	name = "lieutenant's insignia"
	desc = "A set of lientenant's pips."
	icon_state = "aeolus_insignia_lieutenant"

/obj/item/clothing/accessory/medal/aeolus/commander
	name = "commander's insignia"
	desc = "A set of commander's pips."
	icon_state = "aeolus_insignia_commander"

/obj/item/clothing/accessory/medal/aeolus/captain
	name = "captain's insignia"
	desc = "A set of captain's pips."
	icon_state = "aeolus_insignia_captain"

/obj/item/clothing/under/aeolus
	var/pips

/obj/item/clothing/under/aeolus/initialize()
	. = ..()
	if(pips)
		var/obj/insignia = new pips()
		if(can_attach_accessory(insignia))
			attach_accessory(null, insignia)
		else
			qdel(insignia)

/obj/item/clothing/under/aeolus/command
	name = "\improper CO's uniform"
	desc = "The working uniform of a commanding officer."
	icon_state = "aeolus_command"
	pips = /obj/item/clothing/accessory/medal/aeolus/captain

/obj/item/clothing/under/aeolus/bridge
	name = "\improper bridge crew uniform"
	desc = "The working uniform of a executive officer."
	icon_state = "aeolus_xo"
	pips = /obj/item/clothing/accessory/medal/aeolus/lieutenant

/obj/item/clothing/under/aeolus/bridge/operations
	pips = /obj/item/clothing/accessory/medal/aeolus/commander

/obj/item/clothing/under/aeolus/bridge/xo
	pips = /obj/item/clothing/accessory/medal/aeolus/captain

/obj/item/clothing/under/aeolus/engineering
	name = "engineering officer's uniform"
	desc = "The working uniform of a engineering officer."
	icon_state = "aeolus_engineering"

/obj/item/clothing/under/aeolus/engineering/chief
	pips = /obj/item/clothing/accessory/medal/aeolus/commander

/obj/item/clothing/under/aeolus/security
	name = "security officer's uniform"
	desc = "The working uniform of a security officer."
	icon_state = "aeolus_security"
	pips = /obj/item/clothing/accessory/medal/aeolus

/obj/item/clothing/under/aeolus/security/chief
	pips = /obj/item/clothing/accessory/medal/aeolus/commander

/obj/item/clothing/under/aeolus/medical
	name = "medical officer's uniform"
	desc = "The working uniform of a medical officer."
	icon_state = "aeolus_medical"

/obj/item/clothing/under/aeolus/medical/chief
	pips = /obj/item/clothing/accessory/medal/aeolus/commander

/obj/item/clothing/under/aeolus/science
	name = "science officer's uniform"
	desc = "The working uniform of a science officer."
	icon_state = "aeolus_science"

/obj/item/clothing/under/aeolus/science
	pips = /obj/item/clothing/accessory/medal/aeolus/lieutenant

/obj/item/clothing/under/aeolus/supply
	name = "supply corps uniform"
	desc = "The working uniform of a supply officer."
	icon_state = "aeolus_supply"

/obj/item/clothing/under/aeolus/supply/chief
	pips = /obj/item/clothing/accessory/medal/aeolus/commander

/obj/item/clothing/under/aeolus/crewman
	name = "crewman's uniform"
	desc = "The working uniform of a crewman."
	icon_state = "aeolus_crewman"
