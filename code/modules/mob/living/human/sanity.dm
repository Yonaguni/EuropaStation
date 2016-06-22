// General-purpose SAN loss system.
// This will replace hallucinations when properly added.

/mob/living/human/var/insanity = 0         // How crazy are we?
/mob/living/human/var/snapped              // Have we permanently gone off the deep end?
/mob/living/human/var/minimum_insanity = 0 // Some aspects, antag status, etc. increase this.

/mob/living/human/proc/lose_sanity(var/amt)

	if(snapped) // You can't go any crazier.
		return

	var/final_amt = amt
	if(insanity > 50) // Slippery slope...
		final_amt += amt*0.2

	if(traumatic_shock > 50) // Arbitrary, balance later.
		final_amt += amt*0.2

	// Hallucinogenics and such makes you less susceptible.
	if(druggy || confused)
		final_amt -= amt*0.35

	insanity += final_amt
	if(insanity >= 100)
		sanity_snap()
		insanity = 100
		return

/mob/living/human/proc/recover_sanity(var/amt)
	if(snapped || !amt)
		return
	insanity = max(minimum_insanity, insanity - amt)

/mob/living/human/proc/handle_insanity()

	if(snapped)
		insanity = 100
		return

	if(insanity <= 0)
		return

	var/sanity_regained = 0
	if(resting || stat == UNCONSCIOUS)
		sanity_regained += 1
	recover_sanity(sanity_regained)

/mob/living/human/proc/sanity_snap()
	if(snapped)
		return
	snapped = 1
	insanity = 100
