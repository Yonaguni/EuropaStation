/obj/item/jewelry/ring
	name = "ring"
	desc = "A ring. How precious."
	color = "#805500"
	icon_state = "base"
	icon = 'icons/obj/jewelry/ring_parts.dmi'
	slot_flags = SLOT_GLOVES | SLOT_POCKET
	value_mod = 30

	var/wear_side = "left"
	var/had_setting
	var/setting_main
	var/setting_side
	var/setting_colour

/obj/item/jewelry/ring/New(var/newloc, var/newmaterial, var/newsetting, var/sidesetting, var/settingcolour)
	if(sidesetting)
		setting_side = 1
	if(settingcolour)
		setting_colour = settingcolour
	if(newsetting)
		setting_main = newsetting
	..(newloc, newmaterial)

/obj/item/jewelry/ring/initialize()
	if(setting_main)
		had_setting = 1
	..()

/obj/item/jewelry/ring/verb/switch_hand_verb()
	set name = "Switch Ring Hand"
	set desc = "Change your ring to the opposite hand."
	set category = "IC"
	set src in usr

	if(usr.incapacitated())
		return

	switch_ring_hand(usr)

/obj/item/jewelry/ring/attack_self(var/mob/user)
	switch_ring_hand(usr)

/obj/item/jewelry/ring/proc/switch_ring_hand(var/mob/user)
	//TODO: check if they HAVE the relevant hand.
	wear_side = (wear_side == "left") ? "right" : "left"
	user << "<span class='notice'>You switch \the [src] to your [wear_side] hand.</span>"
	update_icon()

/obj/item/jewelry/ring/attackby(var/obj/item/thing, var/mob/living/user)
	if(!istype(thing, /obj/item/weapon/screwdriver) || (!setting_main && !setting_side))
		return ..()
	user << "<span class = 'notice'>You pry out the setting.</span>"
	//TODO, spawn a gem.
	setting_main = null
	setting_side = null
	update_icon()

/obj/item/jewelry/ring/update_icon()
	icon = null
	icon_state = ""
	color = null
	overlays.Cut()
	var/image/I = image('icons/obj/jewelry/ring_parts.dmi', "base")
	I.color = material.icon_colour
	overlays += I
	if(had_setting)
		I = image('icons/obj/jewelry/ring_parts.dmi', "setting")
		I.color = material.icon_colour
		overlays += I
	var/has_setting
	if(setting_main)
		if(!setting_colour)
			setting_colour = get_random_colour(1)
		I = image('icons/obj/jewelry/ring_parts.dmi', setting_main)
		I.color = setting_colour
		overlays += I
		has_setting = 1
	if(setting_side)
		if(!setting_colour)
			setting_colour = get_random_colour(1)
		I = image('icons/obj/jewelry/ring_parts.dmi', "sidestones")
		I.color = setting_colour
		overlays += I
		has_setting = 1
	var/cache_key = "ring-[wear_side]-[material.icon_colour]"
	if(has_setting)
		cache_key = "[cache_key]-setting-[setting_colour]"
	// Generate and cache mob icon.
	if(!necklace_icon_cache[cache_key])
		var/icon/tmp_icon = icon('icons/mob/clothing/jewelry/necklace_parts.dmi', "blank")
		var/icon/base_icon = icon('icons/mob/clothing/jewelry/ring_parts.dmi', "base_[wear_side]")
		base_icon.Blend(material.icon_colour, ICON_MULTIPLY)
		tmp_icon.Blend(base_icon, ICON_OVERLAY)
		if(setting_main || setting_side)
			cache_key = "[cache_key]-setting-[wear_side]-[setting_colour]"
			base_icon = icon('icons/mob/clothing/jewelry/ring_parts.dmi', "setting_[wear_side]")
			base_icon.Blend(setting_colour, ICON_MULTIPLY)
			tmp_icon.Blend(base_icon, ICON_OVERLAY)
		necklace_icon_cache[cache_key] = tmp_icon
	item_icons[slot_gloves_str] = necklace_icon_cache[cache_key]
	var/mob/M = loc
	if(istype(M))
		M.update_inv_gloves()

/obj/item/jewelry/ring/small/New(var/newloc, var/newmaterial)
	..(newloc, newmaterial, "smallstone")

/obj/item/jewelry/ring/smallside/New(var/newloc, var/newmaterial)
	..(newloc, newmaterial, "smallstone", 1)

/obj/item/jewelry/ring/medium/New(var/newloc, var/newmaterial)
	..(newloc, newmaterial, "mediumstone")

/obj/item/jewelry/ring/mediumdiamond/New(var/newloc, var/newmaterial)
	..(newloc, newmaterial, "mediumstone", 0, "#E6FFFF")

/obj/item/jewelry/ring/large/New(var/newloc, var/newmaterial)
	..(newloc, newmaterial, "largestone")

/obj/item/jewelry/ring/largeruby/New(var/newloc, var/newmaterial)
	..(newloc, newmaterial, "largestone", 0, "#CC0000")

/obj/item/jewelry/ring/largest/New(var/newloc, var/newmaterial)
	..(newloc, newmaterial, "largeststone")

/obj/item/jewelry/ring/largestside/New(var/newloc, var/newmaterial)
	..(newloc, newmaterial, "largeststone", 1)

/obj/item/jewelry/ring/round/New(var/newloc, var/newmaterial)
	..(newloc, newmaterial, "roundstone")

/obj/item/jewelry/ring/proud/New(var/newloc, var/newmaterial)
	..(newloc, newmaterial, "proudstone")

