/*
 * Paper
 * also scraps of paper
 */

/obj/item/paper
	name = "sheet of paper"
	gender = NEUTER
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "paper"
	item_state = "paper"
	randpixel = 8
	throwforce = 0
	w_class = 1
	throw_range = 1
	throw_speed = 1
	layer = 4
	slot_flags = SLOT_HEAD
	body_parts_covered = HEAD
	attack_verb = list("bapped")

	var/info		//What's actually written on the paper.
	var/info_links	//A different version of the paper which includes html links at fields and EOF
	var/stamps		//The (text for the) stamps on the paper.
	var/fields		//Amount of user created fields
	var/free_space = MAX_PAPER_MESSAGE_LEN
	var/list/stamped
	var/list/ico[0]      //Icons and
	var/list/offset_x[0] //offsets stored for later
	var/list/offset_y[0] //usage by the photocopier
	var/rigged = 0
	var/spam_flag = 0

	var/const/deffont = "Verdana"
	var/const/signfont = "Times New Roman"
	var/const/crayonfont = "Comic Sans MS"

//lipstick wiping is in code/game/objects/items/weapons/cosmetics.dm!

/obj/item/paper/New()
	..()
	stamps = ""

	if(name != "paper")
		desc = "This is a paper titled '" + name + "'."

	if(info != initial(info))
		info = html_encode(info)
		info = replacetext(info, "\n", "<BR>")
		info = parsepencode(info)

	spawn(2)
		update_icon()
		update_space(info)
		updateinfolinks()
		return

/obj/item/paper/update_icon()
	if(icon_state == "paper_talisman")
		return
	if(info)
		icon_state = "paper_words"
		return
	icon_state = "paper"

/obj/item/paper/proc/update_space(var/new_text)
	if(!new_text)
		return

	free_space -= length(strip_html_properly(new_text))

/obj/item/paper/examine(mob/user)
	..()
	if(in_range(user, src) || isghost(user))
		show_content(usr)
	else
		user << "<span class='notice'>You have to go closer if you want to read it.</span>"
	return

/obj/item/paper/proc/show_content(var/mob/user, var/forceshow=0)
	if(!(istype(user, /mob/living/carbon/human) || isghost(user) || istype(user, /mob/living/silicon)) && !forceshow)
		user << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[stars(info)][stamps]</BODY></HTML>", "window=[name]")
		onclose(user, "[name]")
	else
		user << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[info][stamps]</BODY></HTML>", "window=[name]")
		onclose(user, "[name]")

/obj/item/paper/verb/rename()
	set name = "Rename paper"
	set category = "Object"
	set src in usr

	if((CLUMSY in usr.mutations) && prob(50))
		usr << "<span class='warning'>You cut yourself on the paper.</span>"
		return
	var/n_name = sanitizeSafe(input(usr, "What would you like to label the paper?", "Paper Labelling", null)  as text, MAX_NAME_LEN)

	// We check loc one level up, so we can rename in clipboards and such. See also: /obj/item/photo/rename()
	if((loc == usr || loc.loc && loc.loc == usr) && usr.stat == 0 && n_name)
		name = n_name
		if(n_name != "paper")
			desc = "This is a paper titled '" + name + "'."

		add_fingerprint(usr)
	return

/obj/item/paper/attack_self(var/mob/living/user)
	if(user.a_intent == I_HURT)
		if(icon_state == "scrap")
			user.show_message("<span class='warning'>\The [src] is already crumpled.</span>")
			return
		//crumple dat paper
		info = stars(info,85)
		user.visible_message("\The [user] crumples \the [src] into a ball!")
		icon_state = "scrap"
		return
	user.examinate(src)
	if(rigged && (Holiday == "April Fool's Day"))
		if(spam_flag == 0)
			spam_flag = 1
			playsound(loc, 'sound/items/bikehorn.ogg', 50, 1)
			spawn(20)
				spam_flag = 0
	return

/obj/item/paper/attack_ai(var/mob/living/silicon/ai/user)
	var/dist
	if(istype(user) && user.camera) //is AI
		dist = get_dist(src, user.camera)
	else //cyborg or AI not seeing through a camera
		dist = get_dist(src, user)
	if(dist < 2)
		usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[info][stamps]</BODY></HTML>", "window=[name]")
		onclose(usr, "[name]")
	else
		usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[stars(info)][stamps]</BODY></HTML>", "window=[name]")
		onclose(usr, "[name]")
	return

/obj/item/paper/attack(var/mob/living/carbon/M, var/mob/living/carbon/user)
	if(user.zone_sel.selecting == BP_EYES)
		user.visible_message("<span class='notice'>You show the paper to [M]. </span>", \
			"<span class='notice'> [user] holds up a paper and shows it to [M]. </span>")
		M.examinate(src)

	else if(user.zone_sel.selecting == BP_MOUTH) // lipstick wiping
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(H == user)
				user << "<span class='notice'>You wipe off the lipstick with [src].</span>"
				H.lip_style = null
				H.update_body()
			else
				user.visible_message("<span class='warning'>[user] begins to wipe [H]'s lipstick off with \the [src].</span>", \
								 	 "<span class='notice'>You begin to wipe off [H]'s lipstick.</span>")
				if(do_after(user, 10, H) && do_after(H, 10, needhand = 0))	//user needs to keep their active hand, H does not.
					user.visible_message("<span class='notice'>[user] wipes [H]'s lipstick off with \the [src].</span>", \
										 "<span class='notice'>You wipe off [H]'s lipstick.</span>")
					H.lip_style = null
					H.update_body()

/obj/item/paper/proc/addtofield(var/id, var/text, var/links = 0)
	var/locid = 0
	var/laststart = 1
	var/textindex = 1
	while(1) // I know this can cause infinite loops and fuck up the whole server, but the if(istart==0) should be safe as fuck
		var/istart = 0
		if(links)
			istart = findtext(info_links, "<span class=\"paper_field\">", laststart)
		else
			istart = findtext(info, "<span class=\"paper_field\">", laststart)

		if(istart==0)
			return // No field found with matching id

		laststart = istart+1
		locid++
		if(locid == id)
			var/iend = 1
			if(links)
				iend = findtext(info_links, "</span>", istart)
			else
				iend = findtext(info, "</span>", istart)

			//textindex = istart+26
			textindex = iend
			break

	if(links)
		var/before = copytext(info_links, 1, textindex)
		var/after = copytext(info_links, textindex)
		info_links = before + text + after
	else
		var/before = copytext(info, 1, textindex)
		var/after = copytext(info, textindex)
		info = before + text + after
		updateinfolinks()

/obj/item/paper/proc/updateinfolinks()
	info_links = info
	var/i = 0
	for(i=1,i<=fields,i++)
		addtofield(i, "<font face=\"[deffont]\"><A href='?src=\ref[src];write=[i]'>write</A></font>", 1)
	info_links = info_links + "<font face=\"[deffont]\"><A href='?src=\ref[src];write=end'>write</A></font>"


/obj/item/paper/proc/clearpaper()
	info = null
	stamps = null
	free_space = MAX_PAPER_MESSAGE_LEN
	stamped = list()
	overlays.Cut()
	updateinfolinks()
	update_icon()

/obj/item/paper/proc/get_signature(var/obj/item/pen/P, var/mob/user)
	if(P && istype(P, /obj/item/pen))
		return P.get_signature(user)
	return (user && user.real_name) ? user.real_name : "Anonymous"

/obj/item/paper/proc/parsepencode(var/t, var/obj/item/pen/P, var/mob/user, var/iscrayon = 0)
//	t = copytext(sanitize(t),1,MAX_MESSAGE_LEN)

	t = replacetext(t, "\[center\]", "<center>")
	t = replacetext(t, "\[/center\]", "</center>")
	t = replacetext(t, "\[br\]", "<BR>")
	t = replacetext(t, "\[b\]", "<B>")
	t = replacetext(t, "\[/b\]", "</B>")
	t = replacetext(t, "\[i\]", "<I>")
	t = replacetext(t, "\[/i\]", "</I>")
	t = replacetext(t, "\[u\]", "<U>")
	t = replacetext(t, "\[/u\]", "</U>")
	t = replacetext(t, "\[time\]", "[stationtime2text()]")
	t = replacetext(t, "\[date\]", "[stationdate2text()]")
	t = replacetext(t, "\[large\]", "<font size=\"4\">")
	t = replacetext(t, "\[/large\]", "</font>")
	if(findtext(t, "\[sign\]"))
		t = replacetext(t, "\[sign\]", "<font face=\"[signfont]\"><i>[get_signature(P, user)]</i></font>")
	t = replacetext(t, "\[field\]", "<span class=\"paper_field\"></span>")

	t = replacetext(t, "\[h1\]", "<H1>")
	t = replacetext(t, "\[/h1\]", "</H1>")
	t = replacetext(t, "\[h2\]", "<H2>")
	t = replacetext(t, "\[/h2\]", "</H2>")
	t = replacetext(t, "\[h3\]", "<H3>")
	t = replacetext(t, "\[/h3\]", "</H3>")

	if(!iscrayon)
		t = replacetext(t, "\[*\]", "<li>")
		t = replacetext(t, "\[hr\]", "<HR>")
		t = replacetext(t, "\[small\]", "<font size = \"1\">")
		t = replacetext(t, "\[/small\]", "</font>")
		t = replacetext(t, "\[list\]", "<ul>")
		t = replacetext(t, "\[/list\]", "</ul>")
		t = replacetext(t, "\[table\]", "<table border=1 cellspacing=0 cellpadding=3 style='border: 1px solid black;'>")
		t = replacetext(t, "\[/table\]", "</td></tr></table>")
		t = replacetext(t, "\[grid\]", "<table>")
		t = replacetext(t, "\[/grid\]", "</td></tr></table>")
		t = replacetext(t, "\[row\]", "</td><tr>")
		t = replacetext(t, "\[cell\]", "<td>")
		t = replacetext(t, "\[logo\]", "<img src = ntlogo.png>")

		t = "<font face=\"[deffont]\" color=[P ? P.colour : "black"]>[t]</font>"
	else // If it is a crayon, and he still tries to use these, make them empty!
		t = replacetext(t, "\[*\]", "")
		t = replacetext(t, "\[hr\]", "")
		t = replacetext(t, "\[small\]", "")
		t = replacetext(t, "\[/small\]", "")
		t = replacetext(t, "\[list\]", "")
		t = replacetext(t, "\[/list\]", "")
		t = replacetext(t, "\[table\]", "")
		t = replacetext(t, "\[/table\]", "")
		t = replacetext(t, "\[row\]", "")
		t = replacetext(t, "\[cell\]", "")
		t = replacetext(t, "\[logo\]", "")

		t = "<font face=\"[crayonfont]\" color=[P ? P.colour : "black"]><b>[t]</b></font>"


//	t = replacetext(t, "#", "") // Junk converted to nothing!

//Count the fields
	var/laststart = 1
	while(1)
		var/i = findtext(t, "<span class=\"paper_field\">", laststart)	//</span>
		if(i==0)
			break
		laststart = i+1
		fields++

	return t

/obj/item/paper/proc/burnpaper(var/obj/item/flame/P, mob/user)
	var/class = "warning"

	if(P.lit && !user.restrained())
		if(istype(P, /obj/item/flame/lighter/zippo))
			class = "rose"

		user.visible_message("<span class='[class]'>[user] holds \the [P] up to \the [src], it looks like \he's trying to burn it!</span>", \
		"<span class='[class]'>You hold \the [P] up to \the [src], burning it slowly.</span>")

		spawn(20)
			if(get_dist(src, user) < 2 && user.get_active_hand() == P && P.lit)
				user.visible_message("<span class='[class]'>[user] burns right through \the [src], turning it to ash. It flutters through the air before settling on the floor in a heap.</span>", \
				"<span class='[class]'>You burn right through \the [src], turning it to ash. It flutters through the air before settling on the floor in a heap.</span>")

				if(user.get_inactive_hand() == src)
					user.drop_from_inventory(src)

				new /obj/effect/decal/cleanable/ash(src.loc)
				qdel(src)

			else
				user << "\red You must hold \the [P] steady to burn \the [src]."


/obj/item/paper/Topic(href, href_list)
	..()
	if(!usr || (usr.stat || usr.restrained()))
		return

	if(href_list["write"])
		var/id = href_list["write"]
		//var/t = strip_html_simple(input(usr, "What text do you wish to add to " + (id=="end" ? "the end of the paper" : "field "+id) + "?", "[name]", null),8192) as message

		if(free_space <= 0)
			usr << "<span class='info'>There isn't enough space left on \the [src] to write anything.</span>"
			return

		var/t =  sanitize(input("Enter what you want to write:", "Write", null, null) as message, free_space, extra = 0)

		if(!t)
			return

		var/obj/item/i = usr.get_active_hand() // Check to see if he still got that darn pen, also check if he's using a crayon or pen.
		var/iscrayon = 0
		if(!istype(i, /obj/item/pen))
			if(usr.back && istype(usr.back,/obj/item/rig))
				var/obj/item/rig/r = usr.back
				var/obj/item/rig_module/device/pen/m = locate(/obj/item/rig_module/device/pen) in r.installed_modules
				if(!r.offline && m)
					i = m.device
				else
					return
			else
				return

		if(istype(i, /obj/item/pen/crayon))
			iscrayon = 1


		// if paper is not in usr, then it must be near them, or in a clipboard or folder, which must be in or near usr
		if(src.loc != usr && !src.Adjacent(usr) && !((istype(src.loc, /obj/item/clipboard) || istype(src.loc, /obj/item/folder)) && (src.loc.loc == usr || src.loc.Adjacent(usr)) ) )
			return
/*
		t = checkhtml(t)

		// check for exploits
		for(var/bad in paper_blacklist)
			if(findtext(t,bad))
				usr << "\blue You think to yourself, \"Hm.. this is only paper...\""
				log_admin("PAPER: [usr] ([usr.ckey]) tried to use forbidden word in [src]: [bad].")
				message_admins("PAPER: [usr] ([usr.ckey]) tried to use forbidden word in [src]: [bad].")
				return
*/

		var last_fields_value = fields

		//t = html_encode(t)
		t = replacetext(t, "\n", "<BR>")
		t = parsepencode(t, i, usr, iscrayon) // Encode everything from pencode to html


		if(fields > 50)//large amount of fields creates a heavy load on the server, see updateinfolinks() and addtofield()
			usr << "<span class='warning'>Too many fields. Sorry, you can't do this.</span>"
			fields = last_fields_value
			return

		if(id!="end")
			addtofield(text2num(id), t) // He wants to edit a field, let him.
		else
			info += t // Oh, he wants to edit to the end of the file, let him.
			updateinfolinks()

		update_space(t)

		usr << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[info_links][stamps]</BODY></HTML>", "window=[name]") // Update the window

		update_icon()


/obj/item/paper/attackby(var/obj/item/P, var/mob/user)
	..()
	var/clown = 0
	if(user.mind && (user.mind.assigned_role == "Clown"))
		clown = 1

	if(istype(P, /obj/item/tape_roll))
		var/obj/item/tape_roll/tape = P
		tape.stick(src, user)
		return

	if(istype(P, /obj/item/paper) || istype(P, /obj/item/photo))
		if (istype(P, /obj/item/paper/carbon))
			var/obj/item/paper/carbon/C = P
			if (!C.iscopy && !C.copied)
				user << "<span class='notice'>Take off the carbon copy first.</span>"
				add_fingerprint(user)
				return
		var/obj/item/paper_bundle/B = new(src.loc)
		if (name != "paper")
			B.name = name
		else if (P.name != "paper" && P.name != "photo")
			B.name = P.name

		user.drop_from_inventory(P)
		user.drop_from_inventory(src)
		user.put_in_hands(B)
		src.forceMove(B)
		P.forceMove(B)

		user << "<span class='notice'>You clip the [P.name] to [(src.name == "paper") ? "the paper" : src.name].</span>"

		B.pages.Add(src)
		B.pages.Add(P)
		B.update_icon()

	else if(istype(P, /obj/item/pen))
		if(icon_state == "scrap")
			usr << "<span class='warning'>\The [src] is too crumpled to write on.</span>"
			return

		var/obj/item/pen/robopen/RP = P
		if ( istype(RP) && RP.mode == 2 )
			RP.RenamePaper(user,src)
		else
			user << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[info_links][stamps]</BODY></HTML>", "window=[name]")
		return

	else if(istype(P, /obj/item/stamp))
		if((!in_range(src, usr) && loc != user && !( istype(loc, /obj/item/clipboard) ) && loc.loc != user && user.get_active_hand() != P))
			return

		stamps += (stamps=="" ? "<HR>" : "<BR>") + "<i>This paper has been stamped with the [P.name].</i>"

		var/image/stampoverlay = image('icons/obj/bureaucracy.dmi')
		var/{x; y;}
		if(istype(P, /obj/item/stamp/captain) || istype(P, /obj/item/stamp/centcomm))
			x = rand(-2, 0)
			y = rand(-1, 2)
		else
			x = rand(-2, 2)
			y = rand(-3, 2)
		offset_x += x
		offset_y += y
		stampoverlay.pixel_x = x
		stampoverlay.pixel_y = y

		if(istype(P, /obj/item/stamp/clown))
			if(!clown)
				user << "<span class='notice'>You are totally unable to use the stamp. HONK!</span>"
				return

		if(!ico)
			ico = new
		ico += "paper_[P.icon_state]"
		stampoverlay.icon_state = "paper_[P.icon_state]"

		if(!stamped)
			stamped = new
		stamped += P.type
		overlays += stampoverlay

		user << "<span class='notice'>You stamp the paper with your rubber stamp.</span>"

	else if(istype(P, /obj/item/flame))
		burnpaper(P, user)

	add_fingerprint(user)
	return

/obj/item/paper/crumpled
	name = "paper scrap"
	icon_state = "scrap"

/obj/item/paper/crumpled/update_icon()
	return

/obj/item/paper/crumpled/bloody
	icon_state = "scrap_bloodied"
