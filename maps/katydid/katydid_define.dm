/datum/map/katydid
	name = "Katydid"
	full_name = "ICV Katydid"
	path = "katydid"

	station_levels = list(1)
	admin_levels = list(2)
	contact_levels = list(1,3)
	player_levels = list(1,3)
	use_overmap = TRUE

	has_gravity = FALSE

	shuttle_docked_message = "Jumpgate control reports that departure can occur in approximately %ETD%. All hands, please prepare for departure."
	shuttle_leaving_dock = "Wave jump initiated. Please do not depart the vessel until the jump is complete. Estimate %ETA% until jump completion and arrival at %dock_name%."
	shuttle_called_message = "Negotiations underway for jumpgate entry. Estimated approval time is %ETA%."
	shuttle_recall_message = "The scheduled wave jump has been cancelled."
	emergency_shuttle_docked_message = "Emergency jumpgate plotting complete. Escape pods prepared. Emergency jump will occur in approximately %ETD%. All hands, prepare for departure."
	emergency_shuttle_leaving_dock = "Emergency wave jump initiated; pods launching. Estimate %ETA% until completion of jump and arrival at %dock_name%."
	emergency_shuttle_called_message = "An emergency wave jump has been initiated and escape pods are being prepped. Preparations will be complete in approximately %ETA%"
	emergency_shuttle_recall_message = "The emergency wave jump has been cancelled."
	evac_controller_type = /datum/evacuation_controller/pods/ship
	single_card_authentication = TRUE

	commanding_role = "Captain"

	votable = TRUE

	lobby_music_choices = list(
		/datum/music_track/inorbit,
		/datum/music_track/juno,
		/datum/music_track/andoftheworld
		)

	var/ship_prefix = "ICV"
	var/ship_name = "Katydid"
	var/datum/stellar_location/destination_location
	var/initial_announcement

	var/list/possible_ship_names = list(
		"Hornet",
		"Witchmoth",
		"Planthopper",
		"Mayfly",
		"Locust",
		"Cicada",
		"Sanddragon",
		"Conehead",
		"Whitetail",
		"Amberwing",
		"Swallowtail",
		"Hawkmoth",
		"Katydid",
		"Longhorn",
		"Luna Moth",
		"Monarch",
		"Mydas",
		"Paperwasp",
		"Treehopper",
		"Sphinxmoth",
		"Leatherwing",
		"Scarab",
		"Ash Borer",
		"Admiral",
		"Emperor",
		"Skipper",
		"Tarantula Hawk",
		"Adder",
		"Bumblebee"
		)

	var/list/possible_ship_prefix = list(
		"SEV",
		"SIC",
		"FTUV",
		"ICV",
		"HMS"
		)

/datum/map/katydid/New()
	. = ..()
	ship_prefix = pick(possible_ship_prefix)
	ship_name =   pick(possible_ship_names)
	full_name = "[ship_prefix] [ship_name]"

/datum/map/katydid/perform_map_generation()
	stellar_location.build_level(3)
	return 1

/datum/map/katydid/update_locations()
	. = ..()
	destination_location = pick(all_stellar_locations - stellar_location)
	if(stellar_location.flavour_locations && stellar_location.flavour_locations.len)
		specific_location = pick(stellar_location.flavour_locations)
		initial_announcement = "Wave jump complete. The SHIPNAME has safely arrived in the vicinity of [specific_location], [stellar_location.is_a_planet ? "orbiting" : "within"] [stellar_location.name]. Gravity drive systems are fully disengaged and all crewmembers are cleared to resume their regular duties."
	else
		specific_location = stellar_location.name
		initial_announcement = "Wave jump complete. The SHIPNAME has safely arrived at [specific_location]. Gravity drive systems are fully disengaged and all crewmembers are cleared to resume their regular duties."
	shuttle_leaving_dock = "Wave jump initiated. Please do not depart the vessel until the jump is complete. Estimate %ETA% until leaving orbit and departing for [destination_location.name]."
	emergency_shuttle_leaving_dock = "Emergency wave jump initiated; pods launching. Please do not depart the vessel. Estimate %ETA% until leaving orbit and departing for [destination_location.name]."

/datum/map/katydid/do_roundstart_intro()
	. = ..()
	if(initial_announcement)
		priority_announcement.Announce(replacetext(initial_announcement, "SHIPNAME", full_name))
	sleep(600)
	if(destination_location)
		priority_announcement.Announce("Vector plotting for scheduled jump complete. Departure for [destination_location.name] will be undertaken in two standard hours.")

/obj/effect/landmark/map_data/katydid
	name = "ICV Katydid"
	desc = "An independant freight vessel."
	height = 1

/obj/effect/landmark/map_data/katydid/initialize()
	if(using_map)
		name = using_map.full_name
	. = ..()

/datum/map/katydid/handle_captain_join(var/mob/living/carbon/human/captain)

	var/datum/faction/F = get_faction(default_faction)
	var/obj/item/paper/charter = new(get_turf(captain))
	charter.name = "document (ship charter)"
	charter.desc = "An official-looking watermarked charter of hire for a spacecraft. Don't lose it."
	charter.info = {"
		<center><h1>VESSEL CHARTER AGREEMENT</h1></center>
		<br>This charter made and entered into, with a commencement date of [stationdate2text()], by and between THE CALLISTO FREE TRADERS, a Jovian Free Trade Union affiliate, hereinafter referred to as 'Owner', and [uppertext(captain.real_name)] hereinafter referred to as 'Operator'.
		</br>
		</br>
		WHEREAS, the Operator desires to charter a vessel for the purpose of private cargo shipping within Sol, and
		</br>
		</br>
		WHEREAS, the Owner has a vessel available to charter for such purpose,
		</br>
		</br>
		NOW, THEREFORE, the parties hereto hereinafter agree as follows:
		<br>
		</br>
		<ol>
		<li>Owner shall conduct appropriate vetting procedures to ensure a properly qualified captain and crew adequate for the safety of the vessel and all other persons related to the operation of the vessel, as well as current Sol Navy certification of registration and trading limits, as applicable.</li>
		<li>Subject to such reimbursement and payment as may be specifically provided in this charter, Operator, solely at their own cost and expense, shall furnish the vessel, the captain and full complement of crew, sleeping accommodations and meals for a maximum of thirty passengers, including staff and/or instructors and the vessel's operating and maintenance costs, including but not limited to, fuel, including increased fuel costs which may exist at the time of the charter, water, other consumable stores, docking and wharf charges, permits, licenses, tariffs, fees, taxes, and any and all other expenses relating to such operation and maintenance.</li>
		<li>Owner agrees to secure and keep in force during the entire term of this charter, at Owner's sole cost and expense, a standard intersystem insurance policy including Hull (to full value) and Protection and Indemnity coverage, in such form, with such carriers, and in such amounts as are acceptable to Operator to protect Operator against all claims, demands, damages, liabilities, actions and causes of actions incident to the use of or resulting from any accident occurring in connection with the operation of the vessel.  Said policy or policies shall contain a provision naming the Operator as an additional insured except that such a provision shall not apply to the extent such losses are caused by the negligent acts or omissions of Operator, its officers, agents or employees.  Certificates of insurance acceptable to the Operator shall be furnished to Operator prior to execution of this agreement.  Said policy or policies shall contain a provision requiring Owner's carrier or carriers to notify Operator at least five (5) months prior to cancellation or modification of said policy or policies.</li>
		<li>As and for a material part of the consideration for the entry of Operator into this charter, Owner agrees to defend, indemnify and hold harmless Operator, its officers, agents, and employees from and against any claims, damages, expenses or liability, including without limitation, damages to any property, including Owner's property, or damages arising from the death or injury of any person or persons, including Owner's employees and agents, arising out of the performance of this Charter Agreement or the use of the Vessel, to the extent such claims, damages, expenses and liabilities are not caused by the negligence or willful misconduct of Operator, its officers, agents, or employees acting within the scope of official business of the Operator.</li>
		<li>Operator shall refuse to participate in games of 'space chicken' with asteroids, meteorites, vessels, stationary facilities, habitats (sentient or otherwise) and xenoforms of size categories above four. Failure to abide by this clause will result in the full forfeiture of this charter and full repayment of accrued repair costs.</li>
		<li>Operator shall not imitate fictional or historial captains of note, including but not limited to Captain Picard, Han Solo, or Captain Kirk. Failure to abide by this clause will result in the full forfeiture of this charter.</li>
		<li>In the event the vessel is disabled or damaged by breakdown of machinery, fire, grounding, collision or other cause, Operator then shall not be charged for the use of such vessel except that the daily charter rate of the date of such occurrence shall be on a prorated basis.  In the event the vessel is lost or damaged or the disability is of such extent that the vessel cannot be repaired within five (5) months following such disability, the Operator, as its election, forthwith may terminate the agreement.</li>
		<li>Operator shall not, in any circumstances, stand, crouch or kneel upon the Captain's chair in the Bridge area. Additionally, when seating themselves in the chair, the Operator shall not do so via the method of swinging their leg over the back of the seat. Failure to abide by this clause will result in the full forfeiture of this charter and full repayment of accrued repair costs.</li>
		<li>Operator shall not deliberately or accidentally cause the vessel to collide with, impact with, scrape against or otherwise come into contact with large bodies of ice (spaceborne or planetary).</li>
		<li>Payment of the chartering rate for the use of the vessel shall be made by the Operator to the Owner as agreed in the preceeding document.</li>
		<li>Owner shall retain full care, custody and control of the vessel including final authority with respect to the management and operation of the same, and with respect to any determination regarding conditions affecting the safety of its crew and passengers and/or the safe navigation of the vessel itself.
		<li>The charter may be cancelled by Operator on or before the date of commencement, without any cost or obligation to the Operator. Departure from the Vessel by the Operator prior to departure constitutes forfeiture of this charter. Any amount paid by Operator to the Owner prior to such cancellation shall be refunded by payment to the Operator within five (5) months of cancellation.  Cancellation after the above-specified date shall result in forfeiture of any amount paid by the Operator prior to cancellation.
		</ol><br>
		<br>
		IN WITNESS WHEREOF, the parties hereto have hereunto set their hands and seals to the above written:
		<br>
		<br>
		<i>[captain.real_name]</i>, Captain<br>
		<i>[F.get_random_name(pick(list(MALE,FEMALE)))]</i>, Speaker for the Callisto Free Traders
	"}

	if(!captain.put_in_hands(charter))
		if(!captain.l_store)
			captain.equip_to_slot(charter, slot_l_store)
		else if(!captain.r_store)
			captain.equip_to_slot(charter, slot_r_store)

/datum/map/katydid/show_map_info(var/user)
	user << "<b>The Katydid</b> is a charter vessel belonging to the <b>Callisto Free Traders</b>, a loose \
		interplanetary coalition of independant traders, merchants and politicians opposed to the strength \
		and influence of the Luna megacorporations. The Katydid itself operates out of the Jovian Navy \
		shipyard in orbit around Callisto, but carries freight all over Sol at the behest of whichever \
		captain has decided to charter her this month."

/datum/map/katydid/get_round_completion_text(var/mob/player)
	if(player.stat != DEAD)
		if(!(player.z in station_levels))
			if(!issilicon(player))
				return "<font color='blue'><b>You managed to survive, but were marooned in [specific_location] as [player.real_name] when [station_name()] departed...</b></font>"
			return "<font color='blue'><b>You were left in [specific_location] after the events on [station_name()] as [player.real_name].</b></font>"

		if(!issilicon(player))
			return "<font color='green'><b>You managed to survive the events on [station_name()] as [player.real_name], and escaped with it to [destination_location.name].</b></font>"
		return "<font color='green'><b>You remained operational as [player.real_name] after the events on [station_name()], and escaped with it to [destination_location.name].</b></font>"

	if(isghost(player))
		var/mob/observer/ghost/O = player
		if(!O.started_as_observer)
			return  "<font color='red'><b>You did not survive the events on [station_name()]...</b></font>"
	return "<font color='notice'><b>You kept an eye on the events on [station_name()].</b></font>"

/datum/admins/proc/katydid_rename_ship()
	set category = "Admin"
	set desc = "Forcibly rename the ship."
	set name = "Admin Rename Ship"

	if(!check_rights(R_ADMIN))	return

	var/datum/map/katydid/katydid = using_map
	if(!istype(katydid))
		usr << "This map doesn't support a map name, sorry."
		return

	var/newprefix = input("Select a new prefix.", "Ship Name") as null|anything in katydid.possible_ship_prefix
	if(!newprefix)
		return
	var/newname = sanitizeSafe(input("Enter a new name.", "Ship Name"), MAX_LNAME_LEN)
	if(!newname || newname == "")
		return
	katydid.ship_prefix = newprefix
	katydid.ship_name = newname
	katydid.full_name = "[katydid.ship_prefix] [katydid.ship_name]"
	world << "<span class='notice'><b>Naval Command has registered this vessel as the [katydid.full_name]!</b></span>"

/datum/map/katydid/update_locations()
	stellar_location = pick(all_stellar_locations)
