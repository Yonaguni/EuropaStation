/* First aid storage
 * Contains:
 *		First Aid Kits
 * 		Pill Bottles
 */

/*
 * First Aid Kits
 */
/obj/item/weapon/storage/firstaid
	name = "first-aid kit"
	desc = "It's an emergency medical kit for those serious boo-boos."
	icon_state = "firstaid"
	throw_speed = 2
	throw_range = 8
	var/empty = 0

/obj/item/weapon/storage/firstaid/fire
	name = "fire first-aid kit"
	desc = "It's an emergency medical kit for when the toxins lab <i>-spontaneously-</i> burns down."
	icon_state = "ointment"
	item_state = "firstaid-ointment"

/obj/item/weapon/storage/firstaid/fire/New()
	..()
	if (empty) return
	icon_state = pick("ointment","firefirstaid")
	new /obj/item/device/healthanalyzer( src )
	new /obj/item/weapon/reagent_containers/hypospray/autoinjector( src )
	new /obj/item/stack/medical/ointment( src )
	new /obj/item/stack/medical/ointment( src )

/obj/item/weapon/storage/firstaid/regular
	icon_state = "firstaid"

/obj/item/weapon/storage/firstaid/regular/New()
	..()
	if (empty) return
	new /obj/item/stack/medical/bruise_pack(src)
	new /obj/item/stack/medical/bruise_pack(src)
	new /obj/item/stack/medical/bruise_pack(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/weapon/reagent_containers/hypospray/autoinjector( src )

/obj/item/weapon/storage/firstaid/toxin
	name = "toxin first aid"
	desc = "Used to treat when you have a high amoutn of toxins in your body."
	icon_state = "antitoxin"
	item_state = "firstaid-toxin"

/obj/item/weapon/storage/firstaid/toxin/New()
	..()
	if (empty) return
	icon_state = pick("antitoxin","antitoxfirstaid","antitoxfirstaid2","antitoxfirstaid3")
	new /obj/item/weapon/reagent_containers/syringe/antitoxin( src )
	new /obj/item/weapon/reagent_containers/syringe/antitoxin( src )
	new /obj/item/weapon/reagent_containers/syringe/antitoxin( src )
	new /obj/item/weapon/reagent_containers/pill/antitox( src )
	new /obj/item/weapon/reagent_containers/pill/antitox( src )
	new /obj/item/weapon/reagent_containers/pill/antitox( src )
	new /obj/item/device/healthanalyzer( src )

/obj/item/weapon/storage/firstaid/o2
	name = "oxygen deprivation first aid"
	desc = "A box full of oxygen goodies."
	icon_state = "o2"
	item_state = "firstaid-o2"

/obj/item/weapon/storage/firstaid/o2/New()
	..()
	if (empty) return
	new /obj/item/weapon/reagent_containers/hypospray/autoinjector( src )
	new /obj/item/weapon/reagent_containers/syringe/adrenaline( src )
	new /obj/item/device/healthanalyzer( src )

/obj/item/weapon/storage/firstaid/adv
	name = "advanced first-aid kit"
	desc = "Contains advanced medical treatments."
	icon_state = "advfirstaid"
	item_state = "firstaid-advanced"

/obj/item/weapon/storage/firstaid/adv/New()
	..()
	if (empty) return
	new /obj/item/weapon/reagent_containers/hypospray/autoinjector( src )
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/splint(src)
	return

/obj/item/weapon/storage/firstaid/combat
	name = "combat medical kit"
	desc = "Contains advanced medical treatments."
	icon_state = "bezerk"
	item_state = "firstaid-advanced"

/obj/item/weapon/storage/firstaid/combat/New()
	..()
	if (empty) return
	new /obj/item/weapon/storage/pill_bottle/antitox(src)
	new /obj/item/weapon/storage/pill_bottle/morphine(src)
	new /obj/item/weapon/storage/pill_bottle/antibiotic(src)
	new /obj/item/weapon/storage/pill_bottle/adrenaline(src)
	new /obj/item/weapon/storage/pill_bottle/jumpstart(src)
	new /obj/item/stack/medical/splint(src)
	return

/obj/item/weapon/storage/firstaid/surgery
	name = "surgery kit"
	desc = "Contains tools for surgery. Has precise foam fitting for safe transport."

/obj/item/weapon/storage/firstaid/surgery/New()
	..()
	if (empty) return
	new /obj/item/weapon/bonesetter(src)
	new /obj/item/weapon/cautery(src)
	new /obj/item/weapon/circular_saw(src)
	new /obj/item/weapon/hemostat(src)
	new /obj/item/weapon/retractor(src)
	new /obj/item/weapon/scalpel(src)
	new /obj/item/weapon/surgicaldrill(src)
	new /obj/item/weapon/bonegel(src)
	new /obj/item/weapon/FixOVein(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)

	make_exact_fit()

/*
 * Pill Bottles
 */
/obj/item/weapon/storage/pill_bottle
	name = "pill bottle"
	desc = "It's an airtight container for storing medication."
	icon_state = "pill_canister"
	icon = 'icons/obj/chemical.dmi'
	item_state = "contsolid"
	w_class = 2.0
	can_hold = list(/obj/item/weapon/reagent_containers/pill,/obj/item/weapon/dice,/obj/item/weapon/paper)
	allow_quick_gather = 1
	use_to_pickup = 1
	use_sound = null

/obj/item/weapon/storage/pill_bottle/antitox
	name = "bottle of anti-toxin pills"
	desc = "Contains pills used to counter toxins."

/obj/item/weapon/storage/pill_bottle/antitox/New()
	..()
	for(var/x = 1 to 7)
		new /obj/item/weapon/reagent_containers/pill/antitox(src)

/obj/item/weapon/storage/pill_bottle/adrenaline
	name = "bottle of adrenaline pills"
	desc = "Contains pills used to stabilize patients."

/obj/item/weapon/storage/pill_bottle/adrenaline/New()
	..()
	for(var/x = 1 to 7)
		new /obj/item/weapon/reagent_containers/pill/adrenaline(src)

/obj/item/weapon/storage/pill_bottle/antibiotic
	name = "bottle of antibiotic pills"
	desc = "A theta-lactam antibiotic. Effective against many diseases."

/obj/item/weapon/storage/pill_bottle/antibiotic/New()
	..()
	for(var/x = 1 to 7)
		new /obj/item/weapon/reagent_containers/pill/antibiotic(src)

/obj/item/weapon/storage/pill_bottle/morphine
	name = "bottle of morphine pills"
	desc = "Contains pills used to relieve pain."

/obj/item/weapon/storage/pill_bottle/morphine/New()
	..()
	for(var/x = 1 to 7)
		new /obj/item/weapon/reagent_containers/pill/morphine(src)

/obj/item/weapon/storage/pill_bottle/antidepressant
	name = "bottle of antidepressant pills"
	desc = "Contains pills used to stabilize a patient's mood."

/obj/item/weapon/storage/pill_bottle/antidepressant/New()
	..()
	for(var/x = 1 to 7)
		new /obj/item/weapon/reagent_containers/pill/antidepressant(src)

/obj/item/weapon/storage/pill_bottle/jumpstart
	name = "unlabelled pill bottle"
	desc = "It just has a crude '+1' drawn on the label in black marker."

/obj/item/weapon/storage/pill_bottle/jumpstart/New()
	..()
	for(var/x = 1 to 7)
		new /obj/item/weapon/reagent_containers/pill/jumpstart(src)