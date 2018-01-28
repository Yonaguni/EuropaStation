/datum/psi_complexus
	var/suppressed = TRUE             // Whether or not we are suppressing our psi powers.
	var/telekinesis_suppressed = TRUE // Whether or not we are suppressing TK.
	var/use_intimate_mode = FALSE     // Whether or not we are using the intimate telepathic mode.
	var/rebuild_power_cache = TRUE    // Whether or not we need to rebuild our cache of psi powers.

	var/rating = 0                    // Overall psi rating.
	var/cost_modifier = 1             // Multiplier for power use stamina costs.
	var/stun = 0                      // Number of process ticks we are stunned for.
	var/next_power_use = 0            // world.time minimum before next power use.
	var/stamina = 30                  // Current psi pool.
	var/max_stamina = 30              // Max psi pool.

	var/list/latencies                // List of all currently latent faculties.
	var/list/ranks                    // Assoc list of psi faculties to current rank.
	var/list/manifested_items         // List of atoms manifested/maintained by psychic power.
	var/next_latency_trigger = 0      // world.time minimum before a trigger can be attempted again.

	// Cached powers.
	var/list/melee_powers             // Powers used in melee range.
	var/list/grab_powers              // Powers use by using a grab.
	var/list/ranged_powers            // Powers used at range.
	var/list/manifestation_powers     // Powers that create an item.
	var/list/powers_by_faculty        // All powers within a given faculty.

	var/obj/screen/psi/hub/ui	      // Reference to the master psi UI object.
	var/mob/living/owner // Reference to our owner.
	var/obj/effect/psi_aura/aura

/datum/psi_complexus/New(var/mob/_owner)
	owner = _owner
	aura = new(owner, src)
	START_PROCESSING(SSpsi, src)

/datum/psi_complexus/Destroy()
	STOP_PROCESSING(SSpsi, src)
	if(aura)
		qdel(aura)
		aura = null
	if(owner)
		cancel()
		if(owner.client)
			owner.client.screen -= list(ui, ui.components)
		qdel(ui)
		ui = null
		owner.psi = null
		owner = null
	manifested_items.Cut()
	. = ..()
