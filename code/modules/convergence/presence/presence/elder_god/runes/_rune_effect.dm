/obj/effect/decal/cleanable/sigil/rune
	name = "bloody rune"
	color = "#A10808"
	icon = 'icons/effects/runes.dmi'
	icon_state = "blank"
	light_power = 1
	light_range = 1
	light_color = "#A10808"
	blend_mode = BLEND_MULTIPLY

/obj/effect/decal/cleanable/sigil/rune/update_from_presence()
	var/rune_cache_key = "\ref[sanctified_to]-\ref[effect]"
	if(!rune_icon_cache[rune_cache_key])
		var/list/rune_ident
		while(!rune_ident || !isnull(all_rune_idents[jointext(rune_ident,null)]))
			var/list/rune_states = all_rune_states.Copy()
			rune_ident = list(pick_n_take(rune_states), pick_n_take(rune_states), pick_n_take(rune_states), pick_n_take(rune_states))

		var/image/full_rune = new
		var/i = 0
		for(var/rune_state in rune_ident)
			var/image/single_rune = image('icons/effects/runes.dmi', rune_state)
			if(i)
				var/matrix/M = matrix()
				M.Turn(90 * i)
				single_rune.transform = M
			full_rune.overlays += single_rune
			i++
		rune_icon_cache[rune_cache_key] = full_rune
		all_rune_idents[jointext(rune_ident,null)] = TRUE
	overlays += rune_icon_cache[rune_cache_key]
