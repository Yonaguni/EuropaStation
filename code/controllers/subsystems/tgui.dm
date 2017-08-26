/var/datum/controller/subsystem/tgui/SStgui

/datum/controller/subsystem/tgui
	name = "tgui"
	wait = 1 SECOND

	var/list/tg_open_uis = list() // A list of open UIs, grouped by src_object and ui_key.
	var/list/processing_uis = list() // A list of processing UIs, ungrouped.
	var/basehtml // The HTML base used for all UIs.
	var/list/currentrun

/datum/controller/subsystem/tgui/New()
	NEW_SS_GLOBAL(SStgui)

/datum/controller/subsystem/tgui/Initialize()
	basehtml = file2text('tgui/tgui.html')
	..()

/datum/controller/subsystem/tgui/fire(resumed = 0)
	if (!resumed)
		currentrun = processing_uis.Copy()

	var/list/curr = currentrun
	while(curr.len)
		var/datum/tgui/ui = curr[curr.len]
		curr.len--

		if (!QDELETED(ui) && ui.user && ui.src_object)
			ui.process()

			if (MC_TICK_CHECK)
				return

/datum/controller/subsystem/tgui/stat_entry()
	..("UI:[processing_uis.len]")
