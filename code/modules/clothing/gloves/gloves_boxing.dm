/obj/item/clothing/gloves/boxing
	name = "boxing gloves"
	desc = "Because you really needed another excuse to punch your crewmates."
	icon_state = "boxing"
	item_state = "boxing"

/obj/item/clothing/gloves/boxing/attackby(var/obj/item/W, mob/user)
	if(W.iswirecutter() || istype(W, /obj/item/scalpel))
		user << "<span class='notice'>That won't work.</span>"	//Nope
		return
	..()

/obj/item/clothing/gloves/boxing/blue
	icon_state = "boxing_blue"
	item_state = "boxing_blue"

/obj/item/clothing/gloves/boxing/green
	icon_state = "boxing_green"
	item_state = "boxing_green"

/obj/item/clothing/gloves/boxing/yellow
	icon_state = "boxing_yellow"
	item_state = "boxing_yellow"
