var/list/slug_cache = list()

/mob/living/simple_animal/europa_fish/sea_slug
	name = "sea slug"
	desc = "A colourful slimy friend! Probably poisonous."
	icon_state = "slug"
	icon = 'icons/mob/europa/slugs.dmi'
	wander = 1
	holder_type = /obj/item/weapon/holder

	var/list/base_colour = list()
	var/list/rider

/mob/living/simple_animal/europa_fish/sea_slug/New(var/newloc, var/mob/living/simple_animal/europa_fish/sea_slug/spawner)
	icon_state = null
	if(spawner)
		base_colour = spawner.base_colour.Copy()
		rider = spawner.rider.Copy()

	var/list/components = list("base","eyes","fronds","stripe")
	if(!base_colour["eyes"])   base_colour["eyes"]   = "[pick(list(COLOR_RED, COLOR_YELLOW, COLOR_LIME, COLOR_CYAN, COLOR_BLUE, COLOR_PINK, COLOR_ORANGE, COLOR_LUMINOL))]"
	if(!base_colour["base"])   base_colour["base"]   = "#[get_random_colour(0,40,70)]"
	if(!base_colour["fronds"]) base_colour["fronds"] = "#[get_random_colour(0,50,90)]"
	if(!base_colour["stripe"]) base_colour["stripe"] = "#[get_random_colour(0,50,90)]"
	if(!rider)
		rider = list()
		rider["base"] = 0
		rider["eyes"] = rand(0,3)
		if(prob(80)) rider["stripe"] = rand(0,3)
		if(prob(80)) rider["fronds"] = rand(0,5)

	var/cache_key
	for(var/component in components)
		cache_key += "\[[component]-[base_colour[component]][rider[component]]\]"
	if(!slug_cache[cache_key])
		var/icon/blank = icon(icon,"")
		for(var/component in components)
			var/slug_key = "[component]-[base_colour[component]][rider[component]]"
			if(!slug_cache[slug_key])
				var/icon/base = icon(icon, "[component][rider[component]]")
				base.Blend(base_colour[component],ICON_ADD)
				blank.Blend(base, ICON_OVERLAY)
				slug_cache[slug_key] = base
		slug_cache[cache_key] = blank
	icon = slug_cache[cache_key]
	..(newloc)
	icon_state = null
	set_light(2,2,base_colour["eyes"])
