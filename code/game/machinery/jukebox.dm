//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

/datum/track
	var/title
	var/track

/datum/track/New(var/title, var/track)
	src.title = title
	src.track = track

datum/track/proc/GetTrack()
	if(ispath(track, /music_track))
		var/music_track/music_track = decls_repository.get_decl(track)
		return music_track.song
	return track // Allows admins to continue their adminbus simply by overriding the track var

/obj/machinery/media/jukebox
	name = "mediatronic jukebox"
	desc = "An immense, standalone touchscreen on a swiveling base, equipped with phased array speakers. Embossed on one corner of the ultrathin bezel is the brand name, 'Leitmotif Enterprise Edition'."
	icon = 'icons/obj/jukebox_new.dmi'
	icon_state = "jukebox3-nopower"
	var/state_base = "jukebox3"
	anchored = 1
	density = 1
	power_channel = EQUIP
	idle_power_usage = 10
	active_power_usage = 100
	clicksound = 'sound/machines/buttonbeep.ogg'
	pixel_x = -8

	var/playing = 0
	var/volume = 20

	var/sound_id
	var/datum/sound_token/sound_token

	var/datum/track/current_track
	var/list/datum/track/tracks

/obj/machinery/media/jukebox/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = 1, var/master_ui = null, var/datum/topic_state/state = GLOB.default_state)
	var/list/juke_tracks = new
	for(var/datum/track/T in tracks)
		juke_tracks.Add(T.title)
	var/list/data = list(
		"current_track" = current_track != null ? current_track.title : "No track selected",
		"playing" = playing,
		"tracks" = juke_tracks,
		"volume" = volume
	)
	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "jukebox.tmpl", src.name, 325, 625, master_ui = master_ui, state = state)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/media/jukebox/OnTopic(user, href_list, var/datum/topic_state/state)
	if(href_list["change_track"])
		for(var/datum/track/T in tracks)
			if(T.title == href_list["title"])
				current_track = T
				StartPlaying()
				break
		. = TRUE
	if(href_list["stop"])
		StopPlaying()
		. = TRUE
	if(href_list["play"])
		if(emagged)
			emag_play()
		else if(!current_track)
			to_chat(usr, "No track selected.")
		else
			StartPlaying()
		. = TRUE
	if(href_list["volume"])
		AdjustVolume(text2num(href_list["level"]))
		. = TRUE

/obj/machinery/media/jukebox/old
	name = "space jukebox"
	desc = "A battered and hard-loved jukebox in some forgotten style, carefully restored to some semblance of working condition."
	icon = 'icons/obj/jukebox.dmi'
	icon_state = "jukebox2-nopower"
	state_base = "jukebox2"
	pixel_x = 0

/obj/machinery/media/jukebox/New()
	..()
	update_icon()
	sound_id = "[/obj/machinery/media/jukebox]_[sequential_id(/obj/machinery/media/jukebox)]"

/obj/machinery/media/jukebox/Initialize()
	. = ..()
	tracks = setup_music_tracks(tracks)

/obj/machinery/media/jukebox/Destroy()
	StopPlaying()
	QDEL_NULL_LIST(tracks)
	current_track = null
	. = ..()

/obj/machinery/media/jukebox/powered()
	return anchored && ..()

/obj/machinery/media/jukebox/power_change()
	. = ..()
	if(stat & (NOPOWER|BROKEN) && playing)
		StopPlaying()

/obj/machinery/media/jukebox/on_update_icon()
	overlays.Cut()
	if(stat & (NOPOWER|BROKEN) || !anchored)
		if(stat & BROKEN)
			icon_state = "[state_base]-broken"
		else
			icon_state = "[state_base]-nopower"
		return
	icon_state = state_base
	if(playing)
		if(emagged)
			overlays += "[state_base]-emagged"
		else
			overlays += "[state_base]-running"

/obj/machinery/media/jukebox/interact(mob/user)
	if(!anchored)
		to_chat(usr, "<span class='warning'>You must secure \the [src] first.</span>")
		return

	if(stat & (NOPOWER|BROKEN))
		to_chat(usr, "\The [src] doesn't appear to function.")
		return

	ui_interact(user)

/obj/machinery/media/jukebox/proc/emag_play()
	playsound(loc, 'sound/items/AirHorn.ogg', 100, 1)
	for(var/mob/living/carbon/M in ohearers(6, src))
		if(istype(M, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = M
			if(istype(H.l_ear, /obj/item/clothing/ears/earmuffs) || istype(H.r_ear, /obj/item/clothing/ears/earmuffs))
				continue
		M.sleeping = 0
		M.stuttering += 20
		M.ear_deaf += 30
		M.Weaken(3)
		if(prob(30))
			M.Stun(10)
			M.Paralyse(4)
		else
			M.make_jittery(400)
	spawn(15)
		explode()

/obj/machinery/media/jukebox/attack_ai(mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/media/jukebox/attack_hand(var/mob/user as mob)
	interact(user)

/obj/machinery/media/jukebox/proc/explode()
	walk_to(src,0)
	src.visible_message("<span class='danger'>\the [src] blows apart!</span>", 1)

	explosion(src.loc, 0, 0, 1, rand(1,2), 1)

	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(3, 1, src)
	s.start()

	new /obj/effect/decal/cleanable/blood/oil(src.loc)
	qdel(src)

/obj/machinery/media/jukebox/attackby(obj/item/W as obj, mob/user as mob)
	if(isWrench(W))
		add_fingerprint(user)
		wrench_floor_bolts(user, 0)
		power_change()
		return
	return ..()

/obj/machinery/media/jukebox/emag_act(var/remaining_charges, var/mob/user)
	if(!emagged)
		emagged = 1
		StopPlaying()
		visible_message("<span class='danger'>\The [src] makes a fizzling sound.</span>")
		update_icon()
		return 1

/obj/machinery/media/jukebox/proc/StopPlaying()
	playing = 0
	update_use_power(POWER_USE_IDLE)
	update_icon()
	QDEL_NULL(sound_token)


/obj/machinery/media/jukebox/proc/StartPlaying()
	StopPlaying()
	if(!current_track)
		return

	// Jukeboxes cheat massively and actually don't share id. This is only done because it's music rather than ambient noise.
	sound_token = GLOB.sound_player.PlayLoopingSound(src, sound_id, current_track.GetTrack(), volume = volume, range = 7, falloff = 3, prefer_mute = TRUE)

	playing = 1
	update_use_power(POWER_USE_ACTIVE)
	update_icon()

/obj/machinery/media/jukebox/proc/AdjustVolume(var/new_volume)
	volume = Clamp(new_volume, 0, 50)
	if(sound_token)
		sound_token.SetVolume(volume)
