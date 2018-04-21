/obj/item/soulstone
	name = "soul stone"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "soulstone"
	item_state = "electronic"
	desc = "An unshaped, ridged chunk of a strange, psi-devouring material called nullglass. In the hands of unsavoury operants, it can be used to siphon echoes of the dead into a tormented un-life."
	w_class = 2
	slot_flags = SLOT_BELT

/obj/item/soulstone/New()
	LAZYADD(psi_null_atoms, src)
	..()

/obj/item/soulstone/attackby(var/obj/item/thing, var/mob/user)
	if(!thing.force)
		return ..()
	user.visible_message("<span class='danger'>\The [user] shatters \the [src] with \the [thing]!</span>")
	shatter()

/obj/item/soulstone/proc/shatter()
	playsound(loc, "shatter", 70, 1)
	for(var/i=1 to rand(2,5))
		new /obj/item/material/shard(get_turf(src), "nullglass")
	var/mob/M = loc
	if(istype(M))
		M.drop_from_inventory(src)
	qdel(src)

/obj/item/soulstone/withstand_psi_stress(var/stress)
	. = ..()
	if(. > 0)
		. = max(0, . - rand(2,5))
		shatter()
