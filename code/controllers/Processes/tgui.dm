var/global/datum/controller/process/tgui/tguiProcess

/datum/controller/process/tgui
	var/list/open_uis = list() // A list of open UIs, grouped by src_object and ui_key.
	var/list/processing_uis = list() // A list of processing UIs, ungrouped.
	var/basehtml // The HTML base used for all UIs.

/datum/controller/process/tgui/setup()
	name = "tgui"
	schedule_interval = 10 // every 2 seconds

	basehtml = file2text('tgui/tgui.html') // Read the HTML from disk.
	tguiProcess = src

/datum/controller/process/tgui/doWork()
	for(var/gui in processing_uis)
		var/datum/tgui/ui = gui
		if(ui && ui.user && ui.src_object)
			ui.process()
			scheck()
			continue
		processing_uis.Remove(ui)
		scheck()

/datum/controller/process/tgui/statProcess()
	..()
	stat(null, "[tguiProcess.processing_uis.len] UI\s")