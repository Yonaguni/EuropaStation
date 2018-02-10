/obj/item/gun_component/accessory/barrel/silencer
	name = "suppressor"
	desc = "A suppressor."
	icon_state = "silencer"

/obj/item/gun_component/accessory/barrel/silencer/apply_mod(var/obj/item/gun/composite/gun)
	..()
	gun.silenced = 1
