/obj/item/flame/candle
	name = "red candle"
	desc = "A small pillar candle."
	icon = 'icons/obj/candle.dmi'
	icon_state = "candle1"
	item_state = "candle1"
	w_class = 1
	fuel = 2000
	trash = /obj/effect/decal/cleanable/candle
	one_use = FALSE

/obj/item/flame/candle/New()
	fuel = rand(800, 1000) // Enough for 27-33 minutes. 30 minutes on average.
	..()

/obj/item/flame/candle/update_icon()
	var/i
	if(fuel > 1500)
		i = 1
	else if(fuel > 800)
		i = 2
	else i = 3
	icon_state = "candle[i][lit ? "_lit" : ""]"

/obj/effect/decal/cleanable/candle
	name = "melted candle"
	desc = "A melted candle."
	icon = 'icons/obj/candle.dmi'
	icon_state = "candle4"
	item_state = "candle1"