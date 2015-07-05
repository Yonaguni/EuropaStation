/obj/structure/seaweed
	name = "seaweed"
	desc = "Waving fronds of ocean greenery."
	icon = 'icons/obj/europa/structures/plants.dmi'
	icon_state = "seaweed"
	anchored = 1
	density = 0
	opacity = 0

/obj/structure/seaweed/large
	icon_state = "seaweed2"
	opacity = 1

/obj/structure/seaweed/glow
	name = "glowing seaweed"
	desc = "It shines with an eerie bioluminescent light."
	icon_state = "glowweed1"

/obj/structure/seaweed/glow/New()
	..()
	set_light(3, l_color = "#00FFF4")
	icon_state = "glowweed[rand(1,3)]"
