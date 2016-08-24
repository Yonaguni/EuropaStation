var/list/admin_verbs_default = list(
	/datum/admins/proc/show_player_panel,
	/client/proc/toggleadminhelpsound,
	/client/proc/deadmin_self,
	/client/proc/debug_variables,
	/client/proc/cmd_assume_direct_control,
	/client/proc/cmd_debug_del_all
	)

var/list/admin_verbs_admin = list(
	/datum/admins/proc/show_game_mode,
	/datum/admins/proc/force_mode_latespawn,
	/datum/admins/proc/force_antag_latespawn,
	/datum/admins/proc/toggleenter,
	/datum/admins/proc/toggleguests,
	/datum/admins/proc/announce,
	/client/proc/admin_ghost,
	/client/proc/toggle_view_range,
	/datum/admins/proc/view_txt_log,
	/datum/admins/proc/view_atk_log,
	/client/proc/cmd_admin_pm_context,
	/client/proc/cmd_admin_pm_panel,
	/client/proc/cmd_admin_subtle_message,
	/client/proc/cmd_admin_delete,
	/client/proc/giveruntimelog,
	/client/proc/getserverlog,
	/client/proc/jumptocoord,
	/client/proc/Getmob,
	/client/proc/Getkey,
	/client/proc/Jump,
	/client/proc/jumptokey,
	/client/proc/jumptomob,
	/client/proc/jumptoturf,
	/client/proc/admin_call_shuttle,
	/client/proc/admin_cancel_shuttle,
	/client/proc/cmd_admin_direct_narrate,
	/client/proc/cmd_admin_world_narrate,
	/client/proc/cmd_admin_create_centcom_report,
	/client/proc/check_antagonists,
	/client/proc/admin_memo,
	/client/proc/dsay,
	/client/proc/toggle_hear_radio,
	/client/proc/secrets,
	/datum/admins/proc/toggleooc,
	/datum/admins/proc/toggledsay,
	/client/proc/cmd_admin_say,
	/datum/admins/proc/togglehubvisibility,
	/datum/admins/proc/PlayerNotes,
	/datum/admins/proc/show_player_info,
	/client/proc/free_slot,
	/client/proc/cmd_admin_change_custom_event,
	/client/proc/cmd_admin_rejuvenate,
	/client/proc/toggleattacklogs,
	/client/proc/toggledebuglogs,
	/datum/admins/proc/show_aspects,
	/client/proc/toggle_antagHUD_use,
	/client/proc/toggle_antagHUD_restrictions,
	/client/proc/allow_character_respawn,
	/client/proc/event_manager_panel,
	/datum/admins/proc/reload_vips,
	/datum/admins/proc/show_vips,
	/client/proc/view_chemical_reaction_logs,
	/client/proc/toggle_random_events,
	)

var/list/admin_verbs_ban = list(
	/datum/admins/proc/apply_server_ban,
	/datum/admins/proc/apply_job_ban,
	/datum/admins/proc/list_bans,
	/datum/admins/proc/unban
	)

var/list/admin_verbs_sounds = list(
	/client/proc/play_local_sound,
	/client/proc/play_sound
	)

var/list/admin_verbs_spawn = list(
	/client/proc/drop_bomb,
	/datum/admins/proc/spawn_fruit,
	/datum/admins/proc/spawn_fluid_verb,
	/datum/admins/proc/spawn_custom_item,
	/datum/admins/proc/check_custom_items,
	/datum/admins/proc/spawn_plant,
	/datum/admins/proc/spawn_atom
)

var/list/admin_verbs_server = list(
	/datum/admins/proc/capture_map,
	/client/proc/ToRban,
	/datum/admins/proc/startnow,
	/datum/admins/proc/restart,
	/datum/admins/proc/delay,
	/datum/admins/proc/toggleaban,
	/client/proc/toggle_log_hrefs,
	/client/proc/cmd_admin_delete,
	/client/proc/toggle_random_events
	)
var/list/admin_verbs_debug = list(
	/client/proc/getruntimelog,
	/client/proc/debug_controller,
	/client/proc/debug_antagonist_template,
	/client/proc/cmd_admin_delete,
	/client/proc/print_random_map,
	/client/proc/create_random_map,
	/client/proc/apply_random_map,
	/client/proc/overlay_random_map,
	/client/proc/delete_random_map,
	/client/proc/callproc,
	/client/proc/callproc_target,
	/client/proc/toggledebuglogs,
	/client/proc/SDQL_query,
	/client/proc/SDQL2_query,
	/client/proc/Jump,
	/client/proc/jumptomob,
	/client/proc/jumptocoord,
	/client/proc/dsay
	)

/client/proc/add_admin_verbs()
	if(!holder)
		return
	verbs |= admin_verbs_default
	if(holder.rights & R_ADMIN)  verbs |= admin_verbs_admin
	if(holder.rights & R_BAN)    verbs |= admin_verbs_ban
	if(holder.rights & R_SERVER) verbs |= admin_verbs_server
	if(holder.rights & R_DEBUG)  verbs |= admin_verbs_debug
	if(holder.rights & R_SOUNDS) verbs |= admin_verbs_sounds
	if(holder.rights & R_SPAWN)  verbs |= admin_verbs_spawn

/client/proc/remove_admin_verbs()
	verbs.Remove(
		admin_verbs_default,
		admin_verbs_admin,
		admin_verbs_ban,
		admin_verbs_server,
		admin_verbs_debug,
		admin_verbs_sounds,
		admin_verbs_spawn
		)
