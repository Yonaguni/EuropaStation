/obj/item/pen/crayon/red
	icon_state = "crayonred"
	colour = "#da0000"
	shadeColour = "#810c0c"
	colourName = "red"

/obj/item/pen/crayon/orange
	icon_state = "crayonorange"
	colour = "#ff9300"
	shadeColour = "#a55403"
	colourName = "orange"

/obj/item/pen/crayon/yellow
	icon_state = "crayonyellow"
	colour = "#fff200"
	shadeColour = "#886422"
	colourName = "yellow"

/obj/item/pen/crayon/green
	icon_state = "crayongreen"
	colour = "#a8e61d"
	shadeColour = "#61840f"
	colourName = "green"

/obj/item/pen/crayon/blue
	icon_state = "crayonblue"
	colour = "#00b7ef"
	shadeColour = "#0082a8"
	colourName = "blue"

/obj/item/pen/crayon/purple
	icon_state = "crayonpurple"
	colour = "#da00ff"
	shadeColour = "#810cff"
	colourName = "purple"

/obj/item/pen/crayon/mime
	icon_state = "crayonmime"
	desc = "A very sad-looking crayon."
	colour = "#ffffff"
	shadeColour = "#000000"
	colourName = "mime"
	uses = 0

/obj/item/pen/crayon/mime/attack_self(var/mob/living/user) //inversion
	if(colour != "#ffffff" && shadeColour != "#000000")
		colour = "#ffffff"
		shadeColour = "#000000"
		user << "You will now draw in white and black with this crayon."
	else
		colour = "#000000"
		shadeColour = "#ffffff"
		user << "You will now draw in black and white with this crayon."
	return

/obj/item/pen/crayon/rainbow
	icon_state = "crayonrainbow"
	colour = "#fff000"
	shadeColour = "#000fff"
	colourName = "rainbow"
	uses = 0

/obj/item/pen/crayon/rainbow/attack_self(var/mob/living/user)
	colour = input(user, "Please select the main colour.", "Crayon colour") as color
	shadeColour = input(user, "Please select the shade colour.", "Crayon colour") as color
	return

/obj/item/pen/crayon/afterattack(atom/target, var/mob/user, proximity)
	if(!proximity) return
	if(istype(target,/turf/simulated/floor))
		var/drawtype = input("Choose what you'd like to draw.", "Crayon scribbles") in list("graffiti","rune","letter","arrow")
		switch(drawtype)
			if("letter")
				drawtype = input("Choose the letter.", "Crayon scribbles") in list("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
				user << "You start drawing a letter on the [target.name]."
			if("graffiti")
				user << "You start drawing graffiti on the [target.name]."
			if("rune")
				user << "You start drawing a rune on the [target.name]."
			if("arrow")
				drawtype = input("Choose the arrow.", "Crayon scribbles") in list("left", "right", "up", "down")
				user << "You start drawing an arrow on the [target.name]."
		if(instant || do_after(user, 50))
			new /obj/effect/decal/cleanable/crayon(target,colour,shadeColour,drawtype)
			user << "You finish drawing."
			target.add_fingerprint(user)		// Adds their fingerprints to the floor the crayon is drawn on.
			if(uses)
				uses--
				if(!uses)
					user << "<span class='warning'>You used up your crayon!</span>"
					qdel(src)
	return

/obj/item/pen/crayon/attack(var/mob/living/carbon/M, var/mob/user)
	if(istype(M) && M == user)
		M << "You take a bite of the crayon and swallow it."
		M.nutrition += 1
		M.reagents.add_reagent(REAGENT_CRAYON_DUST,min(5,uses)/3)
		if(uses)
			uses -= 5
			if(uses <= 0)
				M << "<span class='warning'>You ate your crayon!</span>"
				qdel(src)
	else
		..()
