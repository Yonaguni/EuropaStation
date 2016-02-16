/proc/spawn_money(var/sum, var/spawnloc, var/mob/living/user)
	var/obj/item/cash/bundle = new (spawnloc, sum)
	if(istype(user)) user.put_in_hands(bundle)
	return

/proc/make_banknote(var/value)
	var/image/banknote = image('icons/obj/items.dmi', "spacecash[value]")
	var/matrix/M = matrix()
	M.Translate(rand(-6, 6), rand(-4, 8))
	M.Turn(pick(-45, -27.5, 0, 0, 0, 0, 0, 0, 0, 27.5, 45))
	banknote.transform = M
	return banknote