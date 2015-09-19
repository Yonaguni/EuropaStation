/obj/item/weapon/card/id/europa
	name = "citizenship card"
	icon = 'icons/obj/europa/items/cards.dmi'
	icon_state = "card"
	assignment = "Citizen"

/obj/item/weapon/card/id/europa/corpcard
	name = "corporate ID"
	desc = "A slender identification card issued to low-level corporate workers."
	icon_state = "corpcard"
	assignment = "Employee"

/obj/item/weapon/card/id/europa/lanyard
	name = "secure access card"
	desc = "A lanyard holding a laminated Science access card. It's emblazoned with the usual CLASSIFIED ACCESS warning labels."
	icon_state = "lanyard"
	assignment = "Specialist"

/obj/item/weapon/card/id/europa/passport
	name = "passport"
	desc = "A rather worn passport."
	icon_state = "passport"
	var/citizenship = "Europan"

/obj/item/weapon/card/id/europa/passport/update_name()
	name = "[registered_name]'s [citizenship] [initial(name)]"

/obj/item/weapon/card/id/europa/dogtags
	name = "RFID dogtags"
	desc = "A set of Sol-issued naval dog tags with integrated identification chips."
	icon_state = "dogtags"
	assignment = "Officer"

/obj/item/weapon/card/id/europa/keycard
	name = "access keycard"
	desc = "You need the blue key."
	icon_state = "keycard"