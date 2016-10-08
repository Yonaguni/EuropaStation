/datum/console_program/message_board_browser
	name = "Message Boards"

/datum/console_program/message_board_browser/initialize()
	..()
	html[1] =  "<pre class='alignCentre'>=== Select Message Server ==="
	html[2] =  "=========================================================="

	Run()

	html[21] = "=========================================================="
	html[22] = "<div class='alignCentre'>\[<a href='?src=\ref[owner]&action=back' style='[TERM_STD_STYLE]; text-decoration: none'>BACK</a>\]</div>"

/datum/console_program/message_board_browser/Run()
	..()
	for(var/n = 3 to 20)
		html[n] = " "

	var/i = 3
	for(var/b in global_message_servers.boards)
		if(i > 20)
			break
		html[i] = "<div class='alignCentre'>\[<a href='?src=\ref[owner]&action=server&name=[b]' style='[TERM_STD_STYLE]; text-decoration: none'>[b]</a>\]</div>"
		i++

/datum/console_program/message_board_browser/HandleTopic(var/list/href_list)
	switch(href_list["action"])
		if("back")
			owner.SwitchProgram("Main Menu")
		if("server")
			var/datum/console_program/message_board_posts/P = owner.installed_software["Message Board Posts"]
			P.SetServer(global_message_servers.boards[href_list["name"]])
			owner.SwitchProgram("Message Board Posts")

/datum/console_program/message_board_posts
	name = "Message Board Posts"
	main_menu_hide = 1
	var/datum/message_board/board

/datum/console_program/message_board_posts/proc/SetServer(var/datum/message_board/B)
	if(!istype(B))
		return
	board = B
	initialize()

/datum/console_program/message_board_posts/initialize()
	..()
	html[1] =  "<pre class='alignCentre'>=== [board] Message Board ==="
	html[2] =  "=========================================================="

	Run()

	html[21] = "=========================================================="
	html[22] = "<div class='alignCentre'>\[<a href='?src=\ref[owner]&action=back' style='[TERM_STD_STYLE]; text-decoration: none'>BACK</a>\]</div>"

/datum/console_program/message_board_posts/Run()
	..()
	for(var/n = 3 to 20)
		html[n] = " "

	if(!istype(board))
		return

	var/i = 3
	for(var/p in board.posts)
		if(i > 20)
			break
		var/datum/message_board_post/P = board.posts[p]
		if(!istype(P))
			continue
		html[i] = "<div class='alignCentre'>\[<a href='?src=\ref[owner]&action=post&name=[p]' style='[TERM_STD_STYLE]; text-decoration: none'>[P.author] - [P]</a>\]</div>"
		i++

/datum/console_program/message_board_posts/HandleTopic(var/list/href_list)
	switch(href_list["action"])
		if("back")
			owner.SwitchProgram("Message Boards")
