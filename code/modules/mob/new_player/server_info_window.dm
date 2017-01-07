/client/verb/check_server_info()
	set name = "Server Information"
	set category = "OOC"

	if (src.infowindow)  //If the user's already viewed the window before just load it again.
		src.infowindow.open()
		return

	var/list/close = list("Gotcha!","AFFIRMATIVE","EXCELSIOR!","I accept","The Pact Is Sealed","Continue","Take me to the fun!","Let us begin")
	var/output = {"
	[join_motd]
	<br>
	[file2text("config/rules.html")]
	<p><b>Map info:</b></p>
	[using_map.motd]
	<br>
	<br>
	<div align='center'>
	<strong>Useful links:</strong>
	<br>
	<b><a href='byond://?src=\ref[src];bugtracker_link=1'>Bugtracker</A></b>
	<b><a href='byond://?src=\ref[src];wiki_link=1'>Wiki</A></b>
	<b><a href='byond://?src=\ref[src];forum_link=1'>Forum</A></b>
	<b><a href='byond://?src=\ref[src];changelog_link=1'>Changelog</A></b>
	<br>
	This server is running the [game_version] modification of <a href='byond://?src=\ref[src];upstream_link=1'>[config.upstream]</A>'s SS13 code.
	<p><b><a href='byond://?src=\ref[src];close_info=1'>[pick(close)]</A></b></p>
	</div>"}
	infowindow = new(src.mob, "Welcome to [game_version]","Welcome to [game_version]", 768, 768, src)
	infowindow.set_window_options("can_close=0")
	infowindow.set_content(output)
	infowindow.open()
	return

client/Topic(href, href_list[])
	if(href_list["upstream_link"])
		src << link(config.upstreamurl)

	if (href_list["bugtracker_link"])
		src << link(config.githuburl)

	if(href_list["wiki_link"])
		src.wiki()

	if(href_list["forum_link"])
		src.forum()

	if(href_list["changelog_link"])
		src.changes()

	if(href_list["close_info"])
		src.infowindow.close()
		if(isnewplayer(src.mob))
			var/mob/new_player/M = src.mob
			if(!(src.ckey in acceptedKeys)) //If they've yet to view the info window they must be just joining so we note this then show them the normal menu.
				M.new_player_panel()
				acceptedKeys.Add(src.ckey)
	..()