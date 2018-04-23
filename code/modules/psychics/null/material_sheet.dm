/obj/item/stack/material/New()
	..()
	if(disrupts_psionics())
		LAZYADD(psi_null_atoms, src)

/obj/item/stack/material/withstand_psi_stress(var/stress, var/atom/source)
	. = ..(stress, source)
	if(amount > 0 && . > 0 && disrupts_psionics())
		if(. > amount)
			use(amount)
			. -= amount
		else
			use(stress)
			. = 0

/obj/item/stack/material/disrupts_psionics()
	return (material && material.is_psi_null())

/obj/item/stack/material/nullglass
	name = "nullglass"
	icon_state = "sheet-nullglass"
	default_type = "nullglass"

/obj/item/stack/material/nullglass/fifty
	amount = 50

