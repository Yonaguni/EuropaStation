// Slum areas.
/area/europa
	icon = 'icons/areas_europa.dmi'
	base_turf = /turf/simulated/ocean

/area/europa/ocean
	name = "Ocean"
	icon_state = "ocean"

/area/europa/ocean/abyss
	name = "Abyss Floor"
	icon_state = "abyss"
	sound_env = ASTEROID

/area/centcom/europa/offstation
	name = "Rhadamanthus"
	icon_state = "offstation"

/area/maintenance/europa
	icon = 'icons/areas_europa.dmi'

/area/maintenance/europa/maint_upper
	name = "Deck Three Maintenance"
	icon_state = "civil"

/area/maintenance/europa/maint_lower
	name = "Deck One Maintenance"
	icon_state = "civil"

/area/maintenance/europa/port_crew
	name = "Port Crew Quarters"
	icon_state = "civil"

/area/maintenance/europa/starboard_crew
	name = "Starboard Crew Quarters"
	icon_state = "civil"

/area/maintenance/europa/port_cryo
	name = "Port Cryogenics"
	icon_state = "civil"

/area/maintenance/europa/starboard_cryo
	name = "Starboard Cryogenics"
	icon_state = "civil"

/area/hallway/europa
	icon = 'icons/areas_europa.dmi'

/area/europa/forward_port_battery
	name = "Forward Port Battery"
	icon_state = "armory"

/area/europa/expedition_prep
	name = "Expedition Preparation"
	icon_state = "eva"

/area/europa/forward_starboard_battery
	name = "Forward Starboard Battery"
	icon_state = "armory"

/area/europa/port_battery
	name = "Port Battery"
	icon_state = "armory"

/area/europa/starboard_battery
	name = "Starboard Battery"
	icon_state = "armory"

// Civil Sector.
/area/europa/turret_protected/comms
	name = "Communications Hub"
	icon_state = "tcomms"

/area/europa/cargo
	name = "Cargo Bay"
	icon_state = "cargo"

/area/europa/civil
	name = "Civil Sector"
	icon_state = "civil"

/area/europa/observation
	name = "Forward Observation Deck"
	icon_state = "civil"

/area/europa/observation/starboard
	name = "Starboard Observation Deck"

/area/europa/observation/port
	name = "Port Observation Deck"

/area/europa/civil/bridge
	name = "Bridge"
	icon_state = "civil_clo"

/area/europa/civil/captain_quarters
	name = "Captain's Quarters"
	icon_state = "civil_cl"

/area/europa/armory
	name = "Armory"
	icon_state = "armory"

/area/europa/armory_foyer
	name = "Armory Foyer"
	icon_state = "armory"

/area/europa/civil/mate_quarters
	name = "First Mate's Quarters"
	icon_state = "civil_cl"

/area/europa/civil/gunner_quarters
	name = "Gunner's Quarters"
	icon_state = "civil_cl"

/area/europa/civil/janitor
	name = "Custodial Office"
	icon_state = "janitor"

/area/europa/civil/tech_storage
	name = "Technical Storage"
	icon_state = "tech_storage"

/area/europa/civil/secure_storage
	name = "Secure Storage"
	icon_state = "secure_storage"

/area/europa/civil/port_docks
	name = "Port Docks"
	icon_state = "civil_docks"

/area/europa/civil/starboard_docks
	name = "Starboard Docks"
	icon_state = "civil_docks"

/area/europa/civil/hydroponics
	name = "Hydroponics"
	icon_state = "hydroponics"

/area/europa/civil/kitchen
	name = "Kitchen"
	icon_state = "kitchen"

/area/europa/civil/storage
	name = "Storage"
	icon_state = "civil_storage"

/area/europa/civil/rec_area
	name = "Rec Area"
	icon_state = "dorm3"

/area/hallway/europa/deck_one
	name = "Deck One Hallway"
	icon_state = "civil_hall_west"

/area/europa/civil/deck_one_dorms
	name = "Deck One Dormitories"
	icon_state = "dorm3"

/area/europa/civil/deck_one_toilets
	name = "Deck One Toilets"
	icon_state = "dorm2"

/area/hallway/europa/port_fore
	name = "Port Fore Hallway"
	icon_state = "civil_hall_north"

/area/hallway/europa/star_fore
	name = "Starboard Fore Hallway"
	icon_state = "civil_hall_south"

/area/hallway/europa/port_central
	name = "Port Central Hallway"
	icon_state = "civil_hall_east"

/area/hallway/europa/star_central
	name = "Starboard Central Hallway"
	icon_state = "civil_hall_west"

/area/hallway/europa/port_aft
	name = "Port Aft Hallway"
	icon_state = "civil_hall_east"

/area/hallway/europa/star_aft
	name = "Starboard Aft Hallway"
	icon_state = "civil_hall_west"

/area/europa/hospital
	name = "Clinic"
	icon_state = "hospital"

/area/europa/hospital/surgery
	name = "Surgery"
	icon_state = "morgue"

// Engineering sector.
/area/europa/engineering
	name = "Engineering"
	icon_state = "engineering"

/area/europa/engineering/atmos
	name = "Atmospherics"
	icon_state = "atmospherics"

/area/europa/engineering/fabrication
	name = "Fabrication"
	icon_state = "drone"

/area/europa/engineering/engine
	name = "Fusion Plant"
	icon_state = "fusion"

/area/europa/engineering/engine_control
	name = "Fusion Control"
	icon_state = "fusion_obs"

/area/turret_protected/ai
	name = "Computer Core"
	icon_state = "ai_chamber"
	ambience = list('sound/ambience/ambimalf.ogg')

// Shuttle areas.
/area/shuttle/europa
	icon = 'icons/areas_europa.dmi'

/area/turbolift/makara_one
	name = "Deck One"
	lift_announce_str = "Arriving at Deck One."
	base_turf = /turf/simulated/floor/plating

/area/turbolift/makara_two
	name = "Deck Two"
	lift_announce_str = "Arriving at Deck Two."

/area/turbolift/makara_three
	name = "Deck Three"
	lift_announce_str = "Arriving at Deck Three."

// World area refs
/world
	area = /area/europa/ocean

/get_heist_area()
	return null

/get_prison_areas()
	return list()

/get_escape_areas()
	return list()

/get_escape_shuttle_area()
	return null

/get_centcom_areas()
	return list(/area/centcom/europa/offstation)

/get_blueprint_special_areas()
	return list(
		/area/shuttle,
		/area/centcom/europa/offstation
		)