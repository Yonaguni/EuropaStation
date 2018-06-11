///////////////////////////////////////////////Alchohol bottles! -Agouri //////////////////////////
//Functionally identical to regular drinks. The only difference is that the default bottle size is 100. - Darem
//Bottles now weaken and break when smashed on people's heads. - Giacom

/obj/item/reagent_containers/food/drinks/bottle
	amount_per_transfer_from_this = 10
	volume = 100
	item_state = "broken_beer" //Generic held-item sprite until unique ones are made.
	force = 5
	var/smash_duration = 5 //Directly relates to the 'weaken' duration. Lowered by armor (i.e. helmets)
	var/isGlass = 1 //Whether the 'bottle' is made of glass or not so that milk cartons dont shatter when someone gets hit by it

	var/obj/item/reagent_containers/glass/rag/rag = null
	var/rag_underlay = "rag"

/obj/item/reagent_containers/food/drinks/bottle/Initialize(mapload)
	. = ..()
	if(isGlass) unacidable = 1

/obj/item/reagent_containers/food/drinks/bottle/Destroy()
	if(rag)
		rag.forceMove(src.loc)
	rag = null
	return ..()

//when thrown on impact, bottles smash and spill their contents
/obj/item/reagent_containers/food/drinks/bottle/throw_impact(atom/hit_atom, var/speed)
	..()

	var/mob/M = thrower
	if(isGlass && istype(M) && M.a_intent == I_HURT)
		var/throw_dist = get_dist(throw_source, loc)
		if(speed >= throw_speed && smash_check(throw_dist)) //not as reliable as smashing directly
			if(reagents && reagents.total_volume)
				hit_atom.visible_message("<span class='notice'>The contents of \the [src] splash all over [hit_atom]!</span>")
				reagents.splash(hit_atom, reagents.total_volume)
			src.smash(loc, hit_atom)

/obj/item/reagent_containers/food/drinks/bottle/proc/smash_check(var/distance)
	if(!isGlass || !smash_duration)
		return 0

	var/list/chance_table = list(95, 95, 90, 85, 75, 55, 35) //starting from distance 0
	var/idx = max(distance + 1, 1) //since list indices start at 1
	if(idx > chance_table.len)
		return 0
	return prob(chance_table[idx])

/obj/item/reagent_containers/food/drinks/bottle/proc/smash(var/newloc, atom/against = null)
	if(ismob(loc))
		var/mob/M = loc
		M.drop_from_inventory(src)

	//Creates a shattering noise and replaces the bottle with a broken_bottle
	var/obj/item/broken_bottle/B = new /obj/item/broken_bottle(newloc)
	if(prob(33))
		new/obj/item/material/shard(newloc) // Create a glass shard at the target's location!
	B.icon_state = src.icon_state

	var/icon/I = new('icons/obj/drinks.dmi', src.icon_state)
	I.Blend(B.broken_outline, ICON_OVERLAY, rand(5), 1)
	I.SwapColor(rgb(255, 0, 220, 255), rgb(0, 0, 0, 0))
	B.icon = I

	if(rag && rag.on_fire && isliving(against))
		rag.forceMove(loc)
		var/mob/living/L = against
		L.IgniteMob()

	playsound(src, "shatter", 70, 1)
	src.transfer_fingerprints_to(B)

	qdel(src)
	return B

/obj/item/reagent_containers/food/drinks/bottle/attackby(obj/item/W, mob/user)
	if(!rag && istype(W, /obj/item/reagent_containers/glass/rag))
		insert_rag(W, user)
		return
	if(rag && istype(W, /obj/item/flame))
		rag.attackby(W, user)
		return
	..()

/obj/item/reagent_containers/food/drinks/bottle/attack_self(mob/user)
	if(rag)
		remove_rag(user)
	else
		..()

/obj/item/reagent_containers/food/drinks/bottle/proc/insert_rag(var/obj/item/reagent_containers/glass/rag/R, mob/user)
	if(!isGlass || rag) return
	if(user.unEquip(R))
		user << "<span class='notice'>You stuff [R] into [src].</span>"
		rag = R
		rag.forceMove(src)
		flags &= ~OPENCONTAINER
		update_icon()

/obj/item/reagent_containers/food/drinks/bottle/proc/remove_rag(mob/user)
	if(!rag) return
	user.put_in_hands(rag)
	rag = null
	flags |= (initial(flags) & OPENCONTAINER)
	update_icon()

/obj/item/reagent_containers/food/drinks/bottle/open(mob/user)
	if(rag) return
	..()

/obj/item/reagent_containers/food/drinks/bottle/update_icon()
	underlays.Cut()
	if(rag)
		var/underlay_image = image(icon='icons/obj/drinks.dmi', icon_state=rag.on_fire? "[rag_underlay]_lit" : rag_underlay)
		underlays += underlay_image
		copy_light(rag)
	else
		kill_light()

/obj/item/reagent_containers/food/drinks/bottle/apply_hit_effect(mob/living/target, mob/living/user, var/hit_zone)
	var/blocked = ..()

	if(user.a_intent != I_HURT)
		return
	if(!smash_check(1))
		return //won't always break on the first hit

	// You are going to knock someone out for longer if they are not wearing a helmet.
	var/weaken_duration = 0
	if(blocked < 100)
		weaken_duration = smash_duration + min(0, force - target.getarmor(hit_zone, "melee") + 10)

	var/mob/living/carbon/human/H = target
	if(istype(H) && H.headcheck(hit_zone))
		var/obj/item/organ/affecting = H.get_organ(hit_zone) //headcheck should ensure that affecting is not null
		user.visible_message("<span class='danger'>[user] smashes [src] into [H]'s [affecting.name]!</span>")
		if(weaken_duration)
			target.apply_effect(min(weaken_duration, 5), WEAKEN, blocked) // Never weaken more than a flash!
	else
		user.visible_message("<span class='danger'>\The [user] smashes [src] into [target]!</span>")

	//The reagents in the bottle splash all over the target, thanks for the idea Nodrak
	if(reagents)
		user.visible_message("<span class='notice'>The contents of \the [src] splash all over [target]!</span>")
		reagents.splash(target, reagents.total_volume)

	//Finally, smash the bottle. This kills (qdel) the bottle.
	var/obj/item/broken_bottle/B = smash(target.loc, target)
	user.put_in_active_hand(B)

	return blocked

//Keeping this here for now, I'll ask if I should keep it here.
/obj/item/broken_bottle
	name = "broken bottle"
	desc = "A bottle with a sharp broken bottom."
	icon = 'icons/obj/drinks.dmi'
	icon_state = "broken_bottle"
	force = 9
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	item_state = "beer"
	attack_verb = list("stabbed", "slashed", "attacked")
	sharp = 1
	edge = 0
	var/icon/broken_outline = icon('icons/obj/drinks.dmi', "broken")

/obj/item/broken_bottle/attack(var/mob/living/carbon/M, var/mob/living/carbon/user)
	playsound(loc, 'sound/weapons/bladeslice.ogg', 50, 1, -1)
	return ..()


/obj/item/reagent_containers/food/drinks/bottle/gin
	name = "Darrow's Victory Gin"
	desc = "A bottle of high-quality Terran State gin, produced in the Year of the Bastard."
	icon_state = "ginbottle"
	center_of_mass = "x=16;y=4"

/obj/item/reagent_containers/food/drinks/bottle/gin/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_GIN, 100)

/obj/item/reagent_containers/food/drinks/bottle/whiskey
	name = "Ape's Breath Freon Whiskey"
	desc = "A premium single-malt whiskey produced in the abandoned fission stacks rimward of Neith. The fumes alone can strip paint."
	icon_state = "whiskeybottle"
	center_of_mass = "x=16;y=3"

/obj/item/reagent_containers/food/drinks/bottle/whiskey/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_WHISKEY, 100)

/obj/item/reagent_containers/food/drinks/bottle/tequilla
	name = "Caccavo Guaranteed Quality Tequilla"
	desc = "Made from premium petroleum distillates, pure thalidomide and other fine quality ingredients!"
	icon_state = "tequillabottle"
	center_of_mass = "x=16;y=3"

/obj/item/reagent_containers/food/drinks/bottle/tequilla/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_TEQUILLA, 100)

/obj/item/reagent_containers/food/drinks/bottle/wine
	name = "Amico Guido Vino"
	desc = "A premium '79 red wine shipped brinkward at great expense."
	icon_state = "winebottle"
	center_of_mass = "x=16;y=4"

/obj/item/reagent_containers/food/drinks/bottle/wine/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_WINE, 100)

/obj/item/reagent_containers/food/drinks/bottle/absinthe
	name = "Life Cry Absinthe"
	desc = "You know you're in for a good night when there's a picture of a bleeding polar bear on the label."
	icon_state = "absinthebottle"
	center_of_mass = "x=16;y=6"

/obj/item/reagent_containers/food/drinks/bottle/absinthe/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_ABSINTHE, 100)

/obj/item/reagent_containers/food/drinks/bottle/patron
	name = "Teraton Silver Tequila"
	desc = "Silver-laced tequilla, served in every night club sunward of Saturn."
	icon_state = "patronbottle"
	center_of_mass = "x=16;y=6"

/obj/item/reagent_containers/food/drinks/bottle/patron/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_PATRON, 100)

// TODO RESKIN THESE
/obj/item/reagent_containers/food/drinks/bottle/vodka
	name = "triple-distilled vodka"
	desc = "Aah, vodka. Prime choice of drink AND fuel by Russians worldwide."
	icon_state = "vodkabottle"
	center_of_mass = "x=17;y=3"

/obj/item/reagent_containers/food/drinks/bottle/vodka/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_VODKA, 100)

/obj/item/reagent_containers/food/drinks/bottle/rum
	name = "spiced rum"
	desc = "Sweet, spicy and sour."
	icon_state = "rumbottle"
	center_of_mass = "x=16;y=8"

/obj/item/reagent_containers/food/drinks/bottle/rum/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_RUM, 100)

/obj/item/reagent_containers/food/drinks/bottle/holywater
	name = "Flask of Holy Water"
	desc = "A flask of the chaplain's holy water."
	icon_state = "holyflask"
	center_of_mass = "x=17;y=10"

/obj/item/reagent_containers/food/drinks/bottle/holywater/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_HOLY_WATER, 100)

/obj/item/reagent_containers/food/drinks/bottle/vermouth
	name = "vermouth"
	desc = "Sweet, sweet dryness."
	icon_state = "vermouthbottle"
	center_of_mass = "x=17;y=3"

/obj/item/reagent_containers/food/drinks/bottle/vermouth/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_VERMOUTH, 100)

/obj/item/reagent_containers/food/drinks/bottle/kahlua
	name = "coffee liqueur"
	desc = "A widely-known coffee-flavoured liqueur. In production since 1936."
	icon_state = "kahluabottle"
	center_of_mass = "x=17;y=3"

/obj/item/reagent_containers/food/drinks/bottle/kahlua/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_KAHLUA, 100)

/obj/item/reagent_containers/food/drinks/bottle/goldschlager
	name = "Goldschlager"
	desc = "A bottle of gold-flecked 100-proof cinnamon schnapps."
	icon_state = "goldschlagerbottle"
	center_of_mass = "x=15;y=3"

/obj/item/reagent_containers/food/drinks/bottle/goldschlager/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_GOLDSCHLAGER, 100)

/obj/item/reagent_containers/food/drinks/bottle/cognac
	name = "cognac"
	desc = "A sweet and strongly alchoholic drink, made after numerous distillations and years of maturing."
	icon_state = "cognacbottle"
	center_of_mass = "x=16;y=6"

/obj/item/reagent_containers/food/drinks/bottle/cognac/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_COGNAC, 100)

/obj/item/reagent_containers/food/drinks/bottle/pwine
	name = "Warlock's Velvet"
	desc = "What a delightful packaging for a surely high quality wine! The vintage must be amazing!"
	icon_state = "pwinebottle"
	center_of_mass = "x=16;y=4"

/obj/item/reagent_containers/food/drinks/bottle/pwine/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_POISON_WINE, 100)

// END TODO

/obj/item/reagent_containers/food/drinks/bottle/melonliquor
	name = "melon liqueur"
	desc = "A bottle of 46 proof Emeraldine Melon Liquor. Sweet and light."
	icon_state = "alco-green" //Placeholder.
	center_of_mass = "x=16;y=6"

/obj/item/reagent_containers/food/drinks/bottle/melonliquor/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_MELON_LIQUOR, 100)

/obj/item/reagent_containers/food/drinks/bottle/bluecuracao
	name = "blue curacao"
	desc = "A fruity, exceptionally azure liquor."
	icon_state = "alco-blue" //Placeholder.
	center_of_mass = "x=16;y=6"

/obj/item/reagent_containers/food/drinks/bottle/bluecuracao/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_BLUE_CURACAO, 100)

/obj/item/reagent_containers/food/drinks/bottle/grenadine
	name = "grenadine syrup"
	desc = "Sweet and tangy, a bar syrup used to add color or flavor to drinks."
	icon_state = "grenadinebottle"
	center_of_mass = "x=16;y=6"

/obj/item/reagent_containers/food/drinks/bottle/grenadine/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_GRENADINE, 100)

/obj/item/reagent_containers/food/drinks/bottle/cola
	name = "cola"
	desc = "Cadre Cola - it'll keep you running!"
	icon_state = "colabottle"
	center_of_mass = "x=16;y=6"

/obj/item/reagent_containers/food/drinks/bottle/cola/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_COLA, 100)

/obj/item/reagent_containers/food/drinks/bottle/space_up
	name = "lemonade"
	desc = "Tastes like a hull breach in your mouth."
	icon_state = "space-up_bottle"
	center_of_mass = "x=16;y=6"

/obj/item/reagent_containers/food/drinks/bottle/space_up/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_LEMONADE, 100)

/obj/item/reagent_containers/food/drinks/bottle/space_mountain_wind
	name = "soda"
	desc = "The label reads 'Bouncy Bubble Beverage'. Enjoying this refreshing drink is mandatory."
	icon_state = "space_mountain_wind_bottle"
	center_of_mass = "x=16;y=6"

/obj/item/reagent_containers/food/drinks/bottle/space_mountain_wind/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_CITRUS_SODA, 100)

//////////////////////////JUICES AND STUFF ///////////////////////

/obj/item/reagent_containers/food/drinks/bottle/orangejuice
	name = "orange juice"
	desc = "Full of vitamin C, to ward off scurvy!"
	icon_state = "orangejuice"
	item_state = "carton"
	center_of_mass = "x=16;y=7"
	isGlass = 0

/obj/item/reagent_containers/food/drinks/bottle/orangejuice/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_ORANGE_JUICE, 100)

/obj/item/reagent_containers/food/drinks/bottle/cream
	name = "milk cream"
	desc = "It's cream. Made from milk. What else did you think you'd find in there?"
	icon_state = "cream"
	item_state = "carton"
	center_of_mass = "x=16;y=8"
	isGlass = 0

/obj/item/reagent_containers/food/drinks/bottle/cream/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_CREAM, 100)

/obj/item/reagent_containers/food/drinks/bottle/eggnog // empty, do not use
	name = "eggnog"
	desc = "It's eggnog. Christmas is here already?"
	icon_state = "nog1"
	item_state = "carton"
	center_of_mass = "x=16;y=8"
	isGlass = 0

/obj/item/reagent_containers/food/drinks/bottle/eggnog/nonalcoholic
	desc = "It's eggnog. Christmas is here already? This one seems to be non-alcoholic."

/obj/item/reagent_containers/food/drinks/bottle/eggnog/nonalcoholic/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_EGGNOG, 100)

/obj/item/reagent_containers/food/drinks/bottle/eggnog/alcoholic
	desc = "It's eggnog. Christmas is here already? This one seems to be alcoholic."
	icon_state = "nog2"

/obj/item/reagent_containers/food/drinks/bottle/eggnog/alcoholic/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_EGGNOG, 80)
	reagents.add_reagent(REAGENT_RUM, 20)

/obj/item/reagent_containers/food/drinks/bottle/tomatojuice
	name = "tomato juice"
	desc = "Well, at least it LOOKS like tomato juice. You can't tell with all that redness."
	icon_state = "tomatojuice"
	item_state = "carton"
	center_of_mass = "x=16;y=8"
	isGlass = 0

/obj/item/reagent_containers/food/drinks/bottle/tomatojuice/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_TOMATO_JUICE, 100)

/obj/item/reagent_containers/food/drinks/bottle/limejuice
	name = "lime juice"
	desc = "Sweet-sour goodness."
	icon_state = "limejuice"
	item_state = "carton"
	center_of_mass = "x=16;y=8"
	isGlass = 0

/obj/item/reagent_containers/food/drinks/bottle/limejuice/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_LIME_JUICE, 100)

//Small bottles
/obj/item/reagent_containers/food/drinks/bottle/small
	volume = 50
	smash_duration = 1
	flags = 0 //starts closed
	rag_underlay = "rag_small"

/obj/item/reagent_containers/food/drinks/bottle/small/beer
	name = "beer"
	desc = "Saint Peter Beer, sourced from Callisto. Now with added Salt Peter."
	icon_state = "beer"
	center_of_mass = "x=16;y=12"

/obj/item/reagent_containers/food/drinks/bottle/small/beer/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_BEER, 30)

/obj/item/reagent_containers/food/drinks/bottle/small/ale
	name = "ale"
	desc = "J. McCrea's Armpit Ale - 'It's Good For What Ale's You'."
	icon_state = "alebottle"
	item_state = "beer"
	center_of_mass = "x=16;y=10"

/obj/item/reagent_containers/food/drinks/bottle/small/ale/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_ALE, 30)
