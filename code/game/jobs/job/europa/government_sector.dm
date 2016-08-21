/datum/job/government
	title = "Petty Officer"
	job_category = IS_GOVERNMENT
	total_positions = 2
	selection_color = "#ccccff"
	spawn_positions = 4
	supervisors = "Jovian naval officials and Sol colonial law"
	access = list()
	alt_titles = list("Sub Pilot", "Peace Officer")
	idtype = /obj/item/weapon/card/id/dogtags
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory, access_forensics_lockers,
				access_morgue, access_maint_tunnels, access_all_personal_lockers, access_research, access_engine,
				access_mining, access_medical, access_construction, access_mailsorting, access_RC_announce,
				access_gateway, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory, access_forensics_lockers,
				access_morgue, access_maint_tunnels, access_all_personal_lockers, access_research, access_engine,
				access_mining, access_medical, access_construction, access_mailsorting, access_RC_announce,
				access_gateway, access_external_airlocks)
