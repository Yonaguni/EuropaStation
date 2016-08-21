/obj/effect/landmark/start/citizen
	name = "Citizen"

/datum/job/civilian
	title = "Colonist"
	total_positions = -1
	spawn_positions = -1
	supervisors = "colonial authorities"
	selection_color = "#dddddd"
	idtype = /obj/item/weapon/card/id
	alt_titles = list("Citizen", "Visitor", "Doctor", "Janitor", "Gardener")
	access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
            access_construction, access_sec_doors, access_medical, access_medical_equip, access_morgue,
			access_genetics, access_chemistry, access_virology, access_surgery, access_RC_announce,access_psychiatrist)
	minimal_access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
            access_construction, access_sec_doors, access_medical, access_medical_equip, access_morgue,
			access_genetics, access_chemistry, access_virology, access_surgery, access_RC_announce,access_psychiatrist)

/datum/job/civilian/equip_survival(var/mob/living/human/H)
	if(!H) return
	if(H.mind.role_alt_title == "Visitor")
		return
	..()