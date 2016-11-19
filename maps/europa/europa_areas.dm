// Slum areas.
/area/europa
	icon = 'icons/areas_europa.dmi'
	base_turf = /turf/simulated/ocean

/area/europa/slums
	name = "Slums"
	icon_state = "slums"

/area/europa/slums/east
	name = "Slums - East"
	icon_state = "slums_east"

/area/europa/slums/west
	name = "Slums - West"
	icon_state = "slums_west"

// Dome 1 - Civil Dome.
/area/europa/dome_civ
	name = "Civil Dome - Foyer"

/area/europa/dome_civ/kitchen
	name = "Civil Dome - Cafeteria"
	icon_state = "cafe"

/area/europa/dome_civ/medical
	name = "Civil Dome - Hospital"
	icon_state = "medical"

/area/europa/dome_civ/garden
	name = "Civil Dome - Garden"
	icon_state = "garden"

/area/europa/docks_civil
	name = "Civil Dome - Docks"
	icon_state = "docks"

/area/europa/docks_evac
	name = "Civil Dome - Evacuation Bay"
	icon_state = "docks"

/area/europa/dome_civ/admin
	name = "Civil Dome - Administration"
	icon_state = "admin"

/area/europa/dome_civ/dorms_general
	name = "Civil Dome - Dormitory Hallway"
	icon_state = "dorms_general"

/area/europa/dome_civ/dorms_east
	name = "Civil Dome - East Dorms"
	icon_state = "dorms_east"

/area/europa/dome_civ/dorms_west
	name = "Civil Dome - West Dorms"
	icon_state = "dorms_west"

/area/europa/dome_civ/clinic
	name = "Civil Dome - Clinic"
	icon_state = "clinic"

/area/europa/dome_civ/clinic_store
	name = "Civil Dome - Medical Storage"
	icon_state = "storage"

/area/europa/dome_civ/engineering
	name = "Civil Dome - Engineering"
	icon_state = "engineering"

/area/europa/dome_civ/engineering/enter_north
	name = "Civil Dome - Engineering North Entrance"
	icon_state = "engineering_enter"

/area/europa/dome_civ/engineering/enter_south
	name = "Civil Dome - Engineering South Entrance"
	icon_state = "engineering_enter"

/area/europa/dome_civ/engineering/enter_east
	name = "Civil Dome - Engineering East Entrance"
	icon_state = "engineering_enter"

/area/europa/dome_civ/engineering/drones
	name = "Civil Dome - Drone Fabrication"
	icon_state = "engineering_enter"

/area/europa/dome_civ/engineering/storage
	name = "Civil Dome - Engineering Storage"
	icon_state = "engineering_store"

/area/europa/dome_civ/engineering/lockers
	name = "Civil Dome - Engineering Lockers"
	icon_state = "engineering_lockers"

/area/europa/dome_civ/engineering/engine
	name = "Civil Dome - Fusion Core"
	icon_state = "fusion"

/area/europa/dome_civ/engineering/engine_obs
	name = "Civil Dome - Core Observation"
	icon_state = "fusion_obs"

/area/europa/dome_civ/engineering/engine_entry
	name = "Civil Dome - Fusion Core Entrance"
	icon_state = "fusion_enter"

/area/europa/dome_civ/atmos
	name = "Civil Dome - Life Support"
	icon_state = "atmospherics"

// Dome 2 - Industrial/Science Dome.
/area/europa/docks_industrial
	name = "Research Dome - Docks"
	icon_state = "docks"

/area/europa/dome_ind
	name = "Research Dome - Foyer"
	icon_state = "hallway"

/area/europa/walkway
	name = "Southern Walkway"
	icon_state = "walk"

/area/europa/walkway/central
	name = "Central Walkway"
	icon_state = "walk"

/area/europa/walkway/north
	name = "Northern Walkway"
	icon_state = "walk"

/area/europa/dome_ind/admin
	name = "Research Dome - Administration"
	icon_state = "admin"

/area/europa/dome_ind/dome
	name = "Research Dome - Dome Two"
	icon_state = "science"

/area/europa/dome_ind/xenobio
	name = "Research Dome - Xenobiology"
	icon_state = "xeno0"

/area/europa/dome_ind/xenobio_access
	name = "Research Dome - Xenobiology Access"
	icon_state = "xeno1"

/area/europa/dome_ind/xenobio_storage
	name = "Research Dome - Xenobiology Storage"
	icon_state = "xeno2"

/area/europa/dome_ind/xenobio_secure
	name = "Research Dome - Xenobiology Secure Testing"
	icon_state = "xeno3"

/area/europa/dome_ind/xenoflora
	name = "Research Dome - Xenoflora"
	icon_state = "xeno4"

// Dome 3 - Naval Dome
/area/europa/docks_navy
	name = "Naval Dome - Docks"
	icon_state = "docks"

/area/europa/dome_navy
	name = "Naval Dome - Offices"
	icon_state = "admin"

/area/europa/dome_navy/medical
	name = "Naval Dome - First Aid"
	icon_state = "medical"

/area/europa/dome_navy/armory
	name = "Naval Dome - Armory"
	icon_state = "armory"

/area/europa/dome_navy/marshal
	name = "Naval Dome - Marshal Quarters"
	icon_state = "dorms"

/area/europa/dome_navy/lockers
	name = "Naval Dome - Locker Room"
	icon_state = "storage"

/area/europa/hallway
	name = "Hallway"
	icon_state = "hallway"

// Maintenance.
/area/europa/maintenance
	flags = RAD_SHIELDED
	sound_env = TUNNEL_ENCLOSED
	icon_state = "maint"

/area/europa/maintenance/industrial_east
	name = "Industrial Dome - East Maintenance"
	icon_state = "maint_south"

/area/europa/maintenance/industrial_north
	name = "Industrial Dome - North Maintenance"
	icon_state = "maint_north"

/area/europa/maintenance/civil_core
	name = "Civil Dome - Core Maintenance"
	icon_state = "maint_core"

/area/europa/maintenance/civil_north
	name = "Civil Dome - North Maintenance"
	icon_state = "maint_north"

/area/europa/maintenance/civil_east
	name = "Civil Dome - East Maintenance"
	icon_state = "maint_east"

/area/europa/maintenance/navy_east
	name = "Naval Dome - East Maintenance"
	icon_state = "maint_east"

/area/europa/maintenance/navy_west
	name = "Naval Dome - West Maintenance"
	icon_state = "maint_west"

/area/europa/maintenance/navy_south
	name = "Naval Dome - South Maintenance"
	icon_state = "maint_south"

/area/europa/mining
	name = "Mining Station"

/area/europa/ocean
	name = "Ocean"
	icon_state = "ocean"

/area/europa/ocean/abyss
	name = "Abyss Floor"
	icon_state = "abyss"
	sound_env = ASTEROID

/area/europa/ocean/surface
	name = "Icy Wastes"
	icon_state = "surface"

/area/europa/offstation
	name = "Rhadamanthus"
	icon_state = "offstation"
