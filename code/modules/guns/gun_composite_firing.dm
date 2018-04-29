/obj/item/gun/composite/consume_next_projectile()

	if(jammed)
		var/mob/M = loc
		if(istype(M))
			to_chat(M, "<span class='warning'>\The [src] has jammed!</span>")
		return

	if(chamber.can_jam && chamber.design_caliber.projectile_size > barrel.design_caliber.projectile_size && prob(abs(chamber.design_caliber.projectile_size - barrel.design_caliber.projectile_size)*10))
		jam()

	var/obj/item/projectile/proj = chamber.consume_next_projectile()
	if(proj)
		if(model && !isnull(model.produced_by.damage_mod))
			proj.damage = round(proj.damage * model.produced_by.damage_mod)

		if(well_maintained)
			proj.damage *= 1.1
			well_maintained--

		chamber.modify_shot(proj)
		if(proj) barrel.modify_shot(proj)

	if(proj)
		if(jammed)
			proj.on_hit(get_turf(src), 0)
			qdel(proj)
		else
			return proj

/obj/item/gun/composite/handle_post_fire()
	..()
	chamber.handle_post_fire()

/obj/item/gun/composite/handle_click_empty()
	..()
	chamber.handle_click_empty()
