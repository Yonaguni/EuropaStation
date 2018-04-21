/obj/item/stack/material/New()
	..()
	if(material && material.is_psi_null())
		LAZYADD(psi_null_atoms, src)

/obj/item/stack/material/withstand_psi_stress(var/stress)
	. = ..()
	if(amount > 0 && . > 0 && (src in psi_null_atoms))
		if(. > amount)
			use(amount)
			. -= amount
		else
			use(stress)
			. = 0

/obj/item/stack/material/nullglass
	name = "nullglass"
	icon_state = "sheet-nullglass"
	default_type = "nullglass"

/obj/item/stack/material/nullglass/fifty
	amount = 50

