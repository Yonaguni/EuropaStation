/* First aid storage
 * Contains:
 *		First Aid Kits
 * 		Pill Bottles
 */

/*
 * First Aid Kits
 */
/obj/item/storage/firstaid
	name = "first-aid kit"
	desc = "It's an emergency medical kit for those serious boo-boos."
	icon_state = "firstaid"
	throw_speed = 2
	throw_range = 8
	max_w_class = 2
	max_storage_space = DEFAULT_BOX_STORAGE

/obj/item/storage/firstaid/empty
	icon_state = "firstaid"
	name = "First-Aid (empty)"

/obj/item/storage/firstaid/fire
	name = "fire first-aid kit"
	desc = "It's an emergency medical kit for when the toxins lab <i>-spontaneously-</i> burns down."
	icon_state = "ointment"
	item_state = "firstaid-ointment"

	startswith = list(
		/obj/item/healthanalyzer,
		/obj/item/reagent_containers/hypospray/autoinjector,
		/obj/item/stack/medical/ointment,
		/obj/item/reagent_containers/pill/fotiazine = 3,
		)

/obj/item/storage/firstaid/fire/New()
	..()
	icon_state = pick("ointment","firefirstaid")

/obj/item/storage/firstaid/regular
	icon_state = "firstaid"

	startswith = list(
		/obj/item/stack/medical/bruise_pack = 3,
		/obj/item/stack/medical/ointment = 2,
		/obj/item/healthanalyzer,
		/obj/item/reagent_containers/hypospray/autoinjector,
		)

/obj/item/storage/firstaid/toxin
	name = "toxin first aid"
	desc = "Used to treat when you have a high amoutn of toxins in your body."
	icon_state = "antitoxin"
	item_state = "firstaid-toxin"

	startswith = list(
		/obj/item/reagent_containers/syringe/antitoxin = 3,
		/obj/item/reagent_containers/pill/antitox = 3,
		/obj/item/healthanalyzer,
		)

/obj/item/storage/firstaid/toxin/New()
	..()
	icon_state = pick("antitoxin","antitoxfirstaid","antitoxfirstaid2","antitoxfirstaid3")

/obj/item/storage/firstaid/o2
	name = "oxygen deprivation first aid"
	desc = "A box full of oxygen goodies."
	icon_state = "o2"
	item_state = "firstaid-o2"

	startswith = list(
		/obj/item/reagent_containers/pill/dexalin = 4,
		/obj/item/reagent_containers/hypospray/autoinjector,
		/obj/item/reagent_containers/syringe/adrenaline,
		/obj/item/healthanalyzer,
		)

/obj/item/storage/firstaid/adv
	name = "advanced first-aid kit"
	desc = "Contains advanced medical treatments."
	icon_state = "advfirstaid"
	item_state = "firstaid-advanced"

	startswith = list(
		/obj/item/reagent_containers/hypospray/autoinjector,
		/obj/item/stack/medical/advanced/bruise_pack = 3,
		/obj/item/stack/medical/advanced/ointment = 2,
		/obj/item/stack/medical/splint,
		)

/obj/item/storage/firstaid/combat
	name = "combat medical kit"
	desc = "Contains advanced medical treatments."
	icon_state = "bezerk"
	item_state = "firstaid-advanced"

	startswith = list(
		/obj/item/storage/pill_bottle/styptazine,
		/obj/item/storage/pill_bottle/dylovene,
		/obj/item/storage/pill_bottle/morphine,
		/obj/item/storage/pill_bottle/antibiotic,
		/obj/item/stack/medical/splint,
		)

/obj/item/storage/firstaid/surgery
	name = "surgery kit"
	desc = "Contains tools for surgery. Has precise foam fitting for safe transport."

	startswith = list(
		/obj/item/bonesetter,
		/obj/item/cautery,
		/obj/item/circular_saw,
		/obj/item/hemostat,
		/obj/item/retractor,
		/obj/item/scalpel,
		/obj/item/surgicaldrill,
		/obj/item/bonegel,
		/obj/item/FixOVein,
		/obj/item/stack/medical/advanced/bruise_pack,
		)

/obj/item/storage/firstaid/surgery/New()
	..()
	make_exact_fit()

/*
 * Pill Bottles
 */
/obj/item/storage/pill_bottle
	name = "pill bottle"
	desc = "It's an airtight container for storing medication."
	icon_state = "pill_canister"
	icon = 'icons/obj/chemical.dmi'
	item_state = "contsolid"
	w_class = 2
	max_w_class = 1
	max_storage_space = 7
	can_hold = list(/obj/item/reagent_containers/pill,/obj/item/dice,/obj/item/paper)
	allow_quick_gather = 1
	use_to_pickup = 1
	use_sound = null

/obj/item/storage/pill_bottle/antitox
	name = "bottle of Dylovene pills"
	desc = "Contains pills used to counter toxins."

	startswith = list(/obj/item/reagent_containers/pill/antitox = 7)

/obj/item/storage/pill_bottle/styptazine
	name = "bottle of Styptazine pills"
	desc = "Contains pills used to stabilize the severely injured."

	startswith = list(/obj/item/reagent_containers/pill/styptazine = 7)

/obj/item/storage/pill_bottle/dylovene
	name = "bottle of Dylovene pills"
	desc = "Contains pills used to treat toxic substances in the blood."

	startswith = list(/obj/item/reagent_containers/pill/dylovene = 7)

/obj/item/storage/pill_bottle/adrenaline
	name = "bottle of Adrenaline pills"
	desc = "Contains pills used to stabilize patients."

	startswith = list(/obj/item/reagent_containers/pill/adrenaline = 7)

/obj/item/storage/pill_bottle/fotiazine
	name = "bottle of Fotiazine pills"
	desc = "Contains pills used to treat burns."

	startswith = list(/obj/item/reagent_containers/pill/fotiazine = 7)

/obj/item/storage/pill_bottle/antibiotic
	name = "bottle of Antibiotic pills"
	desc = "A broad-spectrum antibiotic. Effective against many diseases likely to be encountered in space."

	startswith = list(/obj/item/reagent_containers/pill/antibiotic = 7)

/obj/item/storage/pill_bottle/morphine
	name = "bottle of Morphine pills"
	desc = "Contains pills used to relieve pain."

	startswith = list(/obj/item/reagent_containers/pill/morphine = 7)

/obj/item/storage/pill_bottle/citalopram
	name = "bottle of Citalopram pills"
	desc = "Contains pills used to stabilize a patient's mood."

	startswith = list(/obj/item/reagent_containers/pill/citalopram = 7)
