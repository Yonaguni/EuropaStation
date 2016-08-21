/**
 * Startup hook.
 * Called in world.dm when the server starts.
 */
/hook/startup

/**
 * Roundstart hook.
 * Called in gameticker.dm when a round starts.
 */
/hook/roundstart

/**
 * Roundend hook.
 * Called in gameticker.dm when a round ends.
 */
/hook/roundend

/**
 * Death hook.
 * Called in death.dm when someone dies.
 * Parameters: var/mob/living/human, var/gibbed
 */
/hook/death

/**
 * Cloning hook.
 * Called in cloning.dm when someone is brought back by the wonders of modern science.
 * Parameters: var/mob/living/human
 */
/hook/clone

/**
 * Debrained hook.
 * Called in brain_item.dm when someone gets debrained.
 * Parameters: var/obj/item/organ/brain
 */
/hook/debrain

/**
 * Employee reassignment hook.
 * Called in card.dm when someone's card is reassigned at the HoP's desk.
 * Parameters: var/obj/item/weapon/card/id
 */
/hook/reassign_employee

