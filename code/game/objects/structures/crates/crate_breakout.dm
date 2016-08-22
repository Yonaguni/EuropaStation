/obj/structure/crate/proc/req_breakout()
	if(breakout)
		return 0 //Already breaking out.
	if(opened)
		return 0 //Door's open... wait, why are you in it's contents then?
	if(!welded)
		return 0 //closed but not welded...
	return 1

/obj/structure/crate/proc/mob_breakout(var/mob/living/escapee)
	var/breakout_time = 2 //2 minutes by default

	if(!req_breakout())
		return

	escapee.setClickCooldown(100)

	//okay, so the closet is either welded or locked... resist!!!
	escapee << "<span class='warning'>You lean on the back of \the [src] and start pushing the door open. (this will take about [breakout_time] minutes)</span>"

	visible_message("<span class='danger'>The [src] begins to shake violently!</span>")

	breakout = 1 //can't think of a better way to do this right now.
	for(var/i in 1 to (6*breakout_time * 2)) //minutes * 6 * 5seconds * 2
		playsound(src.loc, 'sound/effects/grillehit.ogg', 100, 1)
		animate_shake()

		if(!do_after(escapee, 50)) //5 seconds
			breakout = 0
			return
		if(!escapee || escapee.stat || escapee.loc != src)
			breakout = 0
			return //closet/user destroyed OR user dead/unconcious OR user no longer in closet OR closet opened
		//Perform the same set of checks as above for weld and lock status to determine if there is even still a point in 'resisting'...
		if(!req_breakout())
			breakout = 0
			return

	//Well then break it!
	breakout = 0
	escapee << "<span class='warning'>You successfully break out!</span>"
	visible_message("<span class='danger'>\the [escapee] successfully broke out of \the [src]!</span>")
	playsound(src.loc, 'sound/effects/grillehit.ogg', 100, 1)
	break_open()
	animate_shake()

/obj/structure/crate/proc/break_open()
	welded = 0
	update_icon()
	open()

/obj/structure/crate/proc/animate_shake()
	var/init_px = pixel_x
	var/shake_dir = pick(-1, 1)
	animate(src, transform=turn(matrix(), 8*shake_dir), pixel_x=init_px + 2*shake_dir, time=1)
	animate(transform=null, pixel_x=init_px, time=6, easing=ELASTIC_EASING)
