/mob/living/proc/ventcrawl()
	set name = "Crawl through Vent"
	set desc = "Enter an air vent and crawl through the pipe system."
	set category = "Abilities"

	if(stat == DEAD || paralysis || weakened || stunned || restrained())
		return

	handle_ventcrawl()

/mob/living/proc/hide()
	set name = "Hide"
	set desc = "Allows to hide beneath tables or certain items. Toggled on or off."
	set category = "Abilities"

	if(stat == DEAD || paralysis || weakened || stunned || restrained())
		return

	if (layer != 2.45)
		layer = 2.45 //Just above cables with their 2.44
		src << text("\blue You are now hiding.")
	else
		layer = MOB_LAYER
		src << text("\blue You have stopped hiding.")

//Brain slug proc for voluntary removal of control.
/mob/living/proc/release_control()

	set category = "Abilities"
	set name = "Release Control"
	set desc = "Release control of your host's body."

	var/mob/living/animal/borer/B = has_brain_worms()

	if(B && B.host_brain)
		src << "<span class='danger'>You withdraw your probosci, releasing control of [B.host_brain]</span>"

		B.detatch()

		verbs -= /mob/living/proc/release_control
		verbs -= /mob/living/proc/punish_host
		verbs -= /mob/living/proc/spawn_larvae

	else
		src << "<span class='danger'>ERROR NO BORER OR BRAINMOB DETECTED IN THIS MOB, THIS IS A BUG !</span>"

//Brain slug proc for tormenting the host.
/mob/living/proc/punish_host()
	set category = "Abilities"
	set name = "Torment host"
	set desc = "Punish your host with agony."

	var/mob/living/animal/borer/B = has_brain_worms()

	if(!B)
		return

	if(B.host_brain.ckey)
		src << "<span class='danger'>You send a punishing spike of psychic agony lancing into your host's brain.</span>"
		if (!can_feel_pain())
			B.host_brain << "<span class='warning'>You feel a strange sensation as a foreign influence prods your mind.</span>"
			src << "<span class='danger'>It doesn't seem to be as effective as you hoped.</span>"
		else
			B.host_brain << "<span class='danger'><FONT size=3>Horrific, burning agony lances through you, ripping a soundless scream from your trapped mind!</FONT></span>"

/mob/living/proc/spawn_larvae()
	set category = "Abilities"
	set name = "Reproduce"
	set desc = "Spawn several young."

	var/mob/living/animal/borer/B = has_brain_worms()

	if(!B)
		return

	if(B.chemicals >= 100)
		src << "<span class='danger'>Your host twitches and quivers as you rapidly excrete a larva from your sluglike body.</span>"
		visible_message("<span class='danger'>\The [src] heaves violently, expelling a rush of vomit and a wriggling, sluglike creature!</span>")
		B.chemicals -= 100
		B.has_reproduced = 1

		vomit(1)
		new /mob/living/animal/borer(get_turf(src))

	else
		src << "<span class='warning'>You do not have enough chemicals stored to reproduce.</span>"
		return