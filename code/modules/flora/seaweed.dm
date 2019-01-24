/obj/structure/flora/seaweed
	name = "seaweed"
	desc = "Waving fronds of ocean greenery."
	icon = 'icons/obj/flora/seaweed.dmi'
	icon_state = "seaweed"
	anchored = 1
	density = 0
	opacity = 0

/obj/structure/flora/seaweed/large
	icon_state = "seaweed2"

/obj/structure/flora/seaweed/glow
	name = "glowing seaweed"
	desc = "It shines with an eerie bioluminescent light."
	icon_state = "glowweed1"
	light_color = "#00FFF4"

/obj/structure/flora/seaweed/glow/Initialize()
	. = ..()
	set_light(3, 2)
	icon_state = "glowweed[rand(1,3)]"