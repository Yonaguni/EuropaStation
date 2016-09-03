var/datum/message_servers/global_message_servers = new()

/datum/message_servers
	var/name = "message servers"
	var/list/boards

/datum/message_servers/New()
	boards = new()

/datum/message_servers/Destroy()
	for(var/datum/message_board/B in boards)
		qdel(B)
	boards = null
	return ..()

/datum/message_servers/proc/AddServer(var/datum/message_board/M)
	if(!istype(M))
		return

	boards["[M.name]"] = M


/datum/message_board
	var/name
	var/list/posts

/datum/message_board/New(var/new_name)
	name = new_name
	posts = new()

/datum/message_board/Destroy()
	for(var/datum/message_board_post/P in posts)
		qdel(P)
	posts = null
	return ..()

/datum/message_board/proc/RegisterServer()
	global_message_servers.AddServer(src)

/datum/message_board/proc/Post(var/datum/message_board_post/P)
	if(!P.name)
		P.name = "post #[posts.len + 1]"

	if(!P.author)
		P.author = "Anonymous"

	if(!P.content)
		P.content = " "

	posts["[P]"] = P


/datum/message_board_post
	var/name		//title of post
	var/author
	var/content
	var/list/comments

/datum/message_board_post/New()
	comments = new()

/datum/message_board_post/Destroy()
	comments = null
	return ..()

/datum/message_board_post/proc/AddTitle(var/title)
	name = title

/datum/message_board_post/proc/AddAuthor(var/new_author)
	author = new_author

/datum/message_board_post/proc/AddContent(var/new_content)
	content = new_content

/datum/message_board_post/proc/PostMessage(var/datum/message_board/server)
	if(!istype(server))
		return
	server.Post(src)

/datum/message_board_post/proc/Comment(var/datum/message_board_comment/C)
	if(!istype(C))
		return

	if(!C.author)
		C.author = "Anonymous"

	if(!C.content)
		C.content = " "

	comments |= C


/datum/message_board_comment
	var/author
	var/content

/datum/message_board_comment/proc/AddAuthor(var/new_author)
	author = new_author

/datum/message_board_comment/proc/AddContent(var/new_content)
	content = new_content

/datum/message_board_comment/proc/PostComment(var/datum/message_board_post/post)
	if(!istype(post))
		return
	post.Comment(src)
