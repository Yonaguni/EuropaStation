///////////////////////////////////////////////Alchohol bottles! -Agouri //////////////////////////
//Functionally identical to regular drinks. The only difference is that the default bottle size is 100. - Darem
//Bottles now weaken and break when smashed on people's heads. - Giacom

/obj/item/weapon/reagent_containers/food/drinks/bottle
	amount_per_transfer_from_this = 10
	volume = 120
	item_state = "broken_beer" //Generic held-item sprite until unique ones are made.

	light_type = LIGHT_SOFT_FLICKER
	light_range = 2
	light_power = 4
	light_color = "#CC7700"

	var/const/duration = 13 //Directly relates to the 'weaken' duration. Lowered by armor (i.e. helmets)
	var/isGlass = 1 //Whether the 'bottle' is made of glass or not so that milk cartons dont shatter when someone gets hit by it
	var/obj/item/weapon/reagent_containers/glass/rag/rag = null
	var/rag_underlay = "rag"

/obj/item/weapon/reagent_containers/food/drinks/bottle/New()
	..()
	if(isGlass)
		unacidable = 1
	if(!reagents)
		create_reagents(volume)

/obj/item/weapon/reagent_containers/food/drinks/bottle/Destroy()
	if(rag)
		rag.forceMove(src.loc)
	rag = null
	return ..()

//when thrown on impact, bottles smash and spill their contents
/obj/item/weapon/reagent_containers/food/drinks/bottle/throw_impact(atom/hit_atom, var/speed)
	..()

	var/mob/M = thrower
	if(isGlass && istype(M) && M.a_intent == I_HURT)
		var/throw_dist = get_dist(throw_source, loc)
		if(speed >= throw_speed && smash_check(throw_dist)) //not as reliable as smashing directly
			if(reagents)
				hit_atom.visible_message("<span class='notice'>The contents of \the [src] splash all over [hit_atom]!</span>")
				reagents.splash(hit_atom, reagents.total_volume)
			src.smash(loc, hit_atom)

/obj/item/weapon/reagent_containers/food/drinks/bottle/proc/smash_check(var/distance)
	if(!isGlass || !duration)
		return 0

	var/list/chance_table = list(90, 90, 85, 85, 60, 35, 15) //starting from distance 0
	var/idx = max(distance + 1, 1) //since list indices start at 1
	if(idx > chance_table.len)
		return 0
	return prob(chance_table[idx])

/obj/item/weapon/reagent_containers/food/drinks/bottle/proc/smash(var/newloc, atom/against = null)
	var/mob/user
	if(ismob(loc))
		var/mob/M = loc
		M.drop_from_inventory(src)
		user = M

	//Creates a shattering noise and replaces the bottle with a broken_bottle
	var/obj/item/weapon/broken_bottle/B = new /obj/item/weapon/broken_bottle(newloc)
	if(prob(33))
		new/obj/item/weapon/material/shard(newloc) // Create a glass shard at the target's location!
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
	if(user) user.put_in_active_hand(B)
	src.transfer_fingerprints_to(B)

	qdel(src)
	return B

/obj/item/weapon/reagent_containers/food/drinks/bottle/attackby(obj/item/W, mob/user)
	if(!rag && istype(W, /obj/item/weapon/reagent_containers/glass/rag))
		insert_rag(W, user)
		return
	if(rag && istype(W, /obj/item/weapon/flame))
		rag.attackby(W, user)
		return
	..()

/obj/item/weapon/reagent_containers/food/drinks/bottle/attack_self(mob/user)
	if(rag)
		remove_rag(user)
	else
		..()

/obj/item/weapon/reagent_containers/food/drinks/bottle/proc/insert_rag(obj/item/weapon/reagent_containers/glass/rag/R, mob/user)
	if(!isGlass || rag) return
	if(user.unEquip(R))
		user << "<span class='notice'>You stuff [R] into [src].</span>"
		rag = R
		rag.forceMove(src)
		flags &= ~OPENCONTAINER
		update_icon()

/obj/item/weapon/reagent_containers/food/drinks/bottle/proc/remove_rag(mob/user)
	if(!rag) return
	user.put_in_hands(rag)
	rag = null
	flags |= (initial(flags) & OPENCONTAINER)
	update_icon()

/obj/item/weapon/reagent_containers/food/drinks/bottle/open(mob/user)
	if(rag) return
	..()

/obj/item/weapon/reagent_containers/food/drinks/bottle/update_icon()
	underlays.Cut()
	if(rag)
		var/underlay_image = image(icon='icons/obj/drinks.dmi', icon_state=rag.on_fire? "[rag_underlay]_lit" : rag_underlay)
		underlays += underlay_image
		if(rag.on_fire)
			set_light()
			return
	kill_light()

/obj/item/weapon/reagent_containers/food/drinks/bottle/apply_hit_effect(mob/living/target, mob/living/user, var/hit_zone)
	var/blocked = ..()

	if(user.a_intent != I_HURT)
		return
	if(!smash_check(1))
		return //won't always break on the first hit

	// You are going to knock someone out for longer if they are not wearing a helmet.
	var/weaken_duration = 0
	if(blocked < 2)
		weaken_duration = duration + min(0, force - target.getarmor(hit_zone, "melee") + 10)

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
	var/obj/item/weapon/broken_bottle/B = smash(target.loc, target)
	user.put_in_active_hand(B)

//Keeping this here for now, I'll ask if I should keep it here.
/obj/item/weapon/broken_bottle
	name = "Broken Bottle"
	desc = "A bottle with a sharp broken bottom."
	icon = 'icons/obj/drinks.dmi'
	icon_state = "broken_bottle"
	force = 9
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	item_state = "beer"
	attack_verb = list("stabbed", "slashed", "attacked")
	//attack_sound = 'sound/weapons/bladeslice.ogg'
	sharp = 1
	edge = 0
	var/icon/broken_outline = icon('icons/obj/drinks.dmi', "broken")

/obj/item/weapon/reagent_containers/food/drinks/bottle/gin
	name = "gin bottle"
	desc = "A bottle of high-quality gin."
	icon_state = "ginbottle"
	center_of_mass = list("x"=16, "y"=4)
	initialize()
		..()
		reagents.add_reagent(REAGENT_ID_GIN, 100)

/obj/item/weapon/reagent_containers/food/drinks/bottle/whiskey
	name = "whiskey bottle"
	desc = "A premium single-malt whiskey."
	icon_state = "whiskeybottle"
	center_of_mass = list("x"=16, "y"=3)
	initialize()
		..()
		reagents.add_reagent(REAGENT_ID_WHISKEY, 100)

/obj/item/weapon/reagent_containers/food/drinks/bottle/vodka
	name = "vodka bottle"
	desc = "A rough, powerful alcohol made from potatoes."
	icon_state = "vodkabottle"
	center_of_mass = list("x"=17, "y"=3)
	initialize()
		..()
		reagents.add_reagent(REAGENT_ID_VODKA, 100)

/obj/item/weapon/reagent_containers/food/drinks/bottle/tequilla
	name = "tequilla bottle"
	desc = "May or may not contain a worm."
	icon_state = "tequillabottle"
	center_of_mass = list("x"=16, "y"=3)
	initialize()
		..()
		reagents.add_reagent(REAGENT_ID_TEQUILlA, 100)

/obj/item/weapon/reagent_containers/food/drinks/bottle/rum
	name = "rum bottle"
	desc = "A strong, sweet and spicy drink."
	icon_state = "rumbottle"
	center_of_mass = list("x"=16, "y"=8)
	initialize()
		..()
		reagents.add_reagent(REAGENT_ID_RUM, 100)

/obj/item/weapon/reagent_containers/food/drinks/bottle/wine
	name = "wine bottle"
	desc = "Classy!"
	icon_state = "winebottle"
	center_of_mass = list("x"=16, "y"=4)
	initialize()
		..()
		reagents.add_reagent(REAGENT_ID_WINE, 100)

/obj/item/weapon/reagent_containers/food/drinks/bottle/absinthe
	name = "absinthe bottle"
	desc = "One sip of this and you just know you're gonna have a good time."
	icon_state = "absinthebottle"
	center_of_mass = list("x"=16, "y"=6)
	initialize()
		..()
		reagents.add_reagent(REAGENT_ID_ABSINTHE, 100)

//Small bottles
/obj/item/weapon/reagent_containers/food/drinks/bottle/small
	volume = 50
	flags = 0 //starts closed
	rag_underlay = "rag_small"

/obj/item/weapon/reagent_containers/food/drinks/bottle/small/beer
	name = "beer bottle"
	desc = "Contains only water, malt and hops."
	icon_state = "beer"
	center_of_mass = list("x"=16, "y"=12)
	initialize()
		..()
		reagents.add_reagent(REAGENT_ID_BEER, 50)

/obj/item/weapon/reagent_containers/food/drinks/bottle/small/lemonade
	name = "lemonade bottle"
	desc = "A refreshing, fizzy beverage. Tastes like a hull breach in your mouth."
	icon_state = "space-up_bottle"
	center_of_mass = list("x"=16, "y"=6)
	initialize()
		..()
		reagents.add_reagent(REAGENT_ID_LEMONADE, 50)

/obj/item/weapon/reagent_containers/food/drinks/bottle/small/cola
	name = "cola bottle"
	desc = "A refreshing, fizzy beverage. Does not actually contain cocaine."
	icon_state = "colabottle"
	center_of_mass = list("x"=16, "y"=6)
	initialize()
		..()
		reagents.add_reagent(REAGENT_ID_COLA, 50)
