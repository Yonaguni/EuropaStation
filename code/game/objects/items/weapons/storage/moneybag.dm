/obj/item/storage/moneybag
	name = "money bag"
	icon_state = "moneybag"
	flags = CONDUCT
	force = 10
	throwforce = 2
	w_class = 5

/obj/item/storage/moneybag/vault/New(var/newloc)
	..(newloc)
	new /obj/item/material/coin(src, MATERIAL_SILVER)
	new /obj/item/material/coin(src, MATERIAL_SILVER)
	new /obj/item/material/coin(src, MATERIAL_SILVER)
	new /obj/item/material/coin(src, MATERIAL_SILVER)
	new /obj/item/material/coin(src, MATERIAL_GOLD)
	new /obj/item/material/coin(src, MATERIAL_GOLD)
	make_exact_fit()