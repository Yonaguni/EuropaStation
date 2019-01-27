/datum/map/away_sites_testing
	// Unit test exemptions
	apc_test_exempt_areas = list(
		/area/space = NO_SCRUBBER|NO_VENT|NO_APC
	)

	area_coherency_test_exempt_areas = list(
		/area/space
	)

	area_coherency_test_subarea_count = list(
	)

	area_usage_test_exempted_areas = list(
		/area/overmap,
		/area/template_noop,
		/area/centcom,
		/area/centcom/holding,
		/area/centcom/specops,
		/area/chapel,
		/area/hallway,
		/area/medical,
		/area/medical/virology,
		/area/medical/virologyaccess,
		/area/medical/virology,
		/area/security,
		/area/security/brig,
		/area/security/prison,
		/area/maintenance,
		/area/rnd,
		/area/rnd/xenobiology,
		/area/rnd/xenobiology/xenoflora,
		/area/rnd/xenobiology/xenoflora_storage,
		/area/shuttle,
		/area/shuttle/escape,
		/area/shuttle/escape/centcom,
		/area/shuttle/specops,
		/area/shuttle/specops/centcom,
		/area/shuttle/syndicate_elite,
		/area/shuttle/syndicate_elite/mothership,
		/area/shuttle/syndicate_elite/station,
		/area/skipjack_station,
		/area/skipjack_station/start,
		/area/supply,
		/area/syndicate_mothership,
		/area/syndicate_mothership/elite_squad,
		/area/wizard_station,
		/area/beach,
		/area/turbolift
	)

	area_usage_test_exempted_root_areas = list(
		/area/exoplanet,
		/area/map_template
	)
