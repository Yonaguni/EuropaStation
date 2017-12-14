/client/var/list/codex_data = list()

/client/Stat()
	. = ..()
	if(usr && statpanel("Codex") && codex_data.len)
		for(var/line in codex_data)
			stat(null, "[line]")

/client/verb/search_codex(searching as text)

	set name = "Search Codex"
	set category = "IC"
	set src = usr

	if(!mob || !SScodex)
		return

	if(!mob.can_use_codex())
		to_chat(src, "<span class='warning'>You cannot perform codex actions currently.</span>")
		return

	if(!searching)
		searching = input("Enter a search string.", "Codex Search") as text|null
		if(!searching)
			return

	var/list/all_entries = SScodex.retrieve_entries_for_string(searching)
	if(all_entries.len == 1)
		SScodex.present_codex_entry(mob, all_entries[1])
	else if(all_entries.len)
		to_chat(src, "<span class='notice'>Your codex implant reports <b>[all_entries.len] matches</b> for '[searching]':</span>")
		for(var/i = 1 to min(all_entries.len, 5))
			var/datum/codex_entry/entry = all_entries[i]
			to_chat(src, "- <b><a href='?src=\ref[SScodex];show_examined_info=\ref[entry.associated_strings[1]];show_to=\ref[mob]'>[entry.display_name]</a></b></ul>")
		if(all_entries.len > 5)
			to_chat(src, "<span class='notice'><b>[all_entries.len - 5] result\s</b> omitted. Please supply a more specific search term.</span>")
	else
		to_chat(src, "<span class='notice'>Your codex implant reports <b>no data available</b> for '[searching]'.</span>")

/client/verb/list_codex_entries()

	set name = "List Codex Entries"
	set category = "IC"
	set src = usr

	if(!mob || !SScodex)
		return

	if(!mob.can_use_codex())
		to_chat(src, "<span class='warning'>You cannot perform codex actions currently.</span>")
		return

	var/list/dat = list()
	for(var/thing in SScodex.entries_by_path)
		var/datum/codex_entry/entry = SScodex.entries_by_path[thing]
		dat[entry.display_name] = entry
	for(var/thing in SScodex.entries_by_string)
		var/datum/codex_entry/entry = SScodex.entries_by_string[thing]
		dat[entry.display_name] = entry
	dat = sortAssoc(dat)

	codex_data = list("<font size = 5>Codex Entries</font>")
	codex_data += "<list>"
	for(var/thing in dat)
		codex_data += "<ul><b><a href='?src=\ref[SScodex];show_examined_info=\ref[dat[thing]];show_to=\ref[mob]'>[thing]</a></b></ul>"
	codex_data += "</list>"
	to_chat(mob, "<span class='notice'>Your codex implant forwards you an index file. See the <b>Codex</b> tab for more information.</span>")
