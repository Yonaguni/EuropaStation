/* Diffrent misc types of tiles
 * Contains:
 *		Prototype
 *		Grass
 *		Wood
 *		Carpet
 */

/obj/item/stack/tile
	name = "tile"
	singular_name = "tile"
	desc = "A non-descript floor tile"
	w_class = 3
	max_amount = 60

/obj/item/stack/tile/New()
	..()
	pixel_x = rand(-7, 7)
	pixel_y = rand(-7, 7)


/obj/item/stack/tile/floor
	name = "floor tile"
	singular_name = "floor tile"
	desc = "Those could work as a pretty decent throwing weapon" //why?
	icon_state = "tile"
	force = 6.0
	matter = list(DEFAULT_WALL_MATERIAL = 937.5)
	throwforce = 15.0
	throw_speed = 5
	throw_range = 20
	flags = CONDUCT