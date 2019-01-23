/obj/item/clothing/gloves/insulated
	desc = "These gloves will protect the wearer from electric shocks."
	name = "insulated gloves"
	color = COLOR_YELLOW
	icon_state = "white"
	item_state = "lgloves"
	siemens_coefficient = 0
	permeability_coefficient = 0.05

/obj/item/clothing/gloves/insulated/cheap                             //Cheap Chinese Crap
	desc = "These gloves are cheap copies of the coveted gloves, no way this can end badly."
	name = "budget insulated gloves"
	siemens_coefficient = 1			//Set to a default of 1, gets overridden in New()

/obj/item/clothing/gloves/insulated/cheap/New()
	..()
	//average of 0.4, better than regular gloves' 0.75
	siemens_coefficient = pick(0, 0.1, 0.2, 0.3, 0.4, 0.6, 1.3)