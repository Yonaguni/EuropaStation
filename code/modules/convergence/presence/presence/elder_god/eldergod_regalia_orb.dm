/obj/item/convergence/orb/eldergod
	name = "tome"
	icon_state = "culttome"

/obj/item/convergence/orb/eldergod/Topic(href, href_list)

	if(..()) return TRUE

	if(href_list["scribe_user"] && href_list["scribe_sigil"])

		var/mob/user = locate(href_list["scribe_user"])
		var/datum/presence_power/rune/rune = locate(href_list["scribe_sigil"])
		if(!istype(user) || !istype(rune))
			return TRUE

		if(user.l_hand != src && user.r_hand != src)
			to_chat(user, "<span class='warning'>You must be holding your tome to scribe a rune.</span>")
			return TRUE

		var/obj/item/convergence/rod/eldergod/athame
		if(user.l_hand == src)
			athame = user.r_hand
		else
			athame = user.l_hand

		var/turf/T = get_turf(user)
		if(locate(/obj/effect/decal/cleanable/sigil) in T)
			to_chat(user, "<span class='warning'>There is already a rune or a sigil present here.</span>")
			return TRUE

		if(!istype(athame) || !athame.charged())
			to_chat(user, "<span class='warning'>You must be holding a bloodied athame to scribe a rune.</span>")
			return TRUE

		user.visible_message("<span class='warning'>\The [user] begins scribing a rune with a bloodied [athame.name]...</span>")

		if(!do_after(user, 25, src))
			return TRUE

		if(locate(/obj/effect/decal/cleanable/sigil) in T)
			return TRUE

		if((user.l_hand != src && user.r_hand != src) || (user.l_hand != athame && user.r_hand != athame) || !athame.charged())
			return TRUE

		user.visible_message("<span class='danger'>\The [user] completes the blood rune.</span>")
		var/atom/new_rune = new /obj/effect/decal/cleanable/sigil/rune(T, sanctified_to, rune)
		if(athame.blood_color)
			new_rune.color = blood_color
			new_rune.light_color = new_rune.color
		new_rune.set_light()
		athame.spend_charge()
		return TRUE