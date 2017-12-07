/* Closets for specific jobs
 * Contains:
 *		Bartender
 *		Janitor
 *		Lawyer
 */

/*
 * Bartender
 */
/obj/structure/closet/gmcloset
	name = "formal closet"
	desc = "It's a storage unit for formal clothing."
	icon_state = "black"
	icon_closed = "black"

/obj/structure/closet/gmcloset/New()
	..()
	new /obj/item/clothing/head/tophat(src)
	new /obj/item/clothing/head/tophat(src)
	new /obj/item/clothing/head/hairflower
	new /obj/item/clothing/head/hairflower/pink
	new /obj/item/clothing/head/hairflower/yellow
	new /obj/item/clothing/head/hairflower/blue
	new /obj/item/clothing/under/dress/dress_saloon(src)
	new /obj/item/clothing/suit/wcoat(src)
	new /obj/item/clothing/suit/wcoat(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/under/lower/pants/black/hospitality(src)
	new /obj/item/clothing/under/lower/pants/black/hospitality(src)

/*
 * Chef
 */
/obj/structure/closet/chefcloset
	name = "chef's closet"
	desc = "It's a storage unit for foodservice garments."
	icon_state = "black"
	icon_closed = "black"

/obj/structure/closet/chefcloset/New()
	..()
	new /obj/item/storage/box/mousetraps(src)
	new /obj/item/storage/box/mousetraps(src)
	new /obj/item/clothing/under/jumpsuit/white(src)
	new /obj/item/clothing/head/chefhat(src)

/*
 * Janitor
 */
/obj/structure/closet/jcloset
	name = "custodial closet"
	desc = "It's a storage unit for janitorial clothes and gear."
	icon_state = "mixed"
	icon_closed = "mixed"

/obj/structure/closet/jcloset/New()
	..()
	new /obj/item/clothing/under/jumpsuit/janitor(src)
	new /obj/item/cartridge/janitor(src)
	new /obj/item/clothing/gloves/thick(src)
	new /obj/item/clothing/head/soft/purple(src)
	new /obj/item/clothing/head/beret/purple(src)
	new /obj/item/flashlight(src)
	new /obj/item/caution(src)
	new /obj/item/caution(src)
	new /obj/item/caution(src)
	new /obj/item/caution(src)
	new /obj/item/lightreplacer(src)
	new /obj/item/storage/bag/trash(src)
	new /obj/item/clothing/shoes/galoshes(src)
	new /obj/item/soap/corporate(src)
