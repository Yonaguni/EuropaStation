/obj/item/book/magazine
	name = "magazine"
	desc = "It's one of those trashy tabloid magazines. It looks pretty out of date."
	icon = 'icons/obj/magazine.dmi'

/obj/item/book/magazine/Initialize()
	. = ..()
	pixel_x = 5-rand(10)
	pixel_x = 5-rand(10)
	var/magtype = pick(magazine_types)
	magazine_types -= magtype
	if(!magazine_types.len)
		magazine_types = typesof(/datum/magazine)-/datum/magazine
	var/headline = pick(magazine_headlines)
	magazine_headlines -= headline
	if(!magazine_headlines.len)
		magazine_headlines = initial(magazine_headlines)

	var/datum/magazine/content = new magtype
	name = headline
	title = content.title
	icon_state = content.icon_state
	author = content.author
	dat = content.contents

/obj/item/book/magazine/do_read_message(var/mob/user)
	user.visible_message("<span class='notice'>\The [user] leafs idly through a magazine headlined '[name]'.</span>")
	user << "Most of it is the usual pointless trash, but you notice an article titled '[title]'."
