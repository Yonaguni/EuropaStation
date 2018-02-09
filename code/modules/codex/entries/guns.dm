/obj/item/gun/composite/get_specific_codex_entry()

	var/datum/codex_entry/general_entry = SScodex.get_codex_entry(dam_type == "laser" ? "energy weapons" : "ballistic weapons")
	var/datum/codex_entry/entry = new()

	if(general_entry)
		entry.mechanics_text = general_entry.mechanics_text
		entry.lore_text =      general_entry.lore_text
		entry.antag_text =     general_entry.antag_text

	if(!entry.mechanics_text)  entry.mechanics_text = ""
	if(!entry.lore_text)       entry.lore_text = ""

	entry.display_name = name

	if(model && model.produced_by)
		entry.lore_text += "<br><br>This weapon was manufacured by [model.produced_by.manufacturer_name]. [model.produced_by.manufacturer_description]"
		entry.mechanics_text += "<br><br>This weapon has the following manufacturer-specific modifiers:<br>"
		if(!isnull(model.produced_by.accuracy))   entry.mechanics_text += "<b>Accuracy:</b> [model.produced_by.accuracy >= 1 ? "+" : ""][(model.produced_by.accuracy*100)-100]%<br>"
		if(!isnull(model.produced_by.capacity))   entry.mechanics_text += "<b>Ammo capacity:</b> [model.produced_by.capacity >= 1 ? "+" : ""][(model.produced_by.capacity*100)-100]%<br>"
		if(!isnull(model.produced_by.damage_mod)) entry.mechanics_text += "<b>Damage modifier:</b> [model.produced_by.damage_mod >= 1 ? "+" : ""][(model.produced_by.damage_mod*100)-100]%<br>"
		if(!isnull(model.produced_by.recoil))     entry.mechanics_text += "<b>Recoil reduction:</b> [model.produced_by.recoil >= 1 ? "+" : ""][(model.produced_by.recoil*100)-100]%<br>"
		if(!isnull(model.produced_by.fire_rate))  entry.mechanics_text += "<b>Fire delay:</b> [model.produced_by.fire_rate >= 1 ? "+" : ""][(model.produced_by.fire_rate*100)-100]%<br>"
	else
		entry.lore_text += "<br><br>This weapon is a custom-built aftermarket job with no single manufacturer or model."
		entry.mechanics_text += "<br><br>This weapon has no manufacturer-specific modifiers."

	return entry

/datum/codex_entry/energy_weapons
	display_name = "energy weapons"
	mechanics_text = "This weapon is an energy weapon; they run on battery charge rather than traditional ammunition. You can recharge \
		an energy weapon by placing it in a wall-mounted or table-mounted charger, such as those found in Security or around the \
		place. Additionally, most energy weapons can go straight through windows and hit whatever is on the other side, and are \
		hitscan, making them accurate and useful against distant targets. \
		<br><br> \
		This weapon can have accessories removed, or be field-stripped into its component parts, by using a pen, screwdriver, \
		or other small, edged object on it (such as forks)."
	lore_text = "A <b>C</b>oherent <b>R</b>adiation <b>E</b>mission <b>W</b>eapon, or C.R.E.W, uses pulses of \
		'hard light' to burn, damage or disrupt the target, or simply mark them for the purposes of laser tag \
		or practice. While low-power electroshock weapons are popular amongst peacekeepers, security officers and bounty \
		hunters due to the lack of risk from ricochets or penetrating shots destroying the hull or injuring \
		bystanders, more powerful devices are exceedingly rare and expensive."

/datum/codex_entry/ballistic_weapons
	display_name = "ballistic weapons"
	mechanics_text = "This weapon is a ballistic weapon; it fires solid shots using a magazine or loaded rounds of ammunition. You can \
		unload it by holding it and clicking it with an empty hand, and reload it by clicking it with a magazine, or in the case of \
		shotguns or some rifles, by opening the breech and clicking it with individual rounds. \
		<br><br> \
		This weapon can have accessories removed, or be field-stripped into its component parts, by using a pen, screwdriver, \
		or other small, edged object on it (such as forks)."
	lore_text = "Ballistic weapons are very popular even in the 2200's due to the relative expense of decent laser \
		weapons, difficulties in maintaining them, and the sheer stopping and wounding power of solid slugs or \
		composite shot. Using a ballistic weapon on a spacebound habitat is usually considered a serious undertaking, \
		as a missed shot or careless use of automatic fire could rip open the hull or injure bystanders with ease."
