/obj/item/clothing/mask/ai
	name = "camera MIU"
	desc = "Allows for direct mental connection to accessible camera networks."
	icon_state = "s-ninja"
	item_state = "s-ninja"
	flags_inv = HIDEFACE
	body_parts_covered = FACE|EYES
	action_button_name = "Toggle MUI"
	origin_tech = list(TECH_DATA = 5, TECH_ENGINEERING = 5)
	var/active = FALSE
	var/mob/observer/eye/cameranet/eye

/obj/item/clothing/mask/ai/New()
	eye = new(src)
	eye.name_sufix = "camera MIU"
	..()

/obj/item/clothing/mask/ai/Destroy()
	if(eye)
		if(active)
			disengage_mask(eye.owner)
		qdel(eye)
		eye = null
	..()

/obj/item/clothing/mask/ai/attack_self(var/mob/user)
	if(user.incapacitated())
		return
	active = !active
	to_chat(user, "<span class='notice'>You [active ? "" : "dis"]engage \the [src].</span>")
	if(active)
		engage_mask(user)
	else
		disengage_mask(user)

/obj/item/clothing/mask/ai/equipped(var/mob/user, var/slot)
	..(user, slot)
	engage_mask(user)

/obj/item/clothing/mask/ai/dropped(var/mob/user)
	..()
	disengage_mask(user)

/obj/item/clothing/mask/ai/proc/engage_mask(var/mob/user)
	if(!active)
		return
	if(user.get_equipped_item(slot_wear_mask) != src)
		return

	eye.possess(user)
	to_chat(eye.owner, "<span class='notice'>You feel disorented for a moment as your mind connects to the camera network.</span>")

/obj/item/clothing/mask/ai/proc/disengage_mask(var/mob/user)
	if(user == eye.owner)
		to_chat(eye.owner, "<span class='notice'>You feel disorented for a moment as your mind disconnects from the camera network.</span>")
		eye.release(eye.owner)
		eye.forceMove(src)