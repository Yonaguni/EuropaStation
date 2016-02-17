/area/rimworld
	name = "planetary surface"
	icon = 'icons/areas/rimworld.dmi'
	icon_state = "surface"
	requires_power = 1
	always_unpowered = 0
	power_light = 1
	power_equip = 1
	power_environ = 1
	flags = DENY_APC | IGNORE_ENDGAME | IGNORE_ALERTS | DENY_TELEPORT | IGNORE_BLACKOUTS
	outside = 1
	ambience = list()

/area/rimworld/atmosalert()
	return

/area/rimworld/fire_alert()
	return

/area/rimworld/fire_reset()
	return

/area/rimworld/readyalert()
	return

/area/rimworld/partyalert()
	return

/area/rimworld/building
	icon_state = "house"
/area/rimworld/building/farmhouse
	name = "Farmhouse"
	icon_state = "farmhouse"
/area/rimworld/building/farmhouse/hunter
	name = "Hunter's Den"
/area/rimworld/building/pub
	name = "Pub"
	icon_state = "pub"
/area/rimworld/building/garage
	name = "Garage"
	icon_state = "garage"
/area/rimworld/building/garage/power
	name = "Supply Depot"
/area/rimworld/building/garage/scrapper
	name = "Scrapyard"
// Houses!
/area/rimworld/building/mayor
	name = "Mayor's Residence"
/area/rimworld/building/homestead_ne
	name = "Small Homestead - Northeast"
/area/rimworld/building/homestead_se
	name = "Small Homestead - Southeast"
/area/rimworld/building/homestead_nw
	name = "Small Homestead - Northwest"
/area/rimworld/building/homestead_sw
	name = "Small Homestead - Southwest"
/area/rimworld/building/homestead_large_n
	name = "Gaol"
/area/rimworld/building/homestead_large_s
	name = "Clinic"
/area/rimworld/building/chapel
	name = "Chapel"
// Bank!
/area/rimworld/building/bank
	name = "Bank - Foyer"
	icon_state = "bank"
/area/rimworld/building/bank/vault
	name = "Bank - Vaults"
	icon_state = "bank_vault"
/area/rimworld/building/bank/secure_vault
	name = "Bank - Secure Vault"
	icon_state = "bank_vault"

// Other surface areas.
/area/rimworld/forest
	name = "Forest"
	icon_state = "forest"
/area/rimworld/settlement
	name = "Settlement"
	icon_state = "village"
	ambience = list('sound/ambience/wind_fence.ogg')

/area/rimworld/desert
	name = "Desert"
	icon_state = "desert"
	ambience = list('sound/ambience/desert.ogg','sound/ambience/cicada.ogg','sound/ambience/buzzard.ogg')

/area/rimworld/river
	name = "River"
	icon_state = "water"
/area/rimworld/highway
	name = "Highway"
	icon_state = "highway"
/area/rimworld/market
	name = "Market Square"
	icon_state = "market"
/area/rimworld/farmland
	name = "Farmland"
	icon_state = "farms"


