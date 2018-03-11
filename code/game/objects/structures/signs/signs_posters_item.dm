/obj/item/sign/poster
	name = "rolled-up poster"
	desc = "The poster comes with its own automatic adhesive mechanism, for easy pinning to any vertical surface."
	icon = 'icons/obj/posters.dmi'
	icon_state = "rolled_poster"
	placement_type = /obj/structure/sign/poster
	var/poster_type

/obj/item/sign/poster/New(var/turf/newloc, var/_poster_type)
	if(!poster_type && _poster_type)
		poster_type = _poster_type
	if(!poster_type)
		poster_type = rand(1, poster_designs.len)
	name = "[name] - No. [poster_type]"
	..(newloc)

/obj/item/sign/poster/get_placement_args()
	return poster_type

/obj/item/sign/poster/attack_self(var/mob/user)
	deploy(null, user)

/obj/item/sign/poster/handle_placement(var/obj/item/tool, var/mob/user)
	to_chat(user, "<span class='notice'>You start placing the poster on the wall...</span>")
	. = ..()
	if(.)
		flick("poster_being_set", .)

/obj/item/sign/poster/handle_post_placement(var/obj/item/tool, var/mob/user, var/atom/movable/product)
	if(do_after(user, 17, src) && ..())
		to_chat(user, "<span class='notice'>You place the poster!</span>")
		return TRUE
